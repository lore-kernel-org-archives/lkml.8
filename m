Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D6FC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4313420739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgCTJOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:14:21 -0400
Received: from 8bytes.org ([81.169.241.247]:54092 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgCTJOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:14:20 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6E822B0; Fri, 20 Mar 2020 10:14:19 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, guohanjun@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v3 00/15] iommu: Move iommu_fwspec out of 'struct device'
Date:   Fri, 20 Mar 2020 10:13:59 +0100
Message-Id: <20200320091414.3941-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is the third version of the changes to move iommu_fwspec out of
'struct device'. Previous versions of this patch-set can be found here:

	v2: https://lore.kernel.org/lkml/20200310091229.29830-1-joro@8bytes.org/

	v1: https://lore.kernel.org/lkml/20200228150820.15340-1-joro@8bytes.org/

Changes to v2:

	- Fix the issues found by Jean-Philippe

	- Fix a compile issue in the Mediatek driver

Please review.

Thanks,

	Joerg

Joerg Roedel (15):
  iommu: Define dev_iommu_fwspec_get() for !CONFIG_IOMMU_API
  ACPI/IORT: Remove direct access of dev->iommu_fwspec
  drm/msm/mdp5: Remove direct access of dev->iommu_fwspec
  iommu/tegra-gart: Remove direct access of dev->iommu_fwspec
  iommu: Rename struct iommu_param to dev_iommu
  iommu: Move iommu_fwspec to struct dev_iommu
  iommu/arm-smmu: Fix uninitilized variable warning
  iommu: Introduce accessors for iommu private data
  iommu/arm-smmu-v3: Use accessor functions for iommu private data
  iommu/arm-smmu: Use accessor functions for iommu private data
  iommu/renesas: Use accessor functions for iommu private data
  iommu/mediatek: Use accessor functions for iommu private data
  iommu/qcom: Use accessor functions for iommu private data
  iommu/virtio: Use accessor functions for iommu private data
  iommu: Move fwspec->iommu_priv to struct dev_iommu

 drivers/acpi/arm64/iort.c                |  6 ++-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c |  2 +-
 drivers/iommu/arm-smmu-v3.c              | 10 ++--
 drivers/iommu/arm-smmu.c                 | 59 ++++++++++++-----------
 drivers/iommu/iommu.c                    | 31 ++++++------
 drivers/iommu/ipmmu-vmsa.c               |  7 +--
 drivers/iommu/mtk_iommu.c                | 13 +++--
 drivers/iommu/mtk_iommu_v1.c             | 14 +++---
 drivers/iommu/qcom_iommu.c               | 61 ++++++++++++++----------
 drivers/iommu/tegra-gart.c               |  2 +-
 drivers/iommu/virtio-iommu.c             | 11 ++---
 include/linux/device.h                   |  9 ++--
 include/linux/iommu.h                    | 33 ++++++++++---
 13 files changed, 144 insertions(+), 114 deletions(-)

-- 
2.17.1

