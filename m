Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5443EC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306A0206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="cxJgSxTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgEECoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 22:44:37 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:24566 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726635AbgEECog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 22:44:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588646675; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=cnbXS/68+99rkBapeyeMgdaXL1PCbfw3dbdVHYAn7W8=; b=cxJgSxTlBZCCre76NIswxaS1M81xNAi91Te/kF04A1r16IeiqTK5ioK7fhDM/BcFC98gw/uw
 T7yKXCmOGDzpKkWbLDgdrdzB8Z7mMBd8e79QIPgpPtH13qwbJnz/qyVYsdnKV7LgkHxI/QrL
 zE0Vuj09s/bdBf3ieEgLsDYI5pU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb0d312.7fa23d905b90-smtp-out-n03;
 Tue, 05 May 2020 02:44:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 219C9C433BA; Tue,  5 May 2020 02:44:34 +0000 (UTC)
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F7B9C433D2;
        Tue,  5 May 2020 02:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F7B9C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org, jhugo@codeaurora.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v5 0/8] Bug fixes and improved logging in MHI
Date:   Mon,  4 May 2020 19:44:14 -0700
Message-Id: <1588646662-25785-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A set of patches for bug fixes and improved logging in mhi/core/boot.c.
Verified on x86 and arm64 platforms.

v5:
-Updated the macro MHI_RANDOM_U32_NONZERO to take a bitmask as the input
parameter and output a non-zero value between 1 and U32_MAX

v4:
-Dropped the change: bus: mhi: core: WARN_ON for malformed vector table
-Updated bus: mhi: core: Read transfer length from an event properly to include
parse rsc events
-Use prandom_u32_max() instead of prandom_u32 to avoid if check in
bus: mhi: core: Ensure non-zero session or sequence ID values are used

v3:
-Fixed signed-off-by tags
-Add a refactor patch for MHI queue APIs
-Commit text fix in bus: mhi: core: Read transfer length from an event properly
-Fix channel ID range check for ctrl and data event rings processing

v2:
-Fix channel ID range check potential infinite loop
-Add appropriate signed-off-by tags

Bhaumik Bhatt (4):
  bus: mhi: core: Handle firmware load using state worker
  bus: mhi: core: Return appropriate error codes for AMSS load failure
  bus: mhi: core: Improve debug logs for loading firmware
  bus: mhi: core: Ensure non-zero session or sequence ID values are used

Hemant Kumar (4):
  bus: mhi: core: Refactor mhi queue APIs
  bus: mhi: core: Cache intmod from mhi event to mhi channel
  bus: mhi: core: Add range check for channel id received in event ring
  bus: mhi: core: Read transfer length from an event properly

 drivers/bus/mhi/core/boot.c     |  75 ++++++++++++------------
 drivers/bus/mhi/core/init.c     |   5 +-
 drivers/bus/mhi/core/internal.h |   6 +-
 drivers/bus/mhi/core/main.c     | 124 ++++++++++++++++++++--------------------
 drivers/bus/mhi/core/pm.c       |   6 +-
 include/linux/mhi.h             |   2 -
 6 files changed, 109 insertions(+), 109 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
