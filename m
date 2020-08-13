Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021A6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D462A20716
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+x3NSPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgHMRZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMRZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:25:03 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EEAC061757;
        Thu, 13 Aug 2020 10:25:00 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id v22so4805843edy.0;
        Thu, 13 Aug 2020 10:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rSB8VVTvzJbQ2bhhJZj7hUI5mv93QDUUshAlmirOUtA=;
        b=c+x3NSPqjwWvDSgs3rLRPS/myd6Ky3FgX8yuOwAPAlleEeiEqEEE2tzOl7fzjJdE0s
         ssTQzwyAAb/RTFFgEMmqaFKMCO0NUfqOd8PyxwW1BGvOkxKw1Xg/BMarEPevtrCgoTjG
         9xLki6fJBLkST2VXBNEGooWW+HkDoBg8z12yDZ1/oy2hhxZxLGfIM1fNzAW6u0l/lY1q
         E8fjSh7idIZSivlQ+rotSlpY9Noh2AV1JD9muDoBsHv96F6rNVy8Z0w7jDj2tLxezKnl
         Lc7kCFAO+/F7qi8rXbXyeOKPKAeFrrMZrVms4BW5RfUB9R51Tasq78gG82x/UEhPBUqK
         YYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rSB8VVTvzJbQ2bhhJZj7hUI5mv93QDUUshAlmirOUtA=;
        b=gul+f4AcuZYSeeBTQoRXsam7OkdEeALQoUbnKSkp5hrpAx7Fvi4uuDMmfpqFRSCYmm
         3RlXfPvUOdJ/7ikC+sIlp0tCUQ85MhZgxfG+52DDPSkGGj+Z7WANY200ZAYJPfOMsM2h
         od/aLJN/Kj0aIFr4dm+OF1m1GRp0wbg+nUPODcAUEhMTJ+6es9eqOxoChEdj/iJVy3Kl
         Acu2dAmoM/4VpoD+GLBb3mSbtuO9s4l87viXDQdAaFk80+bZXneeUu5ymCLx3poVa48h
         Pb63fKLBLxF7KctFK4K1eqZOAGf3HhuIXIVUNLR1zEcXWG+3BSG9l8tFQ3idmTZAHYfA
         i9Qg==
X-Gm-Message-State: AOAM530yVNIHqHwZrDN9ZVGWY5MIsvuPrAyX2cimNXslka9QfpvVSLRI
        davbxWFVzJq/nhLj8jTcdvA=
X-Google-Smtp-Source: ABdhPJwUpMviHhcDaq2Pfp/b+cSasXXDYlD4c2EJfbiFFCF9FcIzkMU6r1RZW7EUcBCrymI+g2F1TQ==
X-Received: by 2002:aa7:cdc4:: with SMTP id h4mr5532080edw.252.1597339499335;
        Thu, 13 Aug 2020 10:24:59 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u4sm4369408edy.18.2020.08.13.10.24.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 10:24:58 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: rockchip: rk3066a: add label to cpu@1
Date:   Thu, 13 Aug 2020 19:24:50 +0200
Message-Id: <20200813172451.13754-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add label to cpu@1 for later use.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index b599394d1..252750c97 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -36,7 +36,7 @@
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 		};
-		cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
-- 
2.11.0

