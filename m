Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF1CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 05:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82C02075F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 05:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWnloVRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgFKFpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 01:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgFKFpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 01:45:08 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5FEC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 22:45:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j198so6121676wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 22:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GM23ntmkLh0x0xXXUygYPBCzInm4vRrzUCKgyJBobDo=;
        b=sWnloVRpaRtwFyMx2PlMc7a0HO+ZIZPx3+KezHYtUT52Q+GxdjgnaWYUMmNJUW1vnZ
         mL1wNmIMZNqgjx3LmiLJ9gxU57rd4P7iNagScmoIKDQukYLXvHRZPzukqGpFyjHjCtji
         siXghYbLloNdrGjYl43pzeYxkp/3xX+MnvinPCtY3unSPyMfeabDHwumR8dCLa9JdxTu
         LgAa49PFT8YJTpHDEYXT2GPYzT+UgsOt3IwU9eRlIMnGpH5iW7UwjjnVp7K6Oh7gza4H
         PWXas0L4mxC9KiDqvXKLrLfVam69YUhCUZD46GRE7KqgNTOrA3+r4VPsl4GefKbQLbgO
         uYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GM23ntmkLh0x0xXXUygYPBCzInm4vRrzUCKgyJBobDo=;
        b=cXqqkA50hewwiV7rhmM1UVaRvmczIt6Ak4zKrHd+yM513L2Z/ppSRjA9Vy7U51d19k
         jc8IoId9/Zfatn1ub+iQkPfDT+u98djC2dOL9+JAtlRlmJjMEcZ1QzjrtOXV2hnFDSZL
         5ewtSYDmUATNmPWb4KIzXiPW6HKgazIBAMo29s1CcOjWFaZ2CkoxfKgbm36Svbq5cYLp
         MI4/K4YHpO7N4gCN3tMsxmkMDiVvSDTRntnx1oHrxe78S0w0NMP2b5HeGQBHfZymG8Fk
         QbY8iBsKaVLpE7X3lbhNDhddoOEIVh6BB8UC40FuX2+EIR7K0YDvwH2VTWNV61KsnXqr
         29Dg==
X-Gm-Message-State: AOAM530d6DnuJ+GWAGRZRjdcyzZacIrLx96zyrH6GffYobCdZBAC+DE5
        D62Lnf1pPwzomoKYOhcFFYTaPB+7
X-Google-Smtp-Source: ABdhPJw+yB26mkquyy1l1FAMcm4KoBgZN/P2q/14vQK7wDgd7NHbQczEHRUXWyCCLzDpNTTIr1OHoQ==
X-Received: by 2002:a1c:4302:: with SMTP id q2mr6380413wma.54.1591854306435;
        Wed, 10 Jun 2020 22:45:06 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j16sm3492724wre.21.2020.06.10.22.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 22:45:06 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH  2/2] mtd: rawnand: brcmnand: Ecc error handling on EDU transfers
Date:   Thu, 11 Jun 2020 01:44:54 -0400
Message-Id: <20200611054454.2547-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611054454.2547-1-kdasu.kdev@gmail.com>
References: <20200611054454.2547-1-kdasu.kdev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implemented ECC correctable and uncorrectable error handling for EDU
reads. If ECC correctable bitflips are encountered  on EDU transfer,
read page again using pio, This is needed due to a controller lmitation
where read and corrected data is not transferred to the DMA buffer on ECC
errors. This holds true for ECC correctable errors beyond set threshold.

Fixes: a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers")
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 0c1d6e543586..d7daa83c8a58 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1855,6 +1855,22 @@ static int brcmnand_edu_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
 	edu_writel(ctrl, EDU_STOP, 0); /* force stop */
 	edu_readl(ctrl, EDU_STOP);
 
+	if (ret == 0 && edu_cmd == EDU_CMD_READ) {
+		u64 err_addr = 0;
+
+		/*
+		 * check for ecc errors here, subpage ecc erros are
+		 * retained in ecc error addr register
+		 */
+		err_addr = brcmnand_get_uncorrecc_addr(ctrl);
+		if (!err_addr) {
+			err_addr = brcmnand_get_correcc_addr(ctrl);
+			if (err_addr)
+				ret = -EUCLEAN;
+		} else
+			ret = -EBADMSG;
+	}
+
 	return ret;
 }
 
@@ -2058,6 +2074,7 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
 	u64 err_addr = 0;
 	int err;
 	bool retry = true;
+	bool edu_read = false;
 
 	dev_dbg(ctrl->dev, "read %llx -> %p\n", (unsigned long long)addr, buf);
 
@@ -2075,6 +2092,10 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
 			else
 				return -EIO;
 		}
+
+		if (has_edu(ctrl))
+			edu_read = true;
+
 	} else {
 		if (oob)
 			memset(oob, 0x99, mtd->oobsize);
@@ -2122,6 +2143,11 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
 	if (mtd_is_bitflip(err)) {
 		unsigned int corrected = brcmnand_count_corrected(ctrl);
 
+		/* in case of edu correctable error we read again using pio */
+		if (edu_read)
+			err = brcmnand_read_by_pio(mtd, chip, addr, trans, buf,
+						   oob, &err_addr);
+
 		dev_dbg(ctrl->dev, "corrected error at 0x%llx\n",
 			(unsigned long long)err_addr);
 		mtd->ecc_stats.corrected += corrected;
-- 
2.17.1

