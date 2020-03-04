Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC536C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A702166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipv6JMiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbgCDHlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:41:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34548 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgCDHlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:41:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so1094593wrl.1;
        Tue, 03 Mar 2020 23:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CrHAGg7xO0NT1A0T82S72pHlkMFHuRzLgTSmN7ed1nE=;
        b=ipv6JMiDw6jP42BqOvDDy9Yh3RXYzZGPYyDcU9jXEqL4JxdqaTmfpcYntDy+H33beR
         2f0GsEhs7IsntUPTAfnYI33ifPrYDREXuxlsb3vVIEOu/NhxBcW14ekLXlN1tn3uRxEQ
         rfG14QpPV2D07MSU0WGqQV0A9EpuwEzueZF/uIBBK6FQTvQPCYYB+vVBGAgt7GoKJsOr
         qf/8dgdyaoCc4cHLCTFG5CFuWSCbhQP0H0R6mE5k/N2ahBwO1tBdxSPqHaBUGzGz6iqp
         JfAlYBFJaoyPJ0EkhHQDoawMGHk657Jnl4ifI2eGN3IkzFC65H1mQfCKcRoH5v1VTjbg
         SxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CrHAGg7xO0NT1A0T82S72pHlkMFHuRzLgTSmN7ed1nE=;
        b=a3Xayg7ZYpD6XfhTFY7gRC5PYY5zEDDr4lDMqEcQl0fM0m3Dq55QfLsO3lfJzaYsTd
         NORGsZ/fZ9dmIu0AgiSzQ+GvG6tKOGEwNB9aw3JePOBjyXhI4TbsEH5ke39EVnp62ryy
         0sujdJCpnyJb68lUHBVpjMmxaSNrMkl5okFlruXy2ufIhB1q/TiMGz3x7f9JI2/gH2la
         1JSqQLAu7MuAK0bHtbEkajfydUkNA0f2Ou7MQgFZkopk6ZanBaVvB+WvUj7DP0cTAy6p
         j8+Kp0rQJnsVWDqIsL6QYV6nZVcyE6dmxAQ7Zy9dW1w3nJQXSdgyrdmlzBhZw0fA1EOc
         my2w==
X-Gm-Message-State: ANhLgQ0k3/8cchoobv9oOodJQQeekoGYezw9cCxtijtgby8vDP1aXH3B
        Cv6KYPWnufszkwCPhNVwFh8=
X-Google-Smtp-Source: ADFU+vs1bZk9bnffIwK2hnQ7f7/N9rjAEGy/0M/3YUa4nM2yYGwzhot/uOrj5R/5NG1RttDv7QCOWw==
X-Received: by 2002:a5d:410f:: with SMTP id l15mr2638334wrp.245.1583307660517;
        Tue, 03 Mar 2020 23:41:00 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m16sm6410530wrs.67.2020.03.03.23.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 23:40:59 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: rockchip: add missing model properties
Date:   Wed,  4 Mar 2020 08:40:49 +0100
Message-Id: <20200304074051.8742-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives these errors:

arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: /: 'model'
is a required property
arch/arm/boot/dts/rk3288-evb-rk808.dt.yaml: /: 'model'
is a required property
arch/arm/boot/dts/rk3288-r89.dt.yaml: /: 'model'
is a required property

Fix this error by adding the missing model properties to
the involved dts files.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
schemas/root-node.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288-evb-act8846.dts | 1 +
 arch/arm/boot/dts/rk3288-evb-rk808.dts   | 1 +
 arch/arm/boot/dts/rk3288-r89.dts         | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rk3288-evb-act8846.dts
index 80080767c..be695b8c1 100644
--- a/arch/arm/boot/dts/rk3288-evb-act8846.dts
+++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
@@ -4,6 +4,7 @@
 #include "rk3288-evb.dtsi"
 
 / {
+	model = "Rockchip RK3288 EVB ACT8846";
 	compatible = "rockchip,rk3288-evb-act8846", "rockchip,rk3288";
 
 	vcc_lcd: vcc-lcd {
diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rk3288-evb-rk808.dts
index 167882096..42384ea4c 100644
--- a/arch/arm/boot/dts/rk3288-evb-rk808.dts
+++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
@@ -4,6 +4,7 @@
 #include "rk3288-evb.dtsi"
 
 / {
+	model = "Rockchip RK3288 EVB RK808";
 	compatible = "rockchip,rk3288-evb-rk808", "rockchip,rk3288";
 };
 
diff --git a/arch/arm/boot/dts/rk3288-r89.dts b/arch/arm/boot/dts/rk3288-r89.dts
index a6ffc381a..a258c7ae5 100644
--- a/arch/arm/boot/dts/rk3288-r89.dts
+++ b/arch/arm/boot/dts/rk3288-r89.dts
@@ -9,6 +9,7 @@
 #include "rk3288.dtsi"
 
 / {
+	model = "Netxeon R89";
 	compatible = "netxeon,r89", "rockchip,rk3288";
 
 	memory@0 {
-- 
2.11.0

