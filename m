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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D531C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517FB2192A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/+ec3Lz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgBFUYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:24:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35379 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgBFUYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:24:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so289945wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 12:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LFxMYCi8lGoovOV/sAYPGteEncrVIWaLSH+LK6Sw5BI=;
        b=k/+ec3LzTqJfjILFR0cc7f2Q6keBUxbOd+AiEs2of8GbeM6GGMyLV8t5tlwRr6KluB
         Q0ypKUjvislTnM12SgJdNMO4zs4w7G35fKiyxdPp8Ka+faKrRC7xfm0ai1SZ47cQERp8
         V58dZd8FLH99DbpwJCzA2vzmXw4+T85nRNz0CKl3lzj7gTFDukAGr9hZQ6iw9uzeamSZ
         yN5vr+4bbMkRnWqfCBA4hDpo5N+efpViK8lHR5qqNhCPP00uZM2tgoJHKaEqOIln125r
         BZR5072gpKse4NZwGg9LDF2VVgdT/4tOCILneL6geAW20JTdo2aV5GNv3ilenohoKFzP
         P1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LFxMYCi8lGoovOV/sAYPGteEncrVIWaLSH+LK6Sw5BI=;
        b=AqPpGEUboUjwws3Vhp74GDmNErJl9361ckEsPT8OgeNdrPnT0qv0ykPfLZFETJQAZw
         uP9YWlqBFp8Yrr7rkvxM2VPJbvIf8voZw/IdzCByMoA3IpOG0/VH9ss8MoE9GDePJCqM
         US0S3XYMiV8kT3HxWBOv29ehKgmzw39SsUeYQxXwuUpkpgMNXoKRjyT58ZyQZXHY7Fq4
         hqIUEnyUE9zaUbddVPEo+lanaMKI6nXXwbToonhyePB14kOEElca56fj2HdaN5TlvxR5
         h7Lw3om8spStbzEVXxxqLgc18mcjfnxG7jPGn8r3zeXq05+H8ga9AcdUtXHJSLEaJVKh
         K+4Q==
X-Gm-Message-State: APjAAAVqkZJix3HKVg2Vbj2yDK1FptqQdzGDXAUzqlozPeoA8mVNiijq
        ueZ7ckwMSc7N3gl1XPtHVCI=
X-Google-Smtp-Source: APXvYqyq7CoP1tZczuROmScct0k4Sx4IrB7cBccXjoqRWw1lrhus82/ttE+70/rzdw9FMMxc1pYF6w==
X-Received: by 2002:a1c:1f56:: with SMTP id f83mr6336867wmf.93.1581020676029;
        Thu, 06 Feb 2020 12:24:36 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id c13sm539929wrx.9.2020.02.06.12.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:24:35 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v4 3/5] mtd: spinand: micron: identify SPI NAND device with Continuous Read mode
Date:   Thu,  6 Feb 2020 21:22:04 +0100
Message-Id: <20200206202206.14770-4-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206202206.14770-1-sshivamurthy@micron.com>
References: <20200206202206.14770-1-sshivamurthy@micron.com>
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
index 5fd1f921ef12..a8e947609cd9 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -18,6 +18,8 @@
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
 #define MICRON_STATUS_ECC_7TO8_BITFLIPS	(5 << 4)
 
+#define MICRON_CFG_CONTI_READ		BIT(0)
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
+	if (spinand->flags == SPINAND_HAS_CR_FEAT_BIT)
+		return spinand_upd_cfg(spinand, MICRON_CFG_CONTI_READ, 0);
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

