Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8793CC43446
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CBA20724
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLVfAbEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgGRG6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbgGRG6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:58:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7654FC0619D2;
        Fri, 17 Jul 2020 23:58:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so13287590wrs.0;
        Fri, 17 Jul 2020 23:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+sbzGxZrB59pV6U+pYub8QGMoi1y6WlUsM0RAR+NpTo=;
        b=MLVfAbEEt8OAz+5SAcw5V9iCQGbToqL+cmlSIIL8EpSA5td5CPH+5VRKLJ1yqXeMNK
         SzgM3CMnrxFlqh42qGcDI48MkYDTAgACq+2sa/8OcFzSi097xlhleH7JcH25pC/h55QB
         RS81OLa3zJ8ip/sWEf6dYPZBbdEylZpZjwDebRMra5YFEgliCzfnerO5rY8hvyMaRaqN
         89DZCM2CS71AcUqH43J+kAeuGlS/jc+O7SIle0NI5gmVQb892V5Xentb5B5s7Qta3tQL
         jGNXwoamC+JYy85rOlDgOAs+AEGuK+t6p4cYBtSLMAsDV+gO3ITZrbxyLInK1DRfLow+
         tIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+sbzGxZrB59pV6U+pYub8QGMoi1y6WlUsM0RAR+NpTo=;
        b=RHJgZW54H84WJMalQhffmi/BL2//I0t05oq1mFe45OJ9h4J7JHxlXU4lbI7Mpf2Ann
         GVctVLuLgqZPiWmYTzOtV9ylJVcjXvFAsaMX/aSKWgGgKQ6d3CKtXk0vD65eN7CwuE9f
         ekm6xiel1TTDEUiurfsQGPskhktomj4pU93gR8NIsbdtkC9Ntc/EhV5gsKpKC4dwu8md
         jj75wbfMUEQ5+W+hhHCV44agY1AbrO58jyQIYYle0iio1iNdzSZT15veqEV8TNWaxqbi
         FteGzVrYc82ug5ykWLHZnrunZFCHbVpaprUU6siHolVTaA8KeoEznS9f4/3RZUGkx2jP
         fJ+Q==
X-Gm-Message-State: AOAM531+T7raE7tYVS7S8M1BpTUy06wtu85mY3lrsXMC31SJ4+y7bBBv
        Oj1TBdQB0NXNKGU+VUkgh5s=
X-Google-Smtp-Source: ABdhPJzzF7AVveOnVICfgyrqrnbw/GMJl08joyt9cIy/Hji+DY2GExCAGi3oh67Ji1N4fp8pOjJmyw==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr14296531wrw.16.1595055488234;
        Fri, 17 Jul 2020 23:58:08 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x5sm18749191wmg.2.2020.07.17.23.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:58:07 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 11/12] arm64: dts: meson: add audio playback to wetek-hub
Date:   Sat, 18 Jul 2020 06:57:38 +0000
Message-Id: <20200718065739.7802-12-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200718065739.7802-1-christianshewitt@gmail.com>
References: <20200718065739.7802-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
index 83b985bb015e..0c1570153842 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
@@ -7,10 +7,50 @@
 /dts-v1/;
 
 #include "meson-gxbb-wetek.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "wetek,hub", "amlogic,meson-gxbb";
 	model = "WeTek Hub";
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-WETEK-HUB";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&aiu {
+	status = "okay";
 };
 
 &ir {
-- 
2.17.1

