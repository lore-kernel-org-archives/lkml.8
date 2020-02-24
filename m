Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DACC11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F6020828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BYcD3EXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgBXPIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:08:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46901 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgBXPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:08:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id g4so4427985wro.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fT05dRla7k6mi1JhUyZzqKYXuvZdKNrDT0WVGGFRTl0=;
        b=BYcD3EXvKfzozIA2053JwVUhJ9IPx5JuCxPDLSoD+2e1TGLiZUpUZCHd2MMdViO7Oi
         HzZ8tSQb2CglmS9jZ31gIsquRyMfcrLsxFTYsuVUSfJpGKoAAN/YUV/1Re1ubTXTEXwo
         i64S5HP2Rvg3tQhPeunM0uJex3kztuETRY15tqrfR2j4iYsRdyv82/t6mDFDNNFrjNuI
         xtBbXXeDXaSu8PTmXmmDndi6NcyqtvX2yyJXTh3FQ+iQU0RYEIchk8VIe7ljr1ScoQ3p
         NcJJDIqNpVyNMUy2qHp6iwxB826rpWgNToIvCWPusyW0wL8PgsVZVwS7A3ZbtHM5K0Bg
         bpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fT05dRla7k6mi1JhUyZzqKYXuvZdKNrDT0WVGGFRTl0=;
        b=Jvw9JMuY76ttf9txuwmYcdI3DB1Y2E4J7uAePm4llZR4yd+EljMe3oFutw+JnoNwgz
         nent/tlZ9qKimwVu8Tl1AZtjDY3TNea3VTf+ADCjY9+0V5NMvceLrpskstSW10nJ7KJR
         EMzwCT0qZ2qCNCh6psy7OO6jl8DuuSGyjTJGAydUOZ8QM+ew4qYXfSivao76o1c7k3gL
         yPSGQuBt5r391/9BYcfAluIfYng5ZTh1o5C3Vab3COVfu6olJfB3kUW3RcM2mzcJDy8N
         lJHtq5tbaonKUsadOJglvoOxfVKI53LLwHf0PsLEYSaIf31RY3qbv0PuEB5KZKEZOdxZ
         /THA==
X-Gm-Message-State: APjAAAVDZa/Hsqp6YyvZH+s5EbUg/MKoYRbcgWMK6ZbLd7/nkWfN1Sgl
        JVIteStQrcsT4KDaMcmN+//XDw==
X-Google-Smtp-Source: APXvYqzMKfwIAC3EPjlKXLjC88+oVE8Nagq9Gy14JsUqh3VEvQ3KLe3E/Wsf/vNE4nwruJpKV/hnmA==
X-Received: by 2002:adf:8084:: with SMTP id 4mr15568503wrl.201.1582556898282;
        Mon, 24 Feb 2020 07:08:18 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c15sm19074794wrt.1.2020.02.24.07.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:08:17 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: meson: add pdm reset line
Date:   Mon, 24 Feb 2020 16:08:10 +0100
Message-Id: <20200224150812.263980-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224150812.263980-1-jbrunet@baylibre.com>
References: <20200224150812.263980-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset line of the PDM device to g12 and sm1 SoCs.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi | 1 +
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
index 03054c478896..55d39020ec72 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
@@ -56,6 +56,7 @@ pdm: audio-controller@40000 {
 			 <&clkc_audio AUD_CLKID_PDM_DCLK>,
 			 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
 		clock-names = "pclk", "dclk", "sysclk";
+		resets = <&clkc_audio AUD_RESET_PDM>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index d847a3fcbc85..d4ec735fb1a5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -448,6 +448,7 @@ pdm: audio-controller@61000 {
 			 <&clkc_audio AUD_CLKID_PDM_DCLK>,
 			 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
 		clock-names = "pclk", "dclk", "sysclk";
+		resets = <&clkc_audio AUD_RESET_PDM>;
 		status = "disabled";
 	};
 };
-- 
2.24.1

