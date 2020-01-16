Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFFDC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A1C2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199737;
	bh=X6mlH1vtnpIndQAgdl1cIHRneesGicSpCNswQ/zA+oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MkKjnqSoRjgDLWled36NsKqInpVzqUSXS3PoypdX4X5D8MPbailyIvtfYv6JHH++s
	 JvDkaSe8CmP2WDmccHHsSmUuj2CV+iUiCi1iX4jp9u9aFzX7Kz+JFtVia4x/0ms92h
	 Cw+gTMY1QC9FRWI1BsXHNotTIghZnE0gnIK9/g9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436834AbgAPSf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:35:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391767AbgAPRY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:24:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 692452467E;
        Thu, 16 Jan 2020 17:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195468;
        bh=X6mlH1vtnpIndQAgdl1cIHRneesGicSpCNswQ/zA+oI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdUuQuMRQdInCsjzw05++xoMPHJU8T0OVBw4u0xv1sYxo7l8g/0ojn+ALD26JWbEa
         GOoIvPh+AkaUXM5xUv/Ze6rxOKoxT6RhU8WXBSwh8kbXidqtAn4Qjq/5ilo4UHc1uG
         sI9UtjN6E7unXEz+Gunpxo4ER9CizOukWQL9eLQ4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 075/371] ARM: dts: lpc32xx: add required clocks property to keypad device node
Date:   Thu, 16 Jan 2020 12:19:07 -0500
Message-Id: <20200116172403.18149-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Zapolskiy <vz@mleia.com>

[ Upstream commit 3e88bc38b9f6fe4b69cecf81badd3c19fde97f97 ]

NXP LPC32xx keypad controller requires a clock property to be defined.

The change fixes the driver initialization problem:

  lpc32xx_keys 40050000.key: failed to get clock
  lpc32xx_keys: probe of 40050000.key failed with error -2

Fixes: 93898eb775e5 ("arm: dts: lpc32xx: add clock properties to device nodes")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index d077bd2b9583..2ca881055ef0 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -462,6 +462,7 @@
 			key: key@40050000 {
 				compatible = "nxp,lpc3220-key";
 				reg = <0x40050000 0x1000>;
+				clocks = <&clk LPC32XX_CLK_KEY>;
 				interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
-- 
2.20.1

