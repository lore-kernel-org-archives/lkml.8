Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FFCC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB36124955
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpBFv0HP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEHTKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 15:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgEHTKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 15:10:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCDCC061A0C;
        Fri,  8 May 2020 12:10:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g14so1783479wme.1;
        Fri, 08 May 2020 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0R1bpNtmiUv8laLb8N5wJf9G9BrMJmIpRltoZ1sMr8=;
        b=CpBFv0HP/TV6VMgbfdLKt5MNRpk4jZFc2VHOrfjwo7dVC8r9nSYnbILepI/Wp+W2sb
         G1O9oM6lngMAmvOgWlSfyZlDrQqwkHqJrQTiqBYPbs97qtkbxxo1Abk+TxSKFeDBPvY2
         61jNXBYJF+RxOxqivBi4nahv7H+DVwkyn76Eisr5oa5StnlaL4kLjP3EQNJXDEpM2nIc
         aaD71FCoPty3N9sC9hH+o1gN52Y595RChT+2nTUei2hy9LlpOrXqdVR621agdfh5Bn4I
         iBi33lwZqt8a6hgsL1AQR8gtNs+wtsLdOh5P4a2mldbNviqXmOFAFLMXgG058BYzMKDQ
         V8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0R1bpNtmiUv8laLb8N5wJf9G9BrMJmIpRltoZ1sMr8=;
        b=NR6XlA87XhYw/S4GN+TqPeLgaNmFSz6evYpRq5MZZZ6PXTvW9UbYuOOgPSDOmux+/2
         R5AP/tRY92ngWbtYe7Iq19DG4jcvRePPAVPJum4uXdCYVwrXugv5hPXs4CwCX7Jc4+Zo
         lEMPg4aqMnMwm6/ZYSct1fQKN9dRKDh72a45sja3HBjSRqIqabzrwo5G0ixB4fbXasRu
         SG07gNgV7zjaIcAlFk7BJ7xcMn8BHTR2Ye8QOoPFWqWnSUbi8dkgkWJXtLekEbYeMjL+
         SPQRdIcg1tVcVOs+JnYL+NOug1+WMuwAxkRaMdS4oPQWYYi5VL51vPoMCZuZ9OhLQmyG
         aF0A==
X-Gm-Message-State: AGi0Puau1uGEo02nMhGL88nDup/jh3eYvu08mZSGhK8H/Qajw7c8T9Q0
        cpHJ7vGDfTKf/VdnYHfRpxlYfzb2/PA=
X-Google-Smtp-Source: APiQypIqRYWKTbZrWqnb9ThiSmgx4OWhf8bQUmM8TucfI0KAH7NTdrcysk1wMpnZMoy/gyuRTsJVXw==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr17454575wma.138.1588965043831;
        Fri, 08 May 2020 12:10:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:29ef:df7c:92a1:e024])
        by smtp.gmail.com with ESMTPSA id 5sm14074670wmz.16.2020.05.08.12.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 12:10:43 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megous@megous.com>
Subject: [PATCH 1/2] arm64: dts: allwinner: h6: add voltage range to OPP table
Date:   Fri,  8 May 2020 21:10:34 +0200
Message-Id: <20200508191035.24276-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards have a fixed regulator and can't reach the voltage set
by the OPP table.

Add a range where the minimal voltage is the target and the maximal
voltage is 1.2V.

Suggested-by: Ondřej Jirman <megous@megous.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi | 60 +++++++++----------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
index dcb789519797..1a5eddc5a40f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
@@ -12,90 +12,90 @@
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-hz = /bits/ 64 <480000000>;
 
