Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59266C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C48420656
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WAcmLlEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgCFTVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:21:24 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:18411 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbgCFTVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:21:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583522483; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=piXTaqCWbh+pl4OG3SQEESYx+jI27po7fx9Q0GyAWjw=; b=WAcmLlEsEI9oS53vs2OyZb/2uH9LGIunCY8g2eZF9gTpaMgFQ2Uk6AYjLXOBC0DpagyxLvdZ
 A9gbJP+6SlrruuUGh+SfVeZYe96ESrlFxWND39U1Tnld2TM/nObSE8HisI1bri3aGkuuz8d6
 zr8d1iMJK+PsRjj/nuY3rwKIevQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e62a2b0.7fb60665d570-smtp-out-n01;
 Fri, 06 Mar 2020 19:21:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 39CE9C433BA; Fri,  6 Mar 2020 19:21:20 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 86130C433D2;
        Fri,  6 Mar 2020 19:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86130C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org
Cc:     tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH 0/2] Introduce PAS based Secure Subsystem rproc driver
Date:   Fri,  6 Mar 2020 11:21:05 -0800
Message-Id: <1583522467-3499-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm SOCs have a secure remote processor that provides secure
execution environment for processing sensitive data and also performs
cryptographic operations using protected keys stored in its secure
storage. This patch series introduces a Peripheral Authentication
based remoteproc driver that handles booting, shutdown and crash
scenarios for SPSS. Also this driver can handle late attach usecase
where remote  processor is already booted even before linux. This
patchset builds up on the skip firmware load patch
"remoteproc: add support to skip firmware load when recovery" which is
in review.

Rishabh Bhatnagar (2):
  remoteproc: qcom: Add PAS based SPSS PIL driver
  dt-bindings: remoteproc: Add documentation for SPSS remoteproc

 .../devicetree/bindings/remoteproc/qcom,spss.txt   | 114 +++++
 drivers/remoteproc/Kconfig                         |  17 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/qcom_spss.c                     | 500 +++++++++++++++++++++
 4 files changed, 632 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,spss.txt
 create mode 100644 drivers/remoteproc/qcom_spss.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
