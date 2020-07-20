Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC4BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 864282068F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="R3xW78P+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgGTK7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgGTK7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:59:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD3FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:59:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so10048883pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NV2nv0m/i4PWrK4r7Y/F/y8REceyZBWN4KHSSee/EVw=;
        b=R3xW78P+619xgW437IQlUC8v2vkTtoeUwA6HMKwDMcXthJEOLbHGKWBHScwB9ymMRF
         pHJ3Fkq0QWbkPqaGk6ZcI7yblpdUkQk3WFwiB4Yr6UOuN4EPanK3hXNR1I3Wa58FZeEB
         3u+ALj8+OMP0m7hTLIhtKhhjQcS3SO/C0EdIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NV2nv0m/i4PWrK4r7Y/F/y8REceyZBWN4KHSSee/EVw=;
        b=giiENvii5qeLyIr4sWfoX83G1htGqzYa5XBUtBE1mZ2I0VjTlrrA6q/+L00gZRKkC2
         ahWEDQIAeyJB0q1XLiiWogR1oVxAPqsgvyABvuz+Htvz+vAlkC0gmnrQ7Sd6qQ1zlROh
         mdjD0aQBBDDguKNy2cZALzhufgy8HedKTky1lL0DQbqticB09MNqqrPVnnkci2uNO8gt
         zEK7nmRZPl7ZxXduTuo28lwkN700ctenxJ3sZO95KR6S2txmQGHeLMwLxCb5g27QYKP1
         FPVY6CkN/IUsPvhWrSLRLRpFNfJBp/ykxNJVK2iIZ2QJqqC7imBhLllPxvrNAFSuSSsL
         OreQ==
X-Gm-Message-State: AOAM533ARUdBUuh2P1zDHdJ4CAS/sElk2vIaqqDgn9yLXbzWaZZ0Ysuo
        fA6D968akXVxOLtDmFwanb2mvw==
X-Google-Smtp-Source: ABdhPJzFvPMmvpy2zrXoDgPh7VwnXAfVEjNvw+4sm45X9CkVVdWN+xdzon3EKx0JIi+K87Pj4k16ZA==
X-Received: by 2002:a17:90a:f6d8:: with SMTP id er24mr21704466pjb.203.1595242774120;
        Mon, 20 Jul 2020 03:59:34 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:8c21:db7b:4558:fba3])
        by smtp.gmail.com with ESMTPSA id b8sm10817049pjd.5.2020.07.20.03.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 03:59:32 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        William Wu <william.wu@rock-chips.com>
Subject: [PATCH v3] ARM: dts: rockchip: Add usb host0 ohci node for rk3288
Date:   Mon, 20 Jul 2020 16:28:46 +0530
Message-Id: <20200720105846.367776-1-jagan@amarulasolutions.com>
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
Changes for v3:
- none

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

