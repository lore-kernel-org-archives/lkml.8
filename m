Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B73EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 582D020720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ZQK/LuNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgGHFIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 01:08:32 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:28056 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725298AbgGHFIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 01:08:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594184911; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=J/0rtb7ms4jKYAU3mSlVXiZ7/65ZzPwUSJ72i0ViAwU=; b=ZQK/LuNyqGU77DjrT7w1TyBNO1+7+lyh4SOe0XckxAGUJO/rHnt9lTUbGNUIiv2NHhBgmeWZ
 dJXBky0FoPFwSzM7dav7eiHKjCIFhFwJC/gUA2H8BPR8dMs4y3Eg2+bhJLG4/Lvitn5Xavv3
 kmIc1VemBlzyFn0pVaZH7uNcTy0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5f0554ce0082b278486d6af8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 08 Jul 2020 05:08:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 678F6C43391; Wed,  8 Jul 2020 05:08:30 +0000 (UTC)
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2672C433C6;
        Wed,  8 Jul 2020 05:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2672C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v3 0/8] ASoC: qcom: Add support for SC7180 lpass variant
Date:   Wed,  8 Jul 2020 10:38:08 +0530
Message-Id: <1594184896-10629-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch chain add audio support for SC7180 soc by doing the required
modification in existing common lpass-cpu/lpass-platform driver.
Below is a brief summary of patch series:

PATCH v3 0001 ... 0005: Update lpass-cpu, lpass-platform drivers to make it more generic
and support newer soc registers configuration. This also updates existing lpass-apq8096.c
and lpass-ipq806x.c.
PATCH v2 0005 ... 0007: Add documentation and platform driver for newer SC7180 SOC variant.

Changes since v2:
	- Moved yaml conversion of Documentation to the end of patch series
	- Used REG_FIELD_ID instead of REG_FIELD for DMACTL and I2SCTL registers.
Move reg_fields to struct lpass_variant as suggested by Srinivas.

Ajit Pandey (5):
  ASoC: qcom: Add common array to initialize soc based core clocks
  include: dt-bindings: sound: Add sc7180-lpass bindings header
  ASoC: qcom: lpass-platform: Replace card->dev with component->dev
  ASoC: qcom: lpass-sc7180: Add platform driver for lpass audio
  dt-bindings: sound: lpass-cpu: Move to yaml format

Rohit kumar (3):
  ASoC: qcom: lpass-cpu: Move ahbix clk to platform specific function
  ASoC: qcom: lpass: Use regmap_field for i2sctl and dmactl registers
  dt-bindings: sound: lpass-cpu: Add sc7180 lpass cpu node

 .../devicetree/bindings/sound/qcom,lpass-cpu.txt   |  79 --------
 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 154 +++++++++++++++
 include/dt-bindings/sound/sc7180-lpass.h           |  10 +
 sound/soc/qcom/Kconfig                             |   5 +
 sound/soc/qcom/Makefile                            |   2 +
 sound/soc/qcom/lpass-apq8016.c                     |  86 ++++++--
 sound/soc/qcom/lpass-cpu.c                         | 193 +++++++++---------
 sound/soc/qcom/lpass-ipq806x.c                     |  67 +++++++
 sound/soc/qcom/lpass-lpaif-reg.h                   | 157 ++++++++-------
 sound/soc/qcom/lpass-platform.c                    | 156 +++++++++++----
 sound/soc/qcom/lpass-sc7180.c                      | 216 +++++++++++++++++++++
 sound/soc/qcom/lpass.h                             |  63 +++++-
 12 files changed, 886 insertions(+), 302 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
 create mode 100644 include/dt-bindings/sound/sc7180-lpass.h
 create mode 100644 sound/soc/qcom/lpass-sc7180.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

