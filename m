Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF95C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E24420674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgBDLUR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:20:17 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:22704 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727154AbgBDLUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:20:14 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-10-vBYvQg4LN36nAgPRQBlxpQ-1; Tue, 04 Feb 2020 11:20:11 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 4 Feb 2020 11:20:11 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 4 Feb 2020 11:20:11 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'axboe@kernel.dk'" <axboe@kernel.dk>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix io_read() and io_write() when io_import_fixed() is used.
Thread-Topic: [PATCH] Fix io_read() and io_write() when io_import_fixed() is
 used.
Thread-Index: AdXbTP+YLQmyIuo6Sk+vDwZErsD4Xw==
Date:   Tue, 4 Feb 2020 11:20:11 +0000
Message-ID: <0cf51853bebe4c889e4d00e4bbc61fb3@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: vBYvQg4LN36nAgPRQBlxpQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

io_import_fixed() returns 0 on success so io_import_iovec() may
not return the length of the transfer.

Instead always use the value from iov_iter_count()
(Which is called at the same place.)

Fixes 9d93a3f5a (modded by 491381ce0) and 9e645e110.

Signed-off-by: David Laight <david.laight@aculab.com>
---

Spotted while working on another patch to change the return value
of import_iovec() to be the address of the memory to kfree().

 fs/io_uring.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index bde73b1..28128aa 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1376,7 +1376,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	struct iov_iter iter;
 	struct file *file;
 	size_t iov_count;
-	ssize_t read_size, ret;
+	ssize_t ret;
 
 	ret = io_prep_rw(req, s, force_nonblock);
 	if (ret)
@@ -1390,11 +1390,10 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	if (ret < 0)
 		return ret;
 
-	read_size = ret;
+	iov_count = iov_iter_count(&iter);
 	if (req->flags & REQ_F_LINK)
-		req->result = read_size;
+		req->result = iov_count;
 
-	iov_count = iov_iter_count(&iter);
 	ret = rw_verify_area(READ, file, &kiocb->ki_pos, iov_count);
 	if (!ret) {
 		ssize_t ret2;
@@ -1414,7 +1413,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 		 */
 		if (force_nonblock && !(req->flags & REQ_F_NOWAIT) &&
 		    (req->flags & REQ_F_ISREG) &&
-		    ret2 > 0 && ret2 < read_size)
+		    ret2 > 0 && ret2 < iov_count)
 			ret2 = -EAGAIN;
 		/* Catch -EAGAIN return for forced non-blocking submission */
 		if (!force_nonblock || ret2 != -EAGAIN) {
@@ -1455,10 +1454,9 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	if (ret < 0)
 		return ret;
 
-	if (req->flags & REQ_F_LINK)
-		req->result = ret;
-
 	iov_count = iov_iter_count(&iter);
+	if (req->flags & REQ_F_LINK)
+		req->result = iov_count;
 
 	ret = -EAGAIN;
 	if (force_nonblock && !(kiocb->ki_flags & IOCB_DIRECT)) {
-- 
1.8.1.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

