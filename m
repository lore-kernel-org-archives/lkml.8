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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BC8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100212065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQywWIn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgENVX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgENVXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:23:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E82C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 14:23:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id m12so27460209wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 14:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lOO96wShAJuqAKs9HTsMILVEmF21sJSmi2TS/KIsZio=;
        b=tQywWIn+EQM58SefyACM7saPcnu0WrnBE7CVKDLYcJKvF0TF0kpVMMsWl07+aXsIFN
         nNqDWuyGj8Qo1Qn8cWKIaMikHmDSJmxZm138w1tc2G0YA4ZXMoInsKvEgWSlqiF7wNNb
         UwI7XZegXPGOmO8IpQHBDV5Jj5ceOt3qkF38htqD0ZOKy4/1S+ppfvgbPCXsuS/TMiUM
         rIVG+kMsslB3jhLXpRdTrPTVnoR4SUEHytb0MD4wZjoyYRUXdG+5vNbOtodS+2BamKwr
         NaPTNye9gRq6NobW8N3qz4V/kcXmzbcqX1sJg0qVvhe7cg2UBJHpX7vkyG9EvileZUbb
         6xtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lOO96wShAJuqAKs9HTsMILVEmF21sJSmi2TS/KIsZio=;
        b=sBWGLM+LGOT0uCvsvD7Y8TBqa3QkSt8fkEhA/OSmZmBSZEvYs0Gh0wSkNoBRu6yCOV
         3979CbT6+E5UDO4jExwYPo4Tt0/T+4d5u7haDaQaOALxIqZdspWGU5nUf2Be6VA0XiIn
         rn5eX9oIR6B2ahXKbCfIj8Ycmwzu78wCoiJFK3xIwNlf+q0g/UIvCOqsdCxsSp5CrysT
         WfqcrZsn0TxblHUi1jwndla1A7DiZpVhxv6zbwunzBdIkUA0VCsNVa5rxZjIpmnlSRF0
         zIT5yA4/iTB9pKlANRiNy0WmyvCRpKRsYUjxDT72LuLHe0tyKEoPlE3XvYhQYwg7ncqC
         Tb5g==
X-Gm-Message-State: AOAM532VQiHMLAn5qHEfaUJmZnDKcC7rqNT2SOInNuQYZUaPUV0SEFla
        CnERrpTp+El1bE6Wqa9CsaY=
X-Google-Smtp-Source: ABdhPJybyMp/7RRfr70w9s/bNCxLau75t6A3qL7/kggPaMS1TEgCk4YCZ3jmZxKyRhRdiufFCbYjdw==
X-Received: by 2002:a05:600c:1403:: with SMTP id g3mr320697wmi.51.1589491431114;
        Thu, 14 May 2020 14:23:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bfcc8.dynamic.kabel-deutschland.de. [95.91.252.200])
        by smtp.gmail.com with ESMTPSA id 128sm491210wme.39.2020.05.14.14.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 14:23:50 -0700 (PDT)
From:   huobean@gmail.com
X-Google-Original-From: beanhuo@micron.com
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v3 2/5] mtd: rawnand: Add {pre,post}_erase hooks in nand_chip_ops
Date:   Thu, 14 May 2020 23:23:30 +0200
Message-Id: <20200514212333.28692-3-beanhuo@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514212333.28692-1-beanhuo@micron.com>
References: <20200514212333.28692-1-beanhuo@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Add {pre,post}_erase hooks in the structure nand_chip_ops:
pre_erase will be called before a block is physically erased.
post_erase will be called after a block is erased.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mtd/nand/raw/nand_base.c | 18 +++++++++++++-----
 include/linux/mtd/rawnand.h      | 16 ++++++++++------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index a9432e9abf82..842490d9fd09 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4172,7 +4172,7 @@ static int nand_erase(struct mtd_info *mtd, struct erase_info *instr)
 int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 		    int allowbbt)
 {
-	int page, pages_per_block, ret, chipnr;
+	int page, pages_per_block, ret, chipnr, eb;
 	loff_t len;
 
 	pr_debug("%s: start = 0x%012llx, len = %llu\n",
@@ -4226,16 +4226,24 @@ int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 		    (page + pages_per_block))
 			chip->pagecache.page = -1;
 
-		ret = nand_erase_op(chip, (page & chip->pagemask) >>
-				    (chip->phys_erase_shift - chip->page_shift));
+		eb = (page & chip->pagemask) >>
+			(chip->phys_erase_shift - chip->page_shift);
+
+		if (chip->ops.pre_erase)
+			chip->ops.pre_erase(chip, eb);
+
+		ret = nand_erase_op(chip, eb);
 		if (ret) {
-			pr_debug("%s: failed erase, page 0x%08x\n",
-					__func__, page);
+			pr_debug("%s: failed erase block %d, page 0x%08x\n",
+					__func__, eb, page);
 			instr->fail_addr =
 				((loff_t)page << chip->page_shift);
 			goto erase_exit;
 		}
 
+		if (chip->ops.post_erase)
+			chip->ops.post_erase(chip, eb);
+
 		/* Increment page address and decrement length */
 		len -= (1ULL << chip->phys_erase_shift);
 		page += pages_per_block;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 8f5871cf2542..f60cfe93b226 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1012,12 +1012,14 @@ struct nand_legacy {
 
 /**
  * struct nand_chip_ops - NAND Chip specific operations
- * @suspend:           [REPLACEABLE] specific NAND device suspend operation
- * @resume:            [REPLACEABLE] specific NAND device resume operation
- * @lock_area:         [REPLACEABLE] specific NAND chip lock operation
- * @unlock_area:       [REPLACEABLE] specific NAND chip unlock operation
- * @setup_read_retry:  [FLASHSPECIFIC] flash (vendor) specific function for
- *                     setting the read-retry mode. Mostly needed for MLC NAND.
+ * @suspend:		[REPLACEABLE] specific NAND device suspend operation
+ * @resume:		[REPLACEABLE] specific NAND device resume operation
+ * @lock_area:		[REPLACEABLE] specific NAND chip lock operation
+ * @unlock_area:	[REPLACEABLE] specific NAND chip unlock operation
+ * @setup_read_retry:	[FLASHSPECIFIC] flash (vendor) specific function for
+ *			setting the read-retry mode. Mostly needed for MLC NAND.
+ * @pre_erase:		[FLASHSPECIFIC] prepare a physical erase block
+ * @post_erase:		[FLASHSPECIFIC] physical block erase post
  */
 struct nand_chip_ops {
 	int (*suspend)(struct nand_chip *chip);
@@ -1025,6 +1027,8 @@ struct nand_chip_ops {
 	int (*lock_area)(struct nand_chip *chip, loff_t ofs, u64 len);
 	int (*unlock_area)(struct nand_chip *chip, loff_t ofs, u64 len);
 	int (*setup_read_retry)(struct nand_chip *chip, int retry_mode);
+	int (*pre_erase)(struct nand_chip *chip, u32 eraseblock);
+	int (*post_erase)(struct nand_chip *chip, u32 eraseblock);
 };
 
 /**
-- 
2.17.1

