Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1304C2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8864F206F5
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INC92HEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgDERgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:36:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55621 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgDERgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:36:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id r16so12336342wmg.5;
        Sun, 05 Apr 2020 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=953t16PaqsK6LcXl7SedQvIrbO2yGs6c/tDrXm7TIhc=;
        b=INC92HEziM9mI7F9DsK0oDiYSAUcj61mUM8QOERk6Pzc3RsAR9n5EvgY19wVTuuVJW
         KUdW4Pw9qQTehhyANrM6Y/7tIrdr8IQ5puN+/SYfboKxMPTycx7/JIWUsvHG94Zi1UjD
         QgMC22w8FBqy6/D+Ce0SZWlY3xfQBuPljKmyS+JPy41U4iTSnjExPt/csQDBypU8rkll
         tT3X54jPxnPZ25hlCDArG/0Z5iJ/yqhBQp52wlYlZ+EQVviDPToZINJUgwSvCfP75cOj
         IBEL9uCueNVqRvrRq62rHGwtbfK9Wc5poVN2YNDZtXQhjl7gwjn4ZvFaXz69l5mrz6Y7
         4PiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=953t16PaqsK6LcXl7SedQvIrbO2yGs6c/tDrXm7TIhc=;
        b=YGFvq0ZiulRM1hyXe67EfSUhOYAM+a1dBUvX65MC2HycA7FlUK4xQ8snXwfGw7JvZa
         hifsLXH3oZbEMJwDSCRzJpvKj+DIhQP0zdjDFYST+8as3jmmGgsuoGZy+5r3XQ1/8k6B
         g8wljS1rX5+kNWSok9THlPDyMK/Qke8MS0j49FXn19jEzhfQuwYA6FqeMYbSiJaUyZHl
         bd4Cd7mHcpaQD4OuwHVkBaVfb+sPEIokeOV+I5DQ/bwFRaj7ET1dA5+4sAB+po7hKitH
         4arKgDCSZzUBS+82cmU+bDE/Dk9MS/n3Q2XlBYCCYMmqOIVpR/C0VsIHyA30kbvKYjd5
         a9GA==
X-Gm-Message-State: AGi0PuZS5Ibp/ALYUJZjIWmgGtS/+sfE73sk+TmZ7LGMlKQnIRt+BTfn
        vYqBYA5SmAKogl8FMz/LhBE=
X-Google-Smtp-Source: APiQypJrXfDDMcyPXVi9s8+wzP9CVxUi8k0MrgpcBSdXs0lTPfVzTDwTJhHxIg22NnyET3Xt6c/8yQ==
X-Received: by 2002:a1c:4409:: with SMTP id r9mr4398898wma.165.1586108166066;
        Sun, 05 Apr 2020 10:36:06 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id s13sm6031669wrw.20.2020.04.05.10.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 10:36:05 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 1/7] arm64: dts: allwinner: h6: Add clock to CPU cores
Date:   Sun,  5 Apr 2020 19:35:55 +0200
Message-Id: <20200405173601.24331-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200405173601.24331-1-peron.clem@gmail.com>
References: <20200405173601.24331-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

The ARM CPU cores are fed by the CPU clock from the CCU. Add a
reference to the clock for each CPU core, along with the clock
transition latency.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 3329283e38ab..aef4ae760d5e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -25,6 +25,8 @@
 			device_type = "cpu";
 			reg = <0>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu1: cpu@1 {
@@ -32,6 +34,8 @@
 			device_type = "cpu";
 			reg = <1>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu2: cpu@2 {
@@ -39,6 +43,8 @@
 			device_type = "cpu";
 			reg = <2>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu3: cpu@3 {
@@ -46,6 +52,8 @@
 			device_type = "cpu";
 			reg = <3>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 	};
 
-- 
2.20.1

