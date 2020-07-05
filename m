Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0165CC433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 00:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B1420870
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 00:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZlCLHQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgGEA7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 20:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgGEA7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 20:59:42 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA9DC061794;
        Sat,  4 Jul 2020 17:59:42 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id q3so19415842ilt.8;
        Sat, 04 Jul 2020 17:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=af+68LX+7N5jX5lERkACGcOUmlOtCRdKuZ9mViQ1zac=;
        b=eZlCLHQs8tnMlHPDN59duTwiY/iWYszFLrBdNijv54ZPwGzk+cGBooRYX4UFfcZcQd
         YaWexzbFrLO6P7M0/D02KvfxK8959bzhXkWJAtbCGUzrlGEsy1Ont8nxUHP3zmJ72Chr
         EMqs6NkiZeqKhrNKGCWqmQudjhZ2/YaB0tl7XFhy37nd1R5RwyKGg/0CbBgl2hZ/Yl5w
         L4YMd/J443CmqXNg3+8O6P0Ge0go9scMK2REEOw8L3UtteditNuLEp07Zbg3IXY5q198
         kV9NP+75Swvqbsq39BzLXaGZC9y7LjC36RMZc1rEnFk8SOGXhOSPsLhO7McGjXf53EU9
         Sfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=af+68LX+7N5jX5lERkACGcOUmlOtCRdKuZ9mViQ1zac=;
        b=mWSPE+2OBJ7Ky8GWiOWaXHeYBvUb8/C69u+qu0OQ569lrelmjWLgoUesjZORCXlBuM
         QbGEAf5CYSo/gg5nHg6MAQot1/+BOfr1Ru5qESKcaFlpECisLg8A95tg/NjLpL3pT6KA
         H6qRhg6Qkr/Zj3xh9h/TG9O53TtfO+2AF8/4CVpDsnMHBVNMQpNn4CCicvx2cqlm0S3V
         KkQT6SUGgLTGhergxIpuLxjz3eqbr+qhH8NPmx6Bk4GXyDNICzY/GZ43gEFchh9Y6SPq
         K83h3WAzO6li4i8ADDj0s1shq8ieRdAw4//7gmN6MhBCnfn2eSZyP4/1+GOYnUR9inxe
         w0Hg==
X-Gm-Message-State: AOAM5339M1PWe4AH5nHYXJEJBUScv0sTnmNy9i2fUvBYhl9Ays8TPRCA
        aj7F2Mv0B1dvIdijoOG3CVC46/7IuUz0YkPjPy0=
X-Google-Smtp-Source: ABdhPJy34w8YGYvJDmuTPQlRMZxb5FjObMfhkDGeWB5Ui0DrQ2QjeIZbZUdbinIaAF6OL60++yFuvxF8y0l2WkunGP0=
X-Received: by 2002:a92:c78d:: with SMTP id c13mr24437159ilk.85.1593910781278;
 Sat, 04 Jul 2020 17:59:41 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Healy <cphealy@gmail.com>
Date:   Sat, 4 Jul 2020 17:59:30 -0700
Message-ID: <CAFXsbZoYyw6_zUJvR-aeELfixMTy5gJV37vxK+q4RPs6F8uSgw@mail.gmail.com>
Subject: [PATCH] ARM: dts: update MDIO speed and preamble for zii devices
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MDIO configuration with zii devices to fully utilize
MDIO endpoint capabilities.  All devices support 12.5MHz clock and
don't require MDIO preamble.

Signed-off-by: Chris Healy <cphealy@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi   | 2 ++
 arch/arm/boot/dts/vf610-zii-cfu1.dts      | 2 ++
 arch/arm/boot/dts/vf610-zii-dev.dtsi      | 2 ++
 arch/arm/boot/dts/vf610-zii-spb4.dts      | 2 ++
 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts  | 2 ++
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 20350e803377..58cc421042e1 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -720,6 +720,8 @@
         #address-cells = <1>;
         #size-cells = <0>;
         status = "okay";
+        suppress-preamble = <1>;
+        clock-frequency = <12500000>;

         switch: switch@0 {
             compatible = "marvell,mv88e6085";
diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts
b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index ce1920c052fc..c27cacbe6a73 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -159,6 +159,8 @@
         #address-cells = <1>;
         #size-cells = <0>;
         status = "okay";
+        suppress-preamble = <1>;
+        clock-frequency = <12500000>;

         switch0: switch0@0 {
             compatible = "marvell,mv88e6085";
diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi
b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index 95d0060fb56c..9694d3b53607 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -138,6 +138,8 @@
         #address-cells = <1>;
         #size-cells = <0>;
         status = "okay";
+        suppress-preamble = <1>;
+        clock-frequency = <12500000>;
     };
 };

diff --git a/arch/arm/boot/dts/vf610-zii-spb4.dts
b/arch/arm/boot/dts/vf610-zii-spb4.dts
index 55b4201e27f6..d2ad07ed5318 100644
--- a/arch/arm/boot/dts/vf610-zii-spb4.dts
+++ b/arch/arm/boot/dts/vf610-zii-spb4.dts
@@ -120,6 +120,8 @@
         #address-cells = <1>;
         #size-cells = <0>;
         status = "okay";
+        suppress-preamble = <1>;
+        clock-frequency = <12500000>;

         switch0: switch0@0 {
             compatible = "marvell,mv88e6190";
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
index a6c22a79779e..0bb3dcff0b79 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
@@ -106,6 +106,8 @@
         #address-cells = <1>;
         #size-cells = <0>;
         status = "okay";
+        suppress-preamble = <1>;
+        clock-frequency = <12500000>;

         switch0: switch0@0 {
             compatible = "marvell,mv88e6190";
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
index 3d05c894bdc0..e12e11805b71 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -134,6 +134,8 @@
         #address-cells = <1>;
         #size-cells = <0>;
         status = "okay";
+        suppress-preamble = <1>;
+        clock-frequency = <12500000>;

         switch0: switch0@0 {
             compatible = "marvell,mv88e6190";
-- 
2.21.3
