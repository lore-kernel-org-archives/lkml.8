Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAF4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D159C2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgHJMWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgHJMW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:22:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06FBC061756;
        Mon, 10 Aug 2020 05:22:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id C26AD293510
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ARM: dts: exynos: add prefetch properties for L2C-310 cache
Date:   Mon, 10 Aug 2020 13:22:07 +0100
Message-Id: <30cb8edca2185241471ee1318b05288900652521.1597061474.git.guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <267a81e550a0b5d479c82b5908e2a2caa4c9c874.1597061474.git.guillaume.tucker@collabora.com>
References: <267a81e550a0b5d479c82b5908e2a2caa4c9c874.1597061474.git.guillaume.tucker@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devicetree properties to enable instruction and data prefetch
on exynos4210 and exynos4412 which use the L2C-310 cache.  No other
Exynos chip appears to be using this L2 cache hardware.

This follows the default bits being set in the l2c_aux_val register
for the Exynos platform, which can now be cleared as a result.

Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---

Notes:
    v2: split patch to include devicetree changes only

 arch/arm/boot/dts/exynos4210.dtsi | 2 ++
 arch/arm/boot/dts/exynos4412.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index b4466232f0c1..7e0d253b26ef 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -102,6 +102,8 @@
 			reg = <0x10502000 0x1000>;
 			cache-unified;
 			cache-level = <2>;
+			prefetch-data = <1>;
+			prefetch-instr = <1>;
 			arm,tag-latency = <2 2 1>;
 			arm,data-latency = <2 2 1>;
 		};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 48868947373e..37efa247bf4d 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -218,6 +218,8 @@
 			reg = <0x10502000 0x1000>;
 			cache-unified;
 			cache-level = <2>;
+			prefetch-data = <1>;
+			prefetch-instr = <1>;
 			arm,tag-latency = <2 2 1>;
 			arm,data-latency = <3 2 1>;
 			arm,double-linefill = <1>;
-- 
2.20.1

