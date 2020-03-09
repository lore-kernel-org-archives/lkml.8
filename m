Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0377C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901F62051A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXFK10Td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgCILzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:55:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50824 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgCILzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:55:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id a5so9551973wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fZEHZVAiXu8sfQoYawsUmY7xOYvR1LEo4KSCSXP/S8s=;
        b=dXFK10TdPpfScl01k0ffiiqX07TxuSqLkEVjdgqcmmMkTChsCfUmnYlw5CQXwrSvvQ
         Ij+vgNTpHseWIFeMpDjWGXWd+wQHZzwtM9wRtl6IRzA+yI3cSTT5c7sLxHzugTp8KFdI
         k5xaRdT42Uylzwdi9Rf4Q9aAc3Z2cL8rzIXNDdRjD9IWENGXEutg2j8hxw5qDVe63CUD
         FZq8dK5561EP+BYH1Sjl6IbLNiYPLkRu/Efs9MfiOYDMIsPHrMLzF/PsJj1bwhiE0Jrv
         g50Fa/7HqmA4oeE+3kquhriHMpYN+q8R/VHxfCYAGzCOHlYaxfMJQnIYHx/bypCmel6l
         MQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fZEHZVAiXu8sfQoYawsUmY7xOYvR1LEo4KSCSXP/S8s=;
        b=dNGGrZhgePUSuqJhP5qaTdeVcPqexKP3EUJ81VadaP01eyUCK10txtSyyuRMd04fyo
         lbgPNDLoNAV46eQc5KhDotfRcKt2uJ5US+v9w2r0bizRF4fA7UhJWRxFhTqqDIL7MXcd
         0gdD3NzItOAyU08KKjj89KjEnJW+X3t48AHBv6g089NmGXvJ90oTbJr1iwqdPe5hxMr6
         FuwZzvf7wSaau/blDZmdWQCqKgxlfa9L+9RVpLjAgin3WjqVBzQF3OBjefQKTU14ze8p
         5GMhihcmQcaB5Fnm+VKAvmPIWq3sKQq/AziVEajsrOhAatfH1TC6fg2NfILT2Zh0pyYy
         8ScA==
X-Gm-Message-State: ANhLgQ0jAfY3c4Ma54rEbzr32X3dVg6xBzJXoQ7pIJ8WbQHUk8BqxA0s
        Zi9pO/+xXa2g6pJ+7oqyTEk=
X-Google-Smtp-Source: ADFU+vtHW7gernPaKXQhWvxnUv09zon4nD4dRnylsMxdwqyt22NSmRVi3uIhx4q6fzqx8tF53mqq0w==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr10155732wma.114.1583754942047;
        Mon, 09 Mar 2020 04:55:42 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id m21sm25035226wmi.27.2020.03.09.04.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:55:41 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v6 6/6] mtd: spinand: micron: Add new Micron SPI NAND devices with multiple dies
Date:   Mon,  9 Mar 2020 12:52:30 +0100
Message-Id: <20200309115230.7207-7-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309115230.7207-1-sshivamurthy@micron.com>
References: <20200309115230.7207-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add device table for new Micron SPI NAND devices, which have multiple
dies.

Also, enable support to select the dies.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 55 +++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 9db1ab71fcae..f7d148aaa476 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -20,6 +20,14 @@
 
 #define MICRON_CFG_CR			BIT(0)
 
+/*
+ * As per datasheet, die selection is done by the 6th bit of Die
+ * Select Register (Address 0xD0).
+ */
+#define MICRON_DIE_SELECT_REG	0xD0
+
+#define MICRON_SELECT_DIE(x)	((x) << 6)
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
@@ -66,6 +74,20 @@ static const struct mtd_ooblayout_ops micron_8_ooblayout = {
 	.free = micron_8_ooblayout_free,
 };
 
+static int micron_select_target(struct spinand_device *spinand,
+				unsigned int target)
+{
+	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(MICRON_DIE_SELECT_REG,
+						      spinand->scratchbuf);
+
+	if (target > 1)
+		return -EINVAL;
+
+	*spinand->scratchbuf = MICRON_SELECT_DIE(target);
+
+	return spi_mem_exec_op(spinand->spimem, &op);
+}
+
 static int micron_8_ecc_get_status(struct spinand_device *spinand,
 				   u8 status)
 {
@@ -133,6 +155,17 @@ static const struct spinand_info micron_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
+	/* M79A 4Gb 3.3V */
+	SPINAND_INFO("MT29F4G01ADAGD", 0x36,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 80, 2, 1, 2),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status),
+		     SPINAND_SELECT_TARGET(micron_select_target)),
 	/* M70A 4Gb 3.3V */
 	SPINAND_INFO("MT29F4G01ABAFD", 0x34,
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -153,6 +186,28 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_HAS_CR_FEAT_BIT,
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
+	/* M70A 8Gb 3.3V */
+	SPINAND_INFO("MT29F8G01ADAFD", 0x46,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_CR_FEAT_BIT,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status),
+		     SPINAND_SELECT_TARGET(micron_select_target)),
+	/* M70A 8Gb 1.8V */
+	SPINAND_INFO("MT29F8G01ADBFD", 0x47,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_CR_FEAT_BIT,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status),
+		     SPINAND_SELECT_TARGET(micron_select_target)),
 };
 
 static int micron_spinand_detect(struct spinand_device *spinand)
-- 
2.17.1

