Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A23DC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D5722482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fjZzzyn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgGTGee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:34:34 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7093 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGTGee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:34:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f153abc0001>; Sun, 19 Jul 2020 23:33:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 19 Jul 2020 23:34:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 19 Jul 2020 23:34:33 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 06:34:28 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 20 Jul 2020 06:34:28 +0000
Received: from rgumasta-linux.nvidia.com (Not Verified[10.19.66.108]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f153af10006>; Sun, 19 Jul 2020 23:34:28 -0700
From:   Rajesh Gumasta <rgumasta@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kyarlagadda@nvidia.com>, <rgumasta@nvidia.com>
Subject: [Patch v1 0/4] Add Nvidia Tegra GPC-DMA driver
Date:   Mon, 20 Jul 2020 12:04:12 +0530
Message-ID: <1595226856-19241-1-git-send-email-rgumasta@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595226813; bh=tTR6a02OlDP0FwB/hPvaq3dm/G5G+xebE9R5HCR/jVE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=fjZzzyn7ROBm9LIA9IgpO3skziaEIlUdXyJT+uQSICXEQa4tspkYc3GqxSNIDThoh
         57xiwM67DQtblP5jFGBrTgXHbL73UQEcMrYY/oqm8lLdmdc+9BVVYr7f1e4BDV8wGx
         A204iBPwifhIvctBgJqlYYhuVREYjMB8IboHtGm+RUv8WGFvp1CCWQ2jIsI53QkZMZ
         G1SijWfJQdKSQlWnp44sdb9Osa/hXENdorEgK7IL4e/avU+EUW2x3+mNaro0fpUqLu
         9NHF46xASBhKOqL9sDaieETsJrp7E0p8FY7XZoB7uFOYk13MwlZse0kKtTVV64w3sH
         Fbg4o05gaTG5w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Nvida Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

Patch 1: Add dt-binding document for Tegra GPCDMA driver
Patch 2: Add Tegra GPCDMA driver
Patch 3: Enable Tegra GPCDMA as module
Patch 4: Add GPCDMA DT node for Tegra186 and Tegra194

Rajesh Gumasta (4):
  dt-bindings: dma: Add DT binding document
  dma: tegra: Adding Tegra GPC DMA controller driver
  arm64: configs: enable tegra gpc dma
  arm64: tegra: Add GPCDMA node in dt

 .../bindings/dma/nvidia,tegra-gpc-dma.yaml         |   99 ++
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |    4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   46 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   44 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/tegra-gpc-dma.c                        | 1512 ++++++++++++++++++++
 8 files changed, 1719 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra-gpc-dma.c

-- 
2.7.4

