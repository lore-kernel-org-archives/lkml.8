Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACABBC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727B220730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XxmL2UTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgDGQvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:51:25 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:44521 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbgDGQvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:51:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586278284; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=KWYz9mvUkdbBY6VxSARV2NYFIwTTBdGFRZi6/OrS2Zo=; b=XxmL2UTjjqujfS7j1NtfV7PW2tRIAX91YbdGozPCki9NKj8HVYeKgvH+GYJOZCvM6Q6MVfLd
 67g6jo3lpHwKEGGZvvMApt1CgSS5rlyHPcvLHpvN1lkNWtYoqnGNJCzXEBjwy+pWBB3rlXqz
 E1JLOVfivaat4mY5kFQ6oTfw4a4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8caf8b.7f8ce554a6f8-smtp-out-n02;
 Tue, 07 Apr 2020 16:51:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B9BB9C433BA; Tue,  7 Apr 2020 16:51:23 +0000 (UTC)
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1AC3C433D2;
        Tue,  7 Apr 2020 16:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1AC3C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org, hemantk@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2 0/5] Misc MHI fixes
Date:   Tue,  7 Apr 2020 10:50:25 -0600
Message-Id: <1586278230-29565-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few (independent) fixes to the MHI bus for issues that I have come across
while developing against the mainline code.

v2:
-fix syserr reset log message
-fix power up error check code style
-add change to remove pci assumptions for register accesses
-add comment typo fix

Jeffrey Hugo (5):
  bus: mhi: core: Handle syserr during power_up
  bus: mhi: core: Make sure to powerdown if mhi_sync_power_up fails
  bus: mhi: core: Remove link_status() callback
  bus: mhi: core: Offload register accesses to the controller
  bus: mhi: core: Fix typo in comment

 drivers/bus/mhi/core/init.c     |  7 +++----
 drivers/bus/mhi/core/internal.h |  3 ---
 drivers/bus/mhi/core/main.c     | 13 ++-----------
 drivers/bus/mhi/core/pm.c       | 26 +++++++++++++++++++++++++-
 include/linux/mhi.h             | 10 +++++++---
 5 files changed, 37 insertions(+), 22 deletions(-)

-- 
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
