Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D43C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E226B2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="tkM8Q4py"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgGQN3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:29:53 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30134 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgGQN3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:29:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594992591; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=syxYnsEts5Do5jGdb1EtbueYGDiFVWIM3nifipnzhbI=; b=tkM8Q4pyoUG8bzOkAt1kACe3+epjdurhb7dhF8u45PQ0h5WbjqrEOraKsnrdEMmfkrKmEVVx
 zGnpuhspVtyoeer3VtHLv8jhVTjtjjqPSe4Uc/h1YAji/7bGnY89tfNl6aj+PwaGdUv/Q9Gx
 NmC0+YwHCL898OMYalLCTxA+Vyc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
 5f11a7cf75eeb235f6848dd5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 17 Jul 2020 13:29:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7F95AC433C9; Fri, 17 Jul 2020 13:29:50 +0000 (UTC)
Received: from akhilpo-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D27A9C433C9;
        Fri, 17 Jul 2020 13:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D27A9C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akhilpo@codeaurora.org
From:   Akhil P Oommen <akhilpo@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        smasetty@codeaurora.org, devicetree@vger.kernel.org,
        mka@chromium.org, saravanak@google.com, sibis@codeaurora.org,
        viresh.kumar@linaro.org, jonathan@marek.ca, robdclark@gmail.com,
        bjorn.andersson@linaro.org
Subject: [PATCH v6 0/6] Add support for GPU DDR BW scaling
Date:   Fri, 17 Jul 2020 18:59:33 +0530
Message-Id: <1594992579-20662-1-git-send-email-akhilpo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add support for GPU DDR bandwidth scaling and is based on the
bindings from Georgi [1]. This is mostly a rebase of Sharat's patches [2] on the
tip of msm-next branch.

[1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/vireshk/pm/+log/opp/linux-next/
[2] https://patchwork.freedesktop.org/series/75291/

Changes from v5:
- Added "interconnect-names" property

Changes from v4:
- Squashed a patch to another one to fix Jonathan's comment
- Add back the pm_runtime_get_if_in_use() check

Changes from v3:
- Rebased on top of Jonathan's patch which adds support for changing gpu freq
through hfi on newer targets
- As suggested by Rob, left the icc_path intact for pre-a6xx GPUs

Sharat Masetty (6):
  dt-bindings: drm/msm/gpu: Document gpu opp table
  drm: msm: a6xx: send opp instead of a frequency
  drm: msm: a6xx: use dev_pm_opp_set_bw to scale DDR
  arm64: dts: qcom: SDM845: Enable GPU DDR bw scaling
  arm64: dts: qcom: sc7180: Add interconnects property for GPU
  arm64: dts: qcom: sc7180: Add opp-peak-kBps to GPU opp

 .../devicetree/bindings/display/msm/gpu.txt        |  28 ++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  10 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  10 ++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 108 ++++++++++++---------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   2 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   3 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |   3 +-
 7 files changed, 114 insertions(+), 50 deletions(-)

-- 
2.7.4

