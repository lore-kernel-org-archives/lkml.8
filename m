Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD29C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302242064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579170356;
	bh=rfbKFjdigRuq8AVbOSw0k4NXMuREWFVYbNiLvRYfj88=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=jWwon/lFKaQlsfWHyHiUZJvVWSizUETMiXXeI486RZCan+MWuhesZ5GxXbRNzOypf
	 LYPui5GB+DluG6iikyWVm/ruev9xk1bhxaekgyM6bVvZMXBpxkOuChmA6kPlA+cZFP
	 ie4wR3Ytgb2oMInUAhV6hOPGH8PTrASVEVU0PXN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgAPKZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 05:25:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgAPKZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:25:55 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 469582053B;
        Thu, 16 Jan 2020 10:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579170353;
        bh=rfbKFjdigRuq8AVbOSw0k4NXMuREWFVYbNiLvRYfj88=;
        h=Date:From:To:Cc:Subject:From;
        b=a7Rll640V8lSXwIwcQMbTU5F422ieKtpgEDvghdlnKJZHqHmMXFhArtpu8tZ2drEg
         qJehFzVPpI0wYOKA/Ja+z4lgq8GNw2DwW7yOkVrXHFWAR+SISQ04oAoR73r82nI3zX
         yt/E1ziPduV/QHANAsH6itgKnaoYB5nx5enVH6/Q=
Date:   Thu, 16 Jan 2020 10:25:49 +0000
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.6
Message-ID: <20200116102548.GA14761@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these Arm SMMU updates for 5.6. The branch is based on your
arm/smmu branch and includes a patch addressing the feedback from Greg
about setting the module 'owner' field in the 'iommu_ops'.

I've used a signed tag this time, so you can see the summary of the
changes listed in there. The big deal is that we're laying the groundwork
for PCIe PASID support in SMMUv3, and I expect to hook that up for PCIe
masters in 5.7 once we've exported the necessary symbols to do so.

Cheers,

Will

--->8

The following changes since commit 1ea27ee2f76e67f98b9942988f1336a70d351317:

  iommu/arm-smmu: Update my email address in MODULE_AUTHOR() (2019-12-23 14:06:06 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 5a4549fd790500d7db94b7d2af6d60cee42110c3:

  PCI/ATS: Add PASID stubs (2020-01-15 16:30:28 +0000)

----------------------------------------------------------------
Arm SMMU updates for 5.6

- Support for building, and {un,}loading the SMMU drivers as modules

- Minor cleanups

- SMMUv3:
  * Non-critical fix to encoding of TLBI_NH_VA invalidation command
  * Fix broken sanity check on size of MMIO resource during probe
  * Support for Substream IDs which will soon be provided by PCI PASIDs

- io-pgtable:
  * Finish off the TTBR1 preparation work partially merged last cycle
  * Ensure correct memory attributes for non-cacheable mappings

- SMMU:
  * Namespace public #defines to avoid collisions with arch/arm64/
  * Avoid using valid SMR register when probing mask size

----------------------------------------------------------------
Jean-Philippe Brucker (12):
      iommu/arm-smmu-v3: Drop __GFP_ZERO flag from DMA allocation
      dt-bindings: document PASID property for IOMMU masters
      iommu/arm-smmu-v3: Parse PASID devicetree property of platform devices
      ACPI/IORT: Parse SSID property of named component node
      iommu/arm-smmu-v3: Prepare arm_smmu_s1_cfg for SSID support
      iommu/arm-smmu-v3: Add context descriptor tables allocators
      iommu/arm-smmu-v3: Add support for Substream IDs
      iommu/arm-smmu-v3: Propagate ssid_bits
      iommu/arm-smmu-v3: Prepare for handling arm_smmu_write_ctx_desc() failure
      iommu/arm-smmu-v3: Add second level of context descriptor table
      iommu/arm-smmu-v3: Improve add_device() error handling
      PCI/ATS: Add PASID stubs

Masahiro Yamada (3):
      iommu/arm-smmu-v3: Fix resource_size check
      iommu/arm-smmu-v3: Remove useless of_match_ptr()
      iommu/arm-smmu: Fix -Wunused-const-variable warning

Robin Murphy (5):
      iommu/io-pgtable-arm: Rationalise TTBRn handling
      iommu/io-pgtable-arm: Improve attribute handling
      iommu/io-pgtable-arm: Rationalise TCR handling
      iommu/io-pgtable-arm: Prepare for TTBR1 usage
      iommu/arm-smmu: Improve SMR mask test

Shameer Kolothum (1):
      iommu/arm-smmu-v3: Populate VMID field for CMDQ_OP_TLBI_NH_VA

Will Deacon (7):
      drivers/iommu: Initialise module 'owner' field in iommu_device_set_ops()
      iommu/io-pgtable-arm: Support non-coherent stage-2 page tables
      iommu/io-pgtable-arm: Ensure ARM_64_LPAE_S2_TCR_RES1 is unsigned
      iommu/arm-smmu: Rename public #defines under ARM_SMMU_ namespace
      iommu/io-pgtable-arm: Rationalise VTCR handling
      iommu/arm-smmu-v3: Use WRITE_ONCE() when changing validity of an STE
      iommu/arm-smmu-v3: Return -EBUSY when trying to re-add a device

 Documentation/devicetree/bindings/iommu/iommu.txt |   6 +
 drivers/acpi/arm64/iort.c                         |  18 +
 drivers/iommu/arm-smmu-impl.c                     |   2 +-
 drivers/iommu/arm-smmu-v3.c                       | 499 +++++++++++++++++-----
 drivers/iommu/arm-smmu.c                          | 197 +++++----
 drivers/iommu/arm-smmu.h                          | 228 ++++++----
 drivers/iommu/io-pgtable-arm-v7s.c                |  22 +-
 drivers/iommu/io-pgtable-arm.c                    | 164 ++++---
 drivers/iommu/io-pgtable.c                        |   2 +-
 drivers/iommu/ipmmu-vmsa.c                        |   2 +-
 drivers/iommu/msm_iommu.c                         |   4 +-
 drivers/iommu/mtk_iommu.c                         |   4 +-
 drivers/iommu/of_iommu.c                          |   6 +-
 drivers/iommu/qcom_iommu.c                        |  25 +-
 include/linux/io-pgtable.h                        |  27 +-
 include/linux/iommu.h                             |  13 +-
 include/linux/pci-ats.h                           |   3 +
 17 files changed, 810 insertions(+), 412 deletions(-)
