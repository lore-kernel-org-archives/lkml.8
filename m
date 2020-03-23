Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E1DC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38EF20714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="D01hmmTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgCWRrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:47:37 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:21993 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727092AbgCWRrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:47:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584985656; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=GVr0mGgleEg3b4mi+cOMH7/IJ1CsPyhRMPq4wPCQlN4=; b=D01hmmTsDdEpSk3HVCjtcv4mWHA1Rva6ClmdhzdWJ3v2Oq49auZ3ExjJJUirV0xlO/0VgNb3
 MD3eCVvqCv+tQBrqonDXC1rAUj0ICYUCHxh8xjGDmbwdbtfqC45O8KOOuJ5Xy/kmyMNjhiHZ
 4GjorVoGagW6KzWM1E/n2VDGeNY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e78f636.7f736a5316f8-smtp-out-n01;
 Mon, 23 Mar 2020 17:47:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC92DC44791; Mon, 23 Mar 2020 17:47:33 +0000 (UTC)
Received: from kgunda-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C922C433CB;
        Mon, 23 Mar 2020 17:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C922C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kgunda@codeaurora.org
From:   Kiran Gunda <kgunda@codeaurora.org>
To:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V4 0/4] Add support for WLED5
Date:   Mon, 23 Mar 2020 23:16:54 +0530
Message-Id: <1584985618-25689-1-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, WLED driver supports only WLED4 peripherals that is present
on pmi8998 and pm660L. This patch series  converts the existing WLED4
bindings from .txt to .yaml format and adds the support for WLED5 peripheral
that is present on PM8150L.

PM8150L WLED supports the following.
    - Two modulators and each sink can use any of the modulator
    - Multiple CABC selection options
    - Multiple brightness width selection (12 bits to 15 bits)

Changes from V1:
	- Rebased on top of the below commit.
	  backlight: qcom-wled: Fix unsigned comparison to zero

Changes from V2:
	- Addressed Bjorn's comments by splitting the WLED4 changes
	  in a seperate patch.
	- Added WLED5 auto calibration support

Changes from V3:
        - Addressed comments from Daniel Thompson and Rob Herring
        - Seperated the WLED5 bindings from the driver changes
        - Squashed wled5 auto string detection and wled5 basic changes
          to avoid the NULL callback function pointer issue.

Kiran Gunda (3):
  backlight: qcom-wled: convert the wled bindings to .yaml format
  backlight: qcom-wled: Add callback functions
  backlight: qcom-wled: Add WLED5 bindings

Subbaraman Narayanamurthy (1):
  backlight: qcom-wled: Add support for WLED5 peripheral in PM8150L

 .../bindings/leds/backlight/qcom-wled.txt          | 154 ------
 .../bindings/leds/backlight/qcom-wled.yaml         | 223 ++++++++
 drivers/video/backlight/qcom-wled.c                | 613 ++++++++++++++++++---
 3 files changed, 764 insertions(+), 226 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project
