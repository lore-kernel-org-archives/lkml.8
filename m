Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97241C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 680242075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="J7Bf/zaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgH1QDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgH1QDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:03:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980F8C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 09:03:14 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v16so710356plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBuL7NXBea5SmTknXExQrO1gykZeM6lofEf67YE+asM=;
        b=J7Bf/zaGzFYq6t3l7kF0zNYOs8fUKYCIsQFC/xoW3zbpklt/D7o8M7Lj6wwx7b5jwY
         xpTO3H1pBWcQ8Pd65huZY71y7Y5QFmN1S3G5ErqLHo29pBxga8EMUpO4gX2i+SE264P8
         ntp+IDhNvXd7g6Yl6JrMXizmy8fNudINVLkSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBuL7NXBea5SmTknXExQrO1gykZeM6lofEf67YE+asM=;
        b=q2pDNBq+JZCbnVWdrGpARaWD6wDdW09N2blV/pKHSGCtp+pDvsXzIqqpkWBDLGBXSw
         aUIwNIagTyuYMSHbNX4ED4+6nomidTFDgNEp51Z+h4gmRW/WgNJqsZ56GyyMluOBhFOE
         OVKrB70EXou2z/0Muj6+YnC92jQO52S8ScAATmNzzJZcmMCWIxJx8IHw7Ac+TW9zzb1G
         jr8kYp1+RQI16MbjjZv5xta7h6YMeGaDEJFFIjdVHp2yC91tfbOAg07DnbaLhAwMS9AD
         BdfMr+kPej9glmJT6zOTi7b6shm2ddKjFCT8f07ZNrEgx3Doziif7t0CdjW+0q02AZ8+
         aKhA==
X-Gm-Message-State: AOAM530rhq9EurXTEKbgpikppwQqnAKwYe7kivqX2RVHbQKW3FVXycWo
        /8UwS32F0wbUF22qtLTgdeXklw==
X-Google-Smtp-Source: ABdhPJxROrQ2ZtBP4ViEMwf9AJHkiAkMddzBePTwjlFoqmlXIbqH2WofO8/rNQX4eqrucnXq+FcyLg==
X-Received: by 2002:a17:90a:fb4e:: with SMTP id iq14mr1782331pjb.133.1598630593340;
        Fri, 28 Aug 2020 09:03:13 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:8ce8:955b:ae1b:d6ef])
        by smtp.gmail.com with ESMTPSA id a25sm2157212pfk.151.2020.08.28.09.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 09:03:12 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] ARM: dts: imx6q-icore-ofcap10: Use 10.1" Ampire panel compatible
Date:   Fri, 28 Aug 2020 21:33:02 +0530
Message-Id: <20200828160302.329179-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding display timings directly on device tree files make it difficult
to maintain as a same copy of timings may exist on different files or
panel-simple driver.

We have a panel-simple driver for this particular usage so supporting
on this driver will help to use the same timings on any device tree
files if the board mounted on a similar vendor display.

Engicam C.TOUCH OF 10.1" LCD board uses Ampire 10.1" TFT LCD and
it has supported by panel-simple already, so simply use that binding.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note:
Panel patch in ML already,
https://lkml.org/lkml/2020/8/28/685

 arch/arm/boot/dts/imx6q-icore-ofcap10.dts | 28 +++++++++++++----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-icore-ofcap10.dts b/arch/arm/boot/dts/imx6q-icore-ofcap10.dts
index 81cc346dd149..02aca1e28ce3 100644
--- a/arch/arm/boot/dts/imx6q-icore-ofcap10.dts
+++ b/arch/arm/boot/dts/imx6q-icore-ofcap10.dts
@@ -12,6 +12,17 @@
 / {
 	model = "Engicam i.CoreM6 Quad/Dual OpenFrame Capacitive touch 10.1 Kit";
 	compatible = "engicam,imx6-icore", "fsl,imx6q";
+
+	panel {
+		compatible = "ampire,am-1280800n3tzqw-t00h";
+		backlight = <&backlight_lvds>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
 };
 
 &ldb {
@@ -22,18 +33,11 @@ lvds-channel@0 {
 		fsl,data-width = <24>;
 		status = "okay";
 
-		display-timings {
-			native-mode = <&timing0>;
-			timing0: timing0 {
-				clock-frequency = <60000000>;
-				hactive = <1280>;
-				vactive = <800>;
-				hback-porch = <40>;
-				hfront-porch = <40>;
-				vback-porch = <10>;
-				vfront-porch = <3>;
-				hsync-len = <80>;
-				vsync-len = <10>;
+		port@4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in>;
 			};
 		};
 	};
-- 
2.25.1

