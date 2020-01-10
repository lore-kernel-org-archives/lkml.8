Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4148DC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DE22080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DM68tMCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgAJNo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:44:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34946 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbgAJNo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:44:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so2044138wmb.0;
        Fri, 10 Jan 2020 05:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g1iXX7TN7q8kc/bF8PanewJ7fQngTYXBHeGSeFjVWds=;
        b=DM68tMCOF7AcQsfPyRsge0ufcIZ8Z4FE+S0mhA2/9KrwvHWPWgBzdsGGuJD3eXrmtU
         RRZ9NJE9v7j6N6GKSN/nh8Uv5xQbRUKVzfVNf+Xrt5BFd9OMz0yBDnjrAbI8vrEL5vSw
         +zO251pYvU8nIPZb4ci5RHJoaqAfLqmEXF/N8dKBJpIeRSNSCLVW+1LxnxgY/BRsYIvd
         XoNUfcDSvOzrusnLdfPzU+DIY754tlTZ28GMT6vvdrBFMIXAy32/lf8hWgF2PT1MPjlW
         nUCR0lCgsRWshkt70v4jjae73b6svxgqP+fUl0svtgqqCFB4b+rP/5TWF89dE//ICbbF
         JxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g1iXX7TN7q8kc/bF8PanewJ7fQngTYXBHeGSeFjVWds=;
        b=ZM4nBptRM8gQbLorcw764cYxHb7Xy1HgeU9PqSBp70/Yk/ds3NorqlKv0AzA+Pv3rx
         +VXIcLST9pe4hl4nxtAZlXFYYpEB3TvhHh85q7HQ8ySR3JE0Czbktjf3bVsJEjFka78f
         lOxevt4G6rz+aIQWgG4rC/LYHUHP3OPUMqXpw+Mh3fKDCOCrjy8duntdmvTs4TgDX4UR
         j/zmDPM08p6CgOqvLOMBJ9OSczQRRTg0gu9s4wWMga7rdKT10JzwerVESEoK5P9A3kwI
         8+xrJgQXDXs2Dte3vaKzm/Y9BwmEmv1degbUVejEo+2zNWaTOuGL/h6T1IGGPt86WNLt
         q8aw==
X-Gm-Message-State: APjAAAWF9Lf8Lb48lsvRWr9TH3/B4O+xVzyMST6urK4evSJ5gQhkEtoD
        JuMSquRr5/5h9CZOPSKVXHM=
X-Google-Smtp-Source: APXvYqwqXBp9Rf/1rjxjmuLMJTD7KoBkIxYNWpnuqjQXo/kPVf/r0aciCxPP/fSmM6qLFWMCxW3qkw==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr4416957wmi.51.1578663867444;
        Fri, 10 Jan 2020 05:44:27 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c9sm2213656wmc.47.2020.01.10.05.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 05:44:27 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: add reg property to brcmf sub node for rk3188-bqedison2qc
Date:   Fri, 10 Jan 2020 14:44:20 +0100
Message-Id: <20200110134420.11280-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An experimental test with the command below gives this error:
rk3188-bqedison2qc.dt.yaml: dwmmc@10218000: wifi@1:
'reg' is a required property

So fix this by adding a reg property to the brcmf sub node.
Also add #address-cells and #size-cells to prevent more warnings.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3188-bqedison2qc.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188-bqedison2qc.dts b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
index c8b62bbd6..ad1afd403 100644
--- a/arch/arm/boot/dts/rk3188-bqedison2qc.dts
+++ b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
@@ -466,9 +466,12 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd1_clk>, <&sd1_cmd>, <&sd1_bus4>;
 	vmmcq-supply = <&vccio_wl>;
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
 	brcmf: wifi@1 {
+		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&gpio3>;
 		interrupts = <RK_PD2 GPIO_ACTIVE_HIGH>;
-- 
2.11.0

