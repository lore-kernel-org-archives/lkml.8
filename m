Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61B2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8B12065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="k2uS7I0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGGKdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:33:49 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:40287 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGKdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:33:49 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 067AXFdU008062;
        Tue, 7 Jul 2020 19:33:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 067AXFdU008062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594117996;
        bh=G0rt4n1WWH00Z02oulwwHc7NFZd6TJTCR/gKUlXUUEM=;
        h=From:To:Cc:Subject:Date:From;
        b=k2uS7I0+c7MjG9Y7MjhMIZLpHiynGxMjl2ynirQDCVieyPU11+RrTOBrGsNfusiOH
         DR+YMsbAoSATf2sxph+rfena8BJjmmNLUHd4Rnpf9uGTvc+RiE++g4BTbjBgFqJ/SZ
         /tlxRNH+xSXYDJI3kocLktZok4uoJnemNwhG8dSaA7SfxT5ps2XFJMOxxMmVipEWRX
         ZAqH+Sjsq44CVE+JaWb4DjFRR1zCYK7M+OyzNaz8HeBsxJF4/e5Drsu9Mq0QnXLf4M
         Icmo4x1nMNO+lbIjo/iTLwoSLFB6YALnw6VBglOHQgzwfmxMUd0l3t/MbWCeW1KNQ8
         i4DBdyrS3hMXw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: uniphier: give fixed port number to support card serial
Date:   Tue,  7 Jul 2020 19:33:11 +0900
Message-Id: <20200707103311.991098-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add this to the aliases node to make it more convenient.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4-ref.dts  | 2 +-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts | 1 +
 arch/arm/boot/dts/uniphier-pro4-ref.dts | 2 +-
 arch/arm/boot/dts/uniphier-sld8-ref.dts | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ld4-ref.dts
index bac922499205..c46c2e8a10a7 100644
--- a/arch/arm/boot/dts/uniphier-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld4-ref.dts
@@ -20,7 +20,7 @@ chosen {
 
 	aliases {
 		serial0 = &serial0;
-		serial1 = &serial1;
+		serial1 = &serialsc;
 		serial2 = &serial2;
 		serial3 = &serial3;
 		i2c0 = &i2c0;
diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index e0136846ee94..e1828b2de89b 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -22,6 +22,7 @@ aliases {
 		serial0 = &serial0;
 		serial1 = &serial1;
 		serial2 = &serial2;
+		serial3 = &serialsc;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index 22d7150a1eb7..b8eaef2b9985 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -22,7 +22,7 @@ aliases {
 		serial0 = &serial0;
 		serial1 = &serial1;
 		serial2 = &serial2;
-		serial3 = &serial3;
+		serial3 = &serialsc;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
diff --git a/arch/arm/boot/dts/uniphier-sld8-ref.dts b/arch/arm/boot/dts/uniphier-sld8-ref.dts
index 0ad22af4294f..6db949ec7411 100644
--- a/arch/arm/boot/dts/uniphier-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-sld8-ref.dts
@@ -20,7 +20,7 @@ chosen {
 
 	aliases {
 		serial0 = &serial0;
-		serial1 = &serial1;
+		serial1 = &serialsc;
 		serial2 = &serial2;
 		serial3 = &serial3;
 		i2c0 = &i2c0;
-- 
2.25.1

