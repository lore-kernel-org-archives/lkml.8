Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A48C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 09:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB6520826
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 09:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Dw2tzH9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgGDJ4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 05:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgGDJ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 05:56:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF62BC08C5DE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 02:56:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d194so12792025pga.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 02:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DLjCzGoFPMdbYYDaSDjKoYN+kjyqA5RMXC52YJAeII8=;
        b=Dw2tzH9GMo3t6v2OWZ2FKYd50INhuVgAYZ1RNNDAkmfjXIxgihFgvl5W0/JEsbpCfM
         2I2pMwGx+TgY4MyXNoIZABQt8fDBH3vKxvGq8E7jkjhrpx/HK1uPL3Pgv3uR/spZBERO
         5ZNV4b2Rebq9XiKdCHHOP9a6crADnQ6DvGrqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DLjCzGoFPMdbYYDaSDjKoYN+kjyqA5RMXC52YJAeII8=;
        b=QTNZnuXq4xohOVb4ujX9bXJcsZLUZZNmI43QzFItIhWzhm9nOQwH/04nzI6/QfEAcs
         BR6KYKOBdEQai1QeckR3q1r45xZe8Ss8STub91Ekkst6iSvIV5dZsFrJHq+1HHixJj39
         JI9S+QtFHytuXnKrukBQDtMUazigUuwXkAP8s3CIb+vZWt1WpJltPhWFbCAJN2No+tzT
         5iXW7AEihVfCAvIuBKfa2iYBQw9DqB31TAgJWyhM3e6VTjLUpB/99WYN55p6yV8BhV+V
         naNIdDgDysMq/veArT0Wg12S9OFP4RXXCAQ6Ccqd1jimtM+yxvcC8HK/lDGMocxVGucX
         rI3Q==
X-Gm-Message-State: AOAM5322nj8Ec59BJ+jBcLHjQsjx4OD1vF3gjSDEYzAWVVYtqkH/ItGI
        J7QVhDazhrnKjB0W0l+WMuo4Fw==
X-Google-Smtp-Source: ABdhPJx32emjYkDYX9utXROC3YKYNpVwdpnluoe5KD8t6o547/d5ZwrxwXPuuLtCp+COopbqa/lffQ==
X-Received: by 2002:a62:5c02:: with SMTP id q2mr37304228pfb.232.1593856599134;
        Sat, 04 Jul 2020 02:56:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:bdf4:3289:4b66:dcc0])
        by smtp.gmail.com with ESMTPSA id t184sm14302575pfd.49.2020.07.04.02.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 02:56:38 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        mylene.josserand@collabora.com, Robin Murphy <robin.murphy@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        William Wu <william.wu@rock-chips.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2] ARM: dts: rockchip: Add usb host0 ohci node for rk3288
Date:   Sat,  4 Jul 2020 15:26:18 +0530
Message-Id: <20200704095618.72371-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rk3288 and rk3288w have a usb host0 ohci controller.

Although rk3288 ohci doesn't actually work on hardware, but
rk3288w ohci can work well.

So add usb host0 ohci node in rk3288 dtsi and the quirk in
ohci platform driver will disable ohci on rk3288.

Cc: William Wu <william.wu@rock-chips.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Updated NOTE comments.

 arch/arm/boot/dts/rk3288.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 0cd88774db95..f0774d9afb67 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -614,7 +614,16 @@ usb_host0_ehci: usb@ff500000 {
 		status = "disabled";
 	};
 
-	/* NOTE: ohci@ff520000 doesn't actually work on hardware */
+	/* NOTE: doesn't work on RK3288, but fixed on RK3288W */
+	usb_host0_ohci: usb@ff520000 {
+		compatible = "generic-ohci";
+		reg = <0x0 0xff520000 0x0 0x100>;
+		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_USBHOST0>;
+		phys = <&usbphy1>;
+		phy-names = "usb";
+		status = "disabled";
+	};
 
 	usb_host1: usb@ff540000 {
 		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
-- 
2.25.1

