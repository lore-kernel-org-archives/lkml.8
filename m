Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31D9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEDF1205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597686637;
	bh=QuTGwHFG4PfND3wv40WtsKr+cg9CyiMKlrNdZx2m/kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0oXvA9v6/lN79k2Q4FbS8Bz1jvaHNUIZzAp7tdlnstST5ZG5RYUAj/vb2vALRSju1
	 qTsfpWYcJvyd4Z3o+7yVlEy8ik03tloknVvgH+x8+BZxkmTpsBuAaut2XNVb0ylYcS
	 ATfEPxTjMbJ5YcXe6Wr3HnnWAtwsC6BDYg5DFHwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389177AbgHQRug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388692AbgHQQMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:12:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 975F020578;
        Mon, 17 Aug 2020 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680742;
        bh=QuTGwHFG4PfND3wv40WtsKr+cg9CyiMKlrNdZx2m/kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t7H5K/0CdSgiRMO+RFRSo3qzIfiiS4Kkwsu/9mlRu3umOLtVM0ulsYvPvLNy4a2Ua
         fPyHnbFGiEnMaB4g5UrocNXAtibUHA9XkQPiFGhBx3cFR1nods5FuiT///GGqRR3vM
         Wuf+txJ28z9vnkvbgLQD0Lljjy+LFl/KhIXOCMqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 009/168] arm64: dts: rockchip: fix rk3399-puma gmac reset gpio
Date:   Mon, 17 Aug 2020 17:15:40 +0200
Message-Id: <20200817143734.177619880@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

[ Upstream commit 8a445086f8af0b7b9bd8d1901d6f306bb154f70d ]

The puma gmac node currently uses opposite active-values for the
gmac phy reset pin. The gpio-declaration uses active-high while the
separate snps,reset-active-low property marks the pin as active low.

While on the kernel side this works ok, other DT users may get
confused - as seen with uboot right now.

So bring this in line and make both properties match, similar to the
other Rockchip board.

Fixes: 2c66fc34e945 ("arm64: dts: rockchip: add RK3399-Q7 (Puma) SoM")
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Link: https://lore.kernel.org/r/20200603132836.362519-1-heiko@sntech.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index baacb6e227b95..b155f657292bd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -156,7 +156,7 @@ &gmac {
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
-	snps,reset-gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
+	snps,reset-gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
 	tx_delay = <0x10>;
-- 
2.25.1



