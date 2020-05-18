Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562F4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217D020674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823925;
	bh=3jL/axdTlYd33laaCHBdmLeN7tXf5UZO0qK9ao31xS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZNBQ59OU1S0+jJGIes9FR6L98ICkPUG0II2eV4TO4so69cDizDB6F0ZsGi616zrXi
	 7BD9TEKeiJ6mUspStV2Tg9TCLn3VhUqkJnLR7XxO2jbae2FUfrptCwkQUA3xm/M6i0
	 EiC0pPJzquB5yg2xqOMNLbWbq6UC5hnIPFCVjtTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgERRpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729904AbgERRpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:45:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 592BC20674;
        Mon, 18 May 2020 17:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823917;
        bh=3jL/axdTlYd33laaCHBdmLeN7tXf5UZO0qK9ao31xS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVOlXONd44p4UM+7mZ89/msAxuJVkh2zhT2xYtdJ6wl5GWKR/BmkqrBA8JdXgO/bF
         FXnLbsJx1JyOIVAjiEfoBFDTUY/OXiRaYm6nXuY7dgZoILuUiX60ZkpN4d7hKKUXBo
         qC2b81o2lmGfTbqMAYOCwBzDe4OJn4svTkVLaZLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulrich Hecht <uli+renesas@fpond.eu>
Subject: [PATCH 4.9 88/90] ARM: dts: r8a7740: Add missing extal2 to CPG node
Date:   Mon, 18 May 2020 19:37:06 +0200
Message-Id: <20200518173508.964978138@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit e47cb97f153193d4b41ca8d48127da14513d54c7 upstream.

The Clock Pulse Generator (CPG) device node lacks the extal2 clock.
This may lead to a failure registering the "r" clock, or to a wrong
parent for the "usb24s" clock, depending on MD_CK2 pin configuration and
boot loader CPG_USBCKCR register configuration.

This went unnoticed, as this does not affect the single upstream board
configuration, which relies on the first clock input only.

Fixes: d9ffd583bf345e2e ("ARM: shmobile: r8a7740: add SoC clocks to DTS")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Link: https://lore.kernel.org/r/20200508095918.6061-1-geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/r8a7740.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -467,7 +467,7 @@
 		cpg_clocks: cpg_clocks@e6150000 {
 			compatible = "renesas,r8a7740-cpg-clocks";
 			reg = <0xe6150000 0x10000>;
-			clocks = <&extal1_clk>, <&extalr_clk>;
+			clocks = <&extal1_clk>, <&extal2_clk>, <&extalr_clk>;
 			#clock-cells = <1>;
 			clock-output-names = "system", "pllc0", "pllc1",
 					     "pllc2", "r",


