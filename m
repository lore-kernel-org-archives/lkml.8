Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3D2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC2A820756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0ui3OTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgEROAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgEROAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:00:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD92C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:00:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n18so6302025wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A0dzsFd7YATdAmh4B3Ufb/iHlKjHhY14r5pPPWljdn0=;
        b=g0ui3OTSkdJShadSlw+WcDWAUcm6y3J7YghKX95julkcaI4O4wZrMf3JOkUqdcFx35
         aEuXbH1XbUYj+PmfcTNHJS7b7me4PympHBUltaCtxkINQzPHpSFbSyPDEo9g7dA+rxsR
         kF3sPnA0Op4R4UZT+Q4taN8bonFab/1kXD2qIwRHeyqQCjncj2KcggBjVh9EHvqMiQe5
         PujuqQ/m04AYJ9lRwbKp+RR0H8yZVQFTV7NoNiHstGXtegRo72BvuwWllGlksiFSKrqx
         4BvTDXOzxjiMZkz2BaC+pxrj1/9H5ku4SlL7Zb6cYkijKPFn9G6wFzGOkypMjYYscJ2Q
         xVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A0dzsFd7YATdAmh4B3Ufb/iHlKjHhY14r5pPPWljdn0=;
        b=NrYSDDX2uFGzMQ57tYqj1G/ovPSVXt29XCbx3KDy1i1BxlMb9PmfPeNa8nkNhZp9nJ
         yBJepIHPxCxG9fcJ7WLjstQtCrTEQYvoy+Kx5V5ejJG3kiVyo6rz0TrwqEKd+ngBKTx6
         hofxfEJjpDQXjoh1WifOgERIQ/ZdqbpScfFTuJgtPoa7A14lVepRdNuIZSwz9ddslHKy
         R84111AN2SBp9K9a1Zd3JGL6NdJfhzYHK8Wi2TaeYOI3yB1yeMwQu2cCglrna8KBLsIJ
         bcDA/m6u3jJt9o/qAANw6z2uzLS0VnyD2gqhP8SDwtWF08x7PCzAIPKJhXN4rdDgQnXL
         Sguw==
X-Gm-Message-State: AOAM5316Oq9LzDLBJihCx/ROxonJhb1XR+/9ZnNtwZAegkFBdSfTUEPs
        RNeRwDA4H6FLFbK1lYdtlLU=
X-Google-Smtp-Source: ABdhPJzJM6UZDI0PriKylI2w6FhVHwt18WruFbLtc9Ca+rp2Dmr/RFDUJjS8WsGgVPhIfCXSAlD8wg==
X-Received: by 2002:a1c:7305:: with SMTP id d5mr20288874wmb.85.1589810403095;
        Mon, 18 May 2020 07:00:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b884:8d4:84ab:c471:b6eb:fcab])
        by smtp.gmail.com with ESMTPSA id 81sm18114519wme.16.2020.05.18.07.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 07:00:02 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        huobean@gmail.com, Bean Huo <beanhuo@micron.com>
Subject: [PATCH v4 3/5] mtd: rawnand: Add write_oob hook in nand_chip_ops
Date:   Mon, 18 May 2020 15:59:41 +0200
Message-Id: <20200518135943.11749-4-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518135943.11749-1-huobean@gmail.com>
References: <20200518135943.11749-1-huobean@gmail.com>
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
index e90b7ae878e2..09ee490c08a9 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4267,6 +4267,13 @@ static int nand_write_oob(struct mtd_info *mtd, loff_t to,
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
@@ -4573,6 +4580,8 @@ static void nand_set_defaults(struct nand_chip *chip)
 
 	if (!chip->buf_align)
 		chip->buf_align = 1;
+
+	chip->ops.write_oob = nand_write_oob_nand;
 }
 
 /* Sanitize ONFI strings so we can safely print them */
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index df3d4b3ef2f6..3d75e50e5b75 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1035,6 +1035,7 @@ struct nand_legacy {
  *			setting the read-retry mode. Mostly needed for MLC NAND.
  * @pre_erase:		[FLASHSPECIFIC] prepare a physical erase block
  * @post_erase:		[FLASHSPECIFIC] physical block erase post
+ * @write_oob:		[REPLACEABLE] Raw NAND write operation
  */
 struct nand_chip_ops {
 	int (*suspend)(struct nand_chip *chip);
@@ -1044,6 +1045,8 @@ struct nand_chip_ops {
 	int (*setup_read_retry)(struct nand_chip *chip, int retry_mode);
 	int (*pre_erase)(struct nand_chip *chip, u32 eraseblock);
 	int (*post_erase)(struct nand_chip *chip, u32 eraseblock);
+	int (*write_oob)(struct nand_chip *chip, loff_t to,
+			 struct mtd_oob_ops *ops);
 };
 
 /**
-- 
2.17.1

