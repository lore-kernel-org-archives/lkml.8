Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB47C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C5B206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XI8GlVq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgELCDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 22:03:20 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:12799 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728073AbgELCDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:03:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589248999; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=x0TSpUhkeXeTC9dUNUB8kN5ovjs7zf0zTQz2/win20k=; b=XI8GlVq7n+4cD7Dm4qnr026WvI6NdUQ5ttk2CBPkdh0jctjO2Zt27n8bxC3dWkFIZyI6xovc
 srtXXek7p+7YuZJfiMWed3arW+00jCak+tshhdkiww/jovui2gjvCKjNM1DB8EJP08XB/fWv
 1i2LmuS1dXJzh3C1XVpNfWAGrCE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eba03e5.7fae597371b8-smtp-out-n05;
 Tue, 12 May 2020 02:03:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 39B7EC43637; Tue, 12 May 2020 02:03:17 +0000 (UTC)
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 18A21C433CB;
        Tue, 12 May 2020 02:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18A21C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=hemantk@codeaurora.org
From:   Hemant Kumar <hemantk@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org,
        Hemant Kumar <hemantk@codeaurora.org>
Subject: [PATCH v1 0/5] MHI Misc Fixes
Date:   Mon, 11 May 2020 19:03:04 -0700
Message-Id: <1589248989-23824-1-git-send-email-hemantk@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches are addressing MHI core driver bug fixes. Patches tested on
arm64 and x86 platforms.

Hemant Kumar (5):
  bus: mhi: core: Remove the system error worker thread
  bus: mhi: core: Handle disable transitions in state worker
  bus: mhi: core: Skip handling BHI irq if MHI reg access is not allowed
  bus: mhi: core: Do not process SYS_ERROR if RDDM is supported
  bus: mhi: core: Handle write lock properly in mhi_pm_m0_transition

 drivers/bus/mhi/core/init.c     |  3 ++-
 drivers/bus/mhi/core/internal.h |  4 +++-
 drivers/bus/mhi/core/main.c     | 38 +++++++++++++++++++----------
 drivers/bus/mhi/core/pm.c       | 53 ++++++++++++++++++++++++-----------------
 include/linux/mhi.h             |  2 --
 5 files changed, 61 insertions(+), 39 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
