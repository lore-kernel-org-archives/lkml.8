Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F30AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9E3206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Kv/FUf3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgF3X7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:59:12 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5727 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgF3X7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:59:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efbd19e0000>; Tue, 30 Jun 2020 16:58:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 16:59:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 30 Jun 2020 16:59:12 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 23:59:11 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 30 Jun 2020 23:59:11 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5efbd1cf0004>; Tue, 30 Jun 2020 16:59:11 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <robh+dt@kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <yhsu@nvidia.com>,
        <snikam@nvidia.com>, <praithatha@nvidia.com>, <talho@nvidia.com>,
        <bbiswas@nvidia.com>, <mperttunen@nvidia.com>,
        <nicolinc@nvidia.com>, <bhuntsman@nvidia.com>,
        <nicoleotsuka@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v9 0/4] NVIDIA ARM SMMUv2 Implementation
Date:   Tue, 30 Jun 2020 16:57:48 -0700
Message-ID: <20200630235752.8737-1-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593561502; bh=eugbT7LPkULYSHX34wEcidt+kjV35sgqAiK224mDEZU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=Kv/FUf3It4g3ucejbsVYtK7odgARBoEpvehOEfNuEv5oAHAWNjzuP/lxb7zLzQ5VS
         yxLU06gj5Cru2kG1VqesJ4CDO/q8wlrvJADXq8u7lk5cB9aTaAmPNMcRC2H5HUZG4W
         CvFEZ6npnQfa52Yh+FOiTmePbK44PUDt3dQL6UryHybKe5Jlm4Kk7T0Ab5Wu/sqOZ9
         YFhkLXqSwd6t3Mc2LnWkYYso1WBEmjgJv4TFscKmVLu389EZSFEXXeguYpW3RF1Sri
         dHDTUl7BeIHQ0+b+Sx/8BX/j+x6SMEIo4x/Ueej+Of00dATW+3zcGO7ACHi5hLb/YO
         537iGfsZnG1dA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v9:
Move TLB Timeout and spin count macros to arm-smmu.h header to share with i=
mplementation.
Set minItems and maxItems for reg property when compatible contains nvidia,=
tegra194-smmu.
Update commit message for NVIDIA implementation patch.
Fail single SMMU instance usage through NVIDIA implementation to limit the =
usage to two or three instances.
Fix checkpatch warnings with --strict checking.

v8 - https://lkml.org/lkml/2020/6/29/2385
v7 - https://lkml.org/lkml/2020/6/28/347
v6 - https://lkml.org/lkml/2020/6/4/1018
v5 - https://lkml.org/lkml/2020/5/21/1114
v4 - https://lkml.org/lkml/2019/10/30/1054
v3 - https://lkml.org/lkml/2019/10/18/1601
v2 - https://lkml.org/lkml/2019/9/2/980
v1 - https://lkml.org/lkml/2019/8/29/1588

Krishna Reddy (4):
  iommu/arm-smmu: move TLB timeout and spin count macros
  iommu/arm-smmu: add NVIDIA implementation for ARM MMU-500 usage
  dt-bindings: arm-smmu: add binding for Tegra194 SMMU
  iommu/arm-smmu: Add global/context fault implementation hooks

 .../devicetree/bindings/iommu/arm,smmu.yaml   |  18 ++
 MAINTAINERS                                   |   2 +
 drivers/iommu/Makefile                        |   2 +-
 drivers/iommu/arm-smmu-impl.c                 |   3 +
 drivers/iommu/arm-smmu-nvidia.c               | 304 ++++++++++++++++++
 drivers/iommu/arm-smmu.c                      |  20 +-
 drivers/iommu/arm-smmu.h                      |   6 +
 7 files changed, 349 insertions(+), 6 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c


base-commit: 48f0bcfb7aad2c6eb4c1e66476b58475aa14393e
--=20
2.26.2

