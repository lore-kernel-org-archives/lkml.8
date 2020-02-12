Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61A2C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABE92073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGNH1Y97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBLMCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:02:52 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:38091 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgBLMCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:02:51 -0500
Received: by mail-pf1-f181.google.com with SMTP id x185so1145163pfc.5;
        Wed, 12 Feb 2020 04:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OeRfynpBzWtXBGFTr/hu/iRIhnsICLk8oO4a/pXNvUM=;
        b=tGNH1Y97PUNad4YgIOadnTlhC6CXUbtHJK4sKjeZvhgSCzEAETT4v890MUPENwf0VN
         PboD6RHnn7C6QwevJbrYoVDNmhDmPuCTlXdtEdZ3l34GZkGdQFznpg1Fyo7KkX4vZ/va
         F0lqohfFU6iNkPSM2Vdh4MOm6N9W8ndJ6Lh2/zysegNbrog48hcPPfGlc0PwN0byPp88
         2rE+IXjldbW80Atbyq6WXWA82E7jKuzItBT3t2+cjwHofkVe8G74WfP13EUnTBhTQVcc
         ln+Irw7ZFF+yQjRxz06h/JuaKWP4e81+5fUKTNlQQDAo584TO/Cq/5a+mM3QOTz565sS
         dung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OeRfynpBzWtXBGFTr/hu/iRIhnsICLk8oO4a/pXNvUM=;
        b=EDS6oiYzDMJIfUhGGxNPse1NxQSHMKtMwrVEEABICNlF3b/hODxUDOmBC9ak8zRiP3
         wRXovWbVs5gRB47CRU8KQuJ/ALOb/kO247BSt4ASfzXrc+dzSNUtIjeBK46z/fAyl9FN
         5GTppyHjJa5lmnKiUi+bDBqOrwNg5VQaA9uAFUrcUfyuutMn7TXso6lLzV8tdz3pArQw
         Kn6t8aqzvoIhHfUFhhcpSYar5/EL//X03sby2tukONkNYJHNiYL9mbsdCX2x+Nxw5juh
         A4wxabcF/qZ9Tv6iGbdfD/sw/WGpqChQjyXRlkwvOJ7q4QKY9ps5iOa3/MOAA9wqHRoP
         03bA==
X-Gm-Message-State: APjAAAWMP8f0vfrZQbUtjtqAteOyEVsRCt81dcjpoxojHSaSS0qWk2KS
        kQELvyDdU8Qg7ey7ulVNQJA=
X-Google-Smtp-Source: APXvYqykrFWZZK7yAd621OzAw6LmdZuA7kEYns7yVXWQwbZc+9A9ujPl3u0+W8v9yseIOg8L2Tlftw==
X-Received: by 2002:a63:921a:: with SMTP id o26mr12312945pgd.246.1581508970574;
        Wed, 12 Feb 2020 04:02:50 -0800 (PST)
Received: from localhost.localdomain ([45.114.62.33])
        by smtp.gmail.com with ESMTPSA id b24sm682448pfo.84.2020.02.12.04.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 04:02:50 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv1 1/2] ARM: dts: exynos: Add FSYS2 power domain to Exynos542x
Date:   Wed, 12 Feb 2020 12:02:36 +0000
Message-Id: <20200212120237.1332-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212120237.1332-1-linux.amoon@gmail.com>
References: <20200212120237.1332-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a power domain FSYS2 for MMC device present in Exynos542x/5800 SoCs.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index b672080e7469..2ba8a57303cd 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -210,6 +210,7 @@ mmc_0: mmc@12200000 {
 			clocks = <&clock CLK_MMC0>, <&clock CLK_SCLK_MMC0>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x40>;
+			power-domains = <&fsys2_pd>;
 			status = "disabled";
 		};
 
@@ -222,6 +223,7 @@ mmc_1: mmc@12210000 {
 			clocks = <&clock CLK_MMC1>, <&clock CLK_SCLK_MMC1>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x40>;
+			power-domains = <&fsys2_pd>;
 			status = "disabled";
 		};
 
@@ -234,6 +236,7 @@ mmc_2: mmc@12220000 {
 			clocks = <&clock CLK_MMC2>, <&clock CLK_SCLK_MMC2>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x40>;
+			power-domains = <&fsys2_pd>;
 			status = "disabled";
 		};
 
@@ -396,6 +399,13 @@ msc_pd: power-domain@10044120 {
 			label = "MSC";
 		};
 
+		fsys2_pd: power-domain@10044160 {
+			compatible = "samsung,exynos4210-pd";
+			reg = <0x10044160 0x20>;
+			#power-domain-cells = <0>;
+			label = "FSYS2";
+		};
+
 		pinctrl_0: pinctrl@13400000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x13400000 0x1000>;
-- 
2.25.0

