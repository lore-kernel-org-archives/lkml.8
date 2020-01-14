Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84726C33CAD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA602084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Jf31N12j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgANHYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:24:53 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13909 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbgANHYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:24:43 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1d6ca60000>; Mon, 13 Jan 2020 23:24:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jan 2020 23:24:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jan 2020 23:24:42 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 07:24:41 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 14 Jan 2020 07:24:41 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.242]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1d6cb80003>; Mon, 13 Jan 2020 23:24:41 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 16/22] arm64: tegra: smaug: Change clk_out_2 provider to pmc
Date:   Mon, 13 Jan 2020 23:24:21 -0800
Message-ID: <1578986667-16041-17-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578986662; bh=aIi2RKMjRRfxar1w6Hi9kD9PPJabjGanhTPWxjscSm8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Jf31N12jUh3l00gDlS3PYAUltovjzaU15TkbXdgAIoRUlEOKXuNBfSE6lbrTdRVeQ
         bzgROI35jeJw23VMElKIAwvZhxACVgjK2m64SuEYsC7wzraPvMA0yqnLGqJfJ9a8eH
         5g4s4yxCYiRWUKjdQWYSFDe/E2VJ+Wapl6cx5FA2/4wduH2Fh3Xq3WFjT/zHggWSJq
         pvnrOJ1HS3vHSSu0rMyObcHn3CdhMzfZYOCcXMLhtBpiqsSpcTZlxKY4KkANIAYhfl
         l+w4rSYvQcExyj8izZtEGuUomv+/FFWyT2htPCaIpy3E2Zk2OLKsPuBjo5C6QMD1K5
         z8vrseQY9IhSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_out_2 is one of the clocks from Tegra PMC block and Tegra PMC
clocks are moved from clock driver to pmc driver with pmc as clock
provider and using pmc clock ids.

This patch changes clk_out_2 provider to pmc and uses corresponding
pmc clock id for clk_out_2.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index 72c7a04ac1df..2faab6390552 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -1592,7 +1592,7 @@
 			reg = <0x1a>;
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(E, 6) IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&tegra_car TEGRA210_CLK_CLK_OUT_2>;
+			clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_2>;
 			clock-names = "mclk";
 
 			nuvoton,jkdet-enable;
-- 
2.7.4

