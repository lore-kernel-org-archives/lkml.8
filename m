Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD07C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9F72469C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWmxNJ2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgB1Ljd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:39:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33035 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgB1Ljd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:39:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id m10so9159650wmc.0;
        Fri, 28 Feb 2020 03:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HmPLXJpOCywpZeq5lAD4FjaTX4sOpZWVoDemtjk5yXw=;
        b=sWmxNJ2/LfZPrwNbIlrcBLLDjCgorHwi+uDe9ivm0XmvKzs3C7A+9/OX45MvkFI1NY
         bMh+KV5Zjy1uXcPIFddnKJ4wWmJrWMnI70QLnh1N7NumFw098Vi9w3qgONutUWmgrqbc
         Dk5M5RO6rBey+OqWzVdOIOG/Ew4s2SPI+ksKGgFjPyqV/3gvtCrYi85af+lVDQzpKU9J
         i42QqVVi9cYS39pTZZLPz1PGUe+ZXJG7qBbq4HFyLE7+8BYlfyeDUxHkzGAGfo3LMC40
         0K1jQhu5R7QGRDM20zW4pPaM5tBLkwPSx3VdopFhDvFuz5px2CNVk6hFBVopHMBV/O/c
         EkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HmPLXJpOCywpZeq5lAD4FjaTX4sOpZWVoDemtjk5yXw=;
        b=eCj9jS37680PRjQ2QoR63q50+yvsJhs1hNnxVjMBcxVYc9JIfZTAKjrh2PWMyncdOB
         3zBRfCTnTab6vLOso+a7aEMUCaGA+iFS2sIJOtN2PmMj+Bl3OGkF5MdE8pX2Wq97AqNE
         ElTeRPL5xtE26jV5FTifYrHdYUQDx0Fnqm4ShKOXXLDpYxiK0stv70o0N4gvRKRSYbZ+
         HKRgbqgFad13QrLHbkMkY+ghzO+yi5HkHK19bu0fB9Co+dD694eadrm8zcWtxgC9qWQP
         Atf8r0ZD0xWgGObpMQgb33Qcqi0CAf8S3y9vFCwQJF6gQRFSGJ6iDo6kv0Kf95DC0WG7
         sSeA==
X-Gm-Message-State: APjAAAUB9T+199YuLEPkq6lXRzer/r03/xZWXOlk5cvPgbvpQQ/jbGC+
        W6ALarOJXYHRW1du5bdVmuk=
X-Google-Smtp-Source: APXvYqybX1CYwMeuUYbdLHcAbibwv6Xf3qhi54cLwS/IJwbBOzV5j6W4y3iXzUnZoGBvUYIPlYnYxQ==
X-Received: by 2002:a05:600c:20c6:: with SMTP id y6mr4515359wmm.95.1582889971316;
        Fri, 28 Feb 2020 03:39:31 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q1sm11554294wrw.5.2020.02.28.03.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 03:39:30 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: remove g-use-dma from rockchip usb nodes
Date:   Fri, 28 Feb 2020 12:39:22 +0100
Message-Id: <20200228113922.20266-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200228113922.20266-1-jbx6244@gmail.com>
References: <20200228113922.20266-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives these errors:

arch/arm64/boot/dts/rockchip/px30-evb.dt.yaml: usb@ff300000:
'g-use-dma', 'power-domains' do not match any of the regexes:
'pinctrl-[0-9]+'
arch/arm64/boot/dts/rockchip/rk3328-a1.dt.yaml: usb@ff580000:
'g-use-dma' does not match any of the regexes: 'pinctrl-[0-9]+'
arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml: usb@ff580000:
'g-use-dma' does not match any of the regexes: 'pinctrl-[0-9]+'
arch/arm64/boot/dts/rockchip/rk3328-rock64.dt.yaml: usb@ff580000:
'g-use-dma' does not match any of the regexes: 'pinctrl-[0-9]+'
arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dt.yaml: usb@ff580000:
'g-use-dma' does not match any of the regexes: 'pinctrl-[0-9]+'

'g-use-dma' is not a valid option in dwc2.yaml, so remove it
from all Rockchip dtsi files.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/dwc2.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi   | 1 -
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 75908c587..4f484119f 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -870,7 +870,6 @@
 		g-np-tx-fifo-size = <16>;
 		g-rx-fifo-size = <280>;
 		g-tx-fifo-size = <256 128 128 64 32 16>;
-		g-use-dma;
 		phys = <&u2phy_otg>;
 		phy-names = "usb2-phy";
 		power-domains = <&power PX30_PD_USB>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 1f53ead52..bad41bc6f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -957,7 +957,6 @@
 		g-np-tx-fifo-size = <16>;
 		g-rx-fifo-size = <280>;
 		g-tx-fifo-size = <256 128 128 64 32 16>;
-		g-use-dma;
 		phys = <&u2phy_otg>;
 		phy-names = "usb2-phy";
 		status = "disabled";
-- 
2.11.0

