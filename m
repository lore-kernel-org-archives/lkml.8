Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0189C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B750A2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlcLr+qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgDTNAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729814AbgDTNAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:00:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01CDC061A0F;
        Mon, 20 Apr 2020 06:00:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so11999414wrg.11;
        Mon, 20 Apr 2020 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=06l4F0Fbj1OIjrhQursMZ1QtwSUf8beeJ0SuDwg+II8=;
        b=tlcLr+qcBQd9nD7QTtS+m5qGw78g7dkv2yrPeWwNs6uF2RCgIM/TURYFZ5xXCa7aNk
         GAFKd/dAXeZd9KopdEWzHTPSjwx7PaY4v0kW9saJGP9AN7lGtidS6vy+KkRdrCXTcskt
         8+psFyi6qmQwNpctFj0guZuFF0NdPwBLumKbNkieMkO8ceutAMf4DA/eDPwc4u6gwcSa
         E7lFccjL0M6zaxke2M1rh+385s3DxP+X9DTIKkVeIzGLECL3WxG0iBAbg9Fk/Et0/LWT
         tw7iINCDR+O9hiQlM47fpeqiBYbPYNYMxU6P8vZRLptuJUA4neKsJ5iD4LBFMAAnl0Ak
         HRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06l4F0Fbj1OIjrhQursMZ1QtwSUf8beeJ0SuDwg+II8=;
        b=pJ2q+cMNIA0X4qIBI4aGkIziHHTTxDK9eYz/EPLa7RrL6kOHs8Ee02rKEcG2HDBqlq
         Rx2KFhOBRRRDOTZ3BGOII1P2L6FW5B4qehHXK62SruEd2uOKqRY2AVxHlh/Onf9sTVlM
         FV7JTHp++tA0Y1XtYYNPPhu8MMcuUoSQn8qG4XjoOFWngk8vRoypaLuyBarD1jdowuJL
         y8fh7Scx8gmbiFgy21bWwd6mBsxTfT58YJd45XQUrglRNxnj6K/USjnCZZd8He02/aPD
         rGdoa6bQINf+TmSEbYKTqrC6irvWcZFO6ldRYqN9//k+gOXqzajupoZgGZ6P005xuxwS
         RDVw==
X-Gm-Message-State: AGi0PuYIatht3XLfIWUfdrxmZn8OUxzMAsYRQND4+XuzoS2WChJf6EoE
        TCM7wAWwxbn8BlQuAm0ApHA=
X-Google-Smtp-Source: APiQypItG1WvEk1CoQQJoT17pn5VvxyJhlZZM+GMUHSUrzirP1En3WB80UMtZwmFIkhpHpRAGw4bkw==
X-Received: by 2002:adf:f450:: with SMTP id f16mr18688995wrp.346.1587387631354;
        Mon, 20 Apr 2020 06:00:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id e11sm1081680wrn.87.2020.04.20.06.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:00:30 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 6/9] arm64: dts: allwinner: h6: Enable CPU opp tables for Orange Pi 3
Date:   Mon, 20 Apr 2020 15:00:18 +0200
Message-Id: <20200420130021.3841-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420130021.3841-1-peron.clem@gmail.com>
References: <20200420130021.3841-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPU opp tables for Orange Pi 3.

This needs to change the CPU regulator max voltage to fit
the OPP table.

Also add the ramp-delay information to avoid any out of spec
running as the regulator is slower at reaching the voltage
requested compare to the PLL reaching the frequency.

There is no such information for AXP805 but similar PMIC (AXP813)
has a DVM (Dynamic Voltage scaling Management) ramp rate equal
to 2500uV/us.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 47f579610dcc..15c9dd8c4479 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -4,6 +4,7 @@
 /dts-v1/;
 
 #include "sun50i-h6.dtsi"
+#include "sun50i-h6-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -257,6 +258,7 @@
 				regulator-always-on;
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1160000>;
+				regulator-ramp-delay = <2500>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -264,6 +266,7 @@
 				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
+				regulator-ramp-delay = <2500>;
 				regulator-name = "vdd-gpu";
 			};
 
-- 
2.20.1

