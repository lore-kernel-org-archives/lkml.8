Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30969C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134C72072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691550;
	bh=sB317FLKXl8ZWzvoUjIVlaxiV8Hf9CrJJB1t9Ct1CJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CvoDaZD79zFmfejZSYgWBUliiWrd1chpPizJrxnUO2qknzZnn4s3HNk5TOr8Yy0P7
	 5rgOL6KnEars/fIMET1+4igLXv/7aIL+/bvPv6tGRuAiBks49uTgo3VCUwFOeeMxKO
	 2/hugrHONzeja0rR1cluvrsFOJb3KMdIy2HFSaos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbgHQTMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730690AbgHQPkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:40:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8DFB20760;
        Mon, 17 Aug 2020 15:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678851;
        bh=sB317FLKXl8ZWzvoUjIVlaxiV8Hf9CrJJB1t9Ct1CJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rsj5sC+CQ1L9NAsUsl6Hw/xO8GA2iJ6ydshhDbzf5CBruwxWeQFvpJ3K5TyRBgj9e
         GKY6agJo4vt+iGqxDrvNtf6y/Z1iLhWxkhMYR1MlFpuMWoHuAOMScNixLQSWTuBgrL
         S/3koDIWlFF7pulfrCIFc1o9GW0c2dtL42dN6OHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 012/393] arm64: dts: rockchip: fix rk3368-lion gmac reset gpio
Date:   Mon, 17 Aug 2020 17:11:02 +0200
Message-Id: <20200817143820.194373451@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

[ Upstream commit 2300e6dab473e93181cf76e4fe6671aa3d24c57b ]

The lion gmac node currently uses opposite active-values for the
gmac phy reset pin. The gpio-declaration uses active-high while the
separate snps,reset-active-low property marks the pin as active low.

While on the kernel side this works ok, other DT users may get
confused - as seen with uboot right now.

So bring this in line and make both properties match, similar to the
other Rockchip board.

Fixes: d99a02bcfa81 ("arm64: dts: rockchip: add RK3368-uQ7 (Lion) SoM")
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Link: https://lore.kernel.org/r/20200607212909.920575-1-heiko@sntech.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
index e17311e090826..216aafd90e7f1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
@@ -156,7 +156,7 @@ &gmac {
 	pinctrl-0 = <&rgmii_pins>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
-	snps,reset-gpio = <&gpio3 RK_PB3 GPIO_ACTIVE_HIGH>;
+	snps,reset-gpio = <&gpio3 RK_PB3 GPIO_ACTIVE_LOW>;
 	tx_delay = <0x10>;
 	rx_delay = <0x10>;
 	status = "okay";
-- 
2.25.1



