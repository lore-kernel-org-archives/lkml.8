Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F211C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A10120CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YUUYjval"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgFTQKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgFTQKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:10:24 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1351FC0613EF
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:10:23 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w16so13545692ejj.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=orxvClwe2X1G6LLt220P18SzRHWKPs1DBn4J3ndLHzk=;
        b=YUUYjvalbkovpygqyDgaPEV7N9U2IPmmAXOai69kZglvy+h2R3uKIrIQee89/1FLRY
         GvTGfvbO0udWlLhVHtMvHntmxj2Rvh7lIYbj3KiDps+ylKwTBtSKynQz46m3sp5UddNJ
         LAZrq8LsQ6BQwT7KOqDe13dwbDo09+fdZO/6pO60GealIKm6TYZeSLnw5i4ZjLImW7ZN
         F9UTiwOujDit0cRM7zugBQhTTA1UkMfzfo0lt+Y9tbLK1n1eo0FytuNSe15isnoEV633
         zzJMug2C8hB3MP6wlogp3HXPtt2h9dIw9HMB3GvxvZOyUyov7hpx3s4/PFLkzPNA+I0K
         PRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=orxvClwe2X1G6LLt220P18SzRHWKPs1DBn4J3ndLHzk=;
        b=IqxmSsg/S8G+/lVWyP3ALJiit5nVUWHVlELXOJ2HerG8dDHx9vDEAPFWkPeICEAsZI
         UespDWJhE97NZgWMi9JWcZQ3nLxXw0AkZs76x7q+uhgbWYvaOhKefKeCCMU9eQ7fa+O5
         NcRECuvJHWouI1DTOr7XySKTQJaUVokHid+wa9oALfgkYHBTj8jgBae/V6CdGX9tLi2W
         NfWWotopLi0Wxe1Cc8HXiKeLwlGNx3MtlDmN+8pLph7AVPY/6/dz+CeXCydaNr3zDy8I
         Ls/DUBJb0Zh4zGDWLC8nIOp/QZnOTBk6k9v5Q/uske+7zJtU++IzgA4mukFdkBTbFzPz
         yujQ==
X-Gm-Message-State: AOAM5308HlnEKCh40i2FU9rMpCObG5dSMPgSKbQ1c9gBIE23QerXoJbO
        ZZmynJj0sFyRWjB0nNy55N0=
X-Google-Smtp-Source: ABdhPJwcmrBNH01zMxqTshJiUr2AslvrntLjBXS1qW9UDYE1kESSIvl+rlvq9nY/RaNdZ3eqKoAtow==
X-Received: by 2002:a17:906:e298:: with SMTP id gg24mr8377986ejb.120.1592669421795;
        Sat, 20 Jun 2020 09:10:21 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371df700428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371d:f700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id a62sm8033207edf.38.2020.06.20.09.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 09:10:21 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] ARM: dts: meson8b: add power domain controller
Date:   Sat, 20 Jun 2020 18:10:10 +0200
Message-Id: <20200620161010.23171-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620161010.23171-1-martin.blumenstingl@googlemail.com>
References: <20200620161010.23171-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Meson8b SoCs have a power domain controller which can turn on/off
various register areas (such as: Ethernet, VPU, etc.).
Add the main "pwrc" controller and configure the Ethernet power domain.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index ba36168b9c1b..2069c57343e5 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/meson8-ddr-clkc.h>
 #include <dt-bindings/clock/meson8b-clkc.h>
 #include <dt-bindings/gpio/meson8b-gpio.h>
+#include <dt-bindings/power/meson8-power.h>
 #include <dt-bindings/reset/amlogic,meson8b-reset.h>
 #include <dt-bindings/reset/amlogic,meson8b-clkc-reset.h>
 #include "meson.dtsi"
@@ -433,6 +434,8 @@ &ethmac {
 
 	resets = <&reset RESET_ETHERNET>;
 	reset-names = "stmmaceth";
+
+	power-domains = <&pwrc PWRC_MESON8_ETHERNET_MEM_ID>;
 };
 
 &gpio_intc {
@@ -449,6 +452,30 @@ clkc: clock-controller {
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};
+
+	pwrc: power-controller {
+		compatible = "amlogic,meson8b-pwrc";
+		#power-domain-cells = <1>;
+		amlogic,ao-sysctrl = <&pmu>;
+		resets = <&reset RESET_DBLK>,
+			 <&reset RESET_PIC_DC>,
+			 <&reset RESET_HDMI_APB>,
+			 <&reset RESET_HDMI_SYSTEM_RESET>,
+			 <&reset RESET_VENCI>,
+			 <&reset RESET_VENCP>,
+			 <&reset RESET_VDAC_4>,
+			 <&reset RESET_VENCL>,
+			 <&reset RESET_VIU>,
+			 <&reset RESET_VENC>,
+			 <&reset RESET_RDMA>;
+		reset-names = "dblk", "pic_dc", "hdmi_apb", "hdmi_system",
+			      "venci", "vencp", "vdac", "vencl", "viu",
+			      "venc", "rdma";
+		clocks = <&clkc CLKID_VPU>;
+		clock-names = "vpu";
+		assigned-clocks = <&clkc CLKID_VPU>;
+		assigned-clock-rates = <182142857>;
+	};
 };
 
 &hwrng {
-- 
2.27.0

