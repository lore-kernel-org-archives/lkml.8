Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691E8C38A30
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFE620747
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="B4gD7WAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgDVETz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 00:19:55 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:64155 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgDVETz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 00:19:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587529194; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=kvpym/R0LUwgL8lADSrB9TScxJz6XxGUYe6UV96jMZQ=; b=B4gD7WAdHKKiMzR9XryAnaEIx867Fy0KcjLba8hGz9QPocxt5PWVrB1xgzVuhhLh+6nLcIiO
 WMcjBoebPXqWumC6Ma/x8a3KUVNZCrHjHApQ6ebAKtFdFfsEbaxUTyALUcFQIuB2SSQkhKWk
 Cc3k7gdwsYaY2bJf373qYWZvUgs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9fc5e6.7fe203ca6538-smtp-out-n02;
 Wed, 22 Apr 2020 04:19:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 84D90C43637; Wed, 22 Apr 2020 04:19:50 +0000 (UTC)
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B40DC433BA;
        Wed, 22 Apr 2020 04:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B40DC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Hemant Kumar <hemantk@codeaurora.org>
Subject: [PATCH v1 2/8] bus: mhi: core: Add range check for channel id received in event ring
Date:   Tue, 21 Apr 2020 21:19:29 -0700
Message-Id: <1587529175-27778-3-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587529175-27778-1-git-send-email-bbhatt@codeaurora.org>
References: <1587529175-27778-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemant Kumar <hemantk@codeaurora.org>

MHI data completion handler function reads channel id from event
ring element. Value is under the control of MHI devices and can be
any value between 0 and 255. In order to prevent out of bound access
add a bound check against the max channel supported by controller
and skip processing of that event ring element.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
---
 drivers/bus/mhi/core/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 23154f1..ba8afa7 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -827,6 +827,9 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
 
 		chan = MHI_TRE_GET_EV_CHID(local_rp);
+		if (WARN_ON(chan >= mhi_cntrl->max_chan))
+			continue;
+
 		mhi_chan = &mhi_cntrl->mhi_chan[chan];
 
 		if (likely(type == MHI_PKT_TYPE_TX_EVENT)) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
