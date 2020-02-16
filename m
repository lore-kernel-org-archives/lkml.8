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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8510C7619C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 17:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C2720857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 17:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWWAnVhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBPRfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 12:35:13 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:35333 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgBPRfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 12:35:12 -0500
Received: by mail-pl1-f169.google.com with SMTP id g6so5778118plt.2;
        Sun, 16 Feb 2020 09:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJBFrhbCj4MW2FP4lLqpYa6YgQUhBipNhqkx+l0iOfQ=;
        b=RWWAnVhPGKLJcJMkkbYf5cYcJx/3etaaQ5GWv+d1s/bSvHk0vsmSpKKwFpbUE//oJ/
         Jabpj7A7p1mLXVk89Qcx2Wt1btEVkJZmGrnnGOZHldBkZQ2Tujg12uJPpbsRMJxR3h8I
         O27m8W1aGX4ybUZh1+c+oDpjq7QH28Pqfp26DulN58bVSbvfa8SEpjqnMKleNrMMQWie
         3c9DpKIOXHPCa2ucbSdyGUa/O21O4H195iPdZ+rB6pybxBSH2WymvgH9G5gN2ENszDGU
         sIMHtrlTL/4uEYkwdmu6/d7jEKdsEG0//dXOhUKggEbNOFKVNA//R381eDktPlSa4H9Z
         7TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJBFrhbCj4MW2FP4lLqpYa6YgQUhBipNhqkx+l0iOfQ=;
        b=LCLYqGgH8PJOJk46WLDaGVNREh4JngF2+t9BruU6U1yY0bLocXqCNEakNPLkHtyoHA
         +npKj511KTvdGcy//SBTnrX3aBHCqfVM3r3X2OMPqBOUpAlxIxNaAgjJ8Fyfv+ph3Vha
         /jhcYQAFPF34+W/wyWSJxJKAkg821ue7IwrusxU8/9opCBMBpRvYX14cn/Sa/d2LKbYM
         uGYpMJ/mUA/dhw3Y94WuolqUHbLe/zAVHDTNDPJ90L+kZOSgU4C5FNfZjsIJaJpEw1Je
         S4lvL5/ff36SoVtBkMYHGGAu+dSxIKOxuJ8DvJVOBPmHtr+zu32ZfBjdaNHforVakdyD
         HeqA==
X-Gm-Message-State: APjAAAWh2zGt56cBHpjPNRZBkqHSF7Q5jMJSfLFau16tvDFUgocSBilc
        PMplDwkyZsuW3ID0bOPBSTY=
X-Google-Smtp-Source: APXvYqwNQKt62HfzoPLn0vewOSTufVzWbDQ09Pjevzec938dfGoWoc0OxhdO/qd9n2HqQTUuodXShA==
X-Received: by 2002:a17:90b:28f:: with SMTP id az15mr15247514pjb.4.1581874511589;
        Sun, 16 Feb 2020 09:35:11 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.127])
        by smtp.gmail.com with ESMTPSA id a36sm14284724pga.32.2020.02.16.09.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 09:35:11 -0800 (PST)
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
Subject: [PATCHv1 2/3] arm64: dts: meson: Add missing regulator linked to VCCV5 regulator to VDDIO_C/TF_IO
Date:   Sun, 16 Feb 2020 17:34:45 +0000
Message-Id: <20200216173446.1823-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200216173446.1823-1-linux.amoon@gmail.com>
References: <20200216173446.1823-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per schematics add missing VCCV5 power supply to VDDIO_C/TF_IO
regulator. Also add TF_3V3N_1V8_EN signal name to gpio pin.

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
index 353db3b32cc4..23eddff85fe5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -66,11 +66,14 @@ tf_io: gpio-regulator-tf_io {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
 
+		/* TF_3V3N_1V8_EN */
 		gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
 		gpios-states = <0>;
 
 		states = <3300000 0>,
 			 <1800000 1>;
+		/* U16 RT9179GB */
+		vin-supply = <&vcc_5v>;
 	};
 
 	flash_1v8: regulator-flash_1v8 {
-- 
2.25.0

