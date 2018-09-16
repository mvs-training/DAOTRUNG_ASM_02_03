 1. Cấu trúc vật lý của ổ đĩa

	1.1. Track - Side - Cylinder - Sector

		1.1.1. Track
			- Trên một mặt làm việc của đĩa từ chia ra nhiều vòng tròn đồng tâm thành các track. Track trên ổ đĩa cứng không cố định từ khi sản xuất,
			  chúng có thể thay đổi vị trí khi định dạng cấp thấp ổ đĩa (low format ).
		1.1.2. Side
			- Bất kì một đĩa nào cũng có 2 mặt (side). Ghi dữ liệu lên 2 mặt đĩa mang lại tính kinh tế hơn vì khả năng chứa dữ liệu của đĩa tăng lên 
			gấp đôi mà không cần tốn thêm ổ đĩa thứ 2.
		1.1.3. Cylinder
			- Tập hợp các track cùng bán kính (cùng số hiệu trên) ở các mặt đĩa khác nhau thành các cylinder
		1.1.4. Sector
			- Bộ điều khiển đĩa thường được thiết kế để đọc và ghi một lần chỉ từng phân đoạn của Track. Số byte trong 1 phân đoạn, được gọi là Sector
			 Đối với hệ điều hành DOS, kích thước được chọn là 512 byte cho mỗi Sector với tất cả các loại đĩa. 

	1.2. Đánh địa chỉ Sector
			- Khi chúng ta đạt đến Track cần đọc/ghi, có 2 cách để định vị Sector đó:
				+ Đánh số Sector bằng phương pháp cứng (Hard sectoring): Những lỗ đều nhau sẽ được bấm xung quanh đĩa và mỗi lỗ như thế có ý nghĩa đánh dấu sự bắt đầu 1 Sector. 
				+ Đánh số Sector bằng phương pháp mềm (Soft sectoring): Phương pháp này mã hóa địa chỉ của Sector thành dữ liệu của Sector đó và được gắn vào trước mỗi Sector. 
			- Hiện nay, phương pháp đánh số mềm được dùng rộng rãi. Với phương pháp này, trước khi đĩa được dùng, địa chỉ của Sector phải được ghi vao Sector (quá trình này được thực hiện bằng việc Format đĩa).

	1.3. Format vật lý
		- Ghi toàn bộ địa chỉ Sector, các thông tin khác vào phần đầu của Sector được gọi là format vật lý hay format ở mức thấp,vì việc này được thực hiện chỉ bằng phần cứng của bộ điều khiển đĩa. 
		
		- Format vật lý phải được thực hiện trước khi đĩa được đưa vào sử dụng. Một quá trình độc lập thứ 2 - format logic - cũng phải được thực hiện ngay sau đó trước khi đĩa chuẩn bị chứa dữ liệu. 
2. Cấu trúc Logic

	2.1. Boot Sector

		- Luôn chiếm Sector đầu tiên trên Track 0, Side 1 của đĩa, tuy vậy, điều này cũng chỉ tuyệt đối đúng trên các đĩa mềm, còn đối với đĩa cứng, vị trí này phải nhường lại cho Partition table.
		
	2.2. FAT - Root directory
 
	- FAT là hệ thống tập tin được sử dụng trên hệ điều hành MS-DOS và Windows
	- Có 3 loại FAT: FAT12, FAT16, FAT32  
	- Tổ chứng thành 2 vùng:
		
		+ Vùng Hệ thống: BootSector, bảng FAT, bảng thư mục gốc
		+ Vùng dữ liệu
    
	- Root directory là cấu trúc bổ xung cho FAT và nằm ngay sau FAT. 
	2.3. Partition table

		- Các thông tin về điểm bắt đầu và kích th-ớc của từng partition được phản ánh trong Partition table. Partition table này luôn tìm thấy ở sector đầu tiên trên đĩa (track 0, Side 0, sector 1) thayvì Boot sector (còn được gọi dưới tên Master boot).
3. Các tác vụ truy xuất đĩa

	3.1. Mức BIOS

	- Tương ứng với mức cấu trỳc vật lớ, bộ điều khiển đĩa cũng đưa ra cỏc khả năng cho phộp truy xuất ở mức vật lớ. Các chức năng này được thực hiện thụng qua ngắt 13h, với từng chức năng con trong thanh ghi AH. Các chức năng căn bản:

		- Reset đĩa: Vào: AH=0, DL = số hiệu đĩa vật lí (0=đĩa A, 1=đĩa B ..... 080=đĩa cứng). Nếu DL là 80h hay 81h, bộ điều khiển đĩa cứng sẽ reset sau đó đến bộ điều khiển đĩa mềm. Ra: Không.
		- Lấy mã lỗi của tác vụ đĩa gần nhất: Vào: AH = 1 DL = đĩa vật lí. Nếu DL=80h lấy lỗi của đĩa mềm DL=7Fh lấy lỗi của đĩa cứng. Ra: AL chứa mã lỗi. 
		- Đọc sector: Vào: AH=2 DL=số hiệu đĩa (0=đĩa A, ..., 80h=đĩa cứng 0, 81h= đĩa cứng 1); DH=số đầu đọc ghi. CH= số track (Cylinder) CL=số sector. AL=số sector cần đọc/ghi Ra: CF=1 nếu có lỗi và mỰ lỗi chứa trong AH.
		- Ghi sector: Vào: AH=3 ES:BX trỏ đến buffer chứa dữ liệu còn lại tương tự như chức năng đọc sector. Ra: CF=1 nếu có lỗi và mã lỗi chứa trong AH.
		- Verify sector: Chức năng này cho phép kiểm tra CRC của các sector được chọn. Vào: AH=4 Ra: CF=1 nếu có lỗi và mã lỗi chứa trong AH. Vào: AH=4, các thanh ghi như C và D. Ra: CF=1 nếu có lỗi và mã lỗi chứa trong AH.
 
	3.2. Mức DOS

		- Chức năng đọc và ghi đĩa dưới DOS được phân biệt bởi hai ngắt 25h và 26h, tham số đưa vào bây giờ chỉ còn là sector logic ,gọi các đĩa theo thứ tự các chữ cái từ A đến Z . 
		- Vào: AL=số đĩa (0=A, 1=B, ...), CX=số lượng sector cần đọc/ghi, DX=số sector logic bắt đầu, DS:BX=địa chỉ của buffer chứa dữ liệu cho tác vụ đọc/ghi.
		- Ra: Lỗi nếu CF=1, mã lỗi trong AX. Ngược lại, tác vụ đọc/ghi được thực hiện thành công, các giá trị thanh ghi đều bị phá hủy, trừ các thanh ghi phân đoạn và một word còn sót lại trên stack.

	3.3. Các giải thuật chuyển đổi định vị


    