-			opp-microvolt-speed0 = <880000>;
-			opp-microvolt-speed1 = <820000>;
-			opp-microvolt-speed2 = <820000>;
+			opp-microvolt-speed0 = <880000 880000 1200000>;
+			opp-microvolt-speed1 = <820000 820000 1200000>;
+			opp-microvolt-speed2 = <820000 820000 1200000>;
 		};
 
 		opp@720000000 {
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-hz = /bits/ 64 <720000000>;
 
-			opp-microvolt-speed0 = <880000>;
-			opp-microvolt-speed1 = <820000>;
-			opp-microvolt-speed2 = <820000>;
+			opp-microvolt-speed0 = <880000 880000 1200000>;
+			opp-microvolt-speed1 = <820000 820000 1200000>;
+			opp-microvolt-speed2 = <820000 820000 1200000>;
 		};
 
 		opp@816000000 {
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-hz = /bits/ 64 <816000000>;
 
-			opp-microvolt-speed0 = <880000>;
-			opp-microvolt-speed1 = <820000>;
-			opp-microvolt-speed2 = <820000>;
+			opp-microvolt-speed0 = <880000 880000 1200000>;
+			opp-microvolt-speed1 = <820000 820000 1200000>;
+			opp-microvolt-speed2 = <820000 820000 1200000>;
 		};
 
 		opp@888000000 {
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-hz = /bits/ 64 <888000000>;
 
-			opp-microvolt-speed0 = <880000>;
-			opp-microvolt-speed1 = <820000>;
-			opp-microvolt-speed2 = <820000>;
+			opp-microvolt-speed0 = <880000 880000 1200000>;
+			opp-microvolt-speed1 = <820000 820000 1200000>;
+			opp-microvolt-speed2 = <820000 820000 1200000>;
 		};
 
 		opp@1080000000 {
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-hz = /bits/ 64 <1080000000>;
 
-			opp-microvolt-speed0 = <940000>;
-			opp-microvolt-speed1 = <880000>;
-			opp-microvolt-speed2 = <880000>;
+			opp-microvolt-speed0 = <940000 940000 1200000>;
+			opp-microvolt-speed1 = <880000 880000 1200000>;
+			opp-microvolt-speed2 = <880000 880000 1200000>;
 		};
 
 		opp@1320000000 {
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-hz = /bits/ 64 <1320000000>;
 
-			opp-microvolt-speed0 = <1000000>;
-			opp-microvolt-speed1 = <940000>;
-			opp-microvolt-speed2 = <940000>;
+			opp-microvolt-speed0 = <1000000 1000000 1200000>;
+			opp-microvolt-speed1 = <940000 940000 1200000>;
+			opp-microvolt-speed2 = <940000 940000 1200000>;
 		};
 
 		opp@1488000000 {
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-hz = /bits/ 64 <1488000000>;
 
-			opp-microvolt-speed0 = <1060000>;
-			opp-microvolt-speed1 = <1000000>;
-			opp-microvolt-speed2 = <1000000>;
+			opp-microvolt-speed0 = <1060000 1060000 1200000>;
+			opp-microvolt-speed1 = <1000000 1000000 1200000>;
+			opp-microvolt-speed2 = <1000000 1000000 1200000>;
 		};
 
 		opp@1608000000 {
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-hz = /bits/ 64 <1608000000>;
 
-			opp-microvolt-speed0 = <1090000>;
-			opp-microvolt-speed1 = <1030000>;
-			opp-microvolt-speed2 = <1030000>;
+			opp-microvolt-speed0 = <1090000 1090000 1200000>;
+			opp-microvolt-speed1 = <1030000 1030000 1200000>;
+			opp-microvolt-speed2 = <1030000 1030000 1200000>;
 		};
 
 		opp@1704000000 {
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-hz = /bits/ 64 <1704000000>;
 
-			opp-microvolt-speed0 = <1120000>;
-			opp-microvolt-speed1 = <1060000>;
-			opp-microvolt-speed2 = <1060000>;
+			opp-microvolt-speed0 = <1120000 1120000 1200000>;
+			opp-microvolt-speed1 = <1060000 1060000 1200000>;
+			opp-microvolt-speed2 = <1060000 1060000 1200000>;
 		};
 
 		opp@1800000000 {
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-hz = /bits/ 64 <1800000000>;
 
-			opp-microvolt-speed0 = <1160000>;
-			opp-microvolt-speed1 = <1100000>;
-			opp-microvolt-speed2 = <1100000>;
+			opp-microvolt-speed0 = <1160000 1160000 1200000>;
+			opp-microvolt-speed1 = <1100000 1100000 1200000>;
+			opp-microvolt-speed2 = <1100000 1100000 1200000>;
 		};
 	};
 };
-- 
2.20.1

