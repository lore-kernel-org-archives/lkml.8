Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2648BC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78BB2072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="bAD5qUAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD1WSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:18:43 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:52612 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726493AbgD1WSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:18:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588112321; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=//VBqdgUg9G/r+7TrS96H+ACGd9ntTWQxYnT/b7FBF4=; b=bAD5qUAFPuOtJgoTHrYAEPf/Gvs/aPEybValhTcTu9RfFYcevq4dNrHE6HBdwntct+qw+WNc
 IFvIYS2nPIdEVPsApK/g4guvh0h5qaD+2D4WFPYiVYc1lHV6ok4gj0eXGaGPN2DXT2PyPvtb
 BjuiBbJ3E+wRRZ8FviNNhcqRejs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea8abb9.7fecc04a0068-smtp-out-n03;
 Tue, 28 Apr 2020 22:18:33 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E3328C433F2; Tue, 28 Apr 2020 22:18:33 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3E80C433CB;
        Tue, 28 Apr 2020 22:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3E80C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, bjorn.andersson@linaro.org
Cc:     ohad@wizery.com, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v3 0/2] Extend SSR notifications framework
Date:   Tue, 28 Apr 2020 15:16:07 -0700
Message-Id: <1588112169-29447-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches gives kernel client drivers the ability to register
for a particular remoteproc's SSR notifications. Also the notifications
are extended to before/after-powerup/shutdown stages.
It also fixes the bug where clients need to register for notifications
again if the platform driver is removed. This is done by creating a
global list of per-remoteproc notification info data structures which
remain static. An API is exported to register for a remoteproc's SSR
notifications and uses remoteproc's ssr_name and notifier block as
arguments. 

Rishabh Bhatnagar (1):
  remoteproc: qcom: Add per subsystem SSR notification

Siddharth Gupta (1):
  remoteproc: qcom: Add notification types to SSR

v3 -> v2:
- Create a global list of per remoteproc notification data structure
- Pass ssr_name and crashed information as part of notification data
- Move notification type enum to qcom_rproc.h from remoteproc.h

v2 -> v1:
- Fix commit text

 drivers/remoteproc/qcom_common.c      | 133 ++++++++++++++++++++++++++++++----
 drivers/remoteproc/qcom_common.h      |  11 ++-
 include/linux/remoteproc/qcom_rproc.h |  34 +++++++--
 3 files changed, 157 insertions(+), 21 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
