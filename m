Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D10C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269AE20578
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="WofiQHeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgGPGT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgGPGT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:19:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F727C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:19:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 1so3190987pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=FKPcf7JwgOCMRldycKp+o5YHoDwPYEJEd75y9Q84pKg=;
        b=WofiQHeTUi0IO1eEo2pPnbAF37JHNuCuVBDM2Dti1IQ2zjM8dT8mKHJhJvfeTW5NSG
         EHJfoxjcR3SEdZ9CXIW/Yem2WKDD8rjR4OcNQ1DjwNADF4B7d0eKkLfRf0knZgKvMNYG
         F9Y8L5PR9c5iCeNT88Nnf3c06DXYqNcbErgje67WUqwAXq5WFJkuAREAnkk1FvmKj0uQ
         qmFHoHySG+zlU9OzFUpqMf6/EZEeOSexBYYViXS5i6ckUHtUI5yPVEr14h21yy+mH+fu
         pjZOwe00rLUZP9OJscCwNaHmg9chso/ORIVoWpJFhXV64+dPSQq4GxMpnBghqfCUzJB3
         pT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=FKPcf7JwgOCMRldycKp+o5YHoDwPYEJEd75y9Q84pKg=;
        b=B/walWMhklPI9ri1+PI/gzNYN4CmbgPc5MD6iq8bYk+joo4qAryOIn6+KSydaxuXdz
         7x55Hz8Ccps/0NkVlXkm86b9NPZYrHAnrIL+N9/ojFUp1Em1rFviKY2ejYzMqU6xHd6L
         nBrkjTaCe6R84zcCc5XpekPJ9O7BsAlZHaJBRsXD4k2IKcYUbRHc/Z5lHTHB8sFT+IGM
         SO4OQdUInnaqDtTKwSSyo6jy/xsc4wAIpmyJKVlmPnv1OcRQ69QF5ccJ9grjnOQp6bqW
         7O4FIbWNVUspFSsVC4Yjw5Zq52mPK77BDDHCzo1IERXcgiDjTPok66tqXDLLI5CY8UON
         KfFA==
X-Gm-Message-State: AOAM533i5rfdoRuUNHi/QqVcNx+zme/fvYOE31+p4/hgraQzhoZdwp+m
        usxh8yJdIGK45fSQC91qT0WKFw==
X-Google-Smtp-Source: ABdhPJxg+TIg+/m4zJI4ZpHObj5YA20D6VltNo4qLGe2r80SO0ZQyTpQ/TQmxamVOK4YuE+jgNYqeQ==
X-Received: by 2002:a63:9d87:: with SMTP id i129mr2991954pgd.412.1594880397829;
        Wed, 15 Jul 2020 23:19:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u26sm4028385pgo.71.2020.07.15.23.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 23:19:57 -0700 (PDT)
Message-ID: <5f0ff18d.1c69fb81.da154.b562@mx.google.com>
Date:   Wed, 15 Jul 2020 23:19:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc5-262-g7be1e4d3000e
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: next
X-Kernelci-Branch: pending-fixes
X-Kernelci-Lab-Name: lab-collabora
Subject: next/pending-fixes bisection: baseline.dmesg.crit on
 qemu_arm-vexpress-a15
To:     gtucker@collabora.com, Andre Przywara <andre.przywara@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     devicetree@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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

next/pending-fixes bisection: baseline.dmesg.crit on qemu_arm-vexpress-a15

Summary:
  Start:      7be1e4d3000e Merge remote-tracking branch 'drm-misc-fixes/for=
-linux-next-fixes'
  Plain log:  https://storage.kernelci.org/next/pending-fixes/v5.8-rc5-262-=
g7be1e4d3000e/arm/vexpress_defconfig/gcc-8/lab-collabora/baseline-vexpress-=
v2p-ca15-tc1.txt
  HTML log:   https://storage.kernelci.org/next/pending-fixes/v5.8-rc5-262-=
g7be1e4d3000e/arm/vexpress_defconfig/gcc-8/lab-collabora/baseline-vexpress-=
v2p-ca15-tc1.html
  Result:     38ac46002d1d arm: dts: vexpress: Move mcc node back into moth=
erboard node

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-ne=
xt.git
  Branch:     pending-fixes
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
# good: [9a33e375d98ece5ea40c576eabd3257acb90c509] platform/x86: asus-wmi: =
allow BAT1 battery name
git bisect good 9a33e375d98ece5ea40c576eabd3257acb90c509
# bad: [7be1e4d3000ef52ab90d0239711df69b881bd807] Merge remote-tracking bra=
nch 'drm-misc-fixes/for-linux-next-fixes'
git bisect bad 7be1e4d3000ef52ab90d0239711df69b881bd807
# good: [668f532da4808688f5162cec6a38875390e1a91d] Merge tag 'timers-urgent=
-2020-06-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 668f532da4808688f5162cec6a38875390e1a91d
# bad: [a581387e415bbb0085e7e67906c8f4a99746590e] Merge tag 'io_uring-5.8-2=
020-07-10' of git://git.kernel.dk/linux-block
git bisect bad a581387e415bbb0085e7e67906c8f4a99746590e
# bad: [29206c6314a3e5242b23b61cd1270cba9e93b415] Merge tag 'block-5.8-2020=
-07-05' of git://git.kernel.dk/linux-block
git bisect bad 29206c6314a3e5242b23b61cd1270cba9e93b415
# bad: [45564bcd57046ebe8c9309527c114dcd042cb7e5] Merge tag 'for-linus-2020=
-07-02' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux
git bisect bad 45564bcd57046ebe8c9309527c114dcd042cb7e5
# bad: [a0271a15cf2cf907ea5b0f2ba611123f1b7935ec] exfat: call sync_filesyst=
em for read-only remount
git bisect bad a0271a15cf2cf907ea5b0f2ba611123f1b7935ec
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
