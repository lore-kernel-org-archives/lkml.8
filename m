Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3033FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0750C206F8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR8b3ssB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgDERgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:36:14 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:46791 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgDERgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:36:10 -0400
Received: by mail-wr1-f54.google.com with SMTP id j17so14539095wru.13;
        Sun, 05 Apr 2020 10:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TEi0J3UBiq8vdVnxTQ1Q5/nSVsD5Pu06tmZXPEEYVFw=;
        b=gR8b3ssBGDBZKNtMbo2zQGR7V9I3b1vIswpq8CnMG8ckn2lKjT31RIDHHTblxjdY2N
         wWVtQk6SS2XCL7YTSlrWo0LxhPFQ9G3ZaPAUsm5O+ngF0KtBxFgxdb+5tSO/QL4CVk5O
         u4sOenFo7/QBl4a5VYRbfpi/UwS/QNHIs1xVjEYHPEm3cXD+r3zqHUMB32xmQ3cLV5jW
         RikMbrKR+WBaWhy4CNpRc4eZRTdRPf/k94EZQ4OzBrAg8wLZOeYPafr+C8DQFIPtDMDa
         3y/M2Cs+n15G8lelCLKFvTY0iZRXOSQhzROBbvjeamOvlCp6ZJQTJ0sJ/0wKZ6HNSTMI
         5ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TEi0J3UBiq8vdVnxTQ1Q5/nSVsD5Pu06tmZXPEEYVFw=;
        b=AeZuFQ1Gfc/JvO+IofZmIIXPYD28B5+cC76m23AC4x/uBxELBtYeekjfaF996fmFxE
         Nn34iTfOyIYljmrE16FMX+S72TQyteHPD8S27nSuNigDfUhI3/uvxcBYAWaFqutw9Fdg
         BqKZTRFzJjjbopEcHgKA07HNWQ+UYwneD80lyy8+16iWgKzmD7yPqBmx1rucLCA5f6EA
         vS8ikKRVDBW5F+ZRZEntnU7TyavwetUdxci/Sp45vIjmAHVUb+GOvLp5lgG3bPfYRyKG
         BVaRHZDzTXenVqgGE6+e5jfph+Xom68btnOsYyg8zqeeOGWoZcVEhNxM5QoI7MJCZSIw
         wtnw==
X-Gm-Message-State: AGi0PuZWTWc/OGvIWChiOUYHT0XsfxpGmxYVbm+yFclRKmnli2tamCMt
        ShEY3O9djLMoNhsGHRpZDOw=
X-Google-Smtp-Source: APiQypKwD9uIJYm9/anjRKF+p2LvSFBv1h86WMAmm+T4S0HxK/9HxXvlzcvm3Ol+7b9xes1d1948PQ==
X-Received: by 2002:a05:6000:a:: with SMTP id h10mr20891310wrx.226.1586108167224;
        Sun, 05 Apr 2020 10:36:07 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id s13sm6031669wrw.20.2020.04.05.10.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 10:36:06 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Ondrej Jirman <megous@megous.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 2/7] arm64: dts: allwinner: h6: Add thermal trip points/cooling map
Date:   Sun,  5 Apr 2020 19:35:56 +0200
Message-Id: <20200405173601.24331-3-peron.clem@gmail.com>
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

From: Ondrej Jirman <megous@megous.com>

This enables passive cooling by down-regulating CPU voltage
and frequency.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index aef4ae760d5e..e0dd0757be0b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -908,6 +908,30 @@
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 0>;
+
+			trips {
+				cpu_hot_trip: cpu-hot {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_very_hot_trip: cpu-very-hot {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				cpu-hot-limit {
+					trip = <&cpu_hot_trip>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpu-thermal {
-- 
2.20.1

