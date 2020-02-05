Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D52C352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE572072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ImbCkX8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBEVXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:23:52 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6298 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgBEVXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:23:52 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3b324f0000>; Wed, 05 Feb 2020 13:23:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 05 Feb 2020 13:23:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 05 Feb 2020 13:23:51 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Feb
 2020 21:23:51 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 5 Feb 2020 21:23:51 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.167.216]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e3b32660001>; Wed, 05 Feb 2020 13:23:51 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <helen.koike@collabora.com>, <sboyd@kernel.org>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 1/6] dt-bindings: clock: tegra: Add clk id for CSI TPG clock
Date:   Wed, 5 Feb 2020 13:23:21 -0800
Message-ID: <1580937806-17376-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580937806-17376-1-git-send-email-skomatineni@nvidia.com>
References: <1580937806-17376-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580937807; bh=S6xZgZFIi3mqYtcaBlNqBcPaadNMOP/GEU2NRAJynoY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ImbCkX8JcgW9LjNHBAbr4zRWTOTJkZsyJLSoRROFZ8jl6Qa2hjMpzUN4m1dQZPeT8
         ZU2VGvnWtHuTFf2jG1+dOa1IeIMCvbKYVxquGNXnIJHjuHjMsKB6iNIahmAeFqY8qC
         9G94XbHoVuBWBvqiGA4t81rLzcXG6Qps7r3+NBj9eGKWElsWiEYdUCD/1U2o3IpbFc
         3Sk4eC+/9Of6d0xorTJXrRdcBNvEzaLMYPUz3460MQ8S6eOiiAUmq3LhA3bI8tOueU
         U6zM2hPjq4jmF+McFjRGs5p+KQTcLMGhHjcDcnENyh8QMOis3BYzjmr+1XRJPfTEfI
         qHbNfZ1KFYVsA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra210 uses PLLD out internally for CSI TPG.

This patch adds clk id for this CSI TPG clock from PLLD.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 include/dt-bindings/clock/tegra210-car.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/tegra210-car.h b/include/dt-bindings/clock/tegra210-car.h
index 44f60623f99b..dc22aaec8805 100644
--- a/include/dt-bindings/clock/tegra210-car.h
+++ b/include/dt-bindings/clock/tegra210-car.h
@@ -349,7 +349,7 @@
 #define TEGRA210_CLK_PLL_P_OUT_XUSB 317
 #define TEGRA210_CLK_XUSB_SSP_SRC 318
 #define TEGRA210_CLK_PLL_RE_OUT1 319
-/* 320 */
+#define TEGRA210_CLK_CSI_TPG 320
 /* 321 */
 #define TEGRA210_CLK_ISP 322
 #define TEGRA210_CLK_PLL_A_OUT_ADSP 323
-- 
2.7.4

