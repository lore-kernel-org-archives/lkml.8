Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F6DC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE6F206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="O9kSJnUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgD0P7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:59:46 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:60392 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbgD0P7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:59:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588003183; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Lp4UVvPmMQjC2/JYxwrZKcQ0qPfOGZ4e+RUvnDeF/TE=; b=O9kSJnUycXlsgcYSt7ceV3vwq3vvoa62WjQaq4ctHodn+Ro6ZgsnroA23ZNpl6SFghnbpDQy
 AgoBawmD2mz3bYeviynhKCpABNfzxPvODCJWBG6Sshux3qyXcjYLvoTeeskr8KFZmgNbopYP
 bOOYSdl21Ma+Gju4XzVlPNARn1Y=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea7016d.7f1064cf9110-smtp-out-n02;
 Mon, 27 Apr 2020 15:59:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1B29BC433CB; Mon, 27 Apr 2020 15:59:40 +0000 (UTC)
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA644C432C2;
        Mon, 27 Apr 2020 15:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA644C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org, hemantk@codeaurora.org
Cc:     bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v3 6/6] bus: mhi: core: Fix channel device name conflict
Date:   Mon, 27 Apr 2020 09:59:13 -0600
Message-Id: <1588003153-13139-7-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1588003153-13139-1-git-send-email-jhugo@codeaurora.org>
References: <1588003153-13139-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple instances of the same MHI product are present in a system,
we can see a splat from mhi_create_devices() - "sysfs: cannot create
duplicate filename".

This is because the device names assigned to the MHI channel devices are
non-unique.  They consist of the channel's name, and the channel's pipe
id.  For identical products, each instance is going to have the same
set of channel (both in name and pipe id).

To fix this, we prepend the device name of the parent device that the
MHI channels belong to.  Since different instances of the same product
should have unique device names, this makes the MHI channel devices for
each product also unique.

Additionally, remove the pipe id from the MHI channel device name.  This
is an internal detail to the MHI product that provides little value, and
imposes too much device specific internal details to userspace.  It is
expected that channel with a specific name (ie "SAHARA") has a specific
client, and it does not matter what pipe id that channel is enumerated on.
The pipe id is an internal detail between the MHI bus, and the hardware.
The client is not expected to make decisions based on the pipe id, and to
do so would require the client to have intimate knowledge of the hardware,
which is inappropiate as it may violate the layering provided by the MHI
bus.  The limitation of doing this is that each product may only have one
instance of a channel by a unique name.  This limitation is appropriate
given the usecases of MHI channels.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/bus/mhi/core/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 580d72b..0ac0643 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -327,7 +327,8 @@ void mhi_create_devices(struct mhi_controller *mhi_cntrl)
 
 		/* Channel name is same for both UL and DL */
 		mhi_dev->chan_name = mhi_chan->name;
-		dev_set_name(&mhi_dev->dev, "%04x_%s", mhi_chan->chan,
+		dev_set_name(&mhi_dev->dev, "%s_%s",
+			     dev_name(mhi_cntrl->cntrl_dev),
 			     mhi_dev->chan_name);
 
 		/* Init wakeup source if available */
-- 
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
