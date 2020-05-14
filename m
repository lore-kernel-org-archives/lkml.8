Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B38C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B8A2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ClPJZeER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgENUIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:08:25 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57554 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728187AbgENUIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:08:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589486904; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4YJ2XzG2JIi+LCwLrdlVxFzG02vS8JkhTTg9UN+mYy4=; b=ClPJZeERQVc4KP0tfj37bhukVwSr/53LYxeNfJp3ro4xMH1yYiGVBstHYUUImLzkKcN23gc5
 E9hn3o/4iiGk8IaL5538577/hVNHAn+LkVL0h8r2xQCLJX2YNLCKnV0GGgOTg/w6yvDoBkJF
 7E9zQbTNQLJFgvsAJ9a+hJpJHFM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebda537.7f793e833a08-smtp-out-n03;
 Thu, 14 May 2020 20:08:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B4F95C072B7; Thu, 14 May 2020 20:08:22 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8AD8EC38561;
        Thu, 14 May 2020 20:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8AD8EC38561
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v3 0/3] Extend coredump functionality
Date:   Thu, 14 May 2020 13:07:33 -0700
Message-Id: <1589486856-23440-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series moves the coredump functionality to a separate
file and adds "inline" coredump feature. Inline coredump directly
copies segments from device memory during coredump to userspace.
This avoids extra memory usage at the cost of speed. Recovery is
stalled untill all data is read by userspace.

Changelog:

v3 -> v2:
- Move entire coredump functionality to remoteproc_coredump.c
- Modify rproc_coredump to perform dump according to conf. set by userspace
- Move the userspace configuration to debugfs from sysfs.
- Keep the default coredump implementation as is

v2 -> v1:
- Introduce new file for coredump.
- Add userspace sysfs configuration for dump type.

Rishabh Bhatnagar (3):
  remoteproc: Move coredump functionality to a new file
  remoteproc: Add inline coredump functionality
  remoteproc: Add coredump debugfs entry

 drivers/remoteproc/Makefile              |   1 +
 drivers/remoteproc/remoteproc_core.c     | 191 ------------------
 drivers/remoteproc/remoteproc_coredump.c | 322 +++++++++++++++++++++++++++++++
 drivers/remoteproc/remoteproc_debugfs.c  |  86 +++++++++
 drivers/remoteproc/remoteproc_internal.h |   4 +
 include/linux/remoteproc.h               |  15 ++
 6 files changed, 428 insertions(+), 191 deletions(-)
 create mode 100644 drivers/remoteproc/remoteproc_coredump.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
