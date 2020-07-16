Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C717BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A477220760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594900435;
	bh=snuO7Afj7MA835fjlKy97Sdl/QB5+F2KKYVi91gzJGY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=pxP3bSK6JlVhvxejSrW+pvkl7U4TUjHtdEPExu3tGjZVGjH0eerJA3tVnmDsEMavj
	 zPDJs3S1jxZzfVmDpYeGp/YflSBpf8Rg9XkhtU/DubdHxRQm/jXxuvbYqWW04vdUH6
	 BIAHW/qEAXKyOBMRamZym9dYmGuz2HO7lBJEg85c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgGPLxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgGPLxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:53:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C24620739;
        Thu, 16 Jul 2020 11:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594900432;
        bh=snuO7Afj7MA835fjlKy97Sdl/QB5+F2KKYVi91gzJGY=;
        h=Date:From:To:Cc:Subject:From;
        b=z+Lo92f1Z3Hqd0m/IYqU2kSKtnFQPWyqMXEoQQ0N/Zzl0ctA9mVeKJ19ZxZIQLToC
         baqRXp/Yx5/pujymq4Cpv9hPfJY3aK0GWGqd7ZnS3SQnItLBpk5iPLCy/e/d5L4rpE
         WWkD99oVRhItakVJ5C/0akC+F8VNqg4R8kNLV6qc=
Date:   Thu, 16 Jul 2020 13:53:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: properly check all write ioctls for permissions
Message-ID: <20200716115346.GA1667288@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing a "write" ioctl call, properly check that we have permissions
to do so before copying anything from userspace or anything else so we
can "fail fast".  This includes also covering the MEMWRITE ioctl which
previously missed checking for this.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/mtdchar.c | 54 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index c5935b2f9cd1..52c120f9fb0d 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -355,9 +355,6 @@ static int mtdchar_writeoob(struct file *file, struct mtd_info *mtd,
 	uint32_t retlen;
 	int ret = 0;
 
-	if (!(file->f_mode & FMODE_WRITE))
-		return -EPERM;
-
 	if (length > 4096)
 		return -EINVAL;
 
@@ -643,6 +640,48 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 
 	pr_debug("MTD_ioctl\n");
 
+	/*
+	 * Check the file mode to require "dangerous" commands to have write
+	 * permissions.
+	 */
+	switch (cmd) {
+	/* "safe" commands */
+	case MEMGETREGIONCOUNT:
+	case MEMGETREGIONINFO:
+	case MEMGETINFO:
+	case MEMREADOOB:
+	case MEMREADOOB64:
+	case MEMLOCK:
+	case MEMUNLOCK:
+	case MEMISLOCKED:
+	case MEMGETOOBSEL:
+	case MEMGETBADBLOCK:
+	case MEMSETBADBLOCK:
+	case OTPSELECT:
+	case OTPGETREGIONCOUNT:
+	case OTPGETREGIONINFO:
+	case OTPLOCK:
+	case ECCGETLAYOUT:
+	case ECCGETSTATS:
+	case MTDFILEMODE:
+	case BLKPG:
+	case BLKRRPART:
+		break;
+
+	/* "dangerous" commands */
+	case MEMERASE:
+	case MEMERASE64:
+	case MEMWRITEOOB:
+	case MEMWRITEOOB64:
+	case MEMWRITE:
+		if (!(file->f_mode & FMODE_WRITE))
+			return -EPERM;
+		break;
+
+	default:
+		return -ENOTTY;
+	}
+
 	switch (cmd) {
 	case MEMGETREGIONCOUNT:
 		if (copy_to_user(argp, &(mtd->numeraseregions), sizeof(int)))
@@ -690,9 +729,6 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 	{
 		struct erase_info *erase;
 
-		if(!(file->f_mode & FMODE_WRITE))
-			return -EPERM;
-
 		erase=kzalloc(sizeof(struct erase_info),GFP_KERNEL);
 		if (!erase)
 			ret = -ENOMEM;
@@ -985,9 +1021,6 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 		ret = 0;
 		break;
 	}
-
-	default:
-		ret = -ENOTTY;
 	}
 
 	return ret;
@@ -1031,6 +1064,9 @@ static long mtdchar_compat_ioctl(struct file *file, unsigned int cmd,
 		struct mtd_oob_buf32 buf;
 		struct mtd_oob_buf32 __user *buf_user = argp;
 
+		if (!(file->f_mode & FMODE_WRITE))
+			return -EPERM;
+
 		if (copy_from_user(&buf, argp, sizeof(buf)))
 			ret = -EFAULT;
 		else
-- 
2.27.0

