Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91743C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7174220829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgG2Nr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:47:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39654 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2Nrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:47:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 2111029818A
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: exynos: use DT prefetch attributes rather than l2c_aux_val
Date:   Wed, 29 Jul 2020 14:47:33 +0100
Message-Id: <5e41140ddb1afe42699715cca59c44fa2fa29e60.1596028601.git.guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <860eb8a1eed879e55daf960c96acdac514cbda93.1596028601.git.guillaume.tucker@collabora.com>
References: <860eb8a1eed879e55daf960c96acdac514cbda93.1596028601.git.guillaume.tucker@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard l2c2x0 device tree bindings to enable data and
instruction prefetch on exynos4210 and exynos4412 and clear the
respective bits in the default l2c_aux_val.  No other Exynos platform
relying on this default register value appears to be using the l2x0
cache.

Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 2 ++
 arch/arm/boot/dts/exynos4412.dtsi | 2 ++
 arch/arm/mach-exynos/exynos.c     | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

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
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index a96f3353a0c1..0e906cc3a48e 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -193,8 +193,8 @@ static void __init exynos_dt_fixup(void)
 }
 
 DT_MACHINE_START(EXYNOS_DT, "Samsung Exynos (Flattened Device Tree)")
-	.l2c_aux_val	= 0x38400000,
-	.l2c_aux_mask	= 0xc60fffff,
+	.l2c_aux_val	= 0x08400000,
+	.l2c_aux_mask	= 0xf60fffff,
 	.smp		= smp_ops(exynos_smp_ops),
 	.map_io		= exynos_init_io,
 	.init_early	= exynos_firmware_init,
-- 
2.20.1

