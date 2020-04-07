Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FE7C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE7C20801
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586217666;
	bh=pPQAnpLJ6swHilZZiXwdXrhXTemHxz69XOukH7cla4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iaAylxPGFJ8trUnBq8RDW0m97kYRC9D8CY1/vQ1EKG67WVc/6hF/nFA93Vdtg6NZi
	 uSs67IMQdUxnnmIL5FGochjqWo6h9XYJdOKlgyA8Y6Q3ie9jlb5IAWpkZOVEeKJIVY
	 OiF2Qsemq4uRmdDEs3fASzAbvH9AatzFOeaUls4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgDGABE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgDGABD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:01:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFD352083E;
        Tue,  7 Apr 2020 00:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586217662;
        bh=pPQAnpLJ6swHilZZiXwdXrhXTemHxz69XOukH7cla4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbRz7LFitqde9Ix1awwsEbjrDiN/kWyhlR9mGupi1580zYKxNHIA9GyVn5u2wpM8z
         2cyt94ve1qXNlVPYBtbSl0MUC8IuzL40k9C2d8NT//gN21w5vYEvzgTMtjMeG7t5Ld
         YkOXdYlMOmb2ePqX1w7M6pwm8NDwlRIQzH+7Iivo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 03/35] ARM: dts: Fix dm814x Ethernet by changing to use rgmii-id mode
Date:   Mon,  6 Apr 2020 20:00:25 -0400
Message-Id: <20200407000058.16423-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407000058.16423-1-sashal@kernel.org>
References: <20200407000058.16423-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit b46b2b7ba6e104d265ab705914859ec0db7a98c5 ]

Commit cd28d1d6e52e ("net: phy: at803x: Disable phy delay for RGMII mode")
caused a regression for dm814x boards where NFSroot would no longer work.

Let's fix the issue by configuring "rgmii-id" mode as internal delays are
needed that is no longer the case with "rgmii" mode.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/dm8148-evm.dts       | 4 ++--
 arch/arm/boot/dts/dm8148-t410.dts      | 4 ++--
 arch/arm/boot/dts/dra62x-j5eco-evm.dts | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/dm8148-evm.dts b/arch/arm/boot/dts/dm8148-evm.dts
index 3931fb068ff09..91d1018ab75fc 100644
--- a/arch/arm/boot/dts/dm8148-evm.dts
+++ b/arch/arm/boot/dts/dm8148-evm.dts
@@ -24,12 +24,12 @@
 
 &cpsw_emac0 {
 	phy-handle = <&ethphy0>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 };
 
 &cpsw_emac1 {
 	phy-handle = <&ethphy1>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 };
 
 &davinci_mdio {
diff --git a/arch/arm/boot/dts/dm8148-t410.dts b/arch/arm/boot/dts/dm8148-t410.dts
index 9e43d5ec0bb2f..79ccdd4470f4c 100644
--- a/arch/arm/boot/dts/dm8148-t410.dts
+++ b/arch/arm/boot/dts/dm8148-t410.dts
@@ -33,12 +33,12 @@
 
 &cpsw_emac0 {
 	phy-handle = <&ethphy0>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 };
 
 &cpsw_emac1 {
 	phy-handle = <&ethphy1>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 };
 
 &davinci_mdio {
diff --git a/arch/arm/boot/dts/dra62x-j5eco-evm.dts b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
index 861ab90a3f3aa..c16e183822bee 100644
--- a/arch/arm/boot/dts/dra62x-j5eco-evm.dts
+++ b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
@@ -24,12 +24,12 @@
 
 &cpsw_emac0 {
 	phy-handle = <&ethphy0>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 };
 
 &cpsw_emac1 {
 	phy-handle = <&ethphy1>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 };
 
 &davinci_mdio {
-- 
2.20.1

