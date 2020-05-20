Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6204C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71EF22075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="gbGAK2VO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgETJka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 05:40:30 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:53180 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726875AbgETJk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 05:40:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589967628; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=UIharH5fDzSd4i7jVCFkQvYdn49INIoNrfkHjTev/zw=; b=gbGAK2VOQUKnGQBHiShLcgdZzjV2zvrYBt+0K+eFSsL5MLM5OrRNY26X5xFV/q281mDqcSOS
 xSonkoQ/fhWwdVHo+oFLdue1kpzor7+mXnKd1xFFf/T5CAG8s8iO5zBr4omFpVMzVh3biDFA
 FDBMB8/bY9oBjM1mmiEdBF5vm3g=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec4fafe.7f84424289d0-smtp-out-n03;
 Wed, 20 May 2020 09:40:14 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11801C433AF; Wed, 20 May 2020 09:40:14 +0000 (UTC)
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8908FC433C6;
        Wed, 20 May 2020 09:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8908FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
Subject: [PATCH V6 5/5] rpmsg: glink: unregister rpmsg device during endpoint destroy
Date:   Wed, 20 May 2020 15:09:39 +0530
Message-Id: <1589967579-15559-6-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589967579-15559-1-git-send-email-aneela@codeaurora.org>
References: <1589967579-15559-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rpmsg device unregister is not happening if channel close is triggered
from local side and causing re-registration of device failures.

Unregister rpmsg device for local close in endpoint destroy path.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_native.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 2b5368b..53b90a1 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1207,6 +1207,7 @@ static void qcom_glink_destroy_ept(struct rpmsg_endpoint *ept)
 {
 	struct glink_channel *channel = to_glink_channel(ept);
 	struct qcom_glink *glink = channel->glink;
+	struct rpmsg_channel_info chinfo;
 	unsigned long flags;
 
 	spin_lock_irqsave(&channel->recv_lock, flags);
@@ -1214,6 +1215,13 @@ static void qcom_glink_destroy_ept(struct rpmsg_endpoint *ept)
 	spin_unlock_irqrestore(&channel->recv_lock, flags);
 
 	/* Decouple the potential rpdev from the channel */
+	if (channel->rpdev) {
+		strncpy(chinfo.name, channel->name, sizeof(chinfo.name));
+		chinfo.src = RPMSG_ADDR_ANY;
+		chinfo.dst = RPMSG_ADDR_ANY;
+
+		rpmsg_unregister_device(glink->dev, &chinfo);
+	}
 	channel->rpdev = NULL;
 
 	qcom_glink_send_close_req(glink, channel);
@@ -1477,6 +1485,7 @@ static void qcom_glink_rx_close(struct qcom_glink *glink, unsigned int rcid)
 
 		rpmsg_unregister_device(glink->dev, &chinfo);
 	}
+	channel->rpdev = NULL;
 
 	qcom_glink_send_close_ack(glink, channel->rcid);
 
-- 
2.7.4
