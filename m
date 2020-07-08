Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FEFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71FD2220A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgGHIyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:54:24 -0400
Received: from mx.socionext.com ([202.248.49.38]:18909 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgGHIyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:54:22 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Jul 2020 17:54:19 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 202761800E0;
        Wed,  8 Jul 2020 17:54:20 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 8 Jul 2020 17:54:20 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id B5C421A0507;
        Wed,  8 Jul 2020 17:54:19 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/2] arm64: dts: uniphier: Rename ethphy node to ethernet-phy
Date:   Wed,  8 Jul 2020 17:54:11 +0900
Message-Id: <1594198451-29073-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594198451-29073-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1594198451-29073-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This renames the node name "ethphy" to "ethernet-phy" according to
Documentation/devicetree/bindings/net/mdio.yaml.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts  | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts     | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts  | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts     | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts     | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 816ac25..da44a15 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -157,7 +157,7 @@
 };
 
 &mdio {
-	ethphy: ethphy@1 {
+	ethphy: ethernet-phy@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
index 693171f..475c595 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
@@ -76,7 +76,7 @@
 };
 
 &mdio {
-	ethphy: ethphy@1 {
+	ethphy: ethernet-phy@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts
index 816919b..aa159a1 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts
@@ -153,7 +153,7 @@
 };
 
 &mdio {
-	ethphy: ethphy@0 {
+	ethphy: ethernet-phy@0 {
 		reg = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index 2c00008..a01579c 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -141,7 +141,7 @@
 };
 
 &mdio {
-	ethphy: ethphy@1 {
+	ethphy: ethernet-phy@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index eeb976e..e3db4c1 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -64,7 +64,7 @@
 };
 
 &mdio {
-	ethphy: ethphy@0 {
+	ethphy: ethernet-phy@0 {
 		reg = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index 7c30c6b..942a5dc 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -97,7 +97,7 @@
 };
 
 &mdio0 {
-	ethphy0: ethphy@0 {
+	ethphy0: ethernet-phy@0 {
 		reg = <0>;
 	};
 };
@@ -108,7 +108,7 @@
 };
 
 &mdio1 {
-	ethphy1: ethphy@0 {
+	ethphy1: ethernet-phy@0 {
 		reg = <0>;
 	};
 };
-- 
2.7.4

