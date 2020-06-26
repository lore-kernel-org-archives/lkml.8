Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC03FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F615207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wUMG3K2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgFZUFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:05:07 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22653 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgFZUEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:04:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593201889; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Y52DfZmPsADiviryLIjbB10Q7p9PKIz9PJgeiGWZpfo=; b=wUMG3K2IT5uMh1JelpYcCj+VNbQVuMs18C/vYOIRoHCnJnW4VuhjUsAecMt+rCZQcyOH0C5F
 ke6VuC9HRIn+4QMQdeFfi48oVY4xdrC1hKsi8CnGcnJaYvgdfyQ7Ivv4aSqvwtuStHuLurlt
 40CKYNln0FuJ0K9WFTNA3LzdhYE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5ef654c7c4bb4f886d84d6af (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 20:04:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 563DEC4344B; Fri, 26 Jun 2020 20:04:22 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0451C433C6;
        Fri, 26 Jun 2020 20:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0451C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        iommu@lists.linux-foundation.org,
        John Stultz <john.stultz@linaro.org>,
        freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.velikov@collabora.com>,
        Eric Anholt <eric@anholt.net>, Joerg Roedel <joro@8bytes.org>,
        Joerg Roedel <jroedel@suse.de>,
        Jonathan Marek <jonathan@marek.ca>,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] iommu-arm-smmu: Add auxiliary domains and per-instance pagetables
Date:   Fri, 26 Jun 2020 14:04:08 -0600
Message-Id: <20200626200414.14382-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a new refresh of support for auxiliary domains for arm-smmu-v2
and per-instance pagetables for drm/msm. The big change here from past
efforts is that outside of creating a single aux-domain to enable TTBR0
all of the per-instance pagetables are created and managed exclusively
in drm/msm without involving the arm-smmu driver. This fits in with the
suggested model of letting the GPU hardware do what it needs and leave the
arm-smmu driver blissfully unaware.

Almost. In order to set up the io-pgtable properly in drm/msm we need to
query the pagetable configuration from the current active domain and we need to
rely on the iommu API to flush TLBs after a unmap. In the future we can optimize
this in the drm/msm driver to track the state of the TLBs but for now the big
hammer lets us get off the ground.

This series is built on the split pagetable support [1].

[1] https://patchwork.kernel.org/patch/11628543/

v2: Remove unneeded cruft in the a6xx page switch sequence

Jordan Crouse (6):
  iommu/arm-smmu: Add auxiliary domain support for arm-smmuv2
  iommu/io-pgtable: Allow a pgtable implementation to skip TLB
    operations
  iommu/arm-smmu: Add a domain attribute to pass the pagetable config
  drm/msm: Add support to create a local pagetable
  drm/msm: Add support for address space instances
  drm/msm/a6xx: Add support for per-instance pagetables

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  43 +++++
 drivers/gpu/drm/msm/msm_drv.c         |  15 +-
 drivers/gpu/drm/msm/msm_drv.h         |   4 +
 drivers/gpu/drm/msm/msm_gem_vma.c     |   9 +
 drivers/gpu/drm/msm/msm_gpu.c         |  17 ++
 drivers/gpu/drm/msm/msm_gpu.h         |   5 +
 drivers/gpu/drm/msm/msm_gpummu.c      |   2 +-
 drivers/gpu/drm/msm/msm_iommu.c       | 180 +++++++++++++++++++-
 drivers/gpu/drm/msm/msm_mmu.h         |  16 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h  |   1 +
 drivers/iommu/arm-smmu.c              | 231 ++++++++++++++++++++++++--
 drivers/iommu/arm-smmu.h              |   1 +
 include/linux/io-pgtable.h            |  11 +-
 include/linux/iommu.h                 |   1 +
 14 files changed, 507 insertions(+), 29 deletions(-)

-- 
2.17.1

