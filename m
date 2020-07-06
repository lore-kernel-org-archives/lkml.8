Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27FCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E89B20739
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu7P5pHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgGFBCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 21:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgGFBCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:02:45 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4F1C061794;
        Sun,  5 Jul 2020 18:02:45 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id a12so37658297ion.13;
        Sun, 05 Jul 2020 18:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=w9Yeb7gwy/GZ1b3/U19gbbXAoGkciXgijg+0bbd2Ohk=;
        b=Cu7P5pHO4MUnblELFIqozSvLN3AdyVtb7SjJC9za6rYpER4A8GRt4pkx9SMzhEdaOO
         PzVJ3+hP8UfZVfyN/QOu20AJ3Wca4P8lek/uaqzXu7niB0LjGXN6SkLfp6gaNrDiMdVv
         jh26aw1fXPeRJvlAb24TQfxDzjhYvnPxvkuLBmTAcTCg5DinFsNLo6iZt8nc8e+V7NVS
         +xQpD+rZAD3zBuE9VP1QsmjIo/BSW4ah92YGVcXbNYSRGeZ1y5wHyou9vIwA/dz2dwjq
         ssFvXsh65PAMCpxi7oPvXzvj0HaH4wcwDYHbGuf0btLyEkjaMnQptdtmz32dRaAO4h/r
         B5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w9Yeb7gwy/GZ1b3/U19gbbXAoGkciXgijg+0bbd2Ohk=;
        b=KxkT8VfGLLQwtirOzuQmBKK7E0xRWefLkpMvJZvaJveNf8ykSyZd0LKSoe96IoKwxb
         Fjnjcsd+MTzYM8uSAXrlKd6OLXxD67AL6xErd2KTCRAKpCTBKpMWqdg7dWSv1ebvW+zn
         eFB7sTsamlBewbxxaD/TD/KgnwsE9kBDFi3LriSbfbdZv4T5+mvBLb6JccvXFCMVRkez
         scAi3tJ6MxbCH/GJtuO5oKsma3vOW64/OVFjpg110VtCjwJowym2Ch0cPvTic2tbmqi4
         xp4qqTOjHKcWM1hw2vFnzo8qlZwFqcKdk6AvEWcP0GMwppoaTdZQvDfb5PibazFv0b/Q
         TUTg==
X-Gm-Message-State: AOAM532lj/A///hiFAjuHqZYjWjo+yR6ylLuSFOW2k/AAAKW+OHl0Sbk
        sopYOt1lmTQcdgmhn90JYtbM5BWg7y3Ib4wSVmc=
X-Google-Smtp-Source: ABdhPJw0neuwPIyT4dt1aR40e5Kqmv9haPxUPYfkxMLm2fJ5PQtRUklWARQwoAwZqcQEhwmTLrBlhgOl7jmPFQ/Z8Lw=
X-Received: by 2002:a5d:8f0b:: with SMTP id f11mr23113977iof.200.1593997364570;
 Sun, 05 Jul 2020 18:02:44 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Healy <cphealy@gmail.com>
Date:   Sun, 5 Jul 2020 18:02:33 -0700
Message-ID: <CAFXsbZo3xXXgCSd4AgDs8U46hBR0+HkQgzsvwJ=B6rUiondydA@mail.gmail.com>
Subject: [PATCH] arm: DT: vf610-zii-scu4-aib.dts: Configure fibre ports to 1000BaseX
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SFF soldered onto the board expect the ports to use 1000BaseX.  It
makes no sense to have the ports set to SGMII, since they don't even
support that mode.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Chris Healy <cphealy@gmail.com>
---
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
index b642520199ba..040a1f8b6130 100644
--- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
@@ -186,7 +186,7 @@
                     port@2 {
                         reg = <2>;
                         label = "eth_fc_1000_2";
-                        phy-mode = "sgmii";
+                        phy-mode = "1000base-x";
                         managed = "in-band-status";
                         sfp = <&sff1>;
                     };
@@ -194,7 +194,7 @@
                     port@3 {
                         reg = <3>;
                         label = "eth_fc_1000_3";
-                        phy-mode = "sgmii";
+                        phy-mode = "1000base-x";
                         managed = "in-band-status";
                         sfp = <&sff2>;
                     };
@@ -202,7 +202,7 @@
                     port@4 {
                         reg = <4>;
                         label = "eth_fc_1000_4";
-                        phy-mode = "sgmii";
+                        phy-mode = "1000base-x";
                         managed = "in-band-status";
                         sfp = <&sff3>;
                     };
@@ -210,7 +210,7 @@
                     port@5 {
                         reg = <5>;
                         label = "eth_fc_1000_5";
-                        phy-mode = "sgmii";
+                        phy-mode = "1000base-x";
                         managed = "in-band-status";
                         sfp = <&sff4>;
                     };
@@ -218,7 +218,7 @@
                     port@6 {
                         reg = <6>;
                         label = "eth_fc_1000_6";
-                        phy-mode = "sgmii";
+                        phy-mode = "1000base-x";
                         managed = "in-band-status";
                         sfp = <&sff5>;
                     };
@@ -226,7 +226,7 @@
                     port@7 {
                         reg = <7>;
                         label = "eth_fc_1000_7";
-                        phy-mode = "sgmii";
+                        phy-mode = "1000base-x";
                         managed = "in-band-status";
                         sfp = <&sff6>;
                     };
@@ -234,7 +234,7 @@
                     port@9 {
                         reg = <9>;
                         label = "eth_fc_1000_1";
-                        phy-mode = "sgmii";
+                        phy-mode = "1000base-x";
                         managed = "in-band-status";
                         sfp = <&sff0>;
                     };
@@ -269,7 +269,7 @@
                     port@2 {
                         reg = <2>;
                         label = "eth_fc_1000_8";
-                        phy-mode = "sgmii";
+                        phy-mode = "1000base-x";
                         managed = "in-band-status";
                         sfp = <&sff7>;
                     };
@@ -277,7 +277,7 @@
                     port@3 {
                         reg = <3>;
                         label = "eth_fc_1000_9";
-                        phy-mode = "sgmii";
+                        phy-mode = "1000base-x";
                         managed = "in-band-status";
                         sfp = <&sff8>;
                     };
@@ -285,7 +285,7 @@
                     port@4 {
                         reg = <4>;
                         label = "eth_fc_1000_10";
-                        phy-mode = "sgmii";
+                        phy-mode = "1000base-x";
                         managed = "in-band-status";
                         sfp = <&sff9>;
                     };
-- 
2.21.3
