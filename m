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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41B4C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EC32051A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ99WF4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgCILzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:55:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43345 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgCILzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:55:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id v9so10687714wrf.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xNSnSJKXH2EkPaG4hjJt+WELoZtykx3G8gAN3oUER3Y=;
        b=jZ99WF4I2fRMtsfaQ8dSgmMyyh7DWUCBGMfaBLwJkx8xAdU67/hzTtHoBs8BXtmoe4
         noU5Dyx/6OknofOC9bPlRhd0oiBGFtSm+XJPTxgq0sZYsrmRQBPJCVmkrZ0YLkc6JnL+
         64G9JuV9oVLVHzk/wDaCaXBFnAJ1WhWx+vQYMTnEekHWxUy4xS5J4ZkaO/eiRuUdYRS0
         qjxZm5xPyVbL3Tx2kY3rU/xUGiDaP+9dBu0nFsUyMKbi4upiQ6kuvQsSYo8D6tF1+Cww
         W3lNrpLOuGNTMRdONYQlMYeDk4wTb2JGeCVRm1/f+OsaPDvSXvuhq9E8WYQvHrBm9H0S
         Jutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xNSnSJKXH2EkPaG4hjJt+WELoZtykx3G8gAN3oUER3Y=;
        b=ichw2+ox3zFNoulH9aNmFZPBUZRyiHNJCMv48EsAKrWmbQcCaxGAZI1vRsujnW7nxF
         7cMbWb2+0a07cmgNfUSzL+Hu3Z8am9CmJRtuBhlaB6Rs61Cc3o0e5vx0hWUx2BSI/uHn
         tdRA9BlftdqVnLjIAJH4r4S09UpHFp8hHLBfqSZevXCpTPE8HfDFEbY/0RlJYOYA4OfV
         II887LYxJ36FEvcfIEkEeSPjmwa3EVmuSxu8tzB/09sM9mcOe0OUZPiptwC9SX3tF85/
         iuDQyVgbR9NTYp3GrGHu533PkJy9N4TSkL2kr/ZDLmr3XrGPD6UR1+jyHAih3KKmlHzc
         ZX7Q==
X-Gm-Message-State: ANhLgQ0I/vGUGhtXBR5H7l67Q4qLEWLJPEjE+CSnlgIZkO6SSeNvxEPF
        07bNAgOzLe76iXMYjhHPE0kGZVSz
X-Google-Smtp-Source: ADFU+vt2XKelxwVGqJjD55nLHTjQb1eiD81FPw7LKv4smViOuAm8TzRSnFd/oE7McEarGyC+ZzncvQ==
X-Received: by 2002:adf:fc06:: with SMTP id i6mr7576104wrr.285.1583754939622;
        Mon, 09 Mar 2020 04:55:39 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id m21sm25035226wmi.27.2020.03.09.04.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:55:38 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v6 4/6] mtd: spinand: micron: identify SPI NAND device with Continuous Read mode
Date:   Mon,  9 Mar 2020 12:52:28 +0100
Message-Id: <20200309115230.7207-5-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309115230.7207-1-sshivamurthy@micron.com>
References: <20200309115230.7207-1-sshivamurthy@micron.com>
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

