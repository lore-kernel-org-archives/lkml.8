Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86D9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4EDB2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HK8u7Agj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgGJHoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:44:17 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:43256 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJHoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:44:16 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 06A7hQCU009644;
        Fri, 10 Jul 2020 16:43:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 06A7hQCU009644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594367007;
        bh=XzgmZfHGbIg/7Bx4Qqjl6MK0bxbloahArh6T6eyAMM0=;
        h=From:To:Cc:Subject:Date:From;
        b=HK8u7AgjGGJCOEBySXc3+AJacIfrRJ34tZvG08tSJYzTeDP9H4JKqolNL5/0c5PsI
         iFJXBufT7kunBigrBsb0uABb3vqUwClCnbQZ86L6G0E/bRZ8T5sfMthBBhAuzagf35
         W1/ei07Lb2tfXI8IBLbIjq15hbHUyIVrsziVkNJd/WIIrInWDnev+jj1HgJu3edfS3
         NZLu4Ky3fjGQ8Ib8igASaXOmMqec7DOqJvcEaiqU8u+Xgk5YKwvM/30Rktsezu/bb7
         TF6tvR/FzgnwJXYHTFG+kl547I9HUbfbPf2rmEjOTjvRfsSVtArIH5gxBTlTZ1cE/J
         n2G71W7igpSJg==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: uniphier: remove support-card node
Date:   Fri, 10 Jul 2020 16:43:23 +0900
Message-Id: <20200710074323.296007-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device hierarchy is needlessly complex.

Remove the support-card node level, and move the ethernet and serial
nodes right under the system-bus node.

This also fixes the following warning from 'make ARCH=arm dtbs_check':

  support-card@1,1f00000: $nodename:0: 'support-card@1,1f00000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-support-card.dtsi | 31 ++++++++------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-support-card.dtsi b/arch/arm/boot/dts/uniphier-support-card.dtsi
index 11e46e7de7c5..444802fee9fb 100644
--- a/arch/arm/boot/dts/uniphier-support-card.dtsi
+++ b/arch/arm/boot/dts/uniphier-support-card.dtsi
@@ -8,26 +8,19 @@
 &system_bus {
 	status = "okay";
 	ranges = <1 0x00000000 0x42000000 0x02000000>;
+	interrupt-parent = <&gpio>;
 
-	support_card: support-card@1,1f00000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x00000000 1 0x01f00000 0x00100000>;
-		interrupt-parent = <&gpio>;
-
-		ethsc: ethernet@0 {
-			compatible = "smsc,lan9118", "smsc,lan9115";
-			reg = <0x00000000 0x1000>;
-			phy-mode = "mii";
-			reg-io-width = <4>;
-		};
+	ethsc: ethernet@1,1f00000 {
+		compatible = "smsc,lan9118", "smsc,lan9115";
+		reg = <1 0x01f00000 0x1000>;
+		phy-mode = "mii";
+		reg-io-width = <4>;
+	};
 
-		serialsc: serial@b0000 {
-			compatible = "ns16550a";
-			reg = <0x000b0000 0x20>;
-			clock-frequency = <12288000>;
-			reg-shift = <1>;
-		};
+	serialsc: serial@1,1fb0000 {
+		compatible = "ns16550a";
+		reg = <1 0x01fb0000 0x20>;
+		clock-frequency = <12288000>;
+		reg-shift = <1>;
 	};
 };
-- 
2.25.1

