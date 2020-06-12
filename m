Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818A1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B0E620663
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OplEkeIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgFLV3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgFLV33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:29:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EBBC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:29:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d128so9306135wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t7sh6l2f+5trgFJapdjMKhKvmvODdJp1FD96Ciw8Ol4=;
        b=OplEkeIlZyuHSfz2NDZ2KGM+1Nyb99WWYVd73hiBSL3+vJD2Xn0C4WVNTyq+WNQh93
         QaHCI8OjUpCWhWDQyDAhbtZwAsjgjHgEzGaZn+sOlbFmkoZ6BXZwxt9N/sbpmCD8beZh
         CqhwVAK5KPdFJYP7t4eodQ18Dt3MqlnWcBg41BQFTLD+isWboFGXWhIh8WANF5SBB1Vf
         AgdodhXDa52etvebHhYCOLB9Y0d03kNpdVdeUMZgKFppNgH0RzY25moaK0lhHkruBNTR
         z8pTvAOt0twBNGtm7Q972mQULM/U/eQH+/gb/FA8d1AQN4YiMK33RLueAmgILSXzI7ob
         ezEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t7sh6l2f+5trgFJapdjMKhKvmvODdJp1FD96Ciw8Ol4=;
        b=Ew7uhXH47998tCdflgSAfTQ6AocC/2k2DHl8rnHg2wB5IcSSOXXnj2h8BEVpXe+ygP
         gBcMiA2I+V2hTqVwApsKJcZP7mWeWqIjHIIfaJDuKcWEV25A7aGoMYQfWA23fVbERxR5
         qAEkz9uXCLZK3QW+l5hgqG2VMnzETgKTlfSUNaluZlmtvyMET6/s9ZJzVE6pdPILPSqp
         bnQENxSnUkYyemskgtsPmuHzLDx9d4P85YD6xLfd5XIE3xSJqugZcmnASCI1bFNRb4FT
         6V1mlV+B9BYy0fNbFWRjhB5JZPnnV/yTD9Xt4RbhYpf7iS2xFJ+tqfwMReV99a4nbNSf
         G5/A==
X-Gm-Message-State: AOAM532OUYZ7iWfh0drCZ7UOGgF1/DXIWPzIBWj1lG1tadyTxjwC2nbN
        K+70F3Yz8g/tilnWnt8oLA34Zmhl
X-Google-Smtp-Source: ABdhPJxQFwOtTuY9hFOELCASEz96m4UJNODfbkMBPykqB/GhLTej/gj4XR9KJ1Dmlglwp8YOjAfjCQ==
X-Received: by 2002:a1c:bd86:: with SMTP id n128mr895811wmf.5.1591997367305;
        Fri, 12 Jun 2020 14:29:27 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id n189sm10442048wmb.43.2020.06.12.14.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 14:29:26 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     computersforpeace@gmail.com, kdasu.kdev@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mtd: rawnand: brcmnand: ECC error handling on EDU transfers
Date:   Fri, 12 Jun 2020 17:29:02 -0400
Message-Id: <20200612212902.21347-3-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612212902.21347-1-kdasu.kdev@gmail.com>
References: <20200612212902.21347-1-kdasu.kdev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement ECC correctable and uncorrectable error handling for EDU
reads. If ECC correctable bitflips are encountered on EDU transfer,
read page again using PIO. This is needed due to a NAND controller
limitation where corrected data is not transferred to the DMA buffer
on ECC error. This applies to ECC correctable errors that are reported
by the controller hardware based on set number of bitflips threshold in
the controller threshold register, bitflips below the threshold are
corrected silently and are not reported by the controller hardware.

Fixes: a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers")
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 0c1d6e543586..131d5d6e2626 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1855,6 +1855,22 @@ static int brcmnand_edu_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
 	edu_writel(ctrl, EDU_STOP, 0); /* force stop */
 	edu_readl(ctrl, EDU_STOP);
 
+	if (!ret && edu_cmd == EDU_CMD_READ) {
+		u64 err_addr = 0;
+
+		/*
+		 * check for ECC errors here, subpage ECC errors are
+		 * retained in ECC error address register
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
+	bool edu_err = false;
 
 	dev_dbg(ctrl->dev, "read %llx -> %p\n", (unsigned long long)addr, buf);
 
@@ -2075,6 +2092,10 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
 			else
 				return -EIO;
 		}
+
+		if (has_edu(ctrl) && err_addr)
+			edu_err = true;
+
 	} else {
 		if (oob)
 			memset(oob, 0x99, mtd->oobsize);
@@ -2122,6 +2143,11 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
 	if (mtd_is_bitflip(err)) {
 		unsigned int corrected = brcmnand_count_corrected(ctrl);
 
+		/* in case of EDU correctable error we read again using PIO */
+		if (edu_err)
+			err = brcmnand_read_by_pio(mtd, chip, addr, trans, buf,
+						   oob, &err_addr);
+
 		dev_dbg(ctrl->dev, "corrected error at 0x%llx\n",
 			(unsigned long long)err_addr);
 		mtd->ecc_stats.corrected += corrected;
-- 
2.17.1

