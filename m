Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3076C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 911D62083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="sKwIE9FQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgG3FSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 01:18:41 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40258 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbgG3FSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 01:18:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596086320; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=G2U6/qWMx8AMsDo7OVgFfyjUJ0GgJGFSUQQJgkIOkkE=; b=sKwIE9FQSt2OKFLztBpi1BeeqDADWAokKbX6vO7/xG+PKwlZ69SqW5avjiSCxsfretmsj5Cy
 SJ5hiDUkM3X/d6MFODgp7rKJ0UsiRFlsVBGtS6HHJJXnOThKrD9R98ukq87OA2wN+OA1obm9
 1jgNrgmvejfgoGqL9povIvqT2hI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5f22582fca55a5604cb65804 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 30 Jul 2020 05:18:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 08721C433C9; Thu, 30 Jul 2020 05:18:39 +0000 (UTC)
Received: from deesin-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: deesin)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64B4EC433C6;
        Thu, 30 Jul 2020 05:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64B4EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=deesin@codeaurora.org
From:   Deepak Kumar Singh <deesin@codeaurora.org>
To:     bjorn.andersson@linaro.org, clew@codeaurora.org
Cc:     mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Deepak Kumar Singh <deesin@codeaurora.org>
Subject: [PATCH V1 0/6] Glink native fixes upstreaming
Date:   Thu, 30 Jul 2020 10:48:10 +0530
Message-Id: <1596086296-28529-1-git-send-email-deesin@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Includes fixes for -
Few race conditions while channel release and close
Proper unregistration of rpmsg device to avoid use of stale device
Send notify command to remote when glink fifo is full
Handling packet size larger that 16K

Arun Kumar Neelakantam (3):
  rpmsg: glink: Add TX_DATA_CONT command while sending
  rpmsg: glink: Remove the rpmsg dev in close_ack
  rpmsg: glink: Send READ_NOTIFY command in FIFO full case

Chris Lew (2):
  rpmsg: glink: Deny intent request if reusable intent fits
  rpmsg: glink: Remove channel decouple from rpdev release

Konstantin Dorfman (1):
  rpmsg: glink: fix destroy channel endpoint logic

 drivers/rpmsg/qcom_glink_native.c | 109 +++++++++++++++++++++++++++++++++++---
 1 file changed, 101 insertions(+), 8 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

