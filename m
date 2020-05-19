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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBDFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15F120756
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGUTJ2y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgESKFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgESKFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:05:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256C3C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:05:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f13so2409037wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fw6/rheGBigvdKbfBBLuoQxU/TmSkSKuizeWdRgiMEo=;
        b=hGUTJ2y/M09GYiVoHWGGBKpUiYz1GB5jJCOesi2TVqLthpfUikFEUWC5P3uLgIOXmC
         qBfz931F8DcSOe55dQwLqdxoyqB+JL9wLiRwSTjs/X4+6cjJOzDABLIvjDo3JFQpPTfe
         c+FXQb/oMHrskFnQlSi/UxGLySkikNij9tlBns6dZDl0fEZcG7f9xadmypxmpo1GpmxN
         HmcuEzoqWFKPGoYCRo9kD1zLLOyIzio7azxRr17RBJdEPFi+/hyQjQUr7pTeahNCMRli
         eNudUA0Graz/NNVBhcY6lswQUW/zKcCkeA4VRfukeEeepXX4wf/L8FoofzQLaZkFy3Sz
         l+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fw6/rheGBigvdKbfBBLuoQxU/TmSkSKuizeWdRgiMEo=;
        b=JIrWARAg02L40QFDKMN7B7HFmEw/AjqItn2WTGofiyQTMsoLr17Qy2HQXXlvHuTatP
         mMBvxyOnjlikm1JHIfvgyfF6pIvh7NcOlyZ4lcW3jM+h60F11zEGIv62eiQczPVnI0dE
         okpgeYeF0qoZQFDWHKwdKl8/PT8jgR/eSF9hf8+KMMzLj7YyTLFy5GgBLxxBRAqcMDVM
         NkE8DfzrPfJ+7dUyqcXBVAMAz4xOMn6984cqcrIHGfTHoXwglSUZFZr41quy1hMI8WQ/
         VfJmATmAwDZeuzLN4jRiLJFwCUtBgFc9v1ZA8xD4kc59iyH2YMIBE5kggG0MW9G2cS/E
         Wodw==
X-Gm-Message-State: AOAM5323DNx0s100MNeDWNqWgfeSteCaMxm8olbOun02Wi8Dsp+34BRu
        waWowH288gDvGSqV+NZBT4k=
X-Google-Smtp-Source: ABdhPJyUb2Endq5jxFpTICyzKH30uYBBl5l6QVXyVjVUFOjdiwVK78zZ8wgpgPwWAmEoIX2dt553Rg==
X-Received: by 2002:a1c:6156:: with SMTP id v83mr4443501wmb.28.1589882728852;
        Tue, 19 May 2020 03:05:28 -0700 (PDT)
Received: from ubuntu-G3.micron.com ([165.225.86.140])
        by smtp.gmail.com with ESMTPSA id b18sm19968008wrn.82.2020.05.19.03.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:05:28 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        huobean@gmail.com, Bean Huo <beanhuo@micron.com>
Subject: [PATCH v5 4/5] mtd: rawnand: Introduce a new function nand_check_is_erased_page()
Date:   Tue, 19 May 2020 12:05:06 +0200
Message-Id: <20200519100507.19323-5-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519100507.19323-1-huobean@gmail.com>
References: <20200519100507.19323-1-huobean@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Add a new function nand_check_is_erased_page() in nand_base.c, which is
used to check whether one programmable page is empty or already programmed.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mtd/nand/raw/nand_base.c | 40 ++++++++++++++++++++++++++++++++
 include/linux/mtd/rawnand.h      |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 09ee490c08a9..932a8cae4e84 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -2646,6 +2646,46 @@ int nand_check_erased_ecc_chunk(void *data, int datalen,
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
+	int ret, i;
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
+
+	for (i = 0; i < chip->ecc.steps; i++) {
+		ret = nand_check_erased_ecc_chunk(databuf, datasize,
+						  eccbuf, eccbytes,
+						  NULL, 0, chip->ecc.strength);
+		if (ret < 0)
+			return false;
+
+		databuf += chip->ecc.size;
+		eccbuf += chip->ecc.bytes;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(nand_check_is_erased_page);
+
 /**
  * nand_read_page_raw_notsupp - dummy read raw page function
  * @chip: nand chip info structure
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 3d75e50e5b75..718ce81eb111 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1337,6 +1337,8 @@ int nand_check_erased_ecc_chunk(void *data, int datalen,
 				void *extraoob, int extraooblen,
 				int threshold);
 
+int nand_check_is_erased_page(struct nand_chip *chip, u8 *page_data, bool oob);
+
 int nand_ecc_choose_conf(struct nand_chip *chip,
 			 const struct nand_ecc_caps *caps, int oobavail);
 
-- 
2.17.1

