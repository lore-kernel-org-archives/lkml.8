Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48308C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE08206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="XdRp39V5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgGHWKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgGHWKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 18:10:15 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F58C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 15:10:15 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 72so8185765ple.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 15:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=cvnpO/lN76o3kfdC8/AknlyYBHw0310QmPdpMmkhMiE=;
        b=XdRp39V5zmc/zgy26BZC6ZWH6NqYvg+Jau4lgYA1sFJvC7cDjsBX0F+66xO9yvVE7+
         RNowObHF62ScSSlFzEI4wXxZcWOC+W/hNciobjrwgX/ixA5VCZj8GRTYRO+KO65ZKOQE
         fUwpYD+qiEBdTkdeiriRMt/dA5AFcK4xoBxpuVOIBLGZ3XklqPss8/nYkImJR5xo4BCr
         GnlhY1MSSIzCwQw/Hp2RQkayVK9BHxn18KyuYSTvGHJjbvtdrVxlduPvj47i0wP4vmxz
         55f+fkC56C4V2eFkuiz/MapxjLdiT+IdFag9lprR1lGHNewQ2r69L+aR8H6ivb5lQCDf
         PVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=cvnpO/lN76o3kfdC8/AknlyYBHw0310QmPdpMmkhMiE=;
        b=uCnzEcRqLC3L666tDJ/ATyV5uYFszgcQKaOQ0hXSV6nsTHDGEI3MG3v3ZhUniQyqng
         7WnZTLFOL4QY8SxUstGEhGnqcw5+hEx9U0/PNV8mM/j+WXSdsfbunwLbnc7vF2BjPUJR
         6Ck7pPVKGYynPI5pVRW0yUtq95DUV1qzOkitk1X7/EHYwIu1hoUbFew92Z3sYzC4U08T
         PX0zVKg/LiwfgpPTC/QActzRjGYlAmEwEFF/hB+NB3r/jffN1QXIRQh2o4f5/b4/PLVy
         lvhHyBiezj2WBA60jACnBOlMzlEiA/gm4D7yUKyxawC+UTGefoCFB6NWDboy9scFBO5t
         6k0A==
X-Gm-Message-State: AOAM531abWwOoHcRB0pRwgD7tYdR382SiFCr3tPGLzro9ovymydPFKKa
        NMyK83v+s8/LPYHZz0P+78iIFg==
X-Google-Smtp-Source: ABdhPJyTfPC7cSfRp6kgPzbXYErF5ehSVjfacTOp1rrJ8SDJl4RoNdlWTm76mg1pYB1RkcSsvae9JA==
X-Received: by 2002:a17:902:b78a:: with SMTP id e10mr52272949pls.34.1594246214584;
        Wed, 08 Jul 2020 15:10:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f6sm702202pfe.174.2020.07.08.15.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 15:10:13 -0700 (PDT)
Message-ID: <5f064445.1c69fb81.6ed1e.259e@mx.google.com>
Date:   Wed, 08 Jul 2020 15:10:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc4-61-gdcde237b9b0e
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: mainline
X-Kernelci-Branch: master
X-Kernelci-Lab-Name: lab-collabora
Subject: mainline/master bisection: baseline.dmesg.crit on
 qemu_arm-vexpress-a15
To:     kernelci-results@groups.io,
        Andre Przywara <andre.przywara@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, gtucker@collabora.com
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Liviu Dudau <liviu.dudau@arm.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

mainline/master bisection: baseline.dmesg.crit on qemu_arm-vexpress-a15

Summary:
  Start:      dcde237b9b0e Merge tag 'perf-tools-fixes-2020-07-07' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/acme/linux
  Plain log:  https://storage.kernelci.org/mainline/master/v5.8-rc4-61-gdcd=
e237b9b0e/arm/vexpress_defconfig/gcc-8/lab-collabora/baseline-vexpress-v2p-=
ca15-tc1.txt
  HTML log:   https://storage.kernelci.org/mainline/master/v5.8-rc4-61-gdcd=
e237b9b0e/arm/vexpress_defconfig/gcc-8/lab-collabora/baseline-vexpress-v2p-=
ca15-tc1.html
  Result:     38ac46002d1d arm: dts: vexpress: Move mcc node back into moth=
