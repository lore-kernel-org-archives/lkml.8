Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB31C7619C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 17:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8786520857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 17:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMejrEl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgBPRfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 12:35:08 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:36171 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgBPRfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 12:35:08 -0500
Received: by mail-pj1-f47.google.com with SMTP id gv17so6166204pjb.1;
        Sun, 16 Feb 2020 09:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPM2kqx4hlDXSNBDa3izQLbeJ7f1jy1y8czH2Ne/TYs=;
        b=IMejrEl725fqCXBPzYt9wmJUvxnKWr0ybMDAva6F56fobzg5h1czrrqJ32BVqj3Lki
         uF2pqycVRAub8wF470gHyC7O/uukwgYhQwuMlDiJZNwmdEFZTNc22YvxKjwqBNS2h1P5
         TVD0CCcGtcrp63oBFDlzB9MLIt4C62A15uR7Dt5mRklg/IDE4wl9Nu6Gzhj4oZu5oee3
         jPjt2AwjnwZoQuQR0SHvpmwrHjuocsM6cr45QvQiMUgRC0lkbKiAsO+SSdrj49CJhszq
         nWxn1JBEAiZGC1eeeuvWRGANygkQYdVY8FWEaAO9kp16OKk5cn0Jh1WRGjca8BQKrvUK
         0Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPM2kqx4hlDXSNBDa3izQLbeJ7f1jy1y8czH2Ne/TYs=;
        b=kWKsog17QryfrAWzOhru1qVkbgu0lCdnKiKwZ0RKBUhYkrC2+op7ryoZeEnmpGaEeB
         NMtGl9C2iDfJyfHkQFxmZd1QepLJ1fjAlQnS6vsijE+fzvYIOzF7oi8nGtfxQkfpRopU
         sD/S/jIzOhler8edRNkhi86c/oSC5EwfiNHjxp+KYcLaoEuHIdqX6zC2EuCmh1jez9LF
         Klv5qJmnVjcb+wJj+WkNjjCmPznX3529mgBALhEG1br62i361ai+twZ+Vgcp82F6A6tw
         m+TW1+8M1WyOHhL3hQQJ8ednuQzPKlTbkUT6HVk51O0+VMr8q9LkdqddH7MK9Luhcp4S
         ommA==
X-Gm-Message-State: APjAAAUSNYiPJqHwCizzi2kTErk25bWxmGEE/gRzDcXwtBxQBE86dj97
        Rbj7xFwTU3BiGavGP/VdceA=
X-Google-Smtp-Source: APXvYqwNzqmeVTiT7B3ggj00IH6FrnYaVsK+XBkavG5u0s6WRDvhKYzANPW5j9VnHOG0S/Ue30dTkA==
X-Received: by 2002:a17:902:9a45:: with SMTP id x5mr11818858plv.296.1581874507557;
        Sun, 16 Feb 2020 09:35:07 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.127])
        by smtp.gmail.com with ESMTPSA id a36sm14284724pga.32.2020.02.16.09.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 09:35:07 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv1 1/3] arm64: dts: meson: Add missing regulator linked to VDDAO_3V3 regulator to FLASH_VDD
Date:   Sun, 16 Feb 2020 17:34:44 +0000
Message-Id: <20200216173446.1823-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200216173446.1823-1-linux.amoon@gmail.com>
References: <20200216173446.1823-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per schematics add missing VDDAO_3V3 power supply to FLASH_VDD
regulator. Also add TFLASH_VDD_EN signal name to gpio pin.

Fixes: c35f6dc5c377 (arm64: dts: meson: Add minimal support for Odroid-N2)
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 0e54c1dc2842..353db3b32cc4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -51,9 +51,12 @@ tflash_vdd: regulator-tflash_vdd {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
+		/* TFLASH_VDD_EN */
 		gpio = <&gpio_ao GPIOAO_8 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
+		/* U18 FC8731-09VF05NRR */
+		vin-supply = <&vddao_3v3>;
 	};
 
 	tf_io: gpio-regulator-tf_io {
-- 
2.25.0

