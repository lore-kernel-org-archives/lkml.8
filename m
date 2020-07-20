Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F3BC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02EAF22B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YBiM8why"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgGTGes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:34:48 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1272 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgGTGep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:34:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f153a8e0001>; Sun, 19 Jul 2020 23:32:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 19 Jul 2020 23:34:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 19 Jul 2020 23:34:45 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 06:34:40 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 20 Jul 2020 06:34:40 +0000
Received: from rgumasta-linux.nvidia.com (Not Verified[10.19.66.108]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f153afd0002>; Sun, 19 Jul 2020 23:34:39 -0700
From:   Rajesh Gumasta <rgumasta@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kyarlagadda@nvidia.com>, <rgumasta@nvidia.com>
Subject: [Patch v1 3/4] arm64: configs: enable tegra gpc dma
Date:   Mon, 20 Jul 2020 12:04:15 +0530
Message-ID: <1595226856-19241-4-git-send-email-rgumasta@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595226856-19241-1-git-send-email-rgumasta@nvidia.com>
References: <1595226856-19241-1-git-send-email-rgumasta@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595226766; bh=bhLBojTFXOgiLqqKv69qFtYQJyCZHygwLjpojlupOrc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=YBiM8whyCPA5LbNzwLWjjRhBVEGQZgYCKhhaVpCr45mWrwYOWByDRtRcncbaRGk27
         0PNZ+1Gr+yLmdrjZBr9MYXB94+f9DHEK4qmH9L5FjdBfonRjE+sG/TTovlRfg1uM+K
         bX1c987XmHitO1DiRCq4bFzlSe9Eohii0/O3TU9rKERjX3xAcJs6OnhvprPpJWWEJz
         0Ilg3duFnlT1w1FPJgaQ8QYECv9cgMGMjh2nlxfsXJ50gMa0hcQyIqUIhh4+Z5c+fB
         B5aDt4t7liWcRLLbJ5DXFl6NBZX/EepNydtbIFFYvxXFE8xvBeyGQ5ID+pPKqNyGTa
         vz/v5zwUN62Ng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable TEGRA_GPC_DMA in defconfig for Tegra186 and Tegra196 gpc
dma controller driver

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 883e8ba..600f568 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -775,6 +775,7 @@ CONFIG_MV_XOR_V2=y
 CONFIG_OWL_DMA=y
 CONFIG_PL330_DMA=y
 CONFIG_TEGRA20_APB_DMA=y
+CONFIG_TEGRA_GPC_DMA=m
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_QCOM_HIDMA_MGMT=y
 CONFIG_QCOM_HIDMA=y
-- 
2.7.4

