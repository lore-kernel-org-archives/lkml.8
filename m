Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDF9C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E267C2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="GwxB2TJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgGNLXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgGNLXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:23:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C727CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:23:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so1365624pjc.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=//Y6Q6/nt5UQmFKrzLEvuZWLkdIv8woPD80SrhIdXso=;
        b=GwxB2TJx/Q5Gzmc27zqgSGDWp9BFD8ezXXdKNdeVbfRHuvs+Gx7oP5c/nc37kCMPns
         F0IXtXePSz4EcZkvdTXouWnDH2mD+7ZUDy5GmK4VJkVBbBA5kGxyt/EafnqwqE+MRya2
         aHTe2MCOOut1BW6w3Aag5jXJZQ6ECIpSToCg070QrowqQth9bS7UN+WFfTOEvXAHGeov
         QBDYWx4rp9QVdxdWmIsfD5ETVIe+ExmVS8KHQXHsuFzT1ysyQVXybhR/PECam3ncyXCE
         zqWxD62gi29N0rAbmmsx3jyyauDakV8g3lbEEoGfgtoJohajf+o11Qh/aclTOK85Uvxi
         G2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=//Y6Q6/nt5UQmFKrzLEvuZWLkdIv8woPD80SrhIdXso=;
        b=V/VkBV69oDPhmcr73U5ef45x+TDTbtwojwBk7YeYIdkkzCjNtT0/sTb0E2ps4AooKl
         cAwlaCqfFQ02Enk4BeEY/gumEGu74j6wukptqn+z1n31goAPP4qA4S2+pgtfMRdc+AxC
         xd/iSCYTQcy9WGR1qNZh1VpDBliVqbfK3bbM/9WBQx3MO8llSlfYvxI1qaqznqiFmqAV
         VfcM4TTAWnNpnqrwe1x2rG4VT8tp0GBZFVpMxd70V6NBYayAp1WUjY5PZE78sC2abaNI
         QAttKAZMm9YOtXWkgyuuHO54qoh3Nur11H77nPNjHjCNAymFr2I9QO7EyMoFEyhZMLz2
         7QCw==
X-Gm-Message-State: AOAM530FnrYz8MHkhaE6+LQT44ff4a0AE1UNJiGLJryTiCdQqeGc66+o
        EKwh1HIFLzsUupXADpVglt9yDQ==
X-Google-Smtp-Source: ABdhPJxvtS+urOiJgadhaOSFAZcKpmlxwgNZi3nXi9RCL4P9R91Xu7iOpv9+/jUyU8jYbnqAzGtejA==
X-Received: by 2002:a17:90a:b63:: with SMTP id 90mr4262434pjq.47.1594725792100;
        Tue, 14 Jul 2020 04:23:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z11sm17144483pfk.46.2020.07.14.04.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:23:11 -0700 (PDT)
Message-ID: <5f0d959f.1c69fb81.e240a.a18c@mx.google.com>
Date:   Tue, 14 Jul 2020 04:23:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc5-8-g0dc589da873b
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: mainline
X-Kernelci-Branch: master
X-Kernelci-Lab-Name: lab-cip
Subject: mainline/master bisection: baseline.dmesg.crit on
 qemu_arm-vexpress-a15
To:     kernelci-results@groups.io, Sudeep Holla <sudeep.holla@arm.com>,
        gtucker@collabora.com, Andre Przywara <andre.przywara@arm.com>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
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
  Start:      0dc589da873b Merge tag 'iommu-fixes-v5.8-rc5' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/joro/iommu
  Plain log:  https://storage.kernelci.org/mainline/master/v5.8-rc5-8-g0dc5=
89da873b/arm/vexpress_defconfig/gcc-8/lab-cip/baseline-vexpress-v2p-ca15-tc=
1.txt
  HTML log:   https://storage.kernelci.org/mainline/master/v5.8-rc5-8-g0dc5=
89da873b/arm/vexpress_defconfig/gcc-8/lab-cip/baseline-vexpress-v2p-ca15-tc=
1.html
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
# bad: [0dc589da873b58b70f4caf4b070fb0cf70fdd1dc] Merge tag 'iommu-fixes-v5=
.8-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
git bisect bad 0dc589da873b58b70f4caf4b070fb0cf70fdd1dc
# bad: [aa27b32b76d0b1b242d43977da0e5358da1c825f] Merge tag 'for-5.8-rc4-ta=
g' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect bad aa27b32b76d0b1b242d43977da0e5358da1c825f
# bad: [684c8ccc40d7e5408d597a43712bad3827d3fb94] Merge tag 'devicetree-fix=
es-for-5.8-2' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect bad 684c8ccc40d7e5408d597a43712bad3827d3fb94
# bad: [e44b59cd758acdd413512d4597a1fabdadfe3abf] Merge tag 'arm-fixes-5.8-=
1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad e44b59cd758acdd413512d4597a1fabdadfe3abf
# good: [91a9a90d040e8b9ff63d48ea71468e0f4db764ff] Merge tag 'sched_urgent_=
for_5.8_rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 91a9a90d040e8b9ff63d48ea71468e0f4db764ff
# bad: [42d3f7e8da1bc55e3109f612c519c945f6587194] Merge tag 'imx-fixes-5.8'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/f=
ixes
git bisect bad 42d3f7e8da1bc55e3109f612c519c945f6587194
# bad: [6d89c73ca5813768a2cc66f7420ac0cbddf4f37d] Merge tag 'arm-soc/for-5.=
8/soc-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
git bisect bad 6d89c73ca5813768a2cc66f7420ac0cbddf4f37d
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
