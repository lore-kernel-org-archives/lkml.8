Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1811CC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4ED4215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5oGKA/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbgCDHlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:41:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54974 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgCDHlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:41:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id i9so749747wml.4;
        Tue, 03 Mar 2020 23:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zaJoE8S6ZoYeei3qANBHRGMHafpbqFjs0OJRPS7inbc=;
        b=I5oGKA/UWW7QwBvJ3wSieVr1KrOam29uhrWVFyJ5NShFtWmXS+wm5O+7mUKNS5Wi8z
         shOlw/C2PyNt+V8WIOWvMAVn3Kk4InYVY5Wg6OK3nLXbh1EbJb8vouDBFm3yStE1AopM
         ckEbB82cX+WY6Wyzpci3c1xu9loT169vXv73YWaPeyUc6Q5ZJGzedG0uOqJbTjBGJbWE
         WS4Upwtv9gUEi9lHfV1Y3GOAaGC5FeZ0TfPCCzY0NMhD4ES8MXVARxwRNqvby2q89v1p
         LWk4TbrY9acWFcbqcg1JE+hPmviVwkyU8cCYWEDsfZ9+yvo1zJJwMVKZnA+v0ls9j+p2
         TgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zaJoE8S6ZoYeei3qANBHRGMHafpbqFjs0OJRPS7inbc=;
        b=Clj0zaRm5WrSk8E8gYw2D3b3fjt0D+H4SZ3T4oKpUjGlLirJ7HSt+l9U/koO5axXX7
         RzQ5vIetprYk04c5lXEJQOpoIukjckKOaXWIfTbw6+OyJCs0MyNW8gWbySVrRDcJsEzg
         ESWymdPCWHSSmld7WZaDn7jtTs8y4wkonHtaEO/Oq/p4f3PzsxedA5MB+BYdiZyoZBK1
         Y7wpBW3km7bWYaV60xKZdj8or0KdOtm/NzCZTAwfwfyBHpl4dc7qWGW8RaxaPn0Payda
         QJmV3ECAAqwqGyuBZJJS80A+bIaJ80vizMIRpWK1/GEwyBrU7tKqZx9bdUyvNriBd8xq
         F64A==
X-Gm-Message-State: ANhLgQ30ndqO3v09tBKWPMf0TqZA/uSCly1TgEwCMtXx855sJCw7W43m
        W09aV3y4iw+Q30JkHd+CMJ78pQVx
X-Google-Smtp-Source: ADFU+vvLjNcHwxp+EXcjbM13xCnQx0EC41KlBeGvt1Ll82wKDOjh2PiuZOTCyyaL63+lJ3bvpLSuEA==
X-Received: by 2002:a05:600c:214b:: with SMTP id v11mr2277253wml.13.1583307661540;
        Tue, 03 Mar 2020 23:41:01 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m16sm6410530wrs.67.2020.03.03.23.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 23:41:01 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: rockchip: add missing @0 to memory nodenames
Date:   Wed,  4 Mar 2020 08:40:50 +0100
Message-Id: <20200304074051.8742-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200304074051.8742-1-jbx6244@gmail.com>
References: <20200304074051.8742-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm/boot/dts/rk3288-tinker.dt.yaml: /: memory:
False schema does not allow
{'device_type': ['memory'], 'reg': [[0, 0, 0, 2147483648]]}

The memory nodes all have a reg property that requires '@' in
the nodename. Fix this error by adding the missing '@0' to
the involved memory nodenames.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
schemas/root-node.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288-phycore-som.dtsi | 2 +-
 arch/arm/boot/dts/rk3288-tinker.dtsi      | 2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi      | 2 +-
 arch/arm/boot/dts/rk3288-vyasa.dts        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-phycore-som.dtsi b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
index 77a47b9b7..9e76166c3 100644
--- a/arch/arm/boot/dts/rk3288-phycore-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
@@ -16,7 +16,7 @@
 	 * Set the minimum memory size here and
 	 * let the bootloader set the real size.
 	 */
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x8000000>;
 	};
diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index 312582c1b..77ae303b0 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -12,7 +12,7 @@
 		stdout-path = "serial2:115200n8";
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x0 0x0 0x0 0x80000000>;
 		device_type = "memory";
 	};
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 54a6838d7..c089ce008 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -18,7 +18,7 @@
 	 * The default coreboot on veyron devices ignores memory@0 nodes
 	 * and would instead create another memory node.
 	 */
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index ba06e9f97..889b95e95 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -14,7 +14,7 @@
 		stdout-path = &uart2;
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x0 0x0 0x0 0x80000000>;
 		device_type = "memory";
 	};
-- 
2.11.0

