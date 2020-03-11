Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5506C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDA520737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnncAEEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbgCKR7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:59:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41145 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730375AbgCKR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:58:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14so3816767wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=inRJj7F/F+AbnrSRtqE2WRG/KTJ90ug0HSiEeq5Pj94=;
        b=hnncAEEtg+JuFokx6qluoIDGPjGjDCUHe/CaMVrGS+t8kul2ZMdoTNwxanLMkn/tsS
         kB2NMrxOHdP3ZxRW8Gt1a9jwj8JXYYz7ggw/FyNAovZG0yeV4aSObJLAAjZq6JuS9oE5
         nKhHiosX8ZuVzjK5Pp5BEwixnPaplON1R/rgy4cHIAl8sj1r/TCh5xZ9H487/nqztatL
         7vYiGZnNCRfGgnT5FXLOKMVgzgSmHVU4rUMhttkHDxudcOcy0rvtLOYW1piFZGoO3Ol+
         wvk8XB9vG//vjjjZU4mm9IC5RrMksT7ERrHgxS1FyRUdxp7LjuR8yJ4XCxrCxJu2x40b
         g6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=inRJj7F/F+AbnrSRtqE2WRG/KTJ90ug0HSiEeq5Pj94=;
        b=pmawbI6wrplzA+cNrDPpUjj6EBfclnT4exeBoxTHYsZ/Y7w3kLscyYfISkaBQ3na5d
         mSqsCfRlZkOTdZ+2/ZoAjojcK7IsNemFKkfiRq5iaFlip55fKePlY4ZQPOe0oNSVgQIn
         js9I5hcT4Peb46r1fiZsAS9sl20RvNDMOd7UTSLE1mM+m1fNwYZe9bsHW69gpz8SVDFQ
         4qc1Sa5pzr7A3AkXfwsa4t6qkicEbu0XhpDOsWwYAAOmE7OAcsjQiZXv2yIa3PpIF+rQ
         1/JgnCfpcLxOkI8KI+agxOVwb++UjNR1fddF3KJsTtTkJm0qFYIrcxJIPeXWaqKcGaUS
         hEZA==
X-Gm-Message-State: ANhLgQ1l/d7wkB53O6Ozoj1fSNiu7JC4zG+Vn98B518pRDzbYqqMmC8O
        HLJRmjwcjMmWKtMMxilUpwg=
X-Google-Smtp-Source: ADFU+vs5z+HMwUCXtWkE+RoE8aWn/MuWk8pCgfPI8JtM44InUqEHPsnwufNPB0dl/+OoyaIBAU8AYA==
X-Received: by 2002:adf:94a3:: with SMTP id 32mr6039829wrr.276.1583949532613;
        Wed, 11 Mar 2020 10:58:52 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id l18sm1502107wrr.17.2020.03.11.10.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:58:51 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v7 4/6] mtd: spinand: micron: identify SPI NAND device with Continuous Read mode
Date:   Wed, 11 Mar 2020 18:57:33 +0100
Message-Id: <20200311175735.2007-5-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311175735.2007-1-sshivamurthy@micron.com>
References: <20200311175735.2007-1-sshivamurthy@micron.com>
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
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/mtd/nand/spi/micron.c | 16 ++++++++++++++++
 include/linux/mtd/spinand.h   |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 26925714a9fb..956f7710aca2 100644
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
@@ -137,7 +139,21 @@ static const struct spinand_info micron_spinand_table[] = {
 				     micron_8_ecc_get_status)),
 };
 
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
+	.init = micron_spinand_init,
 };
 
 const struct spinand_manufacturer micron_spinand_manufacturer = {
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index f4c4ae87181b..1077c45721ff 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -284,6 +284,7 @@ struct spinand_ecc_info {
 };
 
 #define SPINAND_HAS_QE_BIT		BIT(0)
+#define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
-- 
2.17.1

