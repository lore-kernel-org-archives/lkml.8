Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4526C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89CD20838
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+l48u4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbgCaWTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:19:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42770 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaWTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:19:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so28136060wrx.9;
        Tue, 31 Mar 2020 15:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WS2drkVzUywPkUAraDwxibChKAzL4Ioj5dgxbparViM=;
        b=j+l48u4C7J8YFu72kqeEOtq2fHVLCQ6njNPTXJ14eBxhtOCNzTGMSR+FLzx+GP0at+
         ny2EiUGnqSvjtXrewlGQuLja3NY0BU/4KC0vJxFXsCKMeR1wzJ7WyIx8d9YTnGntjN0v
         6lSye6cpAl30hLV69TVB4RIfp2aHGxqg4qgr0AwI2j4w2F/H5O+3ouxMaN/MqEHGaPB1
         Cn5aq4XLb9HGk9I6n+d9GSNShEU3YYZ0ZJVTZ/5NmMH1iJstFtjeolRmwvrw2pAZ1nnj
         4Jyh7VPPHuldtECCHWUj94BA/0Az+Snrnw2rFchArIIX2cVSGcpgyC6v2TJ2vpoZ0Qsr
         wl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WS2drkVzUywPkUAraDwxibChKAzL4Ioj5dgxbparViM=;
        b=VVN9tJe7U67T0vLxE2m1+oqO/FnaEwT3V+N9j/PWgmyOeiDJNhIzy+0DLE+3tpVHS0
         uWt+qwaRfFNdcrhO0NiazJswrZnj0MJcfh9zjkSpd9FlC9EK1MG+3rWAnNy2nOuKipXX
         WWjuTJtwvPQZkoAisv3gag/bh5/QmM0V17veuIX522vhmQ0/C5RFN8MP1tOid3pD92dW
         WAI3EupMfzm8lXNzBoLarpL7egBqWhLsxV4jFCNqVYo76cOWf6vdlC1btU42dvCOH2xq
         aVu+XdhNT5T431d9UiFDbNNxutHtpAfJVqEtSEZBwsbeYQNfAqhxiRn9e1owhlJDG4JH
         tk3Q==
X-Gm-Message-State: AGi0PubOsAY16rKX+nRkAEgk5OxKkML24P8NVSDV4WkGk2FBbsVAZufw
        4lIdOK1UKQ464DX8idVYhZMsERrs
X-Google-Smtp-Source: APiQypLv2SgaVF2J5eXO0kyZehWb+YmA4nvtrGSRiQWHN0vTsH77+/lj8uWsi3MDQJw8JnIsWEQ1eg==
X-Received: by 2002:a5d:6303:: with SMTP id i3mr239905wru.1.1585693176500;
        Tue, 31 Mar 2020 15:19:36 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id e5sm143063wru.92.2020.03.31.15.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:19:35 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] arm64: tegra: Add native timer support on Tegra194
Date:   Wed,  1 Apr 2020 00:19:13 +0200
Message-Id: <20200331221914.2966407-7-thierry.reding@gmail.com>
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

The native timers IP block found on NVIDIA Tegra SoCs implements a
watchdog timer that can be used to recover from system hangs. Add the
device tree node on Tegra194.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 019f66f03a97..a0a5b44ff9bb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -213,6 +213,23 @@ emc: external-memory-controller@2c60000 {
 			};
 		};
 
+		timer@3010000 {
+			compatible = "nvidia,tegra194-timer",
+				     "nvidia,tegra186-timer";
+			reg = <0x03010000 0x000e0000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		uarta: serial@3100000 {
 			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
 			reg = <0x03100000 0x40>;
-- 
2.24.1

