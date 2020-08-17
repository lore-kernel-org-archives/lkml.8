Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BE0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E391204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690731;
	bh=hBzGgBzNahpEdDADEaYlbQNpcif8S6aBNv/CwkRJClE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2mhwa3cZLvJ0FalGhB0n4o05HlLKM4xXyw/9yLgeda/YIr+rhn7rAz4ceOi6KsJyX
	 4FpcKEqsdgyD1HEH+MorThK3Fso59lVbYHHCWP/psLv5G8td0w3M2fcOj2t3IPDRHb
	 cHx3eKgsladM0+QThj6yk9pv1pqD8Xg/cVU6kanI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387778AbgHQPtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387431AbgHQPjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:39:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9A4422C9F;
        Mon, 17 Aug 2020 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678739;
        bh=hBzGgBzNahpEdDADEaYlbQNpcif8S6aBNv/CwkRJClE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MwRvotq6UBbrLr+M9kCvyeFT24h4CEJbUc9Hzyk4OoD8la+jCqT8q1BEk2ea2KnVZ
         L7HrFGSWPNDn/8rQo6b12PWOQIStofbpg4FoqQp5PPisgens2n7/udm+FTS1lyNggc
         u5/TQW9q5RYvFADo3KJXEcMcUX1M0JllIHWguh8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.8 437/464] mtd: rawnand: qcom: avoid write to unavailable register
Date:   Mon, 17 Aug 2020 17:16:30 +0200
Message-Id: <20200817143854.709969525@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sivaprakash Murugesan <sivaprak@codeaurora.org>

commit 443440cc4a901af462239d286cd10721aa1c7dfc upstream.

SFLASHC_BURST_CFG is only available on older ipq NAND platforms, this
register has been removed when the NAND controller got implemented in
the qpic controller.

Avoid writing this register on devices which are based on qpic NAND
controller.

Fixes: dce84760b09f ("mtd: nand: qcom: Support for IPQ8074 QPIC NAND controller")
Cc: stable@vger.kernel.org
Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/1591948696-16015-2-git-send-email-sivaprak@codeaurora.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/qcom_nandc.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -459,11 +459,13 @@ struct qcom_nand_host {
  * among different NAND controllers.
  * @ecc_modes - ecc mode for NAND
  * @is_bam - whether NAND controller is using BAM
+ * @is_qpic - whether NAND CTRL is part of qpic IP
  * @dev_cmd_reg_start - NAND_DEV_CMD_* registers starting offset
  */
 struct qcom_nandc_props {
 	u32 ecc_modes;
 	bool is_bam;
+	bool is_qpic;
 	u32 dev_cmd_reg_start;
 };
 
@@ -2774,7 +2776,8 @@ static int qcom_nandc_setup(struct qcom_
 	u32 nand_ctrl;
 
 	/* kill onenand */
-	nandc_write(nandc, SFLASHC_BURST_CFG, 0);
+	if (!nandc->props->is_qpic)
+		nandc_write(nandc, SFLASHC_BURST_CFG, 0);
 	nandc_write(nandc, dev_cmd_reg_addr(nandc, NAND_DEV_CMD_VLD),
 		    NAND_DEV_CMD_VLD_VAL);
 
@@ -3035,12 +3038,14 @@ static const struct qcom_nandc_props ipq
 static const struct qcom_nandc_props ipq4019_nandc_props = {
 	.ecc_modes = (ECC_BCH_4BIT | ECC_BCH_8BIT),
 	.is_bam = true,
+	.is_qpic = true,
 	.dev_cmd_reg_start = 0x0,
 };
 
 static const struct qcom_nandc_props ipq8074_nandc_props = {
 	.ecc_modes = (ECC_BCH_4BIT | ECC_BCH_8BIT),
 	.is_bam = true,
+	.is_qpic = true,
 	.dev_cmd_reg_start = 0x7000,
 };
 