erboard node

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       mainline
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git
  Branch:     master
  Target:     qemu_arm-vexpress-a15
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     vexpress_defconfig
  Test case:  baseline.dmesg.crit

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 38ac46002d1df5707566a73486452851341028d2
Author: Andre Przywara <andre.przywara@arm.com>
Date:   Wed Jun 3 17:22:37 2020 +0100

    arm: dts: vexpress: Move mcc node back into motherboard node
    =

    Commit d9258898ad49 ("arm64: dts: arm: vexpress: Move fixed devices
    out of bus node") moved the "mcc" DT node into the root node, because
    it does not have any children using "reg" properties, so does violate
    some dtc checks about "simple-bus" nodes.
    =

    However this broke the vexpress config-bus code, which walks up the
    device tree to find the first node with an "arm,vexpress,site" property.
    This gave the wrong result (matching the root node instead of the
    motherboard node), so broke the clocks and some other devices for
    VExpress boards.
    =

    Move the whole node back into its original position. This re-introduces
    the dtc warning, but is conceptually the right thing to do. The dtc
    warning seems to be overzealous here, there are discussions on fixing or
    relaxing this check instead.
    =

    Link: https://lore.kernel.org/r/20200603162237.16319-1-andre.przywara@a=
rm.com
    Fixes: d9258898ad49 ("arm64: dts: vexpress: Move fixed devices out of b=
us node")
    Reported-and-tested-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Andre Przywara <andre.przywara@arm.com>
    Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/ve=
xpress-v2m-rs1.dtsi
index e6308fb76183..a88ee5294d35 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -100,79 +100,6 @@
 		};
 	};
 =

-	mcc {
-		compatible =3D "arm,vexpress,config-bus";
-		arm,vexpress,config-bridge =3D <&v2m_sysreg>;
-
-		oscclk0 {
-			/* MCC static memory clock */
-			compatible =3D "arm,vexpress-osc";
-			arm,vexpress-sysreg,func =3D <1 0>;
-			freq-range =3D <25000000 60000000>;
-			#clock-cells =3D <0>;
-			clock-output-names =3D "v2m:oscclk0";
-		};
-
-		v2m_oscclk1: oscclk1 {
-			/* CLCD clock */
-			compatible =3D "arm,vexpress-osc";
-			arm,vexpress-sysreg,func =3D <1 1>;
-			freq-range =3D <23750000 65000000>;
-			#clock-cells =3D <0>;
-			clock-output-names =3D "v2m:oscclk1";
-		};
-
-		v2m_oscclk2: oscclk2 {
-			/* IO FPGA peripheral clock */
-			compatible =3D "arm,vexpress-osc";
-			arm,vexpress-sysreg,func =3D <1 2>;
-			freq-range =3D <24000000 24000000>;
-			#clock-cells =3D <0>;
-			clock-output-names =3D "v2m:oscclk2";
-		};
-
-		volt-vio {
-			/* Logic level voltage */
-			compatible =3D "arm,vexpress-volt";
-			arm,vexpress-sysreg,func =3D <2 0>;
-			regulator-name =3D "VIO";
-			regulator-always-on;
-			label =3D "VIO";
-		};
-
-		temp-mcc {
-			/* MCC internal operating temperature */
-			compatible =3D "arm,vexpress-temp";
-			arm,vexpress-sysreg,func =3D <4 0>;
-			label =3D "MCC";
-		};
-
-		reset {
-			compatible =3D "arm,vexpress-reset";
-			arm,vexpress-sysreg,func =3D <5 0>;
-		};
-
-		muxfpga {
-			compatible =3D "arm,vexpress-muxfpga";
-			arm,vexpress-sysreg,func =3D <7 0>;
-		};
-
-		shutdown {
-			compatible =3D "arm,vexpress-shutdown";
-			arm,vexpress-sysreg,func =3D <8 0>;
-		};
-
-		reboot {
-			compatible =3D "arm,vexpress-reboot";
-			arm,vexpress-sysreg,func =3D <9 0>;
-		};
-
-		dvimode {
-			compatible =3D "arm,vexpress-dvimode";
-			arm,vexpress-sysreg,func =3D <11 0>;
-		};
-	};
-
 	bus@8000000 {
 		motherboard-bus {
 			model =3D "V2M-P1";
@@ -435,6 +362,79 @@
 						};
 					};
 				};
