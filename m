Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38062C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04B7246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isJ8mi++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgB1PDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:03:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38606 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgB1PD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:03:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id n64so2203653wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 07:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xNSnSJKXH2EkPaG4hjJt+WELoZtykx3G8gAN3oUER3Y=;
        b=isJ8mi++bCKg0QwA3LH/R8iKb3ngkv58+4RVGVxiTngZMUaTScwi8uVDNccUZTaENn
         yB3vDTxAT0/pVWBZEbflkmopna9V4tN6TEJQetSH0u+1T8A35Y2ITlvugSVngPJhCGiY
         tTfMzRKoA4Eqf11dsWgzBA0Sk2Mtry95qcGQghC6AOYzTTaNR7g7u6xJVY7i+Wnt7M3e
         PdxAB0hBfJQu6cNC4yFQvlYuQ8AB+ejD+j3UI5SW6kfizbXtb0k/FjAKdo0He61fZOoU
         CWZvIvHFGjU39i/wjY3LA5p4vzrCdQ6hVGub4lfDdzn6vyYEyJqIQNlXsRLutp260dH2
         SDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xNSnSJKXH2EkPaG4hjJt+WELoZtykx3G8gAN3oUER3Y=;
        b=fgQ+l3pPPY+llyxVwokMUU/PHUN3czgT8V8KJIrza+MmZWpEv0b9eoRMi08zFvc28G
         02vIb6aSfn9TDzWEnd3pTdVby2z+Yy01qQw2KhORWaWWjsN4PstT29rUuS3PXU3/zdr7
         aXt6Q3MrfCIDSrxJ5PcWkO9ZP60+8iYTlJNv9vFjnjbAHjjRXQJe5FEO5WU5wipXCYpd
         uH5wmd97QY4b/Toj5XsIvgpsHldCKSnPtQCo50SUsvRl6YPNMnxSdqDJjc6TfHy02cRm
         hWHvZfbsFLnC4OW1DWNnYwVyRpcfo6QO/eca+UVlMaevJXxIKsNBl1A5iwUYcHULtOX6
         9LpA==
X-Gm-Message-State: APjAAAV0pmJDYi6kTtLJCbdAXKCnjqBwSi+2uIFXuV+YE2w/GzvbrFcp
        nWLgIbEeL1OKdPbNWNqH+aU=
X-Google-Smtp-Source: APXvYqwl5wksvi5lEi7JJEQ44SKgkAmAfwlNJG3BxMTJZCWLSr2w7QkyiFh8ErKiyNfWrkk7Jzzw8g==
X-Received: by 2002:a1c:df45:: with SMTP id w66mr5155697wmg.171.1582902207037;
        Fri, 28 Feb 2020 07:03:27 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id m125sm2540235wmf.8.2020.02.28.07.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:03:25 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v5 4/6] mtd: spinand: micron: identify SPI NAND device with Continuous Read mode
Date:   Fri, 28 Feb 2020 16:03:09 +0100
Message-Id: <20200228150311.12184-5-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228150311.12184-1-sshivamurthy@micron.com>
References: <20200228150311.12184-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add SPINAND_HAS_CR_FEAT_BIT flag to identify the SPI NAND device with
the Continuous Read mode.

Some of the Micron SPI NAND devices have the "Continuous Read" feature
enabled by default, which does not fit the subsystem needs.

In this mode, the READ CACHE command doesn't require the starting column
address. The device always output the data starting from the first
column of the cache register, and once the end of the cache register
reached, the data output continues through the next page. With the
continuous read mode, it is possible to read out the entire block using
a single READ command, and once the end of the block reached, the output
pins become High-Z state. However, during this mode the read command
doesn't output the OOB area.

Hence, we disable the feature at probe time.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/micron.c | 16 ++++++++++++++++
 include/linux/mtd/spinand.h   |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 5fd1f921ef12..ff0a3c01441d 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -18,6 +18,8 @@
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
 #define MICRON_STATUS_ECC_7TO8_BITFLIPS	(5 << 4)
 
+#define MICRON_CFG_CR			BIT(0)
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
@@ -153,8 +155,22 @@ static int micron_spinand_detect(struct spinand_device *spinand)
 	return 1;
 }
 
+static int micron_spinand_init(struct spinand_device *spinand)
+{
+	/*
+	 * M70A device series enable Continuous Read feature at Power-up,
+	 * which is not supported. Disable this bit to avoid any possible
+	 * failure.
+	 */
+	if (spinand->flags & SPINAND_HAS_CR_FEAT_BIT)
+		return spinand_upd_cfg(spinand, MICRON_CFG_CR, 0);
+
+	return 0;
+}
+
 static const struct spinand_manufacturer_ops micron_spinand_manuf_ops = {
 	.detect = micron_spinand_detect,
+	.init = micron_spinand_init,
 };
 
 const struct spinand_manufacturer micron_spinand_manufacturer = {
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 4ea558bd3c46..333149b2855f 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -270,6 +270,7 @@ struct spinand_ecc_info {
 };
 
 #define SPINAND_HAS_QE_BIT		BIT(0)
+#define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
-- 
2.17.1

