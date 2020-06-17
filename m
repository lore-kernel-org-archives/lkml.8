Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C342C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF510217A0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkLw1Qi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgFQQtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgFQQsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:21 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3580BC06174E;
        Wed, 17 Jun 2020 09:48:21 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n24so3162325ejd.0;
        Wed, 17 Jun 2020 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+5BoVRG0VffCCrfTH/S4zSbtLgUTIBUYTPvbWiSrIw=;
        b=GkLw1Qi3/TTudWObG01QoJrFLKxkdf91mx1SL4oWeEOC8q6Gv/ljjmyt8pVbLHdDgq
         3OWdR2KGw70+qrKXmtMD9Dj1U6QqT0QwZMe2fqPvA9wh7DzpH17z3QzMgUDhwKP8dAbK
         5Thl1mj79F3RlP0hosvkJkBfjhvKNzKilAp8o2cMRog5w5lUwKjl3HA9DwS7UlF3rtbt
         65TRG1tAO34jE5GgX3b93Qm1fNwFzmOeI5CmZ3fBOB21ntxet87PXhmNSkWo/2HYdDZM
         dWP8u6vrcMoxXDbyZPaoqLJ3YbVRCV4ZDaneO8CTFeiPmpZyz3NEWd2LOBYUV/GOfq1p
         CwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+5BoVRG0VffCCrfTH/S4zSbtLgUTIBUYTPvbWiSrIw=;
        b=J08s87O4hvptKvecMrH+Z6Do1/jZjpPbiv72UeoBvR9kGwDZ/f3EpDUjQZRl5T6fno
         IrU5dwp70IOx/TIt/p/gIOVYBz89ou7vwn4G4dyic06LztSPq6DB0oX6h0Ihbi5QUiRY
         uRmjpWjrKzFzNJXQY4DaIsI4xwT4zRZbQDteGt4CGBfxWZ2Q2FFWgIC93dXPubeaa+by
         ptA+eg7pCE6LH8BqGtw0/MPoJewDuS4oLhhEDJTefXskcb9FOY3e7j5xaHSxab2WeHOV
         r5uDaqgQzGRPWD2W5/Ecu6TsJk7+dnh/U2w+FqvBm0SgheaXIprOqkz39SOV5SFObSCZ
         8Dpg==
X-Gm-Message-State: AOAM530X9nI/oPmrXrWIRlBlheO2R+XMAjWXo+mD/gykDHwr7uJjkaR2
        lcOk0hZPzivqX6Vbhkgijew=
X-Google-Smtp-Source: ABdhPJzya/QUz9hu7DpG378s/WItmQR2ysBmEx0/RnQh/KMg8YjHmMTNVtBDCdDe9YqjZVf+sNcS2A==
X-Received: by 2002:a17:906:365a:: with SMTP id r26mr60093ejb.466.1592412499978;
        Wed, 17 Jun 2020 09:48:19 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id v3sm127124edj.89.2020.06.17.09.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:48:19 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] arm: dts: owl-s500-roseapplepi: Use UART clock from CMU
Date:   Wed, 17 Jun 2020 19:48:04 +0300
Message-Id: <255941aa76e1eec8224c7a88b99924f3bae2cec8.1592407030.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
References: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the UART fixed clock and enable using the one provided by CMU.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500-roseapplepi.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
index a2087e617cb2..800edf5d2d12 100644
--- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
+++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
@@ -25,12 +25,6 @@ memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000>; /* 2GB */
 	};
-
-	uart2_clk: uart2-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &twd_timer {
@@ -43,5 +37,4 @@ &timer {
 
 &uart2 {
 	status = "okay";
-	clocks = <&uart2_clk>;
 };
-- 
2.27.0

