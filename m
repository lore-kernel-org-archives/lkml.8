Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F76C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 05:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC9DC206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 05:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="eVFlswC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgEMFL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 01:11:27 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57244 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728097AbgEMFL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 01:11:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589346686; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4QVobzHksEPjTGiJZuOIwWfsqXQMmg4PvTnXvb5US4E=; b=eVFlswC7uFDkAEXt1VWTrSEZHHynuydSCnbb4hPLBi113O6nEfUumi8zJ6Y2/7JeUtBnndh6
 2zkZUSk2Sba/0hQQcUoOl6tr+M8voyB0bWDv3AFpDh8w3kg3CeQdAUbzr1JgMhei/uC3kehb
 f8USxYe/WloachhmX0jQgfU+dyY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebb817e.7f47cba67458-smtp-out-n01;
 Wed, 13 May 2020 05:11:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3DA57C432C2; Wed, 13 May 2020 05:11:25 +0000 (UTC)
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 704D2C433CB;
        Wed, 13 May 2020 05:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 704D2C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [RESEND PATCH V4 0/4] Add TIOCM Signals support for RPMSG char devices
Date:   Wed, 13 May 2020 10:41:07 +0530
Message-Id: <1589346671-15226-1-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Glink transport support signals to exchange state notification between
local and remote side clients. Adding support to send/receive the signal
command and notify the clients through callback and POLL notification.

Changes since v3:
- Correct the TICOMGET case handling as per new rpmsg_get_signals prototype
- Update the rpmsg_get_signals function header

Changes since v2:
- Modify the rpmsg_get_signals function prototype

Changes since v1:
- Split the patches as per functional areas like core, char, glink
- Add set, clear mask for TIOCMSET
- Merge the char signal callback and POLLPRI patches

Arun Kumar Neelakantam (4):
  rpmsg: core: Add signal API support
  rpmsg: glink: Add support to handle signals command
  rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
  rpmsg: char: Add signal callback and POLLPRI support

 drivers/rpmsg/qcom_glink_native.c | 126 ++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_char.c        |  75 ++++++++++++++++++++++-
 drivers/rpmsg/rpmsg_core.c        |  41 +++++++++++++
 drivers/rpmsg/rpmsg_internal.h    |   5 ++
 include/linux/rpmsg.h             |  26 ++++++++
 5 files changed, 270 insertions(+), 3 deletions(-)

-- 
2.7.4
