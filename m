Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAABC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF99206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663145;
	bh=z/VmohNmkdvkGAeptphUD4iQVkdn9sw5EBbjAsBiMks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Of7TwfTVTfP24Vy09NA56sWM2a35tVGBYSYsvJCGZ9qRUcNz/1M4Z6OyR98kS6x/0
	 qIbLILt7z80SjvCv7HrtlnTeOqpA3Ay2Q7bj4XZVtkNuvHa9j0mj49RIw1JjU4OWGj
	 f9dCFLWu2AUy2E0aYBYokqCDWDkCJphE9J9TZNjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgFIAjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729364AbgFHXN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:13:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5ED420B80;
        Mon,  8 Jun 2020 23:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658006;
        bh=z/VmohNmkdvkGAeptphUD4iQVkdn9sw5EBbjAsBiMks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pg7v13Z/fSFemXm5XNFAVdYPRKeC4gb4dg0rY9ty034yRejEgJQ3QAufiFqv4d72r
         dvoCz6/PHe00BZtEWogzOYpW5xFhB+Sz32jgPz5kMoPqIin1aEjl52kCotbeKQ2AXo
         06DZaLCI84EggVADPmwgzorxLdBJr12MMj/Ereeo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 062/606] arm64: dts: imx8mn: Change SDMA1 ahb clock for imx8mn
Date:   Mon,  8 Jun 2020 19:03:07 -0400
Message-Id: <20200608231211.3363633-62-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

commit 15ddc3e17aec0de4c69d595b873e184432b9791d upstream.

Using SDMA1 with UART1 is causing a "Timeout waiting for CH0" error.
This patch changes to ahb clock from SDMA1_ROOT to AHB which fixes the
timeout error.

Fixes: 6c3debcbae47 ("arm64: dts: freescale: Add i.MX8MN dtsi support")

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a44b5438e842..882e913436ca 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -661,7 +661,7 @@ sdma1: dma-controller@30bd0000 {
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_SDMA1_ROOT>,
-					 <&clk IMX8MN_CLK_SDMA1_ROOT>;
+					 <&clk IMX8MN_CLK_AHB>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
-- 
2.25.1

