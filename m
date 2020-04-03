Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D54C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4712077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFUK9LT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgDCUW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:22:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53905 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgDCUWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:22:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id d77so8457350wmd.3;
        Fri, 03 Apr 2020 13:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lHw9M1P3NRhm9zZzwgvQTk0wuIissIS/ZfYp0zlQyws=;
        b=NFUK9LT7vyX3pd2ZO9xJAmutJAo6n1FyzmUWmq6Dl5QWAEfq0pmzVXGvG4oaIBYMtU
         Yva4wOKasiRbew2ufr2Ql9iUd3RmXuimf/Za9ytErkX3vBAbFkpizGRzzyA9t8D1BFia
         8DN2hQugadcXDKEbtdhmL++cLAFv26OrOYq7ECL0CU5ccwpBgSKYmflu8FqsYIQwxg1H
         uayMmdeZzHingkcr/8Wu0na2LhueD8vPvVobx6Z2j8OVmsFSuiAp5km5T0Gentm7Ebtc
         NqWDjEbDLi9ssbeW2/EpTYIw/Y5EZzzPAO79pEdf3ccZnvdQwMyaihIXyYL1wnrvXFiU
         NUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lHw9M1P3NRhm9zZzwgvQTk0wuIissIS/ZfYp0zlQyws=;
        b=lPsRQ/rJ+nmzWf5/Y/6YAivgWMJXwotxTcIwuJARVxLsuCa07M922THuq/k7jnhvWX
         IJFyiuKIgTMvjBg+M+whWSmVX96clsIXMSBnDuteE2RKWPh5Cbp5Y3IogE/g2y211rDa
         Fdv6eDxkDxdeloAw1f4gEhtlaPkawLaidhGcOkDcsCeLAl8aY/VbDZLGwZwMl3IDCmyZ
         w2A/KiTJOESlBwdX6L0eDPpELDZBS6+2mLnxIsHtEyMweJ7wRURfIX+boVU5Xvxtzpxc
         NebyfsPnLHA7R64BOi2LWmVWtcuEit4UYV3cUjcSWBlnPtYFMZ4wM1+gIMJ5srKRgH5o
         Pkjg==
X-Gm-Message-State: AGi0PuaQveXTKDyWU6Zdsw7iLysKqdKXiEj7ZUwxGcB4KN/qwjkcs5sZ
        Y7G4sFLtUBlLb86Db3EBxJY=
X-Google-Smtp-Source: APiQypIk9mxB+aUmqb2XE7HlA8rLb0b0i4gQUHEtneep48FuIKDI1ZpxtC25D8lnPUfmJHe0nMPvSg==
X-Received: by 2002:a05:600c:2501:: with SMTP id d1mr7341836wma.116.1585945342303;
        Fri, 03 Apr 2020 13:22:22 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id h132sm13714318wmf.18.2020.04.03.13.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:22:20 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] arm64: tegra: Order nodes by unit-address on Tegra194
Date:   Fri,  3 Apr 2020 22:22:05 +0200
Message-Id: <20200403202209.299823-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403202209.299823-1-thierry.reding@gmail.com>
References: <20200403202209.299823-1-thierry.reding@gmail.com>
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

