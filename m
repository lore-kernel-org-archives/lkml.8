Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57027C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA77208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2d/TlNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbgCaWTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:19:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33135 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaWTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:19:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so28226367wrd.0;
        Tue, 31 Mar 2020 15:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lHw9M1P3NRhm9zZzwgvQTk0wuIissIS/ZfYp0zlQyws=;
        b=C2d/TlNoKFgzgPOkh1bLSaiQVMxB9mF3tNIRhX22GksnuKNdA8PusyJ0U2BxnEhavO
         cQTTPnNtZqhlIjBOA8mem+INuXMVCFctlWh5VYP9OUWdHiTHeW3Tiw/hEU02zDRe1/rh
         Tlz/E6JggVSD3aUc6yIHKfXFy905iTlSl9ZyMmSWcUowTGOZ0LLffH2dacaetevtOPd7
         0DkSnPTj91snfuassUGP/9aYZU/9pCB1VCUw5pqOPJS9L86XGuWDqvrcAqfgHhWW/U0M
         nGPpXqPjFX9I2jvZjBhnoAaKeucVEXVD7vdV32PYnIJlwYzXF553KBjQHwGmeKffirnt
         BuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lHw9M1P3NRhm9zZzwgvQTk0wuIissIS/ZfYp0zlQyws=;
        b=qBo8sg3XLnexRkj2vyfIyK7XoBp2feeYu/5XTImAQ9o11cQSMyWdAB1FPv1KGdnbW5
         HQxHU3k5am0nEyh9XjYD9nkkUO04QLvqH+SUEb3YgGmQUgE8dspY/hZnjdf5KjdAeYU5
         xzc7W2RaD/1tq4iTjxKSv/ihPM8VhcJxdhRSAaXFTZu4oWl5VYHXpwy8dA1n5NaJP/jI
         J9DEpdfd97TF2MBK1ymHdj4a4yu7MjH57KLCb0WW4cIrhcytZTB1shcrVisRH5gRaZ+9
         Yhu912G7KG9gWo2y1tsPJZ9Ox36BHnID+wTU70nLsN+rOpp/C2xWl3KFG9P4Ggs+CNQE
         Wozw==
X-Gm-Message-State: ANhLgQ3alui494VVsgabfL62UsV3BGFZEB0Jkuc19katPiv0DIJC2FOd
        nssemVED/tQgRiQmRx6Su+k=
X-Google-Smtp-Source: ADFU+vtwDzCJjfpv1D2wNhefief80Zlm5c+JOJxvTKezzwn4Dl7lx8hesBEeSG4YzruxHu5GKZto/g==
X-Received: by 2002:a05:6000:10c8:: with SMTP id b8mr21222742wrx.138.1585693168999;
        Tue, 31 Mar 2020 15:19:28 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id y11sm27830wmi.13.2020.03.31.15.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:19:28 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] arm64: tegra: Order nodes by unit-address on Tegra194
Date:   Wed,  1 Apr 2020 00:19:10 +0200
Message-Id: <20200331221914.2966407-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331221914.2966407-1-thierry.reding@gmail.com>
References: <20200331221914.2966407-1-thierry.reding@gmail.com>
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

