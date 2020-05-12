Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C22C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDCFA2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="m90egbfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgELCDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 22:03:25 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:12799 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728554AbgELCDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:03:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589249001; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=2g53dCdQCv7gFi9EsXPVGxHD6wMKmmDOZGGpFURnlk4=; b=m90egbfAid6GRbXMhb1MXyIw4eMoCevtLA1i3hgqIwLhqxifWsUI2kHHN+v/dBB6kNMIiMA1
 o9uqF2xeJAlLFwl5Tp1IC9eouSQkVA0cm43xTf8Q9Br0OX/x8UUY9UJRC6P8AXVPsH5kbjCO
 G+cRNLP7KjuPPmw5SAfGPyUZboU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eba03e8.7f9bb043f1b8-smtp-out-n01;
 Tue, 12 May 2020 02:03:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0B039C433F2; Tue, 12 May 2020 02:03:20 +0000 (UTC)
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 501CCC433CB;
        Tue, 12 May 2020 02:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 501CCC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=hemantk@codeaurora.org
From:   Hemant Kumar <hemantk@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org,
        Hemant Kumar <hemantk@codeaurora.org>
Subject: [PATCH v1 5/5] bus: mhi: core: Handle write lock properly in mhi_pm_m0_transition
Date:   Mon, 11 May 2020 19:03:09 -0700
Message-Id: <1589248989-23824-6-git-send-email-hemantk@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1589248989-23824-1-git-send-email-hemantk@codeaurora.org>
References: <1589248989-23824-1-git-send-email-hemantk@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take write lock only to protect db_mode member of mhi channel.
This allows rest of the mhi channels to just take read lock which
fine grains the locking. It prevents channel readers to starve if
they try to enter critical section after a writer.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
---
 drivers/bus/mhi/core/pm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 345f197..de5abb2 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -288,14 +288,18 @@ int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl)
 	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
 		struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
 
-		write_lock_irq(&mhi_chan->lock);
-		if (mhi_chan->db_cfg.reset_req)
+		if (mhi_chan->db_cfg.reset_req) {
+			write_lock_irq(&mhi_chan->lock);
 			mhi_chan->db_cfg.db_mode = true;
+			write_unlock_irq(&mhi_chan->lock);
+		}
+
+		read_lock_irq(&mhi_chan->lock);
 
 		/* Only ring DB if ring is not empty */
 		if (tre_ring->base && tre_ring->wp  != tre_ring->rp)
 			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
-		write_unlock_irq(&mhi_chan->lock);
+		read_unlock_irq(&mhi_chan->lock);
 	}
 
 	mhi_cntrl->wake_put(mhi_cntrl, false);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
