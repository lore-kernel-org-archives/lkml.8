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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7F0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B04420709
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvwBdK3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgEROAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgEROAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:00:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD53C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:00:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z4so8244142wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FX8TNCptGGK3iFTps84rr7nd+amFy6w3yf6z9n1Ntbk=;
        b=fvwBdK3JrAS72Dg6AZKgn0+tDykNrwg7gBBpffsQZ1vQJ0XMc/ibB4ETfko3UFcvST
         wXEiRcfmAFxQk1Ap53rY1dn8+X5QKy3BM6uQlY303heMxa2vmCiQKYw1oaGrlW9D5DFt
         Fk/uURXAqymSJp/MsSIAaWuQtrIMI3Na2Z000BEEd5hINmqMOu6abWDn48bd7VOcE5s+
         u97yG3gsaeqvHfIK6Bc4JXtWeInBjO9fGvS1oiosg9mcB0Q7/JjkgP8ece6UfwzsShyk
         HRDrV4NAy3UiHCStXLEzW3uI9OW1Jh19OiO3rYAtTLU/HmAE4eCbWOOJrUl/qxzQLSWf
         bJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FX8TNCptGGK3iFTps84rr7nd+amFy6w3yf6z9n1Ntbk=;
        b=Z5kWAG8vDC3HAMd0EBpE0CFcfrWwV/XI64ntDk0/pX1b8p5OSTZCz80E2pWtu26V5t
         dMhyFFlN/vdIs89//My4M4AuHOivzz/7I9YTKZnt755jHM+IubvY3iHrZq8znhvB0mgE
         HlSWwfDdIj/3weeBmCMaT9wUx9/+55ChYr3yMUTC87aW6DvN1+CmoHOJ3MQyixewX8wf
         G2WAcDuH//glFJ9y0SghsiWpFTJ40xkSMNrpw6TmH5JYw3BFKPJDko2ZWzKlBzMZ4Ou2
         NggVzngvm4COjfEWHt4y5ad0vWkuumI5Fsh1o4ts10xBIOzohl5z/0e+lXwA84jSVPS+
         3mQg==
X-Gm-Message-State: AOAM530maMntjr1kwm3uQqBbOpKr+A98625STVQVxAJXd6gLm4BRbKRq
        Ze5nJ9vpt9WKX6rDFnFKeog=
X-Google-Smtp-Source: ABdhPJwQczAFkXPerpxOthlTabAANkJyTxrBuMCTEbYwFXhB9QX9Ob73IFV5eoS0xDp0Z2eDCKOEqA==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26mr18839093wmb.127.1589810404636;
        Mon, 18 May 2020 07:00:04 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b884:8d4:84ab:c471:b6eb:fcab])
        by smtp.gmail.com with ESMTPSA id 81sm18114519wme.16.2020.05.18.07.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 07:00:04 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        huobean@gmail.com, Bean Huo <beanhuo@micron.com>
Subject: [PATCH v4 4/5] mtd: rawnand: Introduce a new function nand_check_is_erased_page()
Date:   Mon, 18 May 2020 15:59:42 +0200
Message-Id: <20200518135943.11749-5-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518135943.11749-1-huobean@gmail.com>
References: <20200518135943.11749-1-huobean@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Add a new function nand_check_is_erased_page() in nand_base.c, which is
used to check whether one programmable page is empty or already programmed.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mtd/nand/raw/nand_base.c | 41 ++++++++++++++++++++++++++++++++
 include/linux/mtd/rawnand.h      |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 09ee490c08a9..2b9862d9979b 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -2646,6 +2646,47 @@ int nand_check_erased_ecc_chunk(void *data, int datalen,
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
+	max_bitflips = 0;
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
+	return ret;
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

