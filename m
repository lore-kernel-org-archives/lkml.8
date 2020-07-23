Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1F9C433F1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F44D206E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQ0bNcNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgGWP1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgGWP06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:26:58 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943DCC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:26:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so5556445wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3Az9OepR2BdTDAPEdWN7LwMsA5P61TmIGuTZB4zgG8=;
        b=dQ0bNcNHpnx9qpWEBFvn7k8BSJ2+ODBoKIGwRh8WJxScokmdsmED6rZDIst+EPX73+
         IDDU64ZC9K0ihBDdbvtkjDopIVWL++lUhyeRvE1y1WGtDBZY71hjXDm84zKIj44QDyS/
         QixwlMZJ4P0+GvPv9cGPqCLIpGUob9YCuBrBuyZk2xKm8jYOQNElQCkudTwJyeftVOgj
         BcybaEjwi9sQTAZvYtaepJP8A4953wsmbvhodkgh3DC0UE7JAwH2//Gr97lxGDF5F1iC
         g9Sq+FbIp/Hya2TDm9DioJ5j5tu20mfUOJJQ2xr7x5BtGOyT0g1MpcJbIkuWuX4raguH
         oOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3Az9OepR2BdTDAPEdWN7LwMsA5P61TmIGuTZB4zgG8=;
        b=dUuScxemGTvQz43cfRNz9SAcDNiJmuogqSfgE0YyDKQ6EAw2okB9Sf88R8mm7ZL8Ax
         NRrX8YdDGaIVf4D3CHgWPPwksc/uOmPYO5dMtf3q4LBAgvyBD80q5awgFN5XCETg5xOM
         7V63Rv9x4w8kiHnoTFVDahKzNscIlzHoUCBuXzgHdvSa5HhTk7ZWAFEYVGLuJ0bci7LD
         vTgY8vF3yeDZd85NRaiEJEN04iOzspAzzGTDU9ZvoFeZmDKHPNnhLJEGkCWc4lQD5wz8
         UbGyqLrIXqQA6Co9dWVt9WI1hmFimA0E8xr6joSGd1YEQUIDOGaDClwHOha4rz9b4X44
         F8KA==
X-Gm-Message-State: AOAM532Nhg2QwqQeI7pW1KtJMvnHb3P3XohrjfJvL99wmUIgtueUo2L4
        awt8/22TXqUN+pYZcAhDe5vbSQJVagPbIg==
X-Google-Smtp-Source: ABdhPJx6Y0KCgNUV6vyevzLdntNlIy25yfdHe+xPNK9dHmUZ0jPqL/DqTZacB9I3mfa7338G1RCmeQ==
X-Received: by 2002:adf:c108:: with SMTP id r8mr3999574wre.41.1595518017097;
        Thu, 23 Jul 2020 08:26:57 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.gmail.com with ESMTPSA id g145sm5963491wmg.23.2020.07.23.08.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:26:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 03/16] ARM: dts: at91: sama5d2: add TCB GCLK
Date:   Thu, 23 Jul 2020 17:26:23 +0200
Message-Id: <20200723152639.639771-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723152639.639771-1-daniel.lezcano@linaro.org>
References: <1b1122f4-bce9-f349-e602-ed8e14cbb501@linaro.org>
 <20200723152639.639771-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The sama5d2 tcbs take an extra input clock, their gclk.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-4-alexandre.belloni@bootlin.com
---
 arch/arm/boot/dts/sama5d2.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index ab550d69db91..996143e966d8 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -499,23 +499,23 @@ macb0: ethernet@f8008000 {
 			};
 
 			tcb0: timer@f800c000 {
-				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				compatible = "atmel,sama5d2-tcb", "simple-mfd", "syscon";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0xf800c000 0x100>;
 				interrupts = <35 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&pmc PMC_TYPE_PERIPHERAL 35>, <&clk32k>;
-				clock-names = "t0_clk", "slow_clk";
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 35>, <&pmc PMC_TYPE_GCK 35>, <&clk32k>;
+				clock-names = "t0_clk", "gclk", "slow_clk";
 			};
 
 			tcb1: timer@f8010000 {
-				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				compatible = "atmel,sama5d2-tcb", "simple-mfd", "syscon";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0xf8010000 0x100>;
 				interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&pmc PMC_TYPE_PERIPHERAL 36>, <&clk32k>;
-				clock-names = "t0_clk", "slow_clk";
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 36>, <&pmc PMC_TYPE_GCK 36>, <&clk32k>;
+				clock-names = "t0_clk", "gclk", "slow_clk";
 			};
 
 			hsmc: hsmc@f8014000 {
-- 
2.25.1

