Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9078BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC9E2068D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="H1b1WGLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgEVWD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:03:29 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57038 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731051AbgEVWD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:03:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590185007; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=sPrW0uvNk4DDK2vxmKxD2uDng1FDnCD3zI4QzTTTBjc=; b=H1b1WGLO4lSlAQsKiD3olMsdYHMDk0QvJpQBJDcmPcqACnTlTIQsEQpoAS7D4SyqhBF0z8BD
 QLdFgu9Koa0hix87JfOOlClnRfr4to6fNlilqYCZYViMO80ZpheBbBAROA3bWYTeL4WSPgIF
 A/7gSuLkudaQT/7tPV4G9erBhdw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ec84c2f40528fe39446ddac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 22:03:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0640FC43449; Fri, 22 May 2020 22:03:24 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4CC9C433C6;
        Fri, 22 May 2020 22:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4CC9C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Akhil P Oommen <akhilpo@codeaurora.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Drew Davenport <ddavenport@chromium.org>,
        Enrico Weigelt <info@metux.net>, Eric Anholt <eric@anholt.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Shawn Guo <shawn.guo@linaro.org>, Takashi Iwai <tiwai@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, tongtiangen <tongtiangen@huawei.com>,
        zhengbin <zhengbin13@huawei.com>
Subject: [PATCH v1 0/3] drm/msm: Cleanups ahead of per-instance pagetables
Date:   Fri, 22 May 2020 16:03:13 -0600
Message-Id: <20200522220316.23772-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are three cleanup and reorganization patches that were originally
part of one of my many per-instance pagetable stacks [1] [2] but make life
better in general and can stand on their own. Send them now to get them
out of my other stack and make that processs ever so easier.

[1] https://patchwork.kernel.org/patch/11355255/
[2] https://patchwork.kernel.org/patch/11355259/

Jordan Crouse (3):
  drm/msm: Attach the IOMMU device during initialization
  drm/msm: Refactor address space initialization
  drm/msm: Update the MMU helper function APIs

 drivers/gpu/drm/msm/adreno/a2xx_gpu.c    | 16 ++++++++
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c    |  1 +
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c    |  1 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c    |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c    |  1 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c  | 23 ++++++++---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h  |  8 ++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  | 18 +++------
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 18 ++++-----
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c |  4 --
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 18 ++++-----
 drivers/gpu/drm/msm/msm_drv.h            |  8 +---
 drivers/gpu/drm/msm/msm_gem_vma.c        | 36 +++--------------
 drivers/gpu/drm/msm/msm_gpu.c            | 49 +-----------------------
 drivers/gpu/drm/msm/msm_gpu.h            |  4 +-
 drivers/gpu/drm/msm/msm_gpummu.c         | 10 +----
 drivers/gpu/drm/msm/msm_iommu.c          | 15 ++++++--
 drivers/gpu/drm/msm/msm_mmu.h            |  5 +--
 18 files changed, 95 insertions(+), 141 deletions(-)

-- 
2.17.1

