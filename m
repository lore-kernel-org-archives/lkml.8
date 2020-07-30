Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0174C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDAA42173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="U/rG/EIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgG3FT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 01:19:27 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:47943 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727838AbgG3FT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 01:19:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596086366; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=WyvtVLlI6cmKVJj0jDe+724H+IlnfLJvsn+Fgvd0fRQ=; b=U/rG/EIKr7RwusXV5pe/oJVorAW7NWowvNIM+/if84XbAWvIkwuGdLfdPvpfPQxdTqdRk5BQ
 WYJWVgimxP69WdgzRleYlZxyvsfORYhfL3aDyN23tBxdsyCf6nrQK8TrR3Ml8IHbQqcvJocf
 L5zr9KX1qAHfze2aPjN8w1iLoYs=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-east-1.postgun.com with SMTP id
 5f22583c7186ea1ee1b7d4f9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 30 Jul 2020 05:18:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8077BC4339C; Thu, 30 Jul 2020 05:18:51 +0000 (UTC)
Received: from deesin-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: deesin)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3EBD3C433AD;
        Thu, 30 Jul 2020 05:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EBD3C433AD
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=deesin@codeaurora.org
From:   Deepak Kumar Singh <deesin@codeaurora.org>
To:     bjorn.andersson@linaro.org, clew@codeaurora.org
Cc:     mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Deepak Kumar Singh <deesin@codeaurora.org>
Subject: [PATCH V1 4/6] rpmsg: glink: Remove the rpmsg dev in close_ack
Date:   Thu, 30 Jul 2020 10:48:14 +0530
Message-Id: <1596086296-28529-5-git-send-email-deesin@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596086296-28529-1-git-send-email-deesin@codeaurora.org>
References: <1596086296-28529-1-git-send-email-deesin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Kumar Neelakantam <aneela@codeaurora.org>

Un-register and register of rpmsg driver is sending invalid open_ack
on closed channel.

To avoid sending invalid open_ack case unregister the rpmsg device
after receiving the local_close_ack from remote side.

Signed-off-by: Deepak Kumar Singh <deesin@codeaurora.org>
signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_native.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index ac179b1..031bc1d 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1526,6 +1526,7 @@ static void qcom_glink_rx_close(struct qcom_glink *glink, unsigned int rcid)
 
 		rpmsg_unregister_device(glink->dev, &chinfo);
 	}
+	channel->rpdev = NULL;
 
 	qcom_glink_send_close_ack(glink, channel->rcid);
 
@@ -1539,6 +1540,7 @@ static void qcom_glink_rx_close(struct qcom_glink *glink, unsigned int rcid)
 
 static void qcom_glink_rx_close_ack(struct qcom_glink *glink, unsigned int lcid)
 {
+	struct rpmsg_channel_info chinfo;
 	struct glink_channel *channel;
 	unsigned long flags;
 
@@ -1553,6 +1555,16 @@ static void qcom_glink_rx_close_ack(struct qcom_glink *glink, unsigned int lcid)
 	channel->lcid = 0;
 	spin_unlock_irqrestore(&glink->idr_lock, flags);
 
+	/* Decouple the potential rpdev from the channel */
+	if (channel->rpdev) {
+		strlcpy(chinfo.name, channel->name, sizeof(chinfo.name));
+		chinfo.src = RPMSG_ADDR_ANY;
+		chinfo.dst = RPMSG_ADDR_ANY;
+
+		rpmsg_unregister_device(glink->dev, &chinfo);
+	}
+	channel->rpdev = NULL;
+
 	kref_put(&channel->refcount, qcom_glink_channel_release);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

