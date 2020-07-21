Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9950DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7732A20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595318640;
	bh=+MyaGmTaU19aPpvAgrnfqAXQzHmb6mhfDcgxCLDkT9E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=nFOKc8PP8j7ses47fRPbbRekGfg+VIABtUqEq5blKNk6tDx4hnfFZfUuawo9nscgk
	 Amw1ML5gIEB+jU2VtCGwoGstN2HijNvlhjwBVmvRFqsr+H7Sjuk9g3wsyQWRLM/qeM
	 8mAGo4Gs4ywJ18wqG8KaZdlLg3c7cPKSK2CvY/OQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgGUID7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgGUID6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:03:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8E4820709;
        Tue, 21 Jul 2020 08:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595318638;
        bh=+MyaGmTaU19aPpvAgrnfqAXQzHmb6mhfDcgxCLDkT9E=;
        h=Date:From:To:Cc:Subject:From;
        b=a6oaoypm/8b8eKHs4w9CyA8FwIifMPoXrvDj5jj0k0QhmP89uNbdaXVhTvSeLCvOj
         9ptI6ZQw/oWLsYe3436+stZiDSd/Gzxo0/KCc2AIHGFxUmz1TeVShAhd8Wnn4VxjUz
         SSAUielerz1JpuKgUy5MgxVHUz7hFc7JqBzPFW/s=
Date:   Tue, 21 Jul 2020 09:03:53 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.9
Message-ID: <20200721080352.GA13023@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these Arm SMMU driver updates for 5.9. Summary is in the tag,
but the main thing is support for two new SoC integrations, one of which
is considerably more brain-dead than the other (determining which one is
left as an exercise to the reader although the diffstat is fairly revealing).

Cheers,

Will

--->8

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to aa7ec73297df57a86308fee78d2bf86e22ea0bae:

  iommu/arm-smmu: Add global/context fault implementation hooks (2020-07-20 09:30:51 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.9

- Support for SMMU-500 implementation in Marvell Armada-AP806 SoC

- Support for SMMU-500 implementation in NVIDIA Tegra194 SoC

- DT compatible string updates

- Remove unused IOMMU_SYS_CACHE_ONLY flag

----------------------------------------------------------------
Hanna Hawa (1):
      iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum #582743

John Garry (1):
      iommu/arm-smmu-v3: Fix trivial typo

Jonathan Marek (2):
      dt-bindings: arm-smmu: Add sm8150 and sm8250 compatible strings
      iommu: arm-smmu-impl: Use qcom impl for sm8150 and sm8250 compatibles

Krishna Reddy (5):
      iommu/arm-smmu: move TLB timeout and spin count macros
      iommu/arm-smmu: ioremap smmu mmio region before implementation init
      iommu/arm-smmu: add NVIDIA implementation for ARM MMU-500 usage
      dt-bindings: arm-smmu: add binding for Tegra194 SMMU
      iommu/arm-smmu: Add global/context fault implementation hooks

Robin Murphy (1):
      iommu/arm-smmu: Update impl quirks comment

Tomasz Nowicki (2):
      iommu/arm-smmu: Call configuration impl hook before consuming features
      dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806 SMMU-500

Will Deacon (1):
      iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag

 Documentation/arm64/silicon-errata.rst             |   3 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |  31 ++-
 MAINTAINERS                                        |   2 +
 drivers/iommu/Makefile                             |   2 +-
 drivers/iommu/arm-smmu-impl.c                      |  60 ++++-
 drivers/iommu/arm-smmu-nvidia.c                    | 278 +++++++++++++++++++++
 drivers/iommu/arm-smmu-v3.c                        |   2 +-
 drivers/iommu/arm-smmu.c                           |  40 ++-
 drivers/iommu/arm-smmu.h                           |   6 +
 drivers/iommu/io-pgtable-arm.c                     |   3 -
 include/linux/iommu.h                              |   6 -
 11 files changed, 403 insertions(+), 30 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c
