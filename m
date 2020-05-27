Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F0FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D920A2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590608225;
	bh=/fP4PLEHU0IIdFJZZWrRTHjfr9RQst5+GKUMbQYNrLE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TmTX8AMTwu6S1FG5q3kpqd+gVqebXyybYWniMbkpk2LoyqjlyTz+nS6GbVKBKD9xH
	 rPEU2M+zEN6rf+znHSt3F2WXvp8aYtgLtna/V9eicRwjI5ivqabvCLBPo/qima6gOU
	 gwmHG0SsoyBN4nkweqgUkfAkdJpZsAc+bQcErfYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgE0ThF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgE0ThE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:37:04 -0400
Received: from localhost.localdomain (unknown [194.230.155.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75272088E;
        Wed, 27 May 2020 19:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590608224;
        bh=/fP4PLEHU0IIdFJZZWrRTHjfr9RQst5+GKUMbQYNrLE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=le9yjZa9bRO7b60CcrV/b7jYTuGp2kpi/MqLWmKxE8782Vh3dkFAZqso61fJNHWxB
         aN++o6Ybjb47oBmAthZ1MrhdEbfuv9049HDFQkb85js/K8R/6PJHabzxig296EaR6Z
         iOSIfpOz7HHPA+pO4ZxYoxYfj2QbXGDc0YK59ivI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nagarjuna Kristam <nkristam@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 2/2] ARM: dts: tegra: Rename "iram" node to "sram"
Date:   Wed, 27 May 2020 21:36:50 +0200
Message-Id: <20200527193650.17617-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527193650.17617-1-krzk@kernel.org>
References: <20200527193650.17617-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device node name should reflect generic class of a device so rename
the "iram" node to "sram".  This will be also in sync with upcoming DT
schema.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/tegra20.dtsi | 2 +-
 arch/arm/boot/dts/tegra30.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index c3b8ad53b967..36e82fc20d47 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -17,7 +17,7 @@
 		reg = <0 0>;
 	};
 
-	iram@40000000 {
+	sram@40000000 {
 		compatible = "mmio-sram";
 		reg = <0x40000000 0x40000>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index d2d05f1da274..7ff85a651194 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -97,7 +97,7 @@
 		};
 	};
 
-	iram@40000000 {
+	sram@40000000 {
 		compatible = "mmio-sram";
 		reg = <0x40000000 0x40000>;
 		#address-cells = <1>;
-- 
2.17.1

