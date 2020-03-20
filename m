Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E8C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A8A2076E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsbN2zV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCTNfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:35:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42040 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbgCTNfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:35:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so7467378wrm.9;
        Fri, 20 Mar 2020 06:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lHw9M1P3NRhm9zZzwgvQTk0wuIissIS/ZfYp0zlQyws=;
        b=bsbN2zV8A+ePEmLccEtGoPMUvYZwG08mPCxVVdHs302gsQYax6KEdXRDp/RIVy2uYW
         MK63vcq0uz9anncsf+hEKP6l8x+VzNYK2Wy3apZokJQfvdLbCLYdkf3/lPfboul4Qu/y
         Tc0kUQ1+zamYn8XspJ+2KAvMBwxrcTTc6/070Xe2UI9PWFgit9XEaLr6pm/jso6RQWp1
         7x9qTLQvpnWP0Qzfg7V3ygwTCXFmfQOsJtW4rikDto8AR/3AQFT5JtZNTpqJlXbZTujX
         Bbc4IppnWTXkg0GAcoL09bmmH2QBWTBP8gmtbVojdohGMfGRapX9fWAsanHszI674d7/
         Vbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lHw9M1P3NRhm9zZzwgvQTk0wuIissIS/ZfYp0zlQyws=;
        b=azIMxQBWD+P32WEePxLn/kf2bKh/ocnGrZV5R5hbZWG4bEcQnxNXyEogIjnYGVa8JU
         DXmkToxPo8E72qswbP9QWiFpN6yOVQsqUsRH1Oex+3Nq6xfHV/XYBncoSmSWYhRR/unR
         +zGNGj4DSD2lBPk8LHphOKVF5jaKDGeppmn9Z1gtgT6BTQBK51IzkivIYKmqqI0EDZLf
         i3ujRG23LdJcHYTHWNcd96gsoeOM3+iSndLpTu6ay9mxb9aSpRs6aO8z37vZnt7Oo84S
         RkggHYmka8QFbLi8haapr5xZUBM9ZTmLeZQctkitsbpsy0RPjYA6Cl15z9dfWyCsiy4N
         GmUA==
X-Gm-Message-State: ANhLgQ0EWCxMtsUgNiaZmMWHaGvMn9lDZZl9qk9robQ2pTXAwn4RsyQ8
        i2vEKJiN46rKT1gePatMxc0=
X-Google-Smtp-Source: ADFU+vumzkQjA1N3nHYYutRtW+zRnRxi1BmV1bQbE/zU8dCWPp8NIJ2Z6g8X4xQG02UJN4Vb/IAVaw==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr11404331wrm.280.1584711308433;
        Fri, 20 Mar 2020 06:35:08 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id q4sm10246040wmj.1.2020.03.20.06.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:35:07 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] arm64: tegra: Order nodes by unit-address on Tegra194
Date:   Fri, 20 Mar 2020 14:34:48 +0100
Message-Id: <20200320133452.3705040-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320133452.3705040-1-thierry.reding@gmail.com>
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The pin controller device tree node was accidentally added in the wrong
place. Move it to the correct location to keep nodes ordered by unit-
address.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 64 ++++++++++++------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index f4ede86e32b4..019f66f03a97 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -45,6 +45,38 @@ gpio: gpio@2200000 {
 			gpio-controller;
 		};
 
+		pinmux: pinmux@2430000 {
+			compatible = "nvidia,tegra194-pinmux";
+			reg = <0x2430000 0x17000
+			       0xc300000 0x4000>;
+
+			status = "okay";
+
+			pex_rst_c5_out_state: pex_rst_c5_out {
+				pex_rst {
+					nvidia,pins = "pex_l5_rst_n_pgg1";
+					nvidia,schmitt = <TEGRA_PIN_DISABLE>;
+					nvidia,lpdr = <TEGRA_PIN_ENABLE>;
+					nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+					nvidia,io-high-voltage = <TEGRA_PIN_ENABLE>;
+					nvidia,tristate = <TEGRA_PIN_DISABLE>;
+					nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				};
+			};
+
+			clkreq_c5_bi_dir_state: clkreq_c5_bi_dir {
+				clkreq {
+					nvidia,pins = "pex_l5_clkreq_n_pgg0";
+					nvidia,schmitt = <TEGRA_PIN_DISABLE>;
+					nvidia,lpdr = <TEGRA_PIN_ENABLE>;
+					nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+					nvidia,io-high-voltage = <TEGRA_PIN_ENABLE>;
+					nvidia,tristate = <TEGRA_PIN_DISABLE>;
+					nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				};
+			};
+		};
+
 		ethernet@2490000 {
 			compatible = "nvidia,tegra194-eqos",
 				     "nvidia,tegra186-eqos",
@@ -139,38 +171,6 @@ agic: interrupt-controller@2a40000 {
 			};
 		};
 
-		pinmux: pinmux@2430000 {
-			compatible = "nvidia,tegra194-pinmux";
-			reg = <0x2430000 0x17000
-			       0xc300000 0x4000>;
-
-			status = "okay";
-
-			pex_rst_c5_out_state: pex_rst_c5_out {
-				pex_rst {
-					nvidia,pins = "pex_l5_rst_n_pgg1";
-					nvidia,schmitt = <TEGRA_PIN_DISABLE>;
-					nvidia,lpdr = <TEGRA_PIN_ENABLE>;
-					nvidia,enable-input = <TEGRA_PIN_DISABLE>;
-					nvidia,io-high-voltage = <TEGRA_PIN_ENABLE>;
-					nvidia,tristate = <TEGRA_PIN_DISABLE>;
-					nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				};
-			};
-
-			clkreq_c5_bi_dir_state: clkreq_c5_bi_dir {
-				clkreq {
-					nvidia,pins = "pex_l5_clkreq_n_pgg0";
-					nvidia,schmitt = <TEGRA_PIN_DISABLE>;
-					nvidia,lpdr = <TEGRA_PIN_ENABLE>;
-					nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-					nvidia,io-high-voltage = <TEGRA_PIN_ENABLE>;
-					nvidia,tristate = <TEGRA_PIN_DISABLE>;
-					nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				};
-			};
-		};
-
 		mc: memory-controller@2c00000 {
 			compatible = "nvidia,tegra194-mc";
 			reg = <0x02c00000 0x100000>,
-- 
2.24.1

