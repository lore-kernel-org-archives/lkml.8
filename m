Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109D3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA29D2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591661942;
	bh=okD1iWcvVRutgLkmEi7NcL3CvfPnnYTU37AVSJTaVb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UnRiEnCzKPsLpHuV2+sTwImQ6jQVG3fpx+zSp0X2G0ccaWMC27pimkiyCN+T7yg2W
	 Nd4tl3eeF9SHvZtju30Wna+Phpi4VtL5CoovbGHZaeiY1O9Y1EhHRWadtMR0XlQYcf
	 fk14vmZVArGKjZ+YTs6MiwKXZulxjwqwcC0x+7KQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbgFIATB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730640AbgFHXS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:18:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 676572086A;
        Mon,  8 Jun 2020 23:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658308;
        bh=okD1iWcvVRutgLkmEi7NcL3CvfPnnYTU37AVSJTaVb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEcSzFogckrrXJmNUvky0+PMykCww0RVnL9QoSq6TZKQ8i1hQZzRCPqMhU67KHXPf
         IdoZ3EfZGyE425ZKgasG/WJfhOmUFJwzsiNRPYbD3uv97ax1Trc3SzH+mVnKboMHe/
         xJwBqFvhSY3f1VaYojAqASehuxqN3TektlEKfa6k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 309/606] ARM: dts: bcm: HR2: Fix PPI interrupt types
Date:   Mon,  8 Jun 2020 19:07:14 -0400
Message-Id: <20200608231211.3363633-309-sashal@kernel.org>
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

From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>

[ Upstream commit be0ec060b54f0481fb95d59086c1484a949c903c ]

These error messages are output when booting on a BCM HR2 system:
    GIC: PPI11 is secure or misconfigured
    GIC: PPI13 is secure or misconfigured

Per ARM documentation these interrupts are triggered on a rising edge.
See ARM Cortex A-9 MPCore Technical Reference Manual, Revision r4p1,
Section 3.3.8 Interrupt Configuration Registers.

The same issue was resolved for NSP systems in commit 5f1aa51c7a1e
("ARM: dts: NSP: Fix PPI interrupt types").

Fixes: b9099ec754b5 ("ARM: dts: Add Broadcom Hurricane 2 DTS include file")
Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm-hr2.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.dtsi
index 6142c672811e..5e5f5ca3c86f 100644
--- a/arch/arm/boot/dts/bcm-hr2.dtsi
+++ b/arch/arm/boot/dts/bcm-hr2.dtsi
@@ -75,7 +75,7 @@ a9pll: arm_clk@0 {
 		timer@20200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x20200 0x100>;
-			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&periph_clk>;
 		};
 
@@ -83,7 +83,7 @@ twd-timer@20600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x20600 0x20>;
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) |
-						  IRQ_TYPE_LEVEL_HIGH)>;
+						  IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&periph_clk>;
 		};
 
@@ -91,7 +91,7 @@ twd-watchdog@20620 {
 			compatible = "arm,cortex-a9-twd-wdt";
 			reg = <0x20620 0x20>;
 			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) |
-						  IRQ_TYPE_LEVEL_HIGH)>;
+						  IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&periph_clk>;
 		};
 
-- 
2.25.1

