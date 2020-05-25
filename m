Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D05C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A282073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDVqoWqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbgEYMSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 08:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390196AbgEYMSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 08:18:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9D3C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:18:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j198so2869374wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ESfsoKlv3Llhx9eyEI7HcxAzaPZGosDjRxZ21yaiW5c=;
        b=LDVqoWqgfksdNgzbBs0mW5BUlWdwRuzRPremNBMFjSvHw7MbbYfvuihyk6FESesJns
         gTWcZE8XS47qGVLZY0d1gyFOfXi70U+P03in3l6lbLv5h768zheCJvpwqwkONbIeIij3
         LXHomugpkcTR5WUtCvsdmgB3588NZ2EIcdVpvdhdHS8Z3KI6PuWp7TjBKjui5DPT7r4b
         whMzDYG1ctT+c4WEJZ95GLNtVKKbRNnon0FMGwefHIYII/m+RD8gHX/EuQOFagZq7eoo
         369pFu13PnqWT2GyXFOiGPStVFEN3MBulaKWC25DzWMZi3S8qYuGEYr6CAU2J+GYQwbC
         Hn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ESfsoKlv3Llhx9eyEI7HcxAzaPZGosDjRxZ21yaiW5c=;
        b=YbiHAb5Dycx7KEAkoAEKYJhVrjDDF5m+2GcZaNFchjebqyAu7dwmoVOvBgHcVyKvnv
         x7VYVlpbUluvBa/qWdbTdtV4uhjJk8CEuLFdAP0QjwSOS2z6rEL3lFj1IJdDjjikXJRB
         gJBjx0WA624dcnV8+GvsyG2rVpZpVNWysWksKecF0lnjNJbNUkMH6kMvDBzrMD7S88wI
         vdfwOjmU/aq4tNJsm7tHP5SnMus3clt9pxDKrBhzbN8Bi3a4jll5PWUG/j1Ly4efbWRY
         3ADlLVGT7nYB6Xz9cxVK2I+kh5YmnPFP5GBPvLbyPXCq9NY/Mj+u7kHiZ+Sd6yE9rzTO
         qafA==
X-Gm-Message-State: AOAM530PzKEc4Saau2vTlZokN2zZ3RaKJPG5Rj3DoTP7fZcY8cAflO7y
        tj7xuSfLiw57Qv3rF0Pj64Y=
X-Google-Smtp-Source: ABdhPJwkvym87KRYU3fcEG8LCdnFPWaXPFWZG/C1VU/MgRgxDcj6pMJJ59TxmRLBiF9Z+joBW4gQPA==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr24227468wmc.76.1590409123878;
        Mon, 25 May 2020 05:18:43 -0700 (PDT)
Received: from ubuntu-G3.micron.com ([165.225.203.62])
        by smtp.gmail.com with ESMTPSA id 10sm18136635wmw.26.2020.05.25.05.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 05:18:43 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        huobean@gmail.com, Bean Huo <beanhuo@micron.com>
Subject: [PATCH v6 2/5] mtd: rawnand: Add {pre, post}_erase hooks in nand_chip_ops
Date:   Mon, 25 May 2020 14:18:10 +0200
Message-Id: <20200525121814.31934-3-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525121814.31934-1-huobean@gmail.com>
References: <20200525121814.31934-1-huobean@gmail.com>
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
index b86f641f6d74..3de53c42fb74 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4369,7 +4369,7 @@ static int nand_erase(struct mtd_info *mtd, struct erase_info *instr)
 int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 		    int allowbbt)
 {
-	int page, pages_per_block, ret, chipnr;
+	int page, pages_per_block, ret, chipnr, eb;
 	loff_t len;
 
 	pr_debug("%s: start = 0x%012llx, len = %llu\n",
@@ -4423,16 +4423,24 @@ int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
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
index 0c73e9a81e3a..59150f729cf0 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1029,12 +1029,14 @@ struct nand_legacy {
 
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
@@ -1042,6 +1044,8 @@ struct nand_chip_ops {
 	int (*lock_area)(struct nand_chip *chip, loff_t ofs, u64 len);
 	int (*unlock_area)(struct nand_chip *chip, loff_t ofs, u64 len);
 	int (*setup_read_retry)(struct nand_chip *chip, int retry_mode);
+	int (*pre_erase)(struct nand_chip *chip, u32 eraseblock);
+	int (*post_erase)(struct nand_chip *chip, u32 eraseblock);
 };
 
 /**
-- 
2.17.1

