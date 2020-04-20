Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2BCC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F582082E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0y6D57U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgDTOaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729002AbgDTOai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:30:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1784BC061A0C;
        Mon, 20 Apr 2020 07:30:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so11305677wmc.0;
        Mon, 20 Apr 2020 07:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dI1Gh5Ia/IrSE8braqcvjE9iwr/Xeiid7dJ9xFJyCNc=;
        b=s0y6D57U6WglS20eFoAv4FmLmev5Pg9B16Yk09l/PNX24/97t7ckTkGfYzvlkZw0on
         YWCUPILmyo+8FpjJxBZzcc+NUZTnFw1aimtyVysHJ+DYOSk/LPP6rsCCD8+bzuAxqk8Z
         X13V6yNBTptXhlrFhUxIRYyVzRhogVBjBlcHN2AcaRrWxxGAc0WrJ+CO/ACe7Aa9GlX7
         Fo24zIIdl4k2938F/y1TY9MhT9hU+6VX/MVUxNsby+dE8LyFzKRWDssqYGqDWoOyj1jV
         SuYn/vAmMHeCtwC5cxI5E7Hz5Lr6TAj3Aj79HmNZpS4fyJOQzDbTef0sKK3lPDhRKPh+
         T8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dI1Gh5Ia/IrSE8braqcvjE9iwr/Xeiid7dJ9xFJyCNc=;
        b=PmRQPW6uXuYCdVTjtpNTBcQr7+o8rH/7v9lmtHJeI821rIg2yP7Mhna6pU20HquPZH
         fNKBPD4+CRLoNfQ0q8ML16aIKhRYb+JIVNF2Y8b7/P1T3SoUKQ3Tz2GbhoMGvH7b/QLA
         ODtXBw+VWma2p77YBImxgcx/YzjCw+2KrrNcvVf8k/BKxuBY2ZXoeqFAeCvmJTep4gUY
         v7RD7cW+eJXxq57UJKH5CwUPrJAQlaR0UCKAvQeNh0PVVSneA7AhmdlX2goyXiR2XEuh
         Q5fYwOoSHMscaFDGAXaS5NOjYU6xLkk6+U4Erc/AbcADDAw+cWSxG8RdDYgHyLL1I+NX
         Dtcw==
X-Gm-Message-State: AGi0Pub0dCIEG0oC+RwLTeRjqe/rznlx4/RwPjuyX40w/L4HZBH7e1Zs
        KBj2FBiHVgw5cIRvMAGRq9M=
X-Google-Smtp-Source: APiQypIJnP/ANrM/0Xq5qXboBFie6OC/sX9QxmPufyHRw6vMmOHVbp/Ybowp2RM8T3Rv0+n8ep75gA==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr13041186wmc.142.1587393036662;
        Mon, 20 Apr 2020 07:30:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:554b:e8c8:c8c2:f119])
        by smtp.gmail.com with ESMTPSA id v1sm1510452wrv.19.2020.04.20.07.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 07:30:35 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH] arm64: dts: allwinner: h6: fix cooling-cell property
Date:   Mon, 20 Apr 2020 16:30:16 +0200
Message-Id: <20200420143016.16835-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We define cooling-cells property for CPUs only for board including
the sun50i-h6-cpu-opp.dtsi. As not all boards have the CPU OPP
dtsi file included this create a warning because the cooling-maps
is defined but not the cooling-cells property in CPU nodes.

Move the cooling-cells to the sun50i-h6.dtsi instead of the
sun50i-h6-cpu-opp.dtsi

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi | 4 ----
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi         | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
index 9ebd97b04b1a..dcb789519797 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
@@ -102,20 +102,16 @@
 
 &cpu0 {
 	operating-points-v2 = <&cpu_opp_table>;
-	#cooling-cells = <2>;
 };
 
 &cpu1 {
 	operating-points-v2 = <&cpu_opp_table>;
-	#cooling-cells = <2>;
 };
 
 &cpu2 {
 	operating-points-v2 = <&cpu_opp_table>;
-	#cooling-cells = <2>;
 };
 
 &cpu3 {
 	operating-points-v2 = <&cpu_opp_table>;
-	#cooling-cells = <2>;
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 83e32f9c4977..2e31632c6ca8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -27,6 +27,7 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -36,6 +37,7 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -45,6 +47,7 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -54,6 +57,7 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.20.1

