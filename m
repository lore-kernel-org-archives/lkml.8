Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFDEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1FB2065C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="n6ErJQee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgENT6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:58:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47370 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728000AbgENT6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:58:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589486325; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=uinFiHZJfF96ynk2XThtzqi73Peb6XENqUK6oR8JKRI=; b=n6ErJQeeMUUzbxYdTT5czToZEg+iEHatPamPE+IYVhQy8SjVZeQECraBJA+AYAkzB7xUN0+B
 HwteHe2DqhoM/EpU4gUMNPbAt80XCh2greV328lpHNkfvQ8awvYgTdztFEAHFBnUiPzkbdum
 bNQ0h57M9ex19xeosXGzEcsbi/0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ebda2e3aefa5a01ccccf27b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 May 2020 19:58:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D496C44788; Thu, 14 May 2020 19:58:26 +0000 (UTC)
Received: from blr-ubuntu-311.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38F05C433D2;
        Thu, 14 May 2020 19:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38F05C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        coresight@lists.linaro.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv2 0/2] coresight: etm4x: Add support to skip trace unit power up
Date:   Fri, 15 May 2020 01:27:54 +0530
Message-Id: <cover.1589485594.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support to skip powering up of trace unit on systems
with an errata which stops CPU watchdog counter when power up bit is
set (TRCPDCR.PU = 1). Setting this bit is not required on Qualcomm
Technologies Inc. chipsets where this errata exists since the ETMs
are in the same power domain as their respective CPU cores.

Tingwei Zhang (2):
  coresight: etm4x: Add support to skip trace unit power up
  dt-bindings: arm: coresight: Add support to skip trace unit power up

 .../devicetree/bindings/arm/coresight.txt     |  7 +++++
 drivers/hwtracing/coresight/coresight-etm4x.c | 27 ++++++++++++-------
 drivers/hwtracing/coresight/coresight-etm4x.h |  3 +++
 3 files changed, 27 insertions(+), 10 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

