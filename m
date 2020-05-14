Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E6AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115BA2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ysospds4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgENVX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgENVX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:23:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578C9C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 14:23:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 50so593947wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 14:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lEf87Wr/V1F+OPpc1tEBH5YE7A4qvblf+IVSWacua8w=;
        b=Ysospds43Xh0QFZ2lbtrrrAKV1QECg+AWCmc5NsD79uveASjy2zyTD9fq1PSHYHxhN
         wPata0MzJ2+vVCAriWRYFb86pAxVONPdb5cCJFKRQXsTJHcdYXsW4bpmkJ0sMwT6Fo4g
         uJYGk8mSt+NWiyqSba+rPRZTXjl6s8irE2X4DOA35ROfe98LZgRurHyg8CSyOG7vTzu6
         zeqmE0Dmef/EvAiLJ+JX9Z0Vk6+c9lc4FXp1sGTwMQ8k6GZRn6AONq5zbIaZZwcB6HPT
         ERz8t1ZTS7EWXAF2iLZ1WYrGXUWbGm1qOOLq9NqcgShqtTO5w9r3BOTEFhut0l2WQdbR
         A6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lEf87Wr/V1F+OPpc1tEBH5YE7A4qvblf+IVSWacua8w=;
        b=MY9LFYW+I33zSubYY36OeccYLBbjVRQa8HLha4GZXabMTDs9j2cEEG+2w7d68fg4Nm
         biRasY9cVrAbyb2HMlwRDJ4bedhl1GP7wbItmtUToegwdfOegQHG+Lyw7Egq2wtHcOpy
         WmgU3FGiI/WLrrkQlmv4wJYMyABhy6sqyLr7G/xCGfGLcwPoliCpAvFcikGBV9Oedpoa
         kD8eUAs5sbWA7Kr2bDAiP6HpmhY8oqxnJTvQm5qHRVjwg4J4+b1Ypawy80+a5KgLWWV3
         AirXfzseiPigF5XVqdhX7qLbROzBhpHHZ2X2dnWjCTCSloeUm2qxq2f8Mt/HIxIB4k3y
         ZbSw==
X-Gm-Message-State: AOAM533Vk1vDQZHZ0izvhoBvi2QUaKtrpH8VGWMzroXe+n5fp7nl5w84
        0q1AroZyuC8L2+50y7j9IHE=
X-Google-Smtp-Source: ABdhPJwhEuXRhgtqSfq/CKImJE72MohMis9XhR8MhMsNEujmDHNY6z1wbmdQ3+IVC+6XFalnjsztVg==
X-Received: by 2002:adf:f386:: with SMTP id m6mr434002wro.88.1589491435071;
        Thu, 14 May 2020 14:23:55 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bfcc8.dynamic.kabel-deutschland.de. [95.91.252.200])
        by smtp.gmail.com with ESMTPSA id 128sm491210wme.39.2020.05.14.14.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 14:23:54 -0700 (PDT)
From:   huobean@gmail.com
X-Google-Original-From: beanhuo@micron.com
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v3 4/5] mtd: rawnand: Introduce a new function nand_check_is_erased_page()
Date:   Thu, 14 May 2020 23:23:32 +0200
Message-Id: <20200514212333.28692-5-beanhuo@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514212333.28692-1-beanhuo@micron.com>
References: <20200514212333.28692-1-beanhuo@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Add a new function nand_check_is_erased_page() in nand_base.c, which is
used to check whether one programmable page is empty or already programmed

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mtd/nand/raw/nand_base.c | 49 ++++++++++++++++++++++++++++++++
 include/linux/mtd/rawnand.h      |  2 ++
 2 files changed, 51 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index b630f7f6a651..2bc9be745bc1 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -2584,6 +2584,55 @@ int nand_check_erased_ecc_chunk(void *data, int datalen,
 }
 EXPORT_SYMBOL(nand_check_erased_ecc_chunk);
 
+/**
+ * nand_check_is_erased_page - check if this page is a empty page
+ * @chip: nand chip info structure
+ * @page_data: data buffer containing the data in the page being checked
+ * @oob: indicate if chip->oob_poi points to oob date of the page
+ *
+ * Returns true if this is an un-programmed page, false otherwise.
+ */
+int nand_check_is_erased_page(struct nand_chip *chip, u8 *page_data, bool oob)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	int ret, i, max_bitflips;
+	u8 *databuf, *eccbuf = NULL;
+	struct mtd_oob_region oobregion;
+	int datasize, eccbytes = 0;
+
+	databuf = page_data;
+	datasize = chip->ecc.size;
+
+	if (oob) {
+		mtd_ooblayout_ecc(mtd, 0, &oobregion);
+		eccbuf = chip->oob_poi + oobregion.offset;
+		eccbytes = chip->ecc.bytes;
+	}
+	max_bitflips = 0;
+
+	for (i = 0; i < chip->ecc.steps; i++) {
+		ret = nand_check_erased_ecc_chunk(databuf, datasize,
+						  eccbuf, eccbytes,
+						  NULL, 0, chip->ecc.strength);
+		if (ret < 0)
+			return false;
+
+		max_bitflips = max(ret, max_bitflips);
+
+		databuf += chip->ecc.size;
+		eccbuf += chip->ecc.bytes;
+	}
+
+	/*
+	 * As for the empty/erased page, bitflips number should be zero or at
+	 * least less than the bitflip_threshold.
+	 */
+	ret =  max_bitflips < mtd->bitflip_threshold;
+
+	return ret;
+}
+EXPORT_SYMBOL(nand_check_is_erased_page);
+
 /**
  * nand_read_page_raw_notsupp - dummy read raw page function
  * @chip: nand chip info structure
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index a1bb2acfaf6a..bb97b48859f9 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1322,6 +1322,8 @@ int nand_check_erased_ecc_chunk(void *data, int datalen,
 				void *extraoob, int extraooblen,
 				int threshold);
 
+int nand_check_is_erased_page(struct nand_chip *chip, u8 *page_data, bool oob);
+
 int nand_ecc_choose_conf(struct nand_chip *chip,
 			 const struct nand_ecc_caps *caps, int oobavail);
 
-- 
2.17.1

