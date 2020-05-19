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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1DFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F275206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhUgcoRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgESKSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgESKR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:17:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ACAC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:17:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so2874543wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fw6/rheGBigvdKbfBBLuoQxU/TmSkSKuizeWdRgiMEo=;
        b=bhUgcoRlGk/CHPSzeBIJuBbFMldNRehsCtiaScsoniU5k9tnwiteBislmiXObQiYrv
         uAdTee/MMmxgHGVBLuWOk4YbgN6/63XwirRvw/ImqZrXUmqDpBv3ERl7ns1y9iAw9KvZ
         GEohowe7+glTPaGPExzxgS8LvsUU5wbkEb1PZfzJyjOFeou80TtEkT8mAsPtSn2dKhsX
         vNE57xFz+6uSzQM6w8YI4wVwmwdUc4NI91fVTk4lgREygGaeBRP8tOcKzOt3P3Su1Po8
         N3B0GqOkvpDZexOsP9+UXB2tYRUijMYjQgyTZSJDY4mcZWUDFyi2GL6+JfPIqe92lRp2
         c+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fw6/rheGBigvdKbfBBLuoQxU/TmSkSKuizeWdRgiMEo=;
        b=rOxw9m87YCe9Yrida7I/TPDK9W4/HW5LrDE+IjHz3J1tDbSDu6Lxzt1x7Kl/QGlDR1
         UCMGJwF0BdF0bT+4CM5ptl4QeinMcNPEzCGkHqx1i+7TS4tHqc+YmMHI1Uf5aS2Unq7y
         UO4intZA8WI2hdkIx3NhYivM+kOyCT91YU6NcZznOOats/9oligRfV3nB4yjHHv3O47m
         dhNHUY9+zHRSX2/yvISYm4Qx/ZCjrnMNTABJ2/NiguSwTpBG6uihHMxySrUmkXVsndnQ
         1N3Lf6eMQMVxzdv9TOkwbzKbNDKWPWwb6NxFTFy/HARGByVxwSjWjbetNcZGFr7cOyl+
         1M1g==
X-Gm-Message-State: AOAM531SKmzHPVbbWsntoV9MH14j/+1NB8TjaCBBGO6fnEgRrB/yGBUH
        YI8EA3yk6zhkA83LRWYauLg=
X-Google-Smtp-Source: ABdhPJwar6JPscVQ2VJ4NDhUmfxW/yUbFSMSjlV8YwyjbE5MVOzrG9NvLQj9pGAw8yEaxzQG9uUWog==
X-Received: by 2002:a7b:cf15:: with SMTP id l21mr4579351wmg.172.1589883475326;
        Tue, 19 May 2020 03:17:55 -0700 (PDT)
Received: from ubuntu-G3.micron.com ([165.225.86.140])
        by smtp.gmail.com with ESMTPSA id w15sm3062488wmi.35.2020.05.19.03.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:17:54 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        huobean@gmail.com, Bean Huo <beanhuo@micron.com>
Subject: [RESET PATCH v5 4/5] mtd: rawnand: Introduce a new function nand_check_is_erased_page()
Date:   Tue, 19 May 2020 12:17:33 +0200
Message-Id: <20200519101734.19927-5-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519101734.19927-1-huobean@gmail.com>
References: <20200519101734.19927-1-huobean@gmail.com>
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

