Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C2AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 04:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D0B207DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 04:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="eIyH5Pxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgFFE0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 00:26:08 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:55641 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbgFFE0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 00:26:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591417567; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=YqewpJCTCgOSHaknK0YZKVZ9UVuX5fbD5L5BBxceloE=; b=eIyH5PxaAyiwp/Se6X/o/PDZoxT1BdYMEG3GmNn/AnRKqgmpxf2FvY6ycg2/gxLSw8XEvrc+
 M5fTgVD5xlEjnqgMmh2Lwl3FjSTHiLAS3N1aL65sOVd/ftqqZZwNRkl9buVDOIQVYTSZvcaw
 /rUKEnigkarKia6ma6trSBFKYKM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5edb1adf583b2d42d5f1728f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 06 Jun 2020 04:26:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E34FCC433C6; Sat,  6 Jun 2020 04:26:05 +0000 (UTC)
Received: from hyd-lnxbld559.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E76EC433C6;
        Sat,  6 Jun 2020 04:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E76EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=smasetty@codeaurora.org
From:   Sharat Masetty <smasetty@codeaurora.org>
To:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        mka@chromium.org, sibis@codeaurora.org, saravanak@google.com,
        viresh.kumar@linaro.org, robdclark@gmail.com,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: [PATCH v3 0/6] Add support for GPU DDR BW scaling
Date:   Sat,  6 Jun 2020 09:55:45 +0530
Message-Id: <1591417551-38051-1-git-send-email-smasetty@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a respin of [1]. Incorported review feedback and fixed issues observed
during testing. Picked up the Georgi's series from opp/linux-next [2], and this
series is also dependent on a helper function needed to set and clear ddr
bandwidth vote [3]. Patch number 4 in the series adds support for SDM845 as well
but its not tested yet(WIP), but the SC7180 patches are well tested now.

[1] https://patchwork.freedesktop.org/series/75291/
[2] https://kernel.googlesource.com/pub/scm/linux/kernel/git/vireshk/pm/+log/opp/linux-next/
[3] https://patchwork.kernel.org/patch/11590563/

Sharat Masetty (6):
  dt-bindings: drm/msm/gpu: Document gpu opp table
  drm: msm: a6xx: send opp instead of a frequency
  drm: msm: a6xx: use dev_pm_opp_set_bw to scale DDR
  arm64: dts: qcom: SDM845: Enable GPU DDR bw scaling
  arm64: dts: qcom: sc7180: Add interconnects property for GPU
  arm64: dts: qcom: sc7180: Add opp-peak-kBps to GPU opp

 .../devicetree/bindings/display/msm/gpu.txt        | 28 +++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  9 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  9 +++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 85 +++++++++++++---------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  8 --
 drivers/gpu/drm/msm/msm_gpu.c                      |  3 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |  5 +-
 8 files changed, 100 insertions(+), 49 deletions(-)

--
2.7.4

