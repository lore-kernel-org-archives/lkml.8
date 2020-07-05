Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEA4C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 03:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D782070C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 03:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pug4s0S7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgGEDQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 23:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgGEDQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 23:16:22 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C197C061794;
        Sat,  4 Jul 2020 20:16:22 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id f23so36073636iof.6;
        Sat, 04 Jul 2020 20:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pq6LZ0E7Bbe02WCqYFQ2Y7llp3OJst3ScHaZ+npPW94=;
        b=Pug4s0S7zgkeqG8WdFZf5sdT+D7ACy9YA9BfprDU6BfXwPOwBOht+0jrVB5d6CoaS4
         h2noIH/RkP3AIEZ5qM5utgu7bkMGUKJsK18EWG1q49WoUlWY1CLhZu+m9mSFaDBLmVdi
         epFBDHARQoDiy5yCUsZzi13EsYXAVusc5w3eRpuerobRDOWAdHI4LZuuuHwUH4e5a7XF
         IbQQDUAkjM7p+PaPI7BIT/4B5Oftr2SmP8fwafvfz0h9jUOZDFn8zrlEkadcKxokwkiI
         zJ6Hd78WooyIBoqrWxl7HPC6wV6B4gEHLcyJ1GpXapA/SKcBOlsS27trD66uqf5htCTa
         gkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pq6LZ0E7Bbe02WCqYFQ2Y7llp3OJst3ScHaZ+npPW94=;
        b=hpawKKgr5RAjHC0zaFw0a5Llx4ZedxM4H8aE6VX05yS/ztuX1V1aUzLAMRgivuNeEH
         2HOTDSZFNo0a4VNltnHzumvO/Q5mv5kTJi8/6RF2zo1e/HdOKvabi6wXd7JdEzN8/3Ww
         1UiAdbaUPRr1ivYDjhtb+IRrwaPjDcRPY2J/mHlmq5Xd9SSb5CAZkSqW/TTzmU/w3730
         vfTkruP4NrhsXgmw5VKxhw8irraM4BwXchJMQ1geytGfSvElZxPZTfz1ViGsf3yX15fG
         92R4IgcdpSFutxKiv32yYcbTexDSQQUGzAAHOcV4qpzkQ/vJkX6xOTYx51B/FQsPssio
         Ul3w==
X-Gm-Message-State: AOAM531Ym81sV6/5h5AT0y+KGvhfq6WJ07w7GgE8rMyue8BaOFUqlwY4
        HpnTAtGtbwlA2GFt8ZPTQrVHH1YRu1HQxRCYrvRNGjA5GXk=
X-Google-Smtp-Source: ABdhPJwA/XogHq2OnFLpz0AQ0QkhXnA+lKdTCY+tUAsrEb/+5T39j8Ofyjq7ehc8k2B046APhttZNZjiraKP5M0ZU1c=
X-Received: by 2002:a6b:b2d1:: with SMTP id b200mr18181008iof.137.1593918981042;
 Sat, 04 Jul 2020 20:16:21 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Healy <cphealy@gmail.com>
Date:   Sat, 4 Jul 2020 20:16:10 -0700
Message-ID: <CAFXsbZoovWBavRFaEWEFcSkVjNx26BkKOkhcutNfzL8MrHwMTw@mail.gmail.com>
Subject: [PATCH] ARM: dts: vf610-zii-ssmb-dtu: Pass "no-sdio"/"no-sd" properties
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

esdhc0 is connected to an eMMC, so it is safe to pass the "no-sdio"/"no-sd"
properties.

esdhc1 is wired to a standard SD socket, so pass the "no-sdio" property.

Signed-off-by: Chris Healy <cphealy@gmail.com>
---
 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
index 0bb3dcff0b79..7d4ddfb6b5b5 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
@@ -81,6 +81,8 @@
     non-removable;
     no-1-8-v;
     keep-power-in-suspend;
+    no-sdio;
+    no-sd;
     status = "okay";
 };

@@ -88,6 +90,7 @@
     pinctrl-names = "default";
     pinctrl-0 = <&pinctrl_esdhc1>;
     bus-width = <4>;
+    no-sdio;
     status = "okay";
 };

-- 
2.21.3
