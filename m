Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02570C83003
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDDFC2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="sT93KfO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgD1DAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 23:00:06 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:56918 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbgD1C7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:59:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588042783; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Hnw6YsaPhmWo+FG4M9WAgpw2nCpRT7gopKKbS5r3bNc=; b=sT93KfO4RRMvvRammbh1laxrDbhh1Gi1fqMky50uMZOHGxIBkuFPUlbCnhUoDxqsJHT///ha
 a7d9z3QYSpYgXpgxVk49U/iLw0au8T8FWxcBA7nMVJdcIAPrfQXAcEou/tJFlBpUNc5sXkJU
 YYEu5OxRsyKckd0+097MkpsGWqM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea79c1c.7f63f3a57ed8-smtp-out-n03;
 Tue, 28 Apr 2020 02:59:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E5464C433BA; Tue, 28 Apr 2020 02:59:39 +0000 (UTC)
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 467E3C433D2;
        Tue, 28 Apr 2020 02:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 467E3C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org, Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [RESEND PATCH v2 0/8] Bug fixes and improved logging in MHI
Date:   Mon, 27 Apr 2020 19:59:18 -0700
Message-Id: <1588042766-17496-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A set of patches for bug fixes and improved logging in mhi/core/boot.c.
Verified on x86 and arm64 platforms.

v2:
-Fix channel ID range check potential infinite loop
-Add appropriate signed-off-by tags

Bhaumik Bhatt (5):
  bus: mhi: core: Handle firmware load using state worker
  bus: mhi: core: WARN_ON for malformed vector table
  bus: mhi: core: Return appropriate error codes for AMSS load failure
  bus: mhi: core: Improve debug logs for loading firmware
  bus: mhi: core: Ensure non-zero session or sequence ID values

Hemant Kumar (3):
  bus: mhi: core: Cache intmod from mhi event to mhi channel
  bus: mhi: core: Add range check for channel id received in event ring
  bus: mhi: core: Read transfer length from an event properly

 drivers/bus/mhi/core/boot.c     | 74 +++++++++++++++++++++++++----------------
 drivers/bus/mhi/core/init.c     |  5 ++-
 drivers/bus/mhi/core/internal.h |  1 +
 drivers/bus/mhi/core/main.c     | 18 +++++++---
 drivers/bus/mhi/core/pm.c       |  6 +---
 include/linux/mhi.h             |  2 --
 6 files changed, 65 insertions(+), 41 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
