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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD13C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCB1206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhMUnKIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgDCUWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:22:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35616 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgDCUW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:22:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so7724640wrx.2;
        Fri, 03 Apr 2020 13:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UNPe3Sj9nisgX8TMQG4uvyThsRCvZnaiE/iNxuk8GJ8=;
        b=VhMUnKIWuGyXO9Wk/YcdTBcgSMYnN4H26x6y7/9SgmCzWy4Vf6g8fQ6XchCp0Kko61
         x59FMlJkWblglZmlr9PibNCvCdg+/cbB2bzk/c7tV3wMMYpkGD+wOE3ZS2f/u+3pefKS
         V9aNke9IErE3yghtXR012FEnNkXmnyVSjgswey95eT1GBwLyxhOouZvW4LhflDdNdHhL
         bOMct7S3a5fnTeAhYYcUJBHE8H7Q3/K1OhvaEl6o30MORyFRYmfjowZ3+mQMilawVZdR
         xx3vkYhI3qMQNRmwtvfHJSVV21lwWy6Of/BrM97wDImyirH+nuaa+W0cDpGNMj7340Xn
         OmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UNPe3Sj9nisgX8TMQG4uvyThsRCvZnaiE/iNxuk8GJ8=;
        b=MusC5UO9GmCuR8Dwy59rTrCOL3D2ankYho3vonag5LxoBAL5czzpB+3eR4wRLwQQcY
         PSa3R0J/LfNeEZ6Hqo9tw+kfFlQ6GWivxlAesBAIj9oHFbRfGHvs5kMQqZlSdUJF+005
         hDQ1hgB7RV7iR04tMCyQGXv5nEqvdOxT42Y0fjdy5z7c5tXzdLEy9UUf/w2v7GlGDAWk
         bFCZaauMVZ8DrAcUC30Q4R+26XAcUa/rDtqnuXoZDoEOUmJYD269gmj94Nr83dS/h7HK
         9w7q+9wJL11NVPXuCMSF5PrKJjhMhwMgJaewLv7jgkpOdKHEUJMdku/mbZRAzhUYO/jg
         hOxQ==
X-Gm-Message-State: AGi0PuaLxMD5dpCtXDepEG2daVqLQaouOFp8FQBIRU2R12OBtYnHwtfZ
        OiTjVlXf9byaIvVvw7qhd+E=
X-Google-Smtp-Source: APiQypLT9r357ptijr1DMYEYfVwzqiVe4R9FAoRQ/z4pi7HhWS8SjPiZBFyKIpQ4+XmTShtzshM9+w==
X-Received: by 2002:a5d:6605:: with SMTP id n5mr10565784wru.303.1585945344205;
        Fri, 03 Apr 2020 13:22:24 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id d13sm13804946wrq.11.2020.04.03.13.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:22:23 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] arm64: tegra: Add native timer support on Tegra186
Date:   Fri,  3 Apr 2020 22:22:06 +0200
Message-Id: <20200403202209.299823-5-thierry.reding@gmail.com>
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

