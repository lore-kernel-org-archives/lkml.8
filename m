Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8127CC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54AAC2222C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587044540;
	bh=pPQAnpLJ6swHilZZiXwdXrhXTemHxz69XOukH7cla4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c0oUc00s7DuHyf4WASc6ue+WqhE7WOFjgPeYj80uEvTDD1wC03PjWOTPquBeUBLKM
	 VXYLiuLJSoUy/ei9QndGMJcnAho7v+o+o6CAE1M/4+uFgmGSfEIlaT0W1gZfgPUzfn
	 GUmojjfpHPXeI+H6vnlGQV6xR8h/pBg4SdUWVAO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgDPNmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896659AbgDPNdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:33:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 107B022287;
        Thu, 16 Apr 2020 13:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043971;
        bh=pPQAnpLJ6swHilZZiXwdXrhXTemHxz69XOukH7cla4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nii+c1BSyI/GYnXdKZKO87ntrbk5xV5t5RbBXQjA9QCSAHDctyTzbsFna/xd/j4RC
         HuKuptN6s9y5r8oqRUlMHK2dep10CemSmX/2atbnQAYoM8Rrcrzh0eY+lKY4uT6qV8
         6M+1C8AIRSH5+ZusLiveTgUBMq+aPHar/hMotN2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 003/257] ARM: dts: Fix dm814x Ethernet by changing to use rgmii-id mode
Date:   Thu, 16 Apr 2020 15:20:54 +0200
Message-Id: <20200416131326.312287280@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



