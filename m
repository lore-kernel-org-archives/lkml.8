Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341BBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1DE20708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="V36KtfUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgETAax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:30:53 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:45534 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727941AbgETAav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:30:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589934650; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=08T20vkMrFw3x6P4M+RR60tE7Brr4jauqOh0eFtfops=; b=V36KtfUJ+5kG5lpk/gwAseC9GjslXQ7oPOMwfSnCsPptGuKLyPq79WtVZ8b28tnT6PAkoThy
 b91FKCe9muTqPpUKzmQkbKDc5odlbHD35HhO9ZOpLo0p4UJ2tlBebUvQijSnbg4xMEpgO0Qw
 BchTdCi1rkJw8J1T2ujQI8r3H1Q=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec47a2e.7f978273ba40-smtp-out-n01;
 Wed, 20 May 2020 00:30:38 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EB2B1C43395; Wed, 20 May 2020 00:30:37 +0000 (UTC)
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63F44C43387;
        Wed, 20 May 2020 00:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63F44C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v1 0/6] Bug fixes and bootup and shutdown improvements
Date:   Tue, 19 May 2020 17:30:25 -0700
Message-Id: <1589934631-22752-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bug fixes for handling of execution environment in bootup/shutdown scenarios
and to improve host view of device state.
Introduced feature for manual mission mode image loading and allow for mission
mode image load from SBL handling.

Build dependencies:
Patch "bus: mhi: core: Mark device inactive soon after host issues a shutdown"
depends on: "bus: mhi: core: Introduce helper function to check device state".

Bhaumik Bhatt (6):
  bus: mhi: core: Improve shutdown handling after link down detection
  bus: mhi: core: Mark device inactive soon after host issues a shutdown
  bus: mhi: core: Check for RDDM support before forcing a device crash
  bus: mhi: core: Use common name for BHI firmware load function
  bus: mhi: core: Introduce support for manual AMSS loading
  bus: mhi: core: Process execution environment changes serially

 drivers/bus/mhi/core/boot.c     | 100 ++++++++++++++++++++--------------------
 drivers/bus/mhi/core/init.c     |   1 +
 drivers/bus/mhi/core/internal.h |   1 +
 drivers/bus/mhi/core/main.c     |  45 ++++++++++++------
 drivers/bus/mhi/core/pm.c       |  80 +++++++++++++++++++++++---------
 include/linux/mhi.h             |  10 ++++
 6 files changed, 151 insertions(+), 86 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
