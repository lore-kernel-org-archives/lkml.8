Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2998C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0D220724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916380;
	bh=8xb+Gv2zVXgerD4FU1n/Tb5A6ZPUmJJhP1tj6t/q9gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QdTw2XBWMCpUwHSOMwIfRrLxapXfwFbeViCemTX9/g0EEYr4cPLbhnqMD8PzzgdJK
	 +Q3vR9Y1gZHG+6o2OZMKJLV+chpVI8ezSJ6tMCBhTge8i6PpPj8emgt2NsE7qCKvTb
	 5Cc5eu+zByUEk66SEGdVVY9bqGtNuPaHbTtKk8VA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgHTJji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728943AbgHTJjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:39:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C03920724;
        Thu, 20 Aug 2020 09:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916364;
        bh=8xb+Gv2zVXgerD4FU1n/Tb5A6ZPUmJJhP1tj6t/q9gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WvcMxVmUd2cEnwMxu9RXkHG9IYNiN5XBH4jNhrzsgot3jWvxunrzAWqlDPeA3q4cG
         CcYhy76PWPL03ALs86kfRAv0G1wz4Znj7oLiNeTEAiLmjbmr1ykg17QSa7JtkpUADI
         BVI/JhSU4HTMolpFsDOSKOG8oz0/2FZJW+vzuMe0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 103/204] mtd: rawnand: brcmnand: ECC error handling on EDU transfers
Date:   Thu, 20 Aug 2020 11:20:00 +0200
Message-Id: <20200820091611.466364001@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kamal Dasu <kdasu.kdev@gmail.com>

[ Upstream commit 4551e78ad98add1f16b70cf286d5aad3ce7bcd4c ]

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
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20200612212902.21347-3-kdasu.kdev@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index cdae2311a3b69..0b1ea965cba08 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1859,6 +1859,22 @@ static int brcmnand_edu_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
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
 
@@ -2065,6 +2081,7 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
 	u64 err_addr = 0;
 	int err;
 	bool retry = true;
+	bool edu_err = false;
 
 	dev_dbg(ctrl->dev, "read %llx -> %p\n", (unsigned long long)addr, buf);
 
@@ -2082,6 +2099,10 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
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
@@ -2129,6 +2150,11 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
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
2.25.1



