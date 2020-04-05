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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F74C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F88A206F7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFZqux8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgDEKtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 06:49:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41468 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgDEKtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 06:49:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so13867287wrc.8;
        Sun, 05 Apr 2020 03:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T2ox6yFqqUNTyQRjV1Y6BWeD23De5Y0nxhCOsLLOIKs=;
        b=dFZqux8Kt58ZD1nl1pEsS9jGttw4fQIvzoSx1sxe9av3Ci7uCrIEHOIXvDyxTKgdzb
         0/0N+3iC8p/HpM1qtAttoL1O1FPIGj98M/BJSzds66yp0N+NbyG/SSooXpVurt1yII7x
         R703o4PdqnM9DRHTkkj3mmOQl/GrDMAUewk1niAHwEn+w5IcBVaWf8EwGIlkcEaFEo/K
         PTInczeA5IZ86qLOGWu2bayHLi2dwb0/r4wwsIEAoLJVAxZyt2gmqeHDsxXqC/rR/jCJ
         CrDcqDZtlxNfDIvLztGZcNpJtG0HjGUtnN9nPealj8ORDrgxOmPnUIdWYCtoLneCmm+N
         B1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T2ox6yFqqUNTyQRjV1Y6BWeD23De5Y0nxhCOsLLOIKs=;
        b=V9H5Io3Bx9dULP5EOc6rmahv1eteQM4JXlGQAglZRYWS2UyTT6WBAfa/9GWlFZpFpW
         yQTddina82uCryEXiNLZ7/LEuVlhVdvW9mwqxZerqhY99L9p6shThMRVHJi06uLZ1rek
         WkUcHaMlTbABwnzp6PiPxQbCCE5DkFqP129hWyFLz46xHjRrIxYCsxJQmDefgyme4d/B
         7ZjAIW1u/I8QSP4TnM627MD8zS0jpLXxce2yogAYvHiFni3c4UnrQktxlDjaCl9DbjpG
         hJ8xbgxffNlzZCx8mRwfzwcVu64oY5j6sgEKkDRiswHpqa10FwZ3qk6CG3Yn7OK8H4eu
         oBrw==
X-Gm-Message-State: AGi0PuZ0aiIxRRcgyPvB/94msRAMIDW6mnlqX+xDjbP73EmZ48DsegzM
        S8L5tnqgLdFtcCvFVC7kcdE=
X-Google-Smtp-Source: APiQypJ+aVzIiRh0H4IA7SAjs61Pv2FJlbjUyc95b3MQCNX7BWoOWhIjm68s9zmbsLp/uFKpTEJHGg==
X-Received: by 2002:adf:f74d:: with SMTP id z13mr9260727wrp.55.1586083758486;
        Sun, 05 Apr 2020 03:49:18 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id u13sm21606411wru.88.2020.04.05.03.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 03:49:17 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Ondrej Jirman <megous@megous.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 2/7] arm64: dts: allwinner: h6: Add thermal trip points/cooling map
Date:   Sun,  5 Apr 2020 12:49:08 +0200
Message-Id: <20200405104913.22806-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200405104913.22806-1-peron.clem@gmail.com>
References: <20200405104913.22806-1-peron.clem@gmail.com>
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
index aef4ae760d5e..d4d3963705f5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -908,6 +908,30 @@
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 0>;
+
+			trips {
+				cpu_hot_trip: cpu-hot {
+					temperature = <80000>;
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

