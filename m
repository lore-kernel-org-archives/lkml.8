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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64F9C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F312076E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiPsk+JI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgCTNfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:35:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36365 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgCTNfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:35:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so1494739wrs.3;
        Fri, 20 Mar 2020 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UNPe3Sj9nisgX8TMQG4uvyThsRCvZnaiE/iNxuk8GJ8=;
        b=HiPsk+JIb2hyg5Qkn4eZQ5lRw7DEF4diIWH41qF+EGfE1Me0t8w8c+WEgJem++3gc7
         NhQtgcIBHpzOeUPHxBGXhRzffm6AZxluJcxezw9azGvhMWgqLjlu+eyutfux0RsCthAd
         7xrP+47+OjQuY1WP8pOBHk1gKFd0nc9MtCdeR8P5eMmvsK5yInuCUJE2fk0LWFhs+yYC
         vHYNsowa3qGPfwNaDhv6/VlnOFxERDVa3F3uMIYqaQZ/ReKz3n3ON5YJeOteYNdM4vXB
         ZTxNWJ+HuOvYaGV/DzEF/rn2brKSxhwtEvQbkEe6zPBNGK1+U+Uyea5S7b3VDxDHnCnR
         6CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UNPe3Sj9nisgX8TMQG4uvyThsRCvZnaiE/iNxuk8GJ8=;
        b=c0PqLiSd1u3vt5TWsEAIfY04gGnkYAcJ55nWWcYEwg5QnmSRYf/cTL0TuEOcrJK5YY
         02pc1sy8NKYPcwQdKs+FsuQ2qS2MNtBFnuQdQvOwLFQaOjciLtMAmfejGp2alCdOiE4H
         aUC9WLGh+VMX+PqELUu2oRzA9xBDteLLReVLhXAF2vF8lUBreBYwJKb6qts9bT3BAnyv
         zbr+BmeM9cF/5OGzqFd1GyG3GA8HPELe6jPr17ZKl3Hp8eymBs20yjU0leE1nUAno36X
         93wbEmTDb/Cr/2byFZdn/nQOCLHFREOBnYXFRXvuj9Qtr/YIi0LhyUVE3ZI1CnXmx4ia
         bhNQ==
X-Gm-Message-State: ANhLgQ1zbIUKaIzd0CZtTDuahmtXp+WZjXPmgyv7rTy4ucpipNV2hN01
        SC+xhNYQbGjATDQPRZR77D0=
X-Google-Smtp-Source: ADFU+vsmF62dkz4NOF0fz2vj+AQ9Q4dIQxEtvA6NbGIPJUif7KQu/7XeP2PuG9ptM3YqSbuJXOnCFA==
X-Received: by 2002:adf:fc82:: with SMTP id g2mr11634358wrr.117.1584711310179;
        Fri, 20 Mar 2020 06:35:10 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id s22sm7160030wmc.16.2020.03.20.06.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:35:09 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] arm64: tegra: Add native timer support on Tegra186
Date:   Fri, 20 Mar 2020 14:34:49 +0100
Message-Id: <20200320133452.3705040-5-thierry.reding@gmail.com>
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

The native timers IP block found on NVIDIA Tegra SoCs implements a
watchdog timer that can be used to recover from system hangs. Add the
device tree node on Tegra186.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 58100fb9cd8b..4dfa70e93693 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -167,6 +167,22 @@ emc: external-memory-controller@2c60000 {
 		};
 	};
 
+	timer@3010000 {
+		compatible = "nvidia,tegra186-timer";
+		reg = <0x0 0x03010000 0x0 0x000e0000>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	uarta: serial@3100000 {
 		compatible = "nvidia,tegra186-uart", "nvidia,tegra20-uart";
 		reg = <0x0 0x03100000 0x0 0x40>;
-- 
2.24.1

