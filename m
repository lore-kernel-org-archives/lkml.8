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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF13C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44237207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCf7mY5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHSTs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSTsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:48:53 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439A7C061757;
        Wed, 19 Aug 2020 12:48:53 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v6so25879283iow.11;
        Wed, 19 Aug 2020 12:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dbyMcmvoDSVMfgZuxjO+oDADjCPCdht3Erl74BB7i7U=;
        b=eCf7mY5VQ1lJZ1+6XwoRX21POkc12BLUnkujL6SHqNFm6rtkTmFXRgm8ODYzWn+aKC
         diSfG3xMxaNRqlzKBWb5Ih9FYogjRu7u1FZXsUMsU0g1Mix/adoaA/dSx30glgj3d8tc
         0BVjF41Z87qQrQkMwR4CIq9MNDHlfqX0UZOs2UL8HqrjH5XvVD5xHhe9j7iD9FnGPN76
         UH1MEpk1NFdQvRHP35PlrcRG5KOqDQho0jGY6fRQj9Vr+Uq4HcCWNF6DDgpNZZXB0mbT
         FtROBEkJ4vuYoYkPIhsNF4+vgrcfX68YQvymHYX5F3LkQzYp2kWCbu8Rqurzv/2oJToc
         BA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dbyMcmvoDSVMfgZuxjO+oDADjCPCdht3Erl74BB7i7U=;
        b=URqKbz8RnlgKXugrbm9SGV9yHcGax3sRYs6tW0XAD6qA1flarFZDYp+rDReKruQX0U
         mlFPBoxi9Huzcu9vTNW6fZ1Ib9sWNAFFwGGv890Jzo4M9a/unUhyZOljJeDN2mStGKzB
         +SSHvVcOBckfsvxoIue2CJAbUro7Qq5XP0a0a/Ob2uHS38hnypru3j9X2CNgNMp7vQte
         zRuXVxdJsddMIGyiGagyqAHPfKH5wsNOPgBFjpVY3hYdqP2g+VDddhuy/DeMuwC7xRiM
         GZCQAPGw99jC02xBco61q559tlOewr3BW0iOtQXqtcsS3pdrCjV2Isqen2usnQXmjei/
         eDrg==
X-Gm-Message-State: AOAM530A/d72QoOZ15tPbhG3MNuagL0Q/33jK63/03jtoPyhbgpOEI1d
        g3CVeOBWpp0Lr5rI+dGYT30=
X-Google-Smtp-Source: ABdhPJwUY1KrT5Y0/Nm87NaMqnYCy4hVHrqZSz9XFRE38R5GJao0eRP3+6XjkwwZ5LM0JpKrXxfdyw==
X-Received: by 2002:a6b:b246:: with SMTP id b67mr21885541iof.54.1597866532486;
        Wed, 19 Aug 2020 12:48:52 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:b588:1a5f:55c3:870e])
        by smtp.gmail.com with ESMTPSA id e1sm14285525ilq.40.2020.08.19.12.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:48:51 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] ARM: dts: imx6q-logicpd: Fix broken PWM
Date:   Wed, 19 Aug 2020 14:48:44 -0500
Message-Id: <20200819194845.2866317-1-aford173@gmail.com>
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
---
V2:  Don't change HDMI

Signed-off-by: Adam Ford <aford173@gmail.com>

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

