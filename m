Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEC2C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996B02077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579875517;
	bh=ZKDcLH6v9XtUKRk4ZP7IrAf1NjELi1VNKfJKnhwS1Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=axJKGYt4uOEe+GoqLPBf+B8MYwst0FY8VTvqWd0ndeXySguuGDP6NgKSwuCOJN1nx
	 J6V78Z2uJsMJvtUiei1HjrqOpGnh/thjDZOedWOfpfLKoahfpvCkdaJB3kg2nRPia8
	 9RnDnlQo3YrPHYpQhL8GrEkGnFT8lz7M85G3osQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390906AbgAXOSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:18:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390844AbgAXOSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:18:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D66021556;
        Fri, 24 Jan 2020 14:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875515;
        bh=ZKDcLH6v9XtUKRk4ZP7IrAf1NjELi1VNKfJKnhwS1Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OWnCHP0340044PUSHLAASJ9kFPR9ux7fLdbS7iQEmkdAKX4WDwT6ItFPLs62hsTdi
         QnVhItZD22xPUYQeo9pypIt6haHPXW+4f6RnpHGP2gIMngio1Jd7F5Z7bXXrR5O64W
         +qTU/d7HehhofDeT36qpmNXmxv+aevfx1YxM64gY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 015/107] arm64: dts: imx8mm: Change SDMA1 ahb clock for imx8mm
Date:   Fri, 24 Jan 2020 09:16:45 -0500
Message-Id: <20200124141817.28793-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 24a572bf67994223e722cadfe663e15ba221882a ]

Using SDMA1 with UART1 is causing a "Timeout waiting for CH0" error.
This patch changes to ahb clock from SDMA1_ROOT to AHB which
fixes the timeout error.

Fixes:  a05ea40eb384 ("arm64: dts: imx: Add i.mx8mm dtsi support")
Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 23c8fad7932b1..b4ca3b7ef10d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -741,7 +741,7 @@
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_SDMA1_ROOT>,
-					 <&clk IMX8MM_CLK_SDMA1_ROOT>;
+					 <&clk IMX8MM_CLK_AHB>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
-- 
2.20.1

