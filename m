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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F66C433EC
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612602076D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9q4k/1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgGRG6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgGRG54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:57:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0DCC0619D2;
        Fri, 17 Jul 2020 23:57:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so17733672wme.5;
        Fri, 17 Jul 2020 23:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6vYF1uN6y1MEmfx/aSCmf3xT19pRJOVeWursMQGhdC8=;
        b=r9q4k/1UmOpnNBFOhm8kzTNUat2F0iPzWuggKmToYGhPmp4mQRg8S0msDjtyjs+qYm
         b4DwLCCVNLlFSgL3gQ52FWkH69J6TOE2SPbhNNgvV9q+JEWpU8a5cxRzIT6sW/nbALXX
         QI291noBxQ43LnnDHCvUmvSie9eHV73krHsCkYf8YeNxYxnTOJCG3OFEuH0bHKTOpk9u
         Vzh9JWpKWOoKIz5p4BpUnEtMsqVt6MJ3Pi09bpg8xiOqwpH8UGv+uagQIDNi0NjwVRM7
         wv+pRjtzGbD327/2zzmCwMTfDwaCJ67CzeNnT0370VkOlPMd2Ps+MSQzYLpSvUHYEO4J
         2PVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6vYF1uN6y1MEmfx/aSCmf3xT19pRJOVeWursMQGhdC8=;
        b=infjwM69fHwHBuoh6rI/VcdAr6XA2vCNbn3V1NoLs/CUUkBDB7BpPWbKxJdwz8H0+F
         +JzYuvecwVknGU9eF7ZcbwKafMXzvG1fY6mdEK/+4nqhQcMQfwulwXJmukV4cf4cAkVA
         WJUgEG42s5tAq5G9M2GKYvQIMv1tC8vpB3K5M6ESRmvD4pIgjCt/Cdv9NBqh62JEv1eB
         LHLsasnGw5jNFdAg0E3ixfrG8jwzyjmuXNgz/c++BWvsOK7FNyODnrvdDLnChJCxTo1o
         9Ibq0M4l/W95ulllsFaVBm80DRZHtx8mt7S1g5qSHq7ijuxDQvVyN3XlgJ7S6vGjx5yK
         ajrw==
X-Gm-Message-State: AOAM532NCsnqS546Ytj6vKTigeHgm2qnqtjdkvpU5sqF6B9/rMLhMeqU
        iybV/KJGFn+fXp940Y9g5OA=
X-Google-Smtp-Source: ABdhPJxdylbi50zUlqb1YYOa/Ff6SMhJbfn7P8x62EDO+8C6uMeUywN98DVmiDvFARfD4Pn7nGRWdA==
X-Received: by 2002:a1c:2183:: with SMTP id h125mr13322903wmh.83.1595055475237;
        Fri, 17 Jul 2020 23:57:55 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x5sm18749191wmg.2.2020.07.17.23.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:57:54 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 05/12] arm64: dts: meson: add audio playback to odroid-c2
Date:   Sat, 18 Jul 2020 06:57:32 +0000
Message-Id: <20200718065739.7802-6-christianshewitt@gmail.com>
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
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 70fcfb7b0683..9d8c919c6e19 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -9,6 +9,7 @@
 
 #include "meson-gxbb.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "hardkernel,odroid-c2", "amlogic,meson-gxbb";
@@ -172,6 +173,45 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXBB-ODROID-C2";
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
 
 &cec_AO {
-- 
2.17.1

