Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B580C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA922206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="1ShX9mEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgGPGQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgGPGQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:16:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD79C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:16:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m22so4303486pgv.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=kF7R5DUC1URNMPbAYPkDub6YZWoBbHJrUi/9LeiLYeY=;
        b=1ShX9mEwNKC3QnGClMktjWkQoAorJK8LcHm8k2oZ2FIpYaNHeq6+U29CZFWoYFbIVj
         RlR4zvbcjbX9H5mbar9DzS7zFWdIryezMkFQTeCHfkDVyNIbO3dhgtbyG3GJLAj8UJ4T
         9K49gei1FHE/6r7+0oFVPeaE6zVFf/bck8Odk4zNqR/gCrI7Glu4ZB8jh2x6JF2MHN4w
         lbfp1yfxFV4dLVZaEXC3UzXnHei1GahBS8k5Oyc+UVSZk0nB2E0IQGEHijJFbKzR0fJP
         opPTJVvjOC/SOSS5L7aluueiffide0vpYCB3hoYuATsu4I/+njnMtx/gBmkOOBuoTDFn
         iM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=kF7R5DUC1URNMPbAYPkDub6YZWoBbHJrUi/9LeiLYeY=;
        b=bG4laexBxdPUgxlKtb2sjyl9cK/DZq4m42ZNrJmYpRp5jRY5aTHlLJdE46UyGxvS9i
         BrtqxAYljLx2pBfmqOQjF6V76/rCRkrZrGCuROSm+TEOrcdze+kGHXuFN5LrUIknlq6R
         wEBx22oITaEwuiEEefWaav0ywkSVLiZJLZlmVc6KJlUT82QW2pBlidlF057zgEaG9nmB
         3QNiJ2OgJ2KqggaRxkmwlnCZ8ByFBEHOzmWJcIdeUs4+BtSwP0mVOE/oQ3CJ/BPR1EGI
         PSsDDtSdZa4xyRxIIXBNqXZt1iJWTiDpwh7wNhTZycdU/lw9yxJez8k31Mqi4abmKqJF
         2Rpw==
X-Gm-Message-State: AOAM532aBVezEKXY9Z7qdcZiiP7XaZaBLaK7msTusqGS/oLGWgmRgK+p
        /XHNnj1SdvpEwQfn4C+pbEPvOA==
X-Google-Smtp-Source: ABdhPJyryvc/9TBR4TsFYlLjrLX7U8VA92b4q2d0e0ZlaHioYcTNQ7tmPnqI8KZkhRJk69YHxNnpdg==
X-Received: by 2002:a63:5a01:: with SMTP id o1mr2862474pgb.337.1594880173303;
        Wed, 15 Jul 2020 23:16:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e10sm3891656pjw.22.2020.07.15.23.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 23:16:12 -0700 (PDT)
Message-ID: <5f0ff0ac.1c69fb81.d1a0b.b284@mx.google.com>
Date:   Wed, 15 Jul 2020 23:16:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc5-44-g994e99a96c9b
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: mainline
X-Kernelci-Branch: master
X-Kernelci-Lab-Name: lab-cip
Subject: mainline/master bisection: baseline.dmesg.crit on
 qemu_arm-vexpress-a15
To:     Sudeep Holla <sudeep.holla@arm.com>, gtucker@collabora.com,
        kernelci-results@groups.io, Andre Przywara <andre.przywara@arm.com>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
        Rob Herring <robh+dt@kernel.org>
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
  Start:      994e99a96c9b Merge tag 'platform-drivers-x86-v5.8-2' of git:/=
/git.infradead.org/linux-platform-drivers-x86 into master
  Plain log:  https://storage.kernelci.org/mainline/master/v5.8-rc5-44-g994=
e99a96c9b/arm/vexpress_defconfig/gcc-8/lab-cip/baseline-vexpress-v2p-ca15-t=
c1.txt
  HTML log:   https://storage.kernelci.org/mainline/master/v5.8-rc5-44-g994=
e99a96c9b/arm/vexpress_defconfig/gcc-8/lab-cip/baseline-vexpress-v2p-ca15-t=
c1.html
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
  Lab:        lab-cip
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
# bad: [994e99a96c9b502b3f6ee411457007cd52051cf5] Merge tag 'platform-drive=
rs-x86-v5.8-2' of git://git.infradead.org/linux-platform-drivers-x86 into m=
aster
git bisect bad 994e99a96c9b502b3f6ee411457007cd52051cf5
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
