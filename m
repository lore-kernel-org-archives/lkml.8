Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217D2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECDB220708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="O4Z2CsgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgHNKxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:53:53 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56463 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgHNKxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:53:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597402430; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=rlS6jtvmdtc8gXzY+6308pLXZafr54hh4AT7H4tFc6g=; b=O4Z2CsgBst+o/NMowb4TlRVOnixHHCMw/bcCYL4WGLLbuKu14Ws8p96uLAltggxwFWfI3s/s
 VxGNH/wIqRr/MjQxqBYCDs0JlE5fC2JZfJLtVe594SDC6DXfUuSdmFVyMrmMLblfxvoF67Hb
 Kz8oIAzaYx8x5rnf3r7wUmsybo8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5f366d2ed48d4625ca4fdb2d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 10:53:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 31F11C43391; Fri, 14 Aug 2020 10:53:34 +0000 (UTC)
Received: from rohkumar-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8FE86C433C6;
        Fri, 14 Aug 2020 10:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8FE86C433C6
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
Subject: [PATCH v6 00/12]  ASoC: qcom: Add support for SC7180 lpass variant
Date:   Fri, 14 Aug 2020 16:22:56 +0530
Message-Id: <1597402388-14112-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch chain add audio support for SC7180 soc by doing the required
modification in existing common lpass-cpu/lpass-platform driver.
This also fixes some concurrency issue.

This patch series is already tested by Srinivas on Dragon Board 410c.
Changes since v5:
        - Fixed remove api in lpass-sc7180.c
        - Addressed comments by Rob in yaml Documentation.

Ajit Pandey (4):
  ASoC: qcom: Add common array to initialize soc based core clocks
  ASoC: qcom: lpass-platform: Replace card->dev with component->dev
  include: dt-bindings: sound: Add sc7180-lpass bindings header
  ASoC: qcom: lpass-sc7180: Add platform driver for lpass audio

Rohit kumar (8):
  ASoC: qcom: lpass-cpu: Move ahbix clk to platform specific function
  ASoC: qcom: lpass-platform: fix memory leak
  ASoC: qcom: lpass: Use regmap_field for i2sctl and dmactl registers
  ASoC: qcom: lpass-cpu: fix concurrency issue
  dt-bindings: sound: lpass-cpu: Add sc7180 lpass cpu node
  ASoC: qcom: lpass-cpu: Use platform_get_resource
  ASoC: qcom: lpass-platform: Use platform_get_irq
  dt-bindings: sound: lpass-cpu: Move to yaml format

 .../devicetree/bindings/sound/qcom,lpass-cpu.txt   |  79 --------
 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 189 ++++++++++++++++++
 include/dt-bindings/sound/sc7180-lpass.h           |  10 +
 sound/soc/qcom/Kconfig                             |   5 +
 sound/soc/qcom/Makefile                            |   2 +
 sound/soc/qcom/lpass-apq8016.c                     |  86 ++++++--
 sound/soc/qcom/lpass-cpu.c                         | 204 ++++++++++---------
 sound/soc/qcom/lpass-ipq806x.c                     |  67 +++++++
 sound/soc/qcom/lpass-lpaif-reg.h                   | 157 ++++++++-------
 sound/soc/qcom/lpass-platform.c                    | 155 +++++++++++----
 sound/soc/qcom/lpass-sc7180.c                      | 216 +++++++++++++++++++++
 sound/soc/qcom/lpass.h                             |  63 +++++-
 12 files changed, 934 insertions(+), 299 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
 create mode 100644 include/dt-bindings/sound/sc7180-lpass.h
 create mode 100644 sound/soc/qcom/lpass-sc7180.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