+
+				mcc {
+					compatible =3D "arm,vexpress,config-bus";
+					arm,vexpress,config-bridge =3D <&v2m_sysreg>;
+
+					oscclk0 {
+						/* MCC static memory clock */
+						compatible =3D "arm,vexpress-osc";
+						arm,vexpress-sysreg,func =3D <1 0>;
+						freq-range =3D <25000000 60000000>;
+						#clock-cells =3D <0>;
+						clock-output-names =3D "v2m:oscclk0";
+					};
+
+					v2m_oscclk1: oscclk1 {
+						/* CLCD clock */
+						compatible =3D "arm,vexpress-osc";
+						arm,vexpress-sysreg,func =3D <1 1>;
+						freq-range =3D <23750000 65000000>;
+						#clock-cells =3D <0>;
+						clock-output-names =3D "v2m:oscclk1";
+					};
+
+					v2m_oscclk2: oscclk2 {
+						/* IO FPGA peripheral clock */
+						compatible =3D "arm,vexpress-osc";
+						arm,vexpress-sysreg,func =3D <1 2>;
+						freq-range =3D <24000000 24000000>;
+						#clock-cells =3D <0>;
+						clock-output-names =3D "v2m:oscclk2";
+					};
+
+					volt-vio {
+						/* Logic level voltage */
+						compatible =3D "arm,vexpress-volt";
+						arm,vexpress-sysreg,func =3D <2 0>;
+						regulator-name =3D "VIO";
+						regulator-always-on;
+						label =3D "VIO";
+					};
+
+					temp-mcc {
+						/* MCC internal operating temperature */
+						compatible =3D "arm,vexpress-temp";
+						arm,vexpress-sysreg,func =3D <4 0>;
+						label =3D "MCC";
+					};
+
+					reset {
+						compatible =3D "arm,vexpress-reset";
+						arm,vexpress-sysreg,func =3D <5 0>;
+					};
+
+					muxfpga {
+						compatible =3D "arm,vexpress-muxfpga";
+						arm,vexpress-sysreg,func =3D <7 0>;
+					};
+
+					shutdown {
+						compatible =3D "arm,vexpress-shutdown";
+						arm,vexpress-sysreg,func =3D <8 0>;
+					};
+
+					reboot {
+						compatible =3D "arm,vexpress-reboot";
+						arm,vexpress-sysreg,func =3D <9 0>;
+					};
+
+					dvimode {
+						compatible =3D "arm,vexpress-dvimode";
+						arm,vexpress-sysreg,func =3D <11 0>;
+					};
+				};
 			};
 		};
 	};
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [719fdd32921fb7e3208db8832d32ae1c2d68900f] afs: Fix storage of cell=
 names
git bisect good 719fdd32921fb7e3208db8832d32ae1c2d68900f
# bad: [dcde237b9b0eb1d19306e6f48c0a4e058907619f] Merge tag 'perf-tools-fix=
es-2020-07-07' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
git bisect bad dcde237b9b0eb1d19306e6f48c0a4e058907619f
# bad: [442ad2254ac56b39870c0cfed96d500921fea5d5] perf record: Fix duplicat=
ed sideband events with Intel PT system wide tracing
git bisect bad 442ad2254ac56b39870c0cfed96d500921fea5d5
# bad: [f7db192b2d71ea42627a32349d59a5f99f2aafcc] Merge tag 'arm-omap-fixes=
-5.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad f7db192b2d71ea42627a32349d59a5f99f2aafcc
# good: [ae71d4bf0074a81cc04255c96e3de0a49b1d95fa] Merge tag 'perf-urgent-2=
020-06-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good ae71d4bf0074a81cc04255c96e3de0a49b1d95fa
# good: [d528945d7762be94beca4c111bb95dcc9a9f39c0] Merge tag 'omap-for-v5.8=
/fixes-rc1-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/=
linux-omap into arm/omap-fixes
git bisect good d528945d7762be94beca4c111bb95dcc9a9f39c0
# bad: [2596ce4b4ded685b67fed407aed2bfe6ebcc39cb] Merge tag 'arm-soc/for-5.=
8/drivers-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
git bisect bad 2596ce4b4ded685b67fed407aed2bfe6ebcc39cb
# bad: [0f77ce26ebcf6ea384421d2dd47b924b83649692] Revert "ARM: sti: Impleme=
nt dummy L2 cache's write_sec"
git bisect bad 0f77ce26ebcf6ea384421d2dd47b924b83649692
# bad: [d68ec1644dd546851d651787a638aead32a60a6f] Merge tag 'juno-fix-5.8' =
of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into ar=
m/fixes
git bisect bad d68ec1644dd546851d651787a638aead32a60a6f
# bad: [38ac46002d1df5707566a73486452851341028d2] arm: dts: vexpress: Move =
mcc node back into motherboard node
git bisect bad 38ac46002d1df5707566a73486452851341028d2
# first bad commit: [38ac46002d1df5707566a73486452851341028d2] arm: dts: ve=
xpress: Move mcc node back into motherboard node
---------------------------------------------------------------------------=
----
