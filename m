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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0390EC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDD1206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAO4BawG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgCKR7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:59:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35086 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730684AbgCKR65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:58:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id m3so3161580wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v2t+NVS/HW3PqacteoPv2Uzni2FFv9fx2gNtRXkNHUs=;
        b=BAO4BawGO6hw5QFFqCXXUkbiYmVYtXOIkqe/830SqK2Vb2fA69VvA0KnCugBkp7FvU
         5CA0eXj9DP7zARLhqjCnenxIrBdw+yCTkpNisvQxJplQodfY9q91NArnWlImilJ1fXpR
         2C/cKupvLR7rdAy5xIPintmLY6Hnhq+zyGbVSL5a2OC0xlNXcvODEim2hLYyhSFpbhHv
         JZovjsVpd/ijwgdxCClLYQcr7X0Im9fns3NsEbkMnmwtQg3ggcaQxsJ+saosb4xD7l+2
         Fgt/HcTTpIH4PRAInlg7KLEpzAvoAzpXP7ICLCb9+sM3p0jF+KkDbHBRxowWtcRfN7k3
         RFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v2t+NVS/HW3PqacteoPv2Uzni2FFv9fx2gNtRXkNHUs=;
        b=ImRTLHhgn+FhjwPfBDXAqpCTfL1HfBhgNEtZj442hr0QHDkI11ZZLodIH6iOvDCR7T
         45P5guU+7Y5g4trj6mn257KUnuujFaI3n0jQX/Rhm0IV1HKUz/VDiqiNAgw1laTDunTS
         3lI+qkw2T3rGOVRCAvP12sQJ1wltlrs9pKDDMQG1VT/JfcxwQ8yrhKtD0vt1oj709Fyd
         g4ErXmg7lLn6wopVb1wpCtcv3MaM3hmtLaJwOro7s0CvXO/hpIStY3aIMKlCrqqLosFI
         zOAAfZ6w0oEJk6DH+h9GPt5E7SdJa35wLII9Vyg9J2gDLPM2+0E38vUyrp/T89UeRIR3
         2nGQ==
X-Gm-Message-State: ANhLgQ0f6reNNjKmagNyrksD8O+Od4Jcq6hZKirFCZevbRcw5sTCi6y6
        y9kFMonzHPSsYbhukMRqTfk=
X-Google-Smtp-Source: ADFU+vuNAIZgWXGoRiNR8ZkTY6DTs4PVG0Qi5nqBJNQ0jC/0On4au6lzwFLjX/8+ov6DPZHWKpYfHw==
X-Received: by 2002:a1c:5fc5:: with SMTP id t188mr2163818wmb.110.1583949534123;
        Wed, 11 Mar 2020 10:58:54 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id l18sm1502107wrr.17.2020.03.11.10.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:58:53 -0700 (PDT)
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
Subject: [PATCH v7 5/6] mtd: spinand: micron: Add M70A series Micron SPI NAND devices
Date:   Wed, 11 Mar 2020 18:57:34 +0100
Message-Id: <20200311175735.2007-6-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311175735.2007-1-sshivamurthy@micron.com>
References: <20200311175735.2007-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add device table for M70A series Micron SPI NAND devices.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/mtd/nand/spi/micron.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 956f7710aca2..d6fd63008782 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -137,6 +137,28 @@ static const struct spinand_info micron_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
+	/* M70A 4Gb 3.3V */
+	SPINAND_INFO("MT29F4G01ABAFD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x34),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_CR_FEAT_BIT,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
+	/* M70A 4Gb 1.8V */
+	SPINAND_INFO("MT29F4G01ABBFD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_CR_FEAT_BIT,
+		     SPINAND_ECCINFO(&micron_8_ooblayout,
+				     micron_8_ecc_get_status)),
 };
 
 static int micron_spinand_init(struct spinand_device *spinand)
-- 
2.17.1

