Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA54C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 754D320792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="C/X7Qpd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgGWWg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:36:57 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:35923 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbgGWWg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:36:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595543815; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=bJ/v+6BI1paYfL/eqbBaNuQt+rMkV7hVFchzos3nW8A=; b=C/X7Qpd8qQm2K0+ioVWP6HaAftmO8+wFegjD/qFMooro27bimTuUKYR7uVjLwnSWb53xFdnF
 uihg2zDG4J3Y/Cf//wX+ucx3n9t/9oHLS15rIpyyXSLY9LbDdemziKbEdh9bOkP+BfoKZkEB
 5l3CDvWLkY8rsuvaufZC8d8Imbk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f1a1106427cd5576650244e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 23 Jul 2020 22:36:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 431FAC433AF; Thu, 23 Jul 2020 22:36:54 +0000 (UTC)
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C6C9C433CB;
        Thu, 23 Jul 2020 22:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C6C9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v5 06/10] bus: mhi: core: Introduce helper function to check device state
Date:   Thu, 23 Jul 2020 15:36:38 -0700
Message-Id: <1595543802-17859-7-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595543802-17859-1-git-send-email-bbhatt@codeaurora.org>
References: <1595543802-17859-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a helper function to determine whether the device is in a
powered ON state and resides in one of the active MHI states. This will
allow for some use cases where access can be pre-determined.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 1bbd6e9..5a81a42 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -598,6 +598,11 @@ int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl);
 int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl);
 int mhi_send_cmd(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 		 enum mhi_cmd_type cmd);
+static inline bool mhi_is_active(struct mhi_controller *mhi_cntrl)
+{
+	return (mhi_cntrl->dev_state >= MHI_STATE_M0 &&
+		mhi_cntrl->dev_state <= MHI_STATE_M3_FAST);
+}
 
 static inline void mhi_trigger_resume(struct mhi_controller *mhi_cntrl)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

