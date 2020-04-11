Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD0FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DD92078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="T34QU3kp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgDKIDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 04:03:31 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:54469 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbgDKIDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 04:03:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586592211; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=shik54jnyOMg3ZRSwryG1Rwc0uqwahsFZRtNbkOAM4I=; b=T34QU3kpj/NuqsKE8Trv78h8tegtZZXVdkUnM7N/NSjPyq+kHUopBVBTopIpm8pR3+aMe1Lx
 DTE2kzX5wFao3Wjtv2DHKoldOhT168hNlV71lPVoeQVp0jajj9oijKVvELsCcHaw/x7sxWml
 sCiFO6ZZxF6sVKdQcZ81UVgcp0Q=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9179d2.7f4fdf2d8ca8-smtp-out-n03;
 Sat, 11 Apr 2020 08:03:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59ACBC43636; Sat, 11 Apr 2020 08:03:30 +0000 (UTC)
Received: from c-ajitp-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ajitp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4573C433BA;
        Sat, 11 Apr 2020 08:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4573C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ajitp@codeaurora.org
From:   Ajit Pandey <ajitp@codeaurora.org>
To:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: [PATCH 00/11] ASoC: QCOM: Add support for SC7180 lpass variant
Date:   Sat, 11 Apr 2020 13:32:40 +0530
Message-Id: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've common ASoC cpu driver for QCOM LPASS soc varaints. This patch
chain add support for new variant SC7180 soc by doing the required
modification in existing common lpass-cpu driver. Below is a brief
summary of patch series:

PATCH 01 ... 04: Update lpass-cpu driver files to make it more generic
PATCH 05 ... 08: Add changes to support SC7180 specific configuration
PATCH 09 ... 11: Add new drivers and documentation for SC7180 soc lpass

Ajit Pandey (11):
  Documentation: device-tree: sound: Update lpass-cpu driver binding
  ASoC: qcom: lpass: Add struct lpass_dai to store dai clocks pointer
  ASoC: qcom: Add common array to initialize soc based core clocks
  ASoC: qcom: lpass-cpu: Make "ahbix-clk" an optional clock.
  ASoC: qcom: lpass: Add support for newer lpass version
  dt-bindings: sound: Add bindings related to lpass-cpu configuration
  Documentation: dt-bindings: sound: Add details for new dai properties
  ASoC: qcom : lpass: Add support to configure dai's connection mode
  device-tree: bindings: sound: lpass-cpu: Add new compatible soc
  ASoC: qcom: lpass-sc7180: Add platform driver for lpass audio
  ASoC: qcom: lpass-platform: Replace card->dev with component->dev

 .../devicetree/bindings/sound/qcom,lpass-cpu.txt   | 158 -------------
 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 159 +++++++++++++
 include/dt-bindings/sound/qcom,lpass.h             |  31 +++
 sound/soc/qcom/Kconfig                             |   5 +
 sound/soc/qcom/Makefile                            |   2 +
 sound/soc/qcom/lpass-apq8016.c                     |  39 ++-
 sound/soc/qcom/lpass-cpu.c                         | 263 ++++++++++++++-------
 sound/soc/qcom/lpass-lpaif-reg.h                   | 182 +++++++++++++-
 sound/soc/qcom/lpass-platform.c                    |  36 +--
 sound/soc/qcom/lpass-sc7180.c                      | 192 +++++++++++++++
 sound/soc/qcom/lpass.h                             |  40 +++-
 11 files changed, 808 insertions(+), 299 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
 create mode 100644 include/dt-bindings/sound/qcom,lpass.h
 create mode 100644 sound/soc/qcom/lpass-sc7180.c

-- 
1.9.1
