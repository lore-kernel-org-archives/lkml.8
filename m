Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F00C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DD420784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbgCaNwI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:52:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:22538 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730932AbgCaNwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:52:08 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-145-yPuGdS0KPT6ohGvuVMW7SQ-1; Tue, 31 Mar 2020 14:52:04 +0100
X-MC-Unique: yPuGdS0KPT6ohGvuVMW7SQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 31 Mar 2020 14:52:04 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 31 Mar 2020 14:52:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 05/12] scsi: Use iovec_import() instead of import_iovec().
Thread-Topic: [RFC PATCH 05/12] scsi: Use iovec_import() instead of
 import_iovec().
Thread-Index: AdYHYcGSV8aBnavhRqaQOXdNGGYd0Q==
Date:   Tue, 31 Mar 2020 13:52:03 +0000
Message-ID: <56b125de37a842768754905876f4339c@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: David Laight <david.laight@aculab.com>
---
 block/scsi_ioctl.c | 14 ++++++++------
 drivers/scsi/sg.c  | 14 +++++++-------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index b4e73d5..df3a11b 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -327,20 +327,22 @@ static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
 	ret = 0;
 	if (hdr->iovec_count) {
 		struct iov_iter i;
-		struct iovec *iov = NULL;
+		struct iovec *iov;
 
 #ifdef CONFIG_COMPAT
 		if (in_compat_syscall())
-			ret = compat_import_iovec(rq_data_dir(rq),
+			iov = compat_iovec_import(rq_data_dir(rq),
 				   hdr->dxferp, hdr->iovec_count,
-				   0, &iov, &i);
+				   NULL, &i);
 		else
 #endif
-			ret = import_iovec(rq_data_dir(rq),
+			iov = iovec_import(rq_data_dir(rq),
 				   hdr->dxferp, hdr->iovec_count,
-				   0, &iov, &i);
-		if (ret < 0)
+				   NULL, &i);
+		if (IS_ERR(iov)) {
+			ret = PTR_ERR(iov);
 			goto out_free_cdb;
+		}
 
 		/* SG_IO howto says that the shorter of the two wins */
 		iov_iter_truncate(&i, hdr->dxfer_len);
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 4e6af59..4733f7b 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1813,19 +1813,19 @@ static long sg_compat_ioctl(struct file *filp, unsigned int cmd_in, unsigned lon
 	}
 
 	if (iov_count) {
-		struct iovec *iov = NULL;
+		struct iovec *iov;
 		struct iov_iter i;
 
 #ifdef CONFIG_COMPAT
 		if (in_compat_syscall())
-			res = compat_import_iovec(rw, hp->dxferp, iov_count,
-						  0, &iov, &i);
+			iov = compat_iovec_import(rw, hp->dxferp, iov_count,
+						  NULL, &i);
 		else
 #endif
-			res = import_iovec(rw, hp->dxferp, iov_count,
-					   0, &iov, &i);
-		if (res < 0)
-			return res;
+			iov = iovec_import(rw, hp->dxferp, iov_count,
+					   NULL, &i);
+		if (IS_ERR(iov))
+			return PTR_ERR(iov);
 
 		iov_iter_truncate(&i, hp->dxfer_len);
 		if (!iov_iter_count(&i)) {
-- 
1.8.1.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

