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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D324BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBB42087D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5aFzuG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390560AbgEYMS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 08:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390196AbgEYMS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 08:18:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620E7C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:18:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x6so3282755wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MDtuGjq992H7zxIhKOT8Z+F0tNgL9APFEam9OpU1H8Q=;
        b=H5aFzuG/1daEeVbEqDE7WtNrggKNjqP4JqKSQRu+yoDIxkU/3Bbj0UcHzX0eBd2KuM
         94QpMksuIUn5B5d9MOO9KMgE/C/j253P2bKT0U08fUKSldw9fp8Jo4B/ExxzKqmoRPrG
         osx2fcwgYDHoqaxho74/5qNSUwiqnTFUrQKoWrkt1e5nzm4XQYRAGimfT8IdqXWBLjEw
         fmHsgb8IjQ5ayMLmoXMXWd+bJA5Uiml/bvrXVvNryKVCysqB/xgCcKmmr/SnxTwhwP9f
         d7ZWewCEktYZ2sn88fbXPyXLT3yOLjiPeYTUVKok27px08aafKwUnwIvQCbSZD4bvnR0
         Giyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MDtuGjq992H7zxIhKOT8Z+F0tNgL9APFEam9OpU1H8Q=;
        b=Dce5O/nptfcrWMlsbxDMonxWD+/sUOXISBaOcV6XZDXJ+y0Jxe8OrKXW3iFmjmOhTz
         PpAvAl/ilKSQEAQy3tFTJMrY/XIBUrhbNQy3ZaFjFKmejjNW/yT7T/n8gvSj+BekvLrr
         CnsOkfZpqLN23GLc7Yl7P37n+De7JjRGkUFeMY3l6oNjTJrcmpKXt5RtmDiy+0efagDl
         0QAdcJNkhvQDeEukYtDiAIaFH9IjTrsChbG8RidW9lKTx8pWg/SC9SOukPag41HGf8db
         v+qHGakTJ0eMZik/4qKlkaZ8Er76kPkMnvhM69GUXyrY7uNvXZg+moo1P2z2akSOAQ0K
         Wzow==
X-Gm-Message-State: AOAM532o/0PxKhuev+lM/BQHWyEDx8d2YF7iV+h9VERg+GlFi2EdPrzw
        sSSLCl/B+isNbWTZRgqoMXQ=
X-Google-Smtp-Source: ABdhPJx5tsW3yfmkNRTjkYsLRosnRrHe4zn/joO07snVeVquqVUwZjNu2iB3W1+xrXOMbuS+wkGFpw==
X-Received: by 2002:a05:6000:12c2:: with SMTP id l2mr14462285wrx.133.1590409135173;
        Mon, 25 May 2020 05:18:55 -0700 (PDT)
Received: from ubuntu-G3.micron.com ([165.225.203.62])
        by smtp.gmail.com with ESMTPSA id 10sm18136635wmw.26.2020.05.25.05.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 05:18:54 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        huobean@gmail.com, Bean Huo <beanhuo@micron.com>
Subject: [PATCH v6 5/5] mtd: rawnand: micron: Micron SLC NAND filling block
Date:   Mon, 25 May 2020 14:18:13 +0200
Message-Id: <20200525121814.31934-6-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525121814.31934-1-huobean@gmail.com>
References: <20200525121814.31934-1-huobean@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

On planar 2D Micron NAND devices when a block erase command is issued,
occasionally even though a block erase operation completes and returns a
pass status, the flash block may not be completely erased. Subsequent
operations to this block on very rare cases can result in subtle failures
or corruption. These extremely rare cases should nevertheless be
considered. These rare occurrences have been observed on partially written
blocks.

To avoid this rare occurrence, we should make sure that at least 15 pages
have been programmed to a block before it is erased. In case we find that
less than 15 pages have been programmed, we will rewrite first 15 pages of
block.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mtd/nand/raw/nand_micron.c | 102 +++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index 4385092a9325..85aa17ddd3fc 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -36,6 +36,9 @@
 #define NAND_ECC_STATUS_1_3_CORRECTED	BIT(4)
 #define NAND_ECC_STATUS_7_8_CORRECTED	(BIT(4) | BIT(3))
 
