Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9A8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED1820768
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BQ3lICMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgHJW1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:27:19 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:33822 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726789AbgHJW1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:27:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597098437; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=FIQjkRwzuaqtcrLpjzp5zoMBHsNGZCnkU4UlVvBNRWY=; b=BQ3lICMlfRfODeFQaZ9FvqnAeTNJbTdXBX+04sn4m02KqMtsdxg/zbY3FmGRtwe3lxjnRJBU
 6DGEQNBocikQWmPf7JENsWAuU4H0Cmt+zF6d4IdM8InWxCZ3gZTeqdGavFEiYV0JTcBUdA5a
 Z28O+nkcb68xKXsb6vIqlA+R644=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5f31c9bc2f4952907d4d38e6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 Aug 2020 22:27:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 90FA9C433B2; Mon, 10 Aug 2020 22:27:08 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CBE2DC433C6;
        Mon, 10 Aug 2020 22:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CBE2DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        iommu@lists.linux-foundation.org, freedreno@lists.freedesktop.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Brian Masney <masneyb@onstation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hanna Hawa <hannah@marvell.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 00/13] iommu/arm-smmu: Add Adreno SMMU specific implementation
Date:   Mon, 10 Aug 2020 16:26:44 -0600
Message-Id: <20200810222657.1841322-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds an Adreno SMMU implementation to arm-smmu to allow GPU hardware
pagetable switching.

The Adreno GPU has built in capabilities to switch the TTBR0 pagetable during
runtime to allow each individual instance or application to have its own
pagetable.  In order to take advantage of the HW capabilities there are certain
requirements needed of the SMMU hardware.

This series adds support for an Adreno specific arm-smmu implementation. The new
implementation 1) ensures that the GPU domain is always assigned context bank 0,
2) enables split pagetable support (TTBR1) so that the instance specific
pagetable can be swapped while the global memory remains in place and 3) shares
the current pagetable configuration with the GPU driver to allow it to create
its own io-pgtable instances.

The series then adds the drm/msm code to enable these features. For targets that
support it allocate new pagetables using the io-pgtable configuration shared by
the arm-smmu driver and swap them in during runtime.

This version of the series merges the previous patchset(s) [1] and [2]
with the following improvements:

v12:
  - Nitpick cleanups in gpu/drm/msm/msm_iommu.c (Rob Clark)
  - Reorg in gpu/drm/msm/msm_gpu.c (Rob Clark)
  - Use the default asid for the context bank so that iommu_tlb_flush_all works
  - Flush the UCHE after a page switch
  - Add the SCTLR.HUPCF patch at the end of the series
v11:
  - Add implementation specific get_attr/set_attr functions (per Rob Clark)
  - Fix context bank allocation (per Bjorn Andersson)
v10:
  - arm-smmu: add implementation hook to allocate context banks
  - arm-smmu: Match the GPU domain by stream ID instead of compatible string
  - arm-smmu: Make DOMAIN_ATTR_PGTABLE_CFG bi-directional. The leaf driver
    queries the configuration to create a pagetable and then sends the newly
    created configuration back to the smmu-driver to enable TTBR0
  - drm/msm: Add context reference counting for submissions
  - drm/msm: Use dummy functions to skip TLB operations on per-instance
    pagetables

[1] https://lists.linuxfoundation.org/pipermail/iommu/2020-June/045653.html
[2] https://lists.linuxfoundation.org/pipermail/iommu/2020-June/045659.html


Jordan Crouse (13):
  iommu/arm-smmu: Pass io-pgtable config to implementation specific
    function
  iommu/arm-smmu: Add support for split pagetables
  iommu/arm-smmu: Prepare for the adreno-smmu implementation
  iommu: Add a domain attribute to get/set a pagetable configuration
  iommu/arm-smmu-qcom: Add implementation for the adreno GPU SMMU
  dt-bindings: arm-smmu: Add compatible string for Adreno GPU SMMU
  drm/msm: Add a context pointer to the submitqueue
  drm/msm: Set the global virtual address range from the IOMMU domain
  drm/msm: Add support to create a local pagetable
  drm/msm: Add support for private address space instances
  drm/msm/a6xx: Add support for per-instance pagetables
  arm: dts: qcom: sm845: Set the compatible string for the GPU SMMU
  iommu/arm-smmu: Add a init_context_bank implementation hook

 .../devicetree/bindings/iommu/arm,smmu.yaml   |   4 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   2 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |  12 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  75 ++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |   1 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  18 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h       |   3 +-
 drivers/gpu/drm/msm/msm_drv.c                 |  16 +-
 drivers/gpu/drm/msm/msm_drv.h                 |  13 ++
 drivers/gpu/drm/msm/msm_gem.h                 |   1 +
 drivers/gpu/drm/msm/msm_gem_submit.c          |   8 +-
 drivers/gpu/drm/msm/msm_gem_vma.c             |   9 +
 drivers/gpu/drm/msm/msm_gpu.c                 |  31 ++-
 drivers/gpu/drm/msm/msm_gpu.h                 |  12 +-
 drivers/gpu/drm/msm/msm_gpummu.c              |   2 +-
 drivers/gpu/drm/msm/msm_iommu.c               | 197 +++++++++++++++++-
 drivers/gpu/drm/msm/msm_mmu.h                 |  16 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h          |   1 +
 drivers/gpu/drm/msm/msm_submitqueue.c         |   8 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c    |   6 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    | 172 ++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c         | 134 ++++++------
 drivers/iommu/arm/arm-smmu/arm-smmu.h         |  87 +++++++-
 include/linux/iommu.h                         |   1 +
 24 files changed, 708 insertions(+), 121 deletions(-)

-- 
2.25.1

