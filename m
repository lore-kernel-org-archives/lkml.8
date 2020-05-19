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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7741C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE7F120756
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdB+hJkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgESKFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbgESKF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:05:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10AAC05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:05:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id m12so2443568wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A0dzsFd7YATdAmh4B3Ufb/iHlKjHhY14r5pPPWljdn0=;
        b=UdB+hJkWgTSuFJt0pZRMkIPGDKwdUT1dAU/6a7r9v92AjrCvjKa0IcSnT5TsVDfOoe
         EOq225Fjpx21cFKWpS/ChQhtnI6t4Areto19A0DrDTWl3IVERrdo45OgOn4H3hCcvHea
         bWpDTQms8chEpSf6TdoOyJp/hdLhVJ2MMHfFV2JpvumYB4lzbo3TajM9xjZ3Khb/yHet
         Kbo4joZLHEKrc6FU83rsIP7K+8srtJdgzzApwgJ16V/GJB3Mu0ZdgmafaLH5z5LsJVds
         bo7dTYjEijf1jbvkelKLgY26BLnOmIlnGBH86UKob1/Iet4vxMZwWqzQVDZnFtP2qUPe
         cSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A0dzsFd7YATdAmh4B3Ufb/iHlKjHhY14r5pPPWljdn0=;
        b=a2N9SuNnMFEUxHLr220rTVUyt046MnggLG94xQ0fQpDKGJofppe3KkDIbmjg2Mi8XG
         NeV23MHwi7Fnx0OKcaORvpAK/jsOoulynR3uD099IA8fvaL4zMXimxK/UEoEaxGQj7t3
         KcuJ+ZrGjVrz2r0zn40KBznlPa9OcKQmlmPY70lYdB3/Q64KDXXMqtbhRbGRPQRTBrNA
         4Z/v3eiLBCtGaEy/c4koo4f1Bf/7X79IrXBh5f2Zcw4UMQq/uxbWXSf8hZP3CZm95kXD
         kwdgd1lxHzFB5MSQK8t1OnqpyaDxMNlKc1sxN9cMQbE73x5beMkoytDks2P8+zNcyW7f
         F2Wg==
X-Gm-Message-State: AOAM533oKm60eYy3eSWqxhxR7KghKHDcX4kDDGMz6hfKMPPr5PtOtdqi
        cUJspYP9Hd0bsV5kE/8ztNw=
X-Google-Smtp-Source: ABdhPJy75UQcRgxlKDQyvIcayYE4da4DcqqChhNqqn+CKIwudgHm7In5wprKyW16m28JV/a503kkZg==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr4577893wmi.101.1589882726576;
        Tue, 19 May 2020 03:05:26 -0700 (PDT)
Received: from ubuntu-G3.micron.com ([165.225.86.140])
        by smtp.gmail.com with ESMTPSA id b18sm19968008wrn.82.2020.05.19.03.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:05:26 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        huobean@gmail.com, Bean Huo <beanhuo@micron.com>
Subject: [PATCH v5 3/5] mtd: rawnand: Add write_oob hook in nand_chip_ops
Date:   Tue, 19 May 2020 12:05:05 +0200
Message-Id: <20200519100507.19323-4-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519100507.19323-1-huobean@gmail.com>
References: <20200519100507.19323-1-huobean@gmail.com>
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

