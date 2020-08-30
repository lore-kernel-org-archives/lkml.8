Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD8BC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D66020707
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MEcV4v7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgH3OkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:40:01 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:53251 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726880AbgH3OjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 10:39:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598798362; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=mFIGYUIuVh/l0SGKENzwzwQMyfePN8+YBegyW6nrCD0=; b=MEcV4v7IQGdGAk3rR+omZO4k3fCvbI+3CFoFZGO9PzoRaZ+ng+xC4UlwwO25hZ7+lNcjttA6
 P9AW0/oZoFoOPwNl2Np6EK916hY/0IWHf9cv1fZAPdZywn+l8qm18MlXvt0uVjZtg+St4xoe
 2gn0QyoOyEr/xARK5R5SPtnkVCc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f4bb9eba816b7fb4893d617 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 30 Aug 2020 14:38:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F0FA4C43387; Sun, 30 Aug 2020 14:38:34 +0000 (UTC)
Received: from deesin-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: deesin)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 54078C433C6;
        Sun, 30 Aug 2020 14:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54078C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=deesin@codeaurora.org
From:   Deepak Kumar Singh <deesin@codeaurora.org>
To:     bjorn.andersson@linaro.org, clew@codeaurora.org
Cc:     mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Deepak Kumar Singh <deesin@codeaurora.org>
Subject: [PATCH V1 0/4] General qrtr fixes
Date:   Sun, 30 Aug 2020 20:08:08 +0530
Message-Id: <1598798292-5971-1-git-send-email-deesin@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arun Kumar Neelakantam (1):
  net: qrtr: Check function pointer before calling

Chris Lew (3):
  net: qrtr: Do not send packets before hello negotiation
  net: qrtr: Add socket mode optimization
  net: qrtr: Change port allocation to use cyclic idr

 net/qrtr/qrtr.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 77 insertions(+), 16 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

