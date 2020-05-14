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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1FBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673CF2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIXycBsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgENVYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgENVXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:23:54 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD8C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 14:23:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h17so620012wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 14:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vEQ3EETF6/6FEJ3XSdcKCgNodtqpyCCg4YqFAvW+xyc=;
        b=DIXycBslQDtOQVfH7G8oWQmAk53UAsqPQecgcKSjRkdWvxi8W5hRZIga0UtG1ZYrg+
         eDK7bGDbofXGPzfldPcGuzRxtuivsZjgRwTn8eTIRrTy8234CaWrWNc02C+eoTqBTYfd
         yXEirqmATB6Xahu9ovGzxHBwYBAL9ZcXHZAJxyigkc/qWg1O+RyloQBH73VI66em1VbN
         eni/5dOgjR6wQEKALycy95WGYWenwt1ZVhLtY6n6bMXIgtnbspClIJ5y+pmhZlOUHxtm
         BRpkzTE4BXmgXIktljPGP0ROxwQfcRjCZCRWidSuvBn0xP7fEo5cwVTVYPZWJ0MVlC8b
         Tx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vEQ3EETF6/6FEJ3XSdcKCgNodtqpyCCg4YqFAvW+xyc=;
        b=pM0TpSubbR9mzP2RE3QNe6wzJas5yQDlLi61YjYu3y9YF1ZMHOydreSIZARUIdsNYm
         6kwpAIW9SXXV1LJS0qta5fdOpGfgLDxMh6t168UQtd/A7x7rbzjg8qmjXVSxeNbr550t
         icQf/arhEADYCHlDzO3fguJX3ZqE1xkg66Bt5/o0p0AubnYBt49ml4WsNf4lv56T7dzh
         rJn93cb6aCnUJ6w4XaoROh9Rsig8O8yzNvNFV2CXBwpLHav/SmjbU/s0RiSuQb6KHMoc
         UMXS9KHIIhRq1amraOPrPk1nj1oVMoVZD4P0TRIdpFI6FEoA1+Fmyp9MslOlaHqjScyv
         nDQQ==
X-Gm-Message-State: AOAM5339QL0/a6S3OGe4qwV/J4mVfSLegfa9N3UQ5tJS3zyJ1cKC7cz1
        cC/+5hUFghm+WbwBeCNxilw=
X-Google-Smtp-Source: ABdhPJzwMm5H8+1KFnuDw4eEj5HBRBDxs+kDv4Qd1RIWBWitne6+RKJnGbFdqCuTE3Kj7cZXXF6RHA==
X-Received: by 2002:adf:f605:: with SMTP id t5mr424885wrp.354.1589491433142;
        Thu, 14 May 2020 14:23:53 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bfcc8.dynamic.kabel-deutschland.de. [95.91.252.200])
        by smtp.gmail.com with ESMTPSA id 128sm491210wme.39.2020.05.14.14.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 14:23:52 -0700 (PDT)
From:   huobean@gmail.com
X-Google-Original-From: beanhuo@micron.com
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v3 3/5] mtd: rawnand: Add write_oob hook in nand_chip_ops
Date:   Thu, 14 May 2020 23:23:31 +0200
Message-Id: <20200514212333.28692-4-beanhuo@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514212333.28692-1-beanhuo@micron.com>
References: <20200514212333.28692-1-beanhuo@micron.com>
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
index 9d0caadf940e..d54bc43f9ccd 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -96,7 +96,8 @@ int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
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
index 842490d9fd09..b630f7f6a651 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4121,6 +4121,13 @@ static int nand_write_oob(struct mtd_info *mtd, loff_t to,
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
@@ -4427,6 +4434,8 @@ static void nand_set_defaults(struct nand_chip *chip)
 
 	if (!chip->buf_align)
 		chip->buf_align = 1;
+
+	chip->ops.write_oob = nand_write_oob_nand;
 }
 
 /* Sanitize ONFI strings so we can safely print them */
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index f60cfe93b226..a1bb2acfaf6a 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1020,6 +1020,7 @@ struct nand_legacy {
  *			setting the read-retry mode. Mostly needed for MLC NAND.
  * @pre_erase:		[FLASHSPECIFIC] prepare a physical erase block
  * @post_erase:		[FLASHSPECIFIC] physical block erase post
+ * @write_oob:		[REPLACEABLE] Raw NAND write operation
  */
 struct nand_chip_ops {
 	int (*suspend)(struct nand_chip *chip);
@@ -1029,6 +1030,8 @@ struct nand_chip_ops {
 	int (*setup_read_retry)(struct nand_chip *chip, int retry_mode);
 	int (*pre_erase)(struct nand_chip *chip, u32 eraseblock);
 	int (*post_erase)(struct nand_chip *chip, u32 eraseblock);
+	int (*write_oob)(struct nand_chip *chip, loff_t to,
+			 struct mtd_oob_ops *ops);
 };
 
 /**
-- 
2.17.1

