Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DCEC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 08:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51EDD206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 08:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="melW+Sux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgGLIEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 04:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgGLIEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 04:04:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2E4C061794;
        Sun, 12 Jul 2020 01:04:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so4158633plo.7;
        Sun, 12 Jul 2020 01:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LTBQ5hXaHngPCInPYxsn3Tt3w8wK0N53I4uFY//HXvo=;
        b=melW+Suxam/anIIxjGA78CCr5w9gIk8QZ2D4vWtgm+kTWfRvERQd8d+ttOy07gkhk+
         YKJgVZsr1HgL0V8R2rvDVDuQhwSlwMAUcUxU5YuUCt6GFsWruXSEmNQzlLLmgs/jHDbP
         JwWHOCsvKK776bAB/KU7s9zA6iBWJFvx479LEazyPGyxX0Ivdiroi/AE3u+D+4BTT720
         gMNtMxEPQ6y/+l7Q5c7cq8kpPFcHG8jKWm5ruYLvFpv0qHc6V5kGM5j7wiePi0Nz5Vcs
         SNsTztl0xGjGpY9dwcJWu98/sJUVHKYEgm49TOq6+85rOMb3YthZBdOQzckvjQb42yLd
         s20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LTBQ5hXaHngPCInPYxsn3Tt3w8wK0N53I4uFY//HXvo=;
        b=BVdm5/f+HvFHt0tQlSiFlvVlCFoXFFfEDqP0o1GFubkZD6WLqaxmGoFS3/yoSmuqhO
         +LDglLYK0Fwd4AYUtpAhV7c8rQXZKbyryr0BebCUCRDb9zinNKaItJ73ujWHO1h/UzQk
         78wljwnoOU14BiBfvZmeKTZEyKshzI0QYCC8a7z144aoPE5KudmpZY0Sgk3t4+CHcqC1
         iP1A/3+pcLrYpw/TNO2W4r84FSet+8174wU0A75VOn0ElZ3DT95bUdlWE452FBDUWZN4
         W9dSkRw8vB4yqSdK+EAGYQ5JE9zprUHlSWRMNbvqfZNw4PG+vDtfMrJj/7fG5hdU38FI
         OmhA==
X-Gm-Message-State: AOAM530V867+Eki1T8vJ7qwHw7WGG+mRyhEh4QmZkneKEKLwQx3kGgjG
        oKihskSwf7+CHbWDtN/g9FDF/8UJHOV1DQ==
X-Google-Smtp-Source: ABdhPJyRBmqvXaBrw9rcOfDZ+aksHUo0sTFOJITcskkXFEVMr4JjXWXyfsjocjjB+1n7hmVVNpTx9A==
X-Received: by 2002:a17:902:988b:: with SMTP id s11mr13131866plp.229.1594541063719;
        Sun, 12 Jul 2020 01:04:23 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:a2ce:c8ff:fe03:6cb0])
        by smtp.gmail.com with ESMTPSA id y24sm11602154pfp.217.2020.07.12.01.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 01:04:23 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, stefan@agner.ch,
        festevam@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        andrew.smirnov@gmail.com, linux-kernel@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>
Subject: [PATCH] ARM: dts: vf610-zii-spb4: Add node for switch watchdog
Date:   Sun, 12 Jul 2020 01:03:57 -0700
Message-Id: <20200712080357.3586-1-cphealy@gmail.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C child node for switch watchdog present on SPB4

Signed-off-by: Chris Healy <cphealy@gmail.com>
---
 arch/arm/boot/dts/vf610-zii-spb4.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-spb4.dts b/arch/arm/boot/dts/vf610-zii-spb4.dts
index a68eae88174a..9e5187ba3fa6 100644
--- a/arch/arm/boot/dts/vf610-zii-spb4.dts
+++ b/arch/arm/boot/dts/vf610-zii-spb4.dts
@@ -209,6 +209,18 @@
 	};
 };
 
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	watchdog@38 {
+		compatible = "zii,rave-wdt";
+		reg = <0x38>;
+	};
+};
+
 &snvsrtc {
 	status = "disabled";
 };
@@ -326,6 +338,13 @@
 		>;
 	};
 
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			VF610_PAD_PTB16__I2C1_SCL		0x37ff
+			VF610_PAD_PTB17__I2C1_SDA		0x37ff
+		>;
+	};
+
 	pinctrl_leds_debug: pinctrl-leds-debug {
 		fsl,pins = <
 			VF610_PAD_PTD3__GPIO_82			0x31c2
-- 
2.21.3

