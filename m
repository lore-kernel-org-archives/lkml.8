Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049D6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE26A20575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="rlhZccKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgENKyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:54:40 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:13093 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726225AbgENKyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:54:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589453678; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=oTpGsbWxjfhqhfXuRLS+yKsDMjs9vA6BSUaT4f/U54Y=; b=rlhZccKp2T0HUfbbs9XJ+cur1QeQ0iUNrhOVOVHlszb/fKgIRyu3JtC2ipU5a05OTLNWzPp6
 6OCVfM+rHGL/0f7jV/J5eW4h+MUMBGlYOsPej+S8VaP5rJejkF3YRBmhVEe/vJzgZYPucTbW
 RcpNXwh2dp9/IoFAHRmigORD0pM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebd2366.7f5fe96c5b58-smtp-out-n02;
 Thu, 14 May 2020 10:54:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5966EC44791; Thu, 14 May 2020 10:54:30 +0000 (UTC)
Received: from hyd-lnxbld559.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AD68EC433D2;
        Thu, 14 May 2020 10:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD68EC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=smasetty@codeaurora.org
From:   Sharat Masetty <smasetty@codeaurora.org>
To:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        georgi.djakov@linaro.org, mka@chromium.org,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: [PATCH 0/6] Add support for GPU DDR BW scaling
Date:   Thu, 14 May 2020 16:24:13 +0530
Message-Id: <1589453659-27581-1-git-send-email-smasetty@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rework of my previous series [1], but this time based on the bindings
from Georgi [2] + a few fixes which look to be fixed in v8 of Georgi's series
[3]. The work is based on the chromeOS tip.

[1]: https://patchwork.freedesktop.org/series/75291/
[2]: https://lore.kernel.org/patchwork/cover/1230626/
[3]: https://lore.kernel.org/patchwork/cover/1240687/

Sharat Masetty (5):
  arm64: dts: qcom: sc7180: Add interconnect bindings for GPU
  arm64: dts: qcom: sc7180: Add opp-peak-kBps to GPU opp
  drm: msm: a6xx: send opp instead of a frequency
  drm: msm: a6xx: use dev_pm_opp_set_bw to set DDR bandwidth
  dt-bindings: drm/msm/gpu: Document gpu opp table

Sibi Sankar (1):
  OPP: Add and export helper to set bandwidth

 .../devicetree/bindings/display/msm/gpu.txt        | 28 +++++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  9 +++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 68 +++++++++++-----------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |  2 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |  3 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |  3 +-
 drivers/opp/core.c                                 | 43 ++++++++++++++
 include/linux/pm_opp.h                             |  6 ++
 8 files changed, 125 insertions(+), 37 deletions(-)

--
2.7.4
