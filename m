Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FC2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B94020724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="F5x+C77F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbgFWLr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:47:29 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:54208 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732333AbgFWLrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:47:17 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 05NBkITt013767;
        Tue, 23 Jun 2020 20:46:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 05NBkITt013767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592912778;
        bh=a1oq3G0+IN6r2ThnZyGowxmB8YiYcAAiL6PsYWGc6yU=;
        h=From:To:Cc:Subject:Date:From;
        b=F5x+C77FgOQ4e1HXRb+YP7DyLN/M9W741RN79JGv465QRaXylnlIgALm79G2Gt3hQ
         4z1ArvgvTcbIpQ4vFoDXVHwgrFiKlQnAPM95u0LQQKEiz2m3utq6q0RSxfALHczZ2j
         gk2GLwiPuPPJQ08rotJE8NLzjc0UdpeUPheYBSp84A3vmCC51QCrqOabrSgkG8d1TN
         dpF0HiBBbmsW+D/k6qZ2o8GKhbkridUIx/bsbAELcatvzW3MelqwGr28PICwGFcWwX
         1QTbQh39o7f3/JeEbEGpysvxUZab6ftiVTPy/iwxqBf8WihDyFDxs7vIHO0npXAGHq
         L+C8lbAbDEn8w==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ARM: dts: uniphier: add interrupts to support card serial
Date:   Tue, 23 Jun 2020 20:46:11 +0900
Message-Id: <20200623114614.792648-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e69f5dc623f9 ("dt-bindings: serial: Convert 8250 to
json-schema"), the schema for "ns16550a" is checked.

Since then, 'make ARCH=arm dtbs_check' is so noisy because the
required property 'interrupts' is missing.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4-ref.dts  | 4 ++++
 arch/arm/boot/dts/uniphier-ld6b-ref.dts | 4 ++++
 arch/arm/boot/dts/uniphier-pro4-ref.dts | 4 ++++
 arch/arm/boot/dts/uniphier-sld8-ref.dts | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ld4-ref.dts
index f2d060f403cc..bac922499205 100644
--- a/arch/arm/boot/dts/uniphier-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld4-ref.dts
@@ -39,6 +39,10 @@ &ethsc {
 	interrupts = <1 8>;
 };
 
+&serialsc {
+	interrupts = <1 8>;
+};
+
 &serial0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index 079cadc11e6c..e0136846ee94 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -42,6 +42,10 @@ &ethsc {
 	interrupts = <4 8>;
 };
 
+&serialsc {
+	interrupts = <4 8>;
+};
+
 &serial0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index 181442c48532..22d7150a1eb7 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -42,6 +42,10 @@ &ethsc {
 	interrupts = <2 8>;
 };
 
+&serialsc {
+	interrupts = <2 8>;
+};
+
 &serial0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-sld8-ref.dts b/arch/arm/boot/dts/uniphier-sld8-ref.dts
index cf9ea0b15065..0ad22af4294f 100644
--- a/arch/arm/boot/dts/uniphier-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-sld8-ref.dts
@@ -39,6 +39,10 @@ &ethsc {
 	interrupts = <0 8>;
 };
 
+&serialsc {
+	interrupts = <0 8>;
+};
+
 &serial0 {
 	status = "okay";
 };
-- 
2.25.1

