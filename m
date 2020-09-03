Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA8CC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724C3208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="cZBVR/BI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgICTWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:22:13 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24370 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728852AbgICTWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:22:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599160931; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=R0hh22KkhlltUAF3srHYTsHrJ/HEJF9yq02KfP6Tpb8=; b=cZBVR/BIHk/CVwag2V9DjqnXSdPKb/6y8YQvaAxIZki6+s71t9htxokvBUlNUxLOKrKeDzou
 pJ+mKIsZKkAGyKL3lc/bDhrAYUWGlUsIJNUSGHuWjoBNq2saqXDU8azGS5sfL49Uc2AtoXz4
 KHEgnorbamL25IZ0/oxwuw5O/2A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f514263380a624e4dec679a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Sep 2020 19:22:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6F8A8C43387; Thu,  3 Sep 2020 19:22:10 +0000 (UTC)
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BE8AC433C9;
        Thu,  3 Sep 2020 19:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BE8AC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v4 0/6] interconnect: qcom: Misc bcm-voter changes and fixes
Date:   Thu,  3 Sep 2020 12:21:43 -0700
Message-Id: <20200903192149.30385-1-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes are mostly unrelated, but there are some dependencies
between them.

v4:
- Reorder series such that the fix comes first
- Collect reviewed/acked-by from v3

v3:
- Improve qcom,tcs-wait property description
- Stop using #define in property `default` doc

v2:
- New patch for generic qcom,icc.h bindings
- New patch for documenting qcom,tcs-wait property
- Update bcm_div() 'base' parameter from u64 to u32

Mike Tipton (6):
  interconnect: qcom: Fix small BW votes being truncated to zero
  dt-bindings: interconnect: Add generic qcom bindings
  dt-bindings: interconnect: Add property to set BCM TCS wait behavior
  interconnect: qcom: Support bcm-voter-specific TCS wait behavior
  interconnect: qcom: Only wait for completion in AMC/WAKE by default
  interconnect: qcom: Add support for per-BCM scaling factors

 .../bindings/interconnect/qcom,bcm-voter.yaml | 20 ++++++
 drivers/interconnect/qcom/bcm-voter.c         | 63 ++++++++++++-------
 drivers/interconnect/qcom/icc-rpmh.c          |  3 +
 drivers/interconnect/qcom/icc-rpmh.h          | 20 ++----
 include/dt-bindings/interconnect/qcom,icc.h   | 26 ++++++++
 5 files changed, 95 insertions(+), 37 deletions(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,icc.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

