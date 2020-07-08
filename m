Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D58C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8662220A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgGHIyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:54:21 -0400
Received: from mx.socionext.com ([202.248.49.38]:18909 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgGHIyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:54:21 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Jul 2020 17:54:19 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 58B2460060;
        Wed,  8 Jul 2020 17:54:19 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 8 Jul 2020 17:54:19 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id A55BC1A0507;
        Wed,  8 Jul 2020 17:54:18 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/2] ARM: dts: uniphier: Rename ethphy node to ethernet-phy
Date:   Wed,  8 Jul 2020 17:54:10 +0900
Message-Id: <1594198451-29073-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This renames the node name "ethphy" to "ethernet-phy" according to
Documentation/devicetree/bindings/net/mdio.yaml.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-ld6b-ref.dts    | 2 +-
 arch/arm/boot/dts/uniphier-pro4-ace.dts    | 2 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts    | 2 +-
 arch/arm/boot/dts/uniphier-pro4-sanji.dts  | 2 +-
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts | 2 +-
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index 079cadc..df3148f 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -76,7 +76,7 @@
 };
 
 &mdio {
-	ethphy: ethphy@0 {
+	ethphy: ethernet-phy@0 {
 		reg = <0>;
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-pro4-ace.dts b/arch/arm/boot/dts/uniphier-pro4-ace.dts
index 64246fa..27ff2b7 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ace.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ace.dts
@@ -87,7 +87,7 @@
 };
 
 &mdio {
-	ethphy: ethphy@1 {
+	ethphy: ethernet-phy@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index 181442c..2c423e8 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -84,7 +84,7 @@
 };
 
 &mdio {
-	ethphy: ethphy@0 {
+	ethphy: ethernet-phy@0 {
 		reg = <0>;
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-pro4-sanji.dts b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
index 5396556..7b6faf2 100644
--- a/arch/arm/boot/dts/uniphier-pro4-sanji.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
@@ -82,7 +82,7 @@
 };
 
 &mdio {
-	ethphy: ethphy@1 {
+	ethphy: ethernet-phy@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
index 8e9ac57..759384b 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
@@ -87,7 +87,7 @@
 };
 
 &mdio {
-	ethphy: ethphy@1 {
+	ethphy: ethernet-phy@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
index 8eacc7b..7e08a45 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
@@ -88,7 +88,7 @@
 };
 
 &mdio {
-	ethphy: ethphy@1 {
+	ethphy: ethernet-phy@1 {
 		reg = <1>;
 	};
 };
-- 
2.7.4

