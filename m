Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B28C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5268F2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YI54zt1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgELJja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729344AbgELJj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:39:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2579BC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:39:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so14505265wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=exntrZVDrpNC4LfoF62zE8ED3Dungiic5pvW3+dqcrE=;
        b=YI54zt1AshCXbR/9J2FQ3jVLetO9S//XLD3qA1usyzaunxBpK5g6XQVzQvE3dRcAoj
         Nzbsch3Yzon5rMLclMlvOZbTrlyn2AENSVtwzVsKA5aigV+aSt2PagG0vq75UflInWjO
         VyA2LMJ9bSn5/eEQxYGfcEh7EFRFcUh8rRyJlCp5tR4UdNOUwx25toWUgyeyxs19TXEh
         cQnXabZm+r2RMlGcIjEL0fK5m9xTDItuCLJy3u6qwJuWqPsj2gjUIJ/zBrhq9qp+D3kC
         DPpHNHurfHQDE2szd/rsSYRpn2u+SRxeXhVqrkzcPRN/eDk1IC6aOhLkisA6foT2SxOR
         88ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=exntrZVDrpNC4LfoF62zE8ED3Dungiic5pvW3+dqcrE=;
        b=iF080sL5/cgI2+SLT581khTPKFTT+3VyrCvu5xFX9ZfQowRM2H7UcQvQN1YfeK6htf
         nInYtxZ2fXoOxsqolvvxZWlyxrYaEncl249TSpMMUt0ose72QPo/fYj1QA8MOHIUXVxQ
         X/r4iCWFCV4goaUgTKpCq7vUm589I1OC8Neex+s1FaRzebe79OY5ww2g1howx4BgvSCG
         kq/ZkJM6pZ/qdglGChHpcBeB1IA//kQLhzxkvXDSSfDQLsMz8dZqqjIv9G68cXbwu3f/
         ZU1mLjkB/rA09rPdNJrHMkQfofsDpm2CKo81Wiu1E9yJb/9OJUN60OvSeE5Lq3Q2XPmf
         4NyQ==
X-Gm-Message-State: AGi0PualeifbXbHUh/eLffZ43gnHpAVJTH3h3o/xIrZ/kEtiPOdMYc2l
        XFZvaFaw+jEKJ0AN4Qk6xzmqQdHmtBHk/g==
X-Google-Smtp-Source: APiQypICdYm6q0coCTYrsv14gsmy5w38/NkkWNMU1pnmoJaS64rsgzMhP/NsIK7fGIEASWdkxrRSyQ==
X-Received: by 2002:a5d:42c9:: with SMTP id t9mr24850040wrr.246.1589276364767;
        Tue, 12 May 2020 02:39:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id 81sm14037092wme.16.2020.05.12.02.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 02:39:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] arm64: dts: meson-sm1: add cpu thermal nodes
Date:   Tue, 12 May 2020 11:39:16 +0200
Message-Id: <20200512093916.19676-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200512093916.19676-1-narmstrong@baylibre.com>
References: <20200512093916.19676-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal nodes for the Amlogic SM1 SoCs based on the G12A and G12B
thermal nodes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index d4ec735fb1a5..71317f5aada1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -56,6 +56,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -64,6 +65,7 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -72,6 +74,7 @@
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -80,6 +83,7 @@
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		l2: l2-cache0 {
@@ -466,6 +470,26 @@
 	compatible = "amlogic,sm1-clkc";
 };
 
+&cpu_thermal {
+	cooling-maps {
+		map0 {
+			trip = <&cpu_passive>;
+			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+
+		map1 {
+			trip = <&cpu_hot>;
+			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &ethmac {
 	power-domains = <&pwrc PWRC_SM1_ETH_ID>;
 };
-- 
2.22.0

