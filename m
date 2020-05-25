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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6726DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C822207C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khV9PF9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390551AbgEYMSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 08:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390196AbgEYMSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 08:18:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97E9C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:18:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y17so8501194wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tnV8x4gDO8btvOVgLJWVb0PglojCJzIhWmSmYw6JRuo=;
        b=khV9PF9KpiDl49HySg78jC0TRfHV/Si5sxE4YDcm778rH0yaE+qRRwBfAKjEFSdABq
         A4CCPq42e89TP8EPxRT7FBRDbascYSyTlhjByqpMMZQijym73ljxwVDr0adYBjMGsDfE
         zaUOs0zPKzsMZi4j0Iy4oshxnDwQ37j5iCSU2McXnZ8yoEc8vZERkiDwZAdpNg/a4KSp
         i0DTcsMu3kliDNwcHQZh4X5rFccgbykTqLaTOMBK7nN5b7n9Z0UTwOrzGyZTfoQD08X/
         WilJ9n+3Ew1ROt2YHnKnnsan9wPYS0cxALDPENp9bgrKA3zVWB0sl4jYaPVlNuwkgbZJ
         fWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tnV8x4gDO8btvOVgLJWVb0PglojCJzIhWmSmYw6JRuo=;
        b=sO67MG1T5ST12wf2uajV/wn9gdyNMIPj5o6tatHVoOhPfDsjhjbn+zsW6Gm3ss6M5k
         5qlyCnps+jMUDKFwlGCV0WBOJdPpTxtPQum6qaTXnthxJTWSuT45zizHnjthIxf9X1uf
         jO0cko/qOm+jrnbjCNwYuRqa2QejHDKHGkosiwTMud4WLeHnumxFCerOVrfMW3bqFRf/
         xotNwxnQ4VnxL4/q0miTWL2JdSn3Suos33m5ZXmc5QJ1mEkGITUNHQwBfFLVMb63f4dB
         nrqAXg+LRzszn4bZ9yaX+69UFsEiIunMi9vot4q3OKnMqcJoLufbyHW+Npbo9V2pvyJU
         iHLw==
X-Gm-Message-State: AOAM532fBv3nV6JtfRz0znusgdnPA7u/LaNJ0wEaPqJjfvzCPcMKTmmn
        fD+PAp/Y4wVYlpWV9w8Jjzs=
X-Google-Smtp-Source: ABdhPJwhkTEgjfw66VRA50ZFlbixY2EdnhRPhZB3HXoieFs2HwDvJp6n9u+S57CVfs0NzxlZ1CnYAQ==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr16181013wrs.128.1590409131497;
        Mon, 25 May 2020 05:18:51 -0700 (PDT)
Received: from ubuntu-G3.micron.com ([165.225.203.62])
        by smtp.gmail.com with ESMTPSA id 10sm18136635wmw.26.2020.05.25.05.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 05:18:51 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        huobean@gmail.com, Bean Huo <beanhuo@micron.com>
Subject: [PATCH v6 4/5] mtd: rawnand: Introduce a new function nand_check_is_erased_page()
Date:   Mon, 25 May 2020 14:18:12 +0200
Message-Id: <20200525121814.31934-5-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525121814.31934-1-huobean@gmail.com>
References: <20200525121814.31934-1-huobean@gmail.com>
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
index ab39bb33e688..05ee32106af9 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -2697,6 +2697,46 @@ int nand_check_erased_ecc_chunk(void *data, int datalen,
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
index ae1cc60260a7..44c2715691bb 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1339,6 +1339,8 @@ int nand_check_erased_ecc_chunk(void *data, int datalen,
 				void *extraoob, int extraooblen,
 				int threshold);
 
+int nand_check_is_erased_page(struct nand_chip *chip, u8 *page_data, bool oob);
+
 int nand_ecc_choose_conf(struct nand_chip *chip,
 			 const struct nand_ecc_caps *caps, int oobavail);
 
-- 
2.17.1

