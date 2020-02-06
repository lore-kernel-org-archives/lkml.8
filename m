Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D5AC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE55F2192A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeYNlxjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgBFUYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:24:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53505 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgBFUYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:24:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so242738wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 12:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WK+KzBfTuQqE2Bcx0psUGki6jAtzDkPOrrhY+kNzNrw=;
        b=CeYNlxjzHtIWZg/vY47dPxarMHCWklh6vMfP//hs7swnQZfcEmSvk7siiadZno6el+
         cY92Zqet6v7EfYdQIPJClnI7JqiMm38lY1E/mm/WLEXEIjnvmec4OFfzFG66rRaySZRr
         LgzRakLQjea3vek1U7u4Lb+YvTh80JeaLtDxMZXFQnqBuDPV6GQCT+IUzRB1YIueKr6b
         p4WdZ/ESKPVBx93tVok4cW2zrqhfAapALEnSeWgYqYCCo4Lu124nke0C6HtHAs4nqHSL
         BEex2iyuVCPz1mAg8+6PxuFF/BbJfL68ktSu/TuYYu8NXAqdfZ2ExGRhHbm5dLmfIiur
         MI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WK+KzBfTuQqE2Bcx0psUGki6jAtzDkPOrrhY+kNzNrw=;
        b=PfiWmLw7uCoGFAx0jJKZfuJFMgiz1MEOfpU5CqxHKUXuDC2KKjGjowfJfF2b/tfyXR
         wuoI3EDnchHW52Lv8xkJWSdLfbkrlgdDis5Wn7DzSxi33pZAtZCfdarUkddeWROlZnR/
         PDk4c2xAyutn7DxLD7YfZUDS6inz9J4nfRawlnKVNjGSjb6FfUQ51Vq2fMtLek6oF+Wc
         KNCWzhIVliMVmEzcSVuLdGWobjBb5O4L6kxJz2eaokDH/yYGuvN2vztUYbgJOCz5bce/
         pZoETamJDpOPWr6/Sax5IXMA1ewtvbrLpJC9X8n/qInmT2teRrrtu5i3J2/6Xu8JqFKU
         DnZA==
X-Gm-Message-State: APjAAAW+53YnrBOqFPaH8KF0JccsZHFDsg/+K7DTOqk2qqTpSJcn5o96
        DpKK31z/5U+VOvahXe2jyuY=
X-Google-Smtp-Source: APXvYqwJHnB1/JUbJWR3PS09nalAM3wop5u4zJscsuPs6GYDb2BIyh1yEJhadIt0O2IBggxqTKYnGA==
X-Received: by 2002:a1c:4c5:: with SMTP id 188mr6356293wme.82.1581020673255;
        Thu, 06 Feb 2020 12:24:33 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id c13sm539929wrx.9.2020.02.06.12.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:24:32 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v4 2/5] mtd: spinand: micron: Add new Micron SPI NAND devices
Date:   Thu,  6 Feb 2020 21:22:03 +0100
Message-Id: <20200206202206.14770-3-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206202206.14770-1-sshivamurthy@micron.com>
References: <20200206202206.14770-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add device table for M79A and M78A series Micron SPI NAND devices.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index c028d0d7e236..5fd1f921ef12 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -91,6 +91,7 @@ static int micron_8_ecc_get_status(struct spinand_device *spinand,
 }
 
 static const struct spinand_info micron_spinand_table[] = {
+	/* M79A 2Gb 3.3V */
 	SPINAND_INFO("MT29F2G01ABAGD", 0x24,
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -100,6 +101,36 @@ static const struct spinand_info micron_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
+	/* M79A 2Gb 1.8V */
+	SPINAND_INFO("MT29F2G01ABBGD", 0x25,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
+	/* M78A 1Gb 3.3V */
+	SPINAND_INFO("MT29F1G01ABAFD", 0x14,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
+	/* M78A 1Gb 1.8V */
+	SPINAND_INFO("MT29F1G01ABAFD", 0x15,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
 };
 
 static int micron_spinand_detect(struct spinand_device *spinand)
-- 
2.17.1

