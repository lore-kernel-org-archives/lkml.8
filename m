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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E92DC433F7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753BF2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WENSboNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgGRG6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbgGRG6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:58:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F013DC0619D2;
        Fri, 17 Jul 2020 23:58:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so20467581wml.3;
        Fri, 17 Jul 2020 23:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DR+MN9yI45B0CbPas30C2sDxsoxmrDbz6ZTE82Yi1YU=;
        b=WENSboNWqFEFKMhQ1tpuQelRMJAoIzuNKBQN5XrO86dudVwcu92a3aNhzf/hlGc70C
         99QuqYIR8SsFjoVQgDKKzVGUrP4+ay/lkffYF0gtdz02LOYtjut8md2FNXS04mJsRS2o
         FKK5iZs2FO/SJGqeip0SksH48C2emf6ivIjUSa9R48xoh6LzVmZyv0BwFC4VDA/ow4un
         S8tOWLsQGbZ5UNLWIWQIZo6hoXZwjY0XIcLO4XR/kj/wM/FZ9KF1x+/ryHYkCYaTQJIT
         mvGkLlP4D3O7uBc2jdIoLUW+EmFLc1FEDftrBQzCMOxAXBkFyApgX3u020lCf+QzlV+u
         92ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DR+MN9yI45B0CbPas30C2sDxsoxmrDbz6ZTE82Yi1YU=;
        b=eVuucsUH92CqtaGhQeI6NXpuPhQjnn8rPDC73W6O6/UGp5g4yIraL4cprjgYxHtcV1
         nOOi9IPrKNrOkIQys2I32Wrbu1RRYn7JEm7r6jS2w/TyX3naOmiM6hlpGWKlQS0lv9Tw
         1Gpm+vkbSONgfs3ZgyOUWQFJh11JexkyzA04t2IBqZrsnB8F6mw6WoCJsDDW6zuUsaeF
         4lOE7Nph0yg3U0griMqIIWh1vQzXWZx5nWEicv1/igTaC39niGBOioF26hURr3pE+4FV
         pGTqS04K9pVSiAXzJfaDYLQD3n5QqU0AxTMsccFmAiMtk7IixLDgZ2TYpLuu3RB0LDFC
         t5iw==
X-Gm-Message-State: AOAM532FlqjrOcAGd2xhbu032O/0EVpzZL/TSyR5uCnFLwu/YJfXG7cJ
        bygibEoAQbufadc+etYjC2Bg3aNO
X-Google-Smtp-Source: ABdhPJweouzzfuZ/Hx+GE+ZOtOp3U/VJVa4dJNLXiSlFEcR7hnZHpn2pOAOKEreYUvRVMOyapB6v0A==
X-Received: by 2002:a1c:dfd6:: with SMTP id w205mr13231447wmg.118.1595055481607;
        Fri, 17 Jul 2020 23:58:01 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x5sm18749191wmg.2.2020.07.17.23.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:58:01 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 08/12] arm64: dts: meson: add audio playback to p212-s905x dtsi
Date:   Sat, 18 Jul 2020 06:57:35 +0000
Message-Id: <20200718065739.7802-9-christianshewitt@gmail.com>
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
 .../dts/amlogic/meson-gxl-s905x-p212.dtsi     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index 05cb2f5e5c36..40776d42bf8e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -11,6 +11,7 @@
 /* Common DTSI for devices which are based on the P212 reference board. */
 
 #include "meson-gxl-s905x.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	aliases {
@@ -85,6 +86,45 @@
 		clocks = <&wifi32k>;
 		clock-names = "ext_clock";
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "GXL-S905X-P212";
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
 
 &ethmac {
-- 
2.17.1