+#define MICRON_SHALLOW_ERASE_MIN_PAGE 15
+#define MICRON_PAGE_MASK_TRIGGER GENMASK(MICRON_SHALLOW_ERASE_MIN_PAGE, 0)
+
 struct nand_onfi_vendor_micron {
 	u8 two_plane_read;
 	u8 read_cache;
@@ -64,6 +67,7 @@ struct micron_on_die_ecc {
 
 struct micron_nand {
 	struct micron_on_die_ecc ecc;
+	u16 *writtenp;
 };
 
 static int micron_nand_setup_read_retry(struct nand_chip *chip, int retry_mode)
@@ -472,6 +476,93 @@ static int micron_supports_on_die_ecc(struct nand_chip *chip)
 	return MICRON_ON_DIE_SUPPORTED;
 }
 
+static int micron_nand_pre_erase(struct nand_chip *chip, u32 eraseblock)
+{
+	struct micron_nand *micron = nand_get_manufacturer_data(chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	u8 last_page = MICRON_SHALLOW_ERASE_MIN_PAGE - 1;
+	u32 page;
+	u8 *data_buf;
+	int ret, i;
+
+	data_buf = nand_get_data_buf(chip);
+	WARN_ON(!data_buf);
+
+	if (likely(micron->writtenp[eraseblock] & BIT(last_page)))
+		return 0;
+
+	page = eraseblock << (chip->phys_erase_shift - chip->page_shift);
+
+	if (unlikely(micron->writtenp[eraseblock] == 0)) {
+		ret = nand_read_page_raw(chip, data_buf, 1, page + last_page);
+		if (ret)
+			return ret; /* Read error */
+		ret = nand_check_is_erased_page(chip, data_buf, true);
+		if (!ret)
+			return 0;
+	}
+
+	memset(data_buf, 0x00, mtd->writesize);
+
+	for (i = 0; i < MICRON_SHALLOW_ERASE_MIN_PAGE; i++) {
+		ret = nand_write_page_raw(chip, data_buf, false, page + i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int micron_nand_post_erase(struct nand_chip *chip, u32 eraseblock)
+{
+	struct micron_nand *micron = nand_get_manufacturer_data(chip);
+
+	if (!micron)
+		return -EINVAL;
+
+	micron->writtenp[eraseblock] = 0;
+
+	return 0;
+}
+
+static int micron_nand_write_oob(struct nand_chip *chip, loff_t to,
+				 struct mtd_oob_ops *ops)
+{
+	struct micron_nand *micron = nand_get_manufacturer_data(chip);
+	u32 eb_sz = nanddev_eraseblock_size(&chip->base);
+	u32 p_sz = nanddev_page_size(&chip->base);
+	u32 ppeb = nanddev_pages_per_eraseblock(&chip->base);
+	u32 nb_p_tot = ops->len / p_sz;
+	u32 first_eb = DIV_ROUND_DOWN_ULL(to, eb_sz);
+	u32 first_p = DIV_ROUND_UP_ULL(to - (first_eb * eb_sz), p_sz);
+	u32 nb_eb = DIV_ROUND_UP_ULL(first_p + nb_p_tot, ppeb);
+	u32 remaining_p, eb, nb_p;
+	int ret;
+
+	ret = nand_write_oob_nand(chip, to, ops);
+
+	if (ret || ops->len != ops->retlen)
+		return ret;
+
+	/* Mark the last pages of the first erase block to write */
+	nb_p = min(nb_p_tot, ppeb - first_p);
+	micron->writtenp[first_eb] |= GENMASK(first_p + nb_p, 0) &
+					MICRON_PAGE_MASK_TRIGGER;
+	remaining_p = nb_p_tot - nb_p;
+
+	/* Mark all the pages of all "in-the-middle" erase blocks */
+	for (eb = first_eb + 1; eb < first_eb + nb_eb - 1; eb++) {
+		micron->writtenp[eb] |= MICRON_PAGE_MASK_TRIGGER;
+		remaining_p -= ppeb;
+	}
+
+	/* Mark the first pages of the last erase block to write */
+	if (remaining_p)
+		micron->writtenp[eb] |= GENMASK(remaining_p - 1, 0) &
+					MICRON_PAGE_MASK_TRIGGER;
+	return 0;
+}
+
 static int micron_nand_init(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
@@ -558,6 +649,17 @@ static int micron_nand_init(struct nand_chip *chip)
 		}
 	}
 
+	if (nand_is_slc(chip)) {
+		micron->writtenp = kcalloc(nanddev_neraseblocks(&chip->base),
+					   sizeof(u16), GFP_KERNEL);
+		if (!micron->writtenp)
+			goto err_free_manuf_data;
+
+		chip->ops.write_oob = micron_nand_write_oob;
+		chip->ops.pre_erase = micron_nand_pre_erase;
+		chip->ops.post_erase = micron_nand_post_erase;
+	}
+
 	return 0;
 
 err_free_manuf_data:
-- 
2.17.1

