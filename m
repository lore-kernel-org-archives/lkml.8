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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889B0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DF92073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEy5EDr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390542AbgEYMSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 08:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390196AbgEYMSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 08:18:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A437EC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:18:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so11523191wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tVA1UbOaARrvvv1nlYyFoEmayQWYr9sKJ7BoMFNxaQk=;
        b=BEy5EDr9haL+F0ICTwU1254kVADvxBIYDTTH+LQKwuWjj5ubU4pvHRj0xn4d2T8EQh
         6D2fTveYYKSZFhAzyA7vLt65JccZVR2weFUSR3jouLVxxF4DiepNTxFEl6XJ4+OHO2Un
         wooRh97Oh8vle8uffYNF7Xby2Mgy/ln54AFl1O8IUVSKyby1e12rKWw85m/23LSIr1XI
         9m1C/Vl/gq1LOJ/2HC9Z+2SU1FCFcNauo/1DATTekWNMwcMmthi1DKsTuA4bE3bu2dAq
         aBeBSSR1lVYUEh5zi3sXuZ3d41cN+x4haDbynGJ9/JzlesP6YO/20jvYYhzNQIl85/Kv
         kZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tVA1UbOaARrvvv1nlYyFoEmayQWYr9sKJ7BoMFNxaQk=;
        b=thixJCUpKkHztO3aThas/m9sN7oNCViy8DHXkCc9aSYi/4A5FJsnDUaDoJeLzfV9Ay
         bG4XunCxLM++ofSgEnXaZ9FsmTLR/jn/aB/N7Qq3ZUtsZp1EN5SBgEc56A2se80UmqBn
         KT1PboGIH9WQAvrrmgcUUjn9dy0P0mq0pZOwCydQa/vUZ10rZ7EvHfjY429oPjqtpJHJ
         t3GVpZaEQjqKdWz1lw4KzVyDvErKs0q2QU070cp1rhy0LVzQy60e5uqxZNi7C/M29aI1
         +hI9GvJnFIw35JUinZZ+szaCNoN3lxw3TxTnZDZ4zqk6sMknJJuxDz4Xkwjj99QsEZKC
         JCkw==
X-Gm-Message-State: AOAM5301tkduAh0P88pBNaU3TOBWzsoY8Cd3u/geVlJM6mKBBdb9/4t1
        SOjXPyM59qgAcF1Zm3npk9U=
X-Google-Smtp-Source: ABdhPJxwE9kB9MmZL64vT0gVFu1JaJrEJsau2tAB6wBPkMN495vO2Iq+1kX+vuWT2/qnq+n8aSt2Lg==
X-Received: by 2002:adf:e744:: with SMTP id c4mr16252259wrn.71.1590409127451;
        Mon, 25 May 2020 05:18:47 -0700 (PDT)
Received: from ubuntu-G3.micron.com ([165.225.203.62])
        by smtp.gmail.com with ESMTPSA id 10sm18136635wmw.26.2020.05.25.05.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 05:18:47 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        huobean@gmail.com, Bean Huo <beanhuo@micron.com>
Subject: [PATCH v6 3/5] mtd: rawnand: Add write_oob hook in nand_chip_ops
Date:   Mon, 25 May 2020 14:18:11 +0200
Message-Id: <20200525121814.31934-4-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525121814.31934-1-huobean@gmail.com>
References: <20200525121814.31934-1-huobean@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Break the function nand_write_oob() into two functions, and one of them
is named nand_write_oob_nand(), which will be assigned to new added hook
write_oob by default. The hook write_oob will be overwritten in the NAND
vendor lower-level driver if needed.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mtd/nand/raw/internals.h | 3 ++-
 drivers/mtd/nand/raw/nand_base.c | 9 +++++++++
 include/linux/mtd/rawnand.h      | 3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
index 03866b0aadea..94d300a207ac 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -99,7 +99,8 @@ int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
 void nand_decode_ext_id(struct nand_chip *chip);
 void panic_nand_wait(struct nand_chip *chip, unsigned long timeo);
 void sanitize_string(uint8_t *s, size_t len);
-
+int nand_write_oob_nand(struct nand_chip *chip, loff_t to,
+			 struct mtd_oob_ops *ops);
 static inline bool nand_has_exec_op(struct nand_chip *chip)
 {
 	if (!chip->controller || !chip->controller->ops ||
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 3de53c42fb74..ab39bb33e688 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4318,6 +4318,13 @@ static int nand_write_oob(struct mtd_info *mtd, loff_t to,
 			  struct mtd_oob_ops *ops)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	return chip->ops.write_oob(chip, to, ops);
+}
+
+int nand_write_oob_nand(struct nand_chip *chip, loff_t to,
+			struct mtd_oob_ops *ops)
+{
 	int ret;
 
 	ops->retlen = 0;
@@ -4624,6 +4631,8 @@ static void nand_set_defaults(struct nand_chip *chip)
 
 	if (!chip->buf_align)
 		chip->buf_align = 1;
+
+	chip->ops.write_oob = nand_write_oob_nand;
 }
 
 /* Sanitize ONFI strings so we can safely print them */
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 59150f729cf0..ae1cc60260a7 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1037,6 +1037,7 @@ struct nand_legacy {
  *			setting the read-retry mode. Mostly needed for MLC NAND.
  * @pre_erase:		[FLASHSPECIFIC] prepare a physical erase block
  * @post_erase:		[FLASHSPECIFIC] physical block erase post
+ * @write_oob:		[REPLACEABLE] Raw NAND write operation
  */
 struct nand_chip_ops {
 	int (*suspend)(struct nand_chip *chip);
@@ -1046,6 +1047,8 @@ struct nand_chip_ops {
 	int (*setup_read_retry)(struct nand_chip *chip, int retry_mode);
 	int (*pre_erase)(struct nand_chip *chip, u32 eraseblock);
 	int (*post_erase)(struct nand_chip *chip, u32 eraseblock);
+	int (*write_oob)(struct nand_chip *chip, loff_t to,
+			 struct mtd_oob_ops *ops);
 };
 
 /**
-- 
2.17.1

