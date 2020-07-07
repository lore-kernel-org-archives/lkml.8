Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A65DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B004206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cE0rViub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGGKMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgGGKMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:12:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641FBC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:12:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so44463509wrj.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ox2ec9xKeqYNpU//N7D5LOrU5GweWdGDzS15Zrqp/JA=;
        b=cE0rViubzmawGs+s2bNz/HYeJLyTK9UhluVB6bOjXJ+IEJTQNmNzLxv6o7WDhR99GJ
         7O0NOspsGwaqUUZWZhOk2yYCw9Qgr6sNLKG7r0heK45wZDL45btcODXbBTjyPMAG/mwI
         x3JLFhxPnnkSuU+jLELEtwEnFdPJS23UVx8g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ox2ec9xKeqYNpU//N7D5LOrU5GweWdGDzS15Zrqp/JA=;
        b=JIlsxZLyU81V3Glq5nwhqC7KjRmxnzgXReeOzJaWV7txW90bVpdIMpxaHMLEWl79cx
         hdudL0wTH48gCfPvvwoyp318Up2T12uH6jsRsoni+2ZvLD/yRSrWRgLzWniMpJMdSq3A
         N/5BhfQcserXYB1GuJC/kvqI+WzKpM6Lr8BStrqnYzEwQG54YJ4OB8syrgAl0Z6FdQLE
         PThPCz/afwNrH1z88vIpmIe0LKzN8qMxHhU6G5B0uo3+a3znvDotjpg3MqFTXx19731q
         OiR9CMwJ+BcrJEgHiDDze14bvFSW0DgaGOu1Ikd05asWmYcZErclSwL+ifRKyj0rJOCL
         CvkQ==
X-Gm-Message-State: AOAM531vjzZO+T1ZNkBRtyIBTEfUN3dNzb389P4giMKyFBuzD3nKD4Q3
        9DlN32J/S2V+LbhoDMz2468OlAhWrKOJIg==
X-Google-Smtp-Source: ABdhPJxoBYAgdDhWiramJwYkHt3jHpGiUWv4+qul7we1FmarfIbbJjwEpFAWtIooatx3TBXa8a5ikA==
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr50329141wrw.28.1594116736051;
        Tue, 07 Jul 2020 03:12:16 -0700 (PDT)
Received: from panicking.lan (93-46-124-24.ip107.fastwebnet.it. [93.46.124.24])
        by smtp.gmail.com with ESMTPSA id f12sm363053wrj.48.2020.07.07.03.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:12:15 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: Fix VBUS on rk3288-vyasa
Date:   Tue,  7 Jul 2020 12:12:14 +0200
Message-Id: <20200707101214.2301768-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Connect the voltage regulator of vbus to the otg connector.
Depending on the current mode this is enabled (in "host" mode")
or disabled (in "peripheral" mode). The regulator must be updated
if the controller is configured in "otg" mode and the status changes
between "host" and "peripheral".

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-vyasa.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index ba06e9f97ddc..5b0263b1be73 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -87,8 +87,6 @@
 		pinctrl-0 = <&otg_vbus_drv>;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
 		vin-supply = <&vsus_5v>;
 	};
 
@@ -405,6 +403,7 @@
 
 &usb_otg {
 	status = "okay";
+	vbus-supply = <&vusb1_5v>;
 };
 
 &vopb {
-- 
2.25.1

