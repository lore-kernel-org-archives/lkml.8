Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597C5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C0C4207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/M4TmMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgESLOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 07:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgESLOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 07:14:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C498AC061A0C;
        Tue, 19 May 2020 04:14:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i15so15383387wrx.10;
        Tue, 19 May 2020 04:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=of2x5lvAuGZZISiXgz474RwZ3LgUvSAn73pq9BHWecA=;
        b=Q/M4TmMBVodfFqQhaQkwvo8TiGW6wEClscN8kJRFoE88xxzaYjoB+KuWpIzOKcn1OA
         Repf7QesvlYP49vKo/ZTR1i4cjgT4a9kthfPm/43mY0Vc26C/WYVn7SlvsqxKFzQ2tWC
         oBTZ2JHr0yUbVPhgmQRzCyyyM3+Vqr0AfSJwvVqs07mVOJN3sTzsYmOQBMWBaHEX0jfZ
         1ZEh06YzA9iC9hjkU8k16YT1uWBXmWsLgsRy7InL5kUjWmDXzUDEC72m5yxOarondboH
         HrGBT2AP0bH82SLcjvjQLQ6wwz0iOICNj+YkvSVSZ/OvYqAoRxMwg/boe0sM9teEv9YA
         gJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=of2x5lvAuGZZISiXgz474RwZ3LgUvSAn73pq9BHWecA=;
        b=kHQ0+uNXh/J9yWZ5iMfwjAnC2VfujjteREyzK9ZLkq6y1HliZ6WADlWmOGebO+7LDC
         TA28xUZbV0ySjemEPebXgX06fFxuxJmyI9n9HSpo1CiML/9tspf45WnhroBMLkQgeAcu
         wolSoW0MIMJX3da6MNudw85i7kPMQzQM+p526R/a9ORchdkroTeUzePRTWTWjjBnWLU4
         tNhshn2r2wuekAbF8UtR98eOAkVqiVSzvpT0YFcFxcKJm4UuNUtfLO6laBy3qZKyHQmC
         KvSF6HsIwkeOFoIKZ3zMOSp6m15qrsnFc9NYiLlN8e7XXUevFPXUuxq48UMNO+BwS5Zz
         vVFw==
X-Gm-Message-State: AOAM530oCT+NitlHNMQFkwlP3hHjQQN82ViWh+SsHUCDZg1E3gjXIRXv
        pLlTh0X0BVcENhnQA5lAbL4=
X-Google-Smtp-Source: ABdhPJxE6Oeqg3yyLJk9EPIj3I82abb+VGE7ljtS6QE3RtAJ1qmVRcpNZbbmwVH/HoEcmatYQW2A9Q==
X-Received: by 2002:adf:f1c3:: with SMTP id z3mr26854773wro.201.1589886892590;
        Tue, 19 May 2020 04:14:52 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v8sm21041368wrs.45.2020.05.19.04.14.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 04:14:51 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: fix pinctrl-names for gpio-leds node on rk3326-odroid-go2
Date:   Tue, 19 May 2020 13:14:44 +0200
Message-Id: <20200519111444.2208-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'pinctrl-names' property should contain a list of names
to the assigned states. The value 'led_pins' in the gpio-leds
node on rk3326-odroid-go2 is not a state that is normally used,
so change it the common name 'default'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index 46826b6e2..b3a8f9365 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -127,7 +127,7 @@
 
 	leds: gpio-leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "led_pins";
+		pinctrl-names = "default";
 		pinctrl-0 = <&blue_led_pin>;
 
 		blue_led: led-0 {
-- 
2.11.0

