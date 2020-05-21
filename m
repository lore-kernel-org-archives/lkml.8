Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6D9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ECA620829
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590082790;
	bh=rZ7OTMNu5T3UCgib1e3eEgYYpyAWOaCd5OohlJnEMDo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=VQS5ntcq91P89KkC1BmIrqfL45ez6msAPvDb+BYppqTpCbRaQ4M9iZdQxuwIuyIyh
	 4F949cITeJmkbmEW/sr5PWNKR24Z0fWROclyic4K+cnenj3uGlng4KQZ19cvl0xuDZ
	 nRvZP6Pgvft5JuUmzKSX/a1hGKBFJeVikI3raIRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgEURjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbgEURjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:39:49 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7A27207F7;
        Thu, 21 May 2020 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590082788;
        bh=rZ7OTMNu5T3UCgib1e3eEgYYpyAWOaCd5OohlJnEMDo=;
        h=Date:From:To:Cc:Subject:From;
        b=oEgGuQeONzen71ym3SmfwHbStp6Iv/qiCn0Zlhowk7y9UaPuWTV7/MDErl+ZfoI92
         hKW2W7RzfGMoHlfcHHFFWSidXGbZ61miQMpUe5ThBpYwJXb506hwMe4IX82saoP6tl
         9OQNYX8y1p83Kx0VoFMpCjUZprB7ll8BGFkU8EQw=
Date:   Thu, 21 May 2020 18:39:44 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.8
Message-ID: <20200521173944.GM6608@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these Arm SMMU updates for 5.8. The branch is based on your
'core' branch from a little while ago.

Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 1b032ec1ecbce6047af7d11c9db432e237cb17d8:

  iommu: Unexport iommu_group_get_for_dev() (2020-05-05 14:36:14 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 0299a1a81ca056e79c1a7fb751f936ec0d5c7afe:

  iommu/arm-smmu-v3: Manage ASIDs with xarray (2020-05-21 14:54:06 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.8

- Avoid mapping reserved MMIO space on SMMUv3, so that it can be claimed
  by the PMU driver

- Use xarray to manage ASIDs on SMMUv3

- Reword confusing shutdown message

- DT compatible string updates

- Allow implementations to override the default domain type

----------------------------------------------------------------
Andre Przywara (1):
      dt-bindings: arm-smmu: Allow mmu-400, smmu-v1 compatible

Chen Zhou (1):
      iommu/arm-smmu-v3: remove set but not used variable 'smmu'

Jean-Philippe Brucker (2):
      iommu/arm-smmu-v3: Don't reserve implementation defined register space
      iommu/arm-smmu-v3: Manage ASIDs with xarray

Jordan Crouse (1):
      iommu/arm-smmu: Allow client devices to select direct mapping

Sai Prakash Ranjan (3):
      iommu/arm-smmu: Make remove callback message more informative
      iommu: arm-smmu-impl: Convert to a generic reset implementation
      iommu/arm-smmu: Implement iommu_ops->def_domain_type call-back

Sibi Sankar (3):
      dt-bindings: remoteproc: qcom: Add iommus property
      arm64: dts: qcom: sdm845-cheza: Add iommus property
      iommu/arm-smmu-qcom: Request direct mapping for modem device

 .../devicetree/bindings/iommu/arm,smmu.yaml        |  4 +-
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |  3 +
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi         |  5 ++
 drivers/iommu/arm-smmu-impl.c                      |  8 ++-
 drivers/iommu/arm-smmu-qcom.c                      | 37 ++++++++++++-
 drivers/iommu/arm-smmu-v3.c                        | 64 +++++++++++++++++-----
 drivers/iommu/arm-smmu.c                           | 14 ++++-
 drivers/iommu/arm-smmu.h                           |  1 +
 8 files changed, 113 insertions(+), 23 deletions(-)
