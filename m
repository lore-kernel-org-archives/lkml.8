Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC39C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B2F207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJuZeawC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgHST7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgHST7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:59:51 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69325C061383;
        Wed, 19 Aug 2020 12:59:50 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b16so26058562ioj.4;
        Wed, 19 Aug 2020 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ygavyca8ZgkVKwDX6HM+0kMxYdRp4lQl7aXJqvcjge4=;
        b=qJuZeawCAlnY0Njy54IJuctZsoc7VD0hoYOptrT4jsw8QJ+ZZkA2AkTMGoXqNhieC0
         h1eEqLUFDpXDcGSvvuE0+MedBqsGM80a3xsOM20mH+BF/jZMrtJLlTmpLPEutPHUgrS7
         z8+wV6pIzxJmsgYWOb3hyl04QSeflTSUHz/SPwOFUmo2/SWinfDBNoN7pV7G4zvSfNCq
         lmWhXZCHha4ie9t7Q1XrnERxu68Jkyb7n/fDGkSimrBIhXg+3oDAu89/8M16IzL+q1sX
         SjHMVIp/Go9uXVdIvGmJ09qtfn0a15ZrLg5/dXGXqSm54XtuaMV7pTcA5trmTFBYq76o
         dC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ygavyca8ZgkVKwDX6HM+0kMxYdRp4lQl7aXJqvcjge4=;
        b=JxSVlsRyQd8XSMOXBAb+/YLs54ho0HXqNb0uT7Mz6RoaSvMkN6wkYp+sRnHKdSy07v
         Y4zQ45L7afkCsv65Q23Goo0Ph7sHNZ1qtyfxnMFn4h6x51KdjPcZO89Irs6OI0pDeylz
         p/524/0a0iOD49E2uUFNDIIN1gn4M7MOsgMgexxJuYfa+dKTVravjV/o8KfCBpnNf2BG
         To0zyODgjyhxomvLO09wUanb/U24BrjB7Evwo0x7xVOcWQjGZSArJNQ4qlyDBiGSPIda
         ovKJdCktBI6OkkOFp98vTBRdCrTm1qI0mmk+//gUNqd21o37NEPHSBQygjC/5uwJgZuz
         316w==
X-Gm-Message-State: AOAM53050+4LRwL1NJtU0Y/PXLl+Y+taGUhfF363OKFNEqrjSa0JTPD6
        NF2vC9B06C3W/tWVzJC089fhqJDmrgXiBfri
X-Google-Smtp-Source: ABdhPJyqkWObDuUVCFnt9qBI+a2Axf8B4VbXkzie+QYSIi7v5Ae2U9+rxBKc7KdYO1QAVWg8ESsDrQ==
X-Received: by 2002:a5e:a607:: with SMTP id q7mr21426824ioi.16.1597867189624;
        Wed, 19 Aug 2020 12:59:49 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:b588:1a5f:55c3:870e])
        by smtp.gmail.com with ESMTPSA id c88sm10447354ilg.5.2020.08.19.12.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:59:49 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3] ARM: dts: imx6q-logicpd: Fix broken PWM
Date:   Wed, 19 Aug 2020 14:59:44 -0500
Message-Id: <20200819195944.2866832-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTC doesn't like the default PWM settings, because it's expecting
three cells.  This patch reduces adds the extra entry of 0 to the PWM
reference.

Fixes:  fa28d8212ede ("ARM: dts: imx: default to #pwm-cells = <3> in the SoC dtsi files")

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Don't change HDMI

diff --git a/arch/arm/boot/dts/imx6q-logicpd.dts b/arch/arm/boot/dts/imx6q-logicpd.dts
index 7a3d1d3e54a9..8f94364ba484 100644
--- a/arch/arm/boot/dts/imx6q-logicpd.dts
+++ b/arch/arm/boot/dts/imx6q-logicpd.dts
@@ -13,7 +13,7 @@ / {
 
 	backlight: backlight-lvds {
 		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 20000>;
+		pwms = <&pwm3 0 20000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		power-supply = <&reg_lcd>;
-- 
2.25.1

