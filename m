Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD97DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982B7206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6nxr6YQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgESKR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgESKRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:17:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7F0C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:17:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h17so15211005wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zgSEgyu5An5GyigcNkf1Yhsncd+sLucumkdkFEyxqlE=;
        b=q6nxr6YQHJig4FIQLsOZ+PDKr+h8lboz/+1TJtyQBJ/+DCsA6WHQjS/WODxjKswbCt
         MZIWPphEjJWZAw6MLtsHSO4RiTBsipgYIeNrb8wNxFlB/dkPYbrfEKZpM3/6V7N/sb+O
         QfwXpPA2lsaIH1KJ0a176usfs+CNIsDyFDjE/u/he8cUkSLOJ6Gl3pkpx//p2+nWdNcv
         +cI9xJCd2soTYEPeZcjVVClB7+20HesVVKR+qNu+swiFIgjzC9JI4BlL45n1TGzYjhBP
         fN2l/BdpjbxAuFhgoAnzT+xadt3MpnW2KT0hvbgTPYMKkAjn26lR3xyAwo8vufRwKnIm
         /ZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zgSEgyu5An5GyigcNkf1Yhsncd+sLucumkdkFEyxqlE=;
        b=PiSlVlOTpUgDUJuHbBlmJZLWgNBRDBpDPs2mac1EXEgP1HEjT0aYXRQXgM+1jdNb9F
         I1Vf6KPwPyQRIEoLPT/AeKCjYTVfyVHMwPVU5cDEKCTNhkyjEWbJQne9LUahxjTW+o9K
         9yYS2qRlEf6P0ctty6JAsO0yIvnRwZkOUoMw0hdcOmLMrewJNVPsVhQBklTGRCbf3NnU
         E3bUTSRsbKxL8hUxCJigC6IT3Gu/H3u+/B8lF2BshdC2coWfhSf1SeO/wFsBffdD/pco
         ZXtdg064aD16idwrq5GDOHOCIOzIffmSWwHie/SJ3MgMCRpCJy2a7qfJyrzAe2MP6p84
         C+5Q==
X-Gm-Message-State: AOAM531K0plebjEsmO9Vts5jab4+QxJBQ4HwHmu9qJwvrh8/gAVNUkP7
        sKF77vUjBLJV3ppEOvTiO60=
X-Google-Smtp-Source: ABdhPJzb/prlS7H0turq6VxBxGXU2pntYezfTvzREHoKOQ/5DLsF12XHH6sMIscmiNnQgoujF3Oxfg==
X-Received: by 2002:a05:6000:1c5:: with SMTP id t5mr26834855wrx.229.1589883471218;
        Tue, 19 May 2020 03:17:51 -0700 (PDT)
Received: from ubuntu-G3.micron.com ([165.225.86.140])
        by smtp.gmail.com with ESMTPSA id w15sm3062488wmi.35.2020.05.19.03.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:17:50 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        huobean@gmail.com, Bean Huo <beanhuo@micron.com>
Subject: [RESET PATCH v5 2/5] mtd: rawnand: Add {pre,post}_erase hooks in nand_chip_ops
Date:   Tue, 19 May 2020 12:17:31 +0200
Message-Id: <20200519101734.19927-3-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519101734.19927-1-huobean@gmail.com>
References: <20200519101734.19927-1-huobean@gmail.com>
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
index 7af21cf49290..e90b7ae878e2 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4318,7 +4318,7 @@ static int nand_erase(struct mtd_info *mtd, struct erase_info *instr)
 int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 		    int allowbbt)
 {
-	int page, pages_per_block, ret, chipnr;
+	int page, pages_per_block, ret, chipnr, eb;
 	loff_t len;
 
 	pr_debug("%s: start = 0x%012llx, len = %llu\n",
@@ -4372,16 +4372,24 @@ int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
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
index 62932cc3ed8d..df3d4b3ef2f6 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1027,12 +1027,14 @@ struct nand_legacy {
 
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
@@ -1040,6 +1042,8 @@ struct nand_chip_ops {
 	int (*lock_area)(struct nand_chip *chip, loff_t ofs, u64 len);
 	int (*unlock_area)(struct nand_chip *chip, loff_t ofs, u64 len);
 	int (*setup_read_retry)(struct nand_chip *chip, int retry_mode);
+	int (*pre_erase)(struct nand_chip *chip, u32 eraseblock);
+	int (*post_erase)(struct nand_chip *chip, u32 eraseblock);
 };
 
 /**
-- 
2.17.1

