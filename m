Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB34EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F78206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="jMGzTdoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgERUEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 16:04:23 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:15375 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727831AbgERUEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:04:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589832253; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=j1u5QBULuJKFUyNxaQAkdzuQVerFj62srXNJ8V0Lrak=; b=jMGzTdoPje8wGew7bm3jFE21UTNOJeliCb/dAgOUxvLmS5o6fU762XeWWC5UzrxFZzHOfzGz
 m/drCBzh116QRoS+6A+Ky9Sk9wg1CEfoiT6+5+U9X/vyk6saU7Vf9GLmL4Uz1MqNWDd44agy
 DA5/tmy7DRNdaXlaZz5T0fqrKvk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec2ea38.7efd1e647110-smtp-out-n02;
 Mon, 18 May 2020 20:04:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0B1C6C433D2; Mon, 18 May 2020 20:04:08 +0000 (UTC)
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 656E0C433F2;
        Mon, 18 May 2020 20:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 656E0C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v3 1/7] bus: mhi: core: Abort suspends due to outgoing pending packets
Date:   Mon, 18 May 2020 13:03:55 -0700
Message-Id: <1589832241-13867-2-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1589832241-13867-1-git-send-email-bbhatt@codeaurora.org>
References: <1589832241-13867-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing check to abort suspends if a client has pending outgoing
packets to send to the device. This allows better utilization of the MHI
bus wherein clients on the host are not left waiting for longer suspend
or resume cycles to finish for data transfers.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 7960980..661d704 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -686,7 +686,8 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
 		return -EIO;
 
 	/* Return busy if there are any pending resources */
-	if (atomic_read(&mhi_cntrl->dev_wake))
+	if (atomic_read(&mhi_cntrl->dev_wake) ||
+	    atomic_read(&mhi_cntrl->pending_pkts))
 		return -EBUSY;
 
 	/* Take MHI out of M2 state */
@@ -712,7 +713,8 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
 
 	write_lock_irq(&mhi_cntrl->pm_lock);
 
-	if (atomic_read(&mhi_cntrl->dev_wake)) {
+	if (atomic_read(&mhi_cntrl->dev_wake) ||
+	    atomic_read(&mhi_cntrl->pending_pkts)) {
 		write_unlock_irq(&mhi_cntrl->pm_lock);
 		return -EBUSY;
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
