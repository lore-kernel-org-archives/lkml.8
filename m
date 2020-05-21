Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5EFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0E120884
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aKVeXdDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgEUXbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 19:31:24 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17646 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbgEUXbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:31:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec70efc0000>; Thu, 21 May 2020 16:30:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 May 2020 16:31:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 May 2020 16:31:23 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 May
 2020 23:31:23 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 21 May 2020 23:31:23 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec70f4b0000>; Thu, 21 May 2020 16:31:23 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <bbiswas@nvidia.com>, <mperttunen@nvidia.com>,
        <nicolinc@nvidia.com>, <bhuntsman@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v5 0/5] Nvidia Arm SMMUv2 Implementation
Date:   Thu, 21 May 2020 16:31:02 -0700
Message-ID: <20200521233107.11968-1-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590103804; bh=M6pyOSXeBOTReqc8kunREzZAoNiV34NpWkSM15LmbZE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=aKVeXdDGaA5yxJZ9pHolRgPOdSbkNSWg3kK+lUBbUZhQQ8Vb9s4KmPGN9/eDyh2pn
         fwDfQe0yzIv0NLTsZykdKRyWp7YXPKDD9rb2BCOeMz9ZQU95HlzqW4bBv4MjjCZQeY
         1AuoNyiplaMpTgMHcLGdmQIvZwp06S12ZAgkh7foMDbF0n+bKbFY049vuCdHxdDUiB
         Zm9ouLoxsGAurFj20nn9lIZ8ObBzDoZ115+7yTax6wXfbLZ9ooXQHifZuFA3OCdySY
         Rl4b0eFi+F6pYDD4heoETKWAe46D4SFwnqLowoCothFcJbF/1ZXSonGYkjp6ZaQQRr
         KB17wiPqbDPFg==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v5:
Rebased on top of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.=
git next

v4 - https://lkml.org/lkml/2019/10/30/1054
v3 - https://lkml.org/lkml/2019/10/18/1601
v2 - https://lkml.org/lkml/2019/9/2/980
v1 - https://lkml.org/lkml/2019/8/29/1588

Krishna Reddy (5):
  iommu/arm-smmu: add NVIDIA implementation for dual ARM MMU-500 usage
  dt-bindings: arm-smmu: Add binding for Tegra194 SMMU
  iommu/arm-smmu: Add global/context fault implementation hooks
  arm64: tegra: Add DT node for T194 SMMU
  arm64: tegra: enable SMMU for SDHCI and EQOS on T194

 .../devicetree/bindings/iommu/arm,smmu.yaml   |   5 +
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  81 ++++++
 drivers/iommu/Makefile                        |   2 +-
 drivers/iommu/arm-smmu-impl.c                 |   3 +
 drivers/iommu/arm-smmu-nvidia.c               | 261 ++++++++++++++++++
 drivers/iommu/arm-smmu.c                      |  11 +-
 drivers/iommu/arm-smmu.h                      |   4 +
 8 files changed, 366 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c


base-commit: 365f8d504da50feaebf826d180113529c9383670
--=20
2.26.2

