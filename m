Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D53C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DAED20737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="GgtgWYLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgGCOdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgGCOdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:33:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B108C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 07:33:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m22so4817095pgv.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 07:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=7WvGi3ZWzZ6amDsfHb5k51P9HzBmGi89bs5PYzy6Mxs=;
        b=GgtgWYLMzWh/a1jUS92H1aJ8rur1vg3pPP3+hotqIpRbf6wmlBBTBVNkzuhadRfrAP
         EIcu/7/BoazS/XZNK6VRhlctZYSCnCRJz5TlsyP0G+lHmdKhavNz6KMOdlclRsQrXvF3
         mx+J6Nkeugr+wThh5bhv1nDNarfuL/22Mrwd2Y0oci3aCWDJ90wCqrPxDB7nlW462I8S
         oRlVeBUgwZiEWijL3iQtpLCyEIuugAv/0ZoHqhbeLhRjM+mTLGBRrEQ7M/FZg6fECxLz
         vhHSjkAJJ+Fyu8gn3+CfdA8ed5QeSwQBPWAeyJeKuavWY7TO/MzqRdMdevuWpAezNYH7
         1ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=7WvGi3ZWzZ6amDsfHb5k51P9HzBmGi89bs5PYzy6Mxs=;
        b=Q4gsCDU3eg8dn+t8sdnwa2BwoyQSVsQQa/59LXAsixYzniatyl/0Kin+KwZMHmNb3n
         2aRMhLLzh6G3i167kXFhmwNmY5pmK4am5cpgPRVprQmeJ6fOMsTPGtCAiCcCtyyyfg56
         CrkZwTV7wA2WuoPZq/wxXRPapdy7YcrCnfBEtN9aIla64FHUB1q9nuRy8I6dpApVKLN0
         57vlkRr+JuKrtZRbTzFFUFak0nh28gG3UoB/WRWKQKd1lVgeEZjqvYSNuJ+KPRZUY+sa
         EmrorDcXjktG6WbTmF4THr9DFJVsMMlORn7Oh3yHSXF/gApOaNF6FqOqKh8F+yFA/hDa
         C5KQ==
X-Gm-Message-State: AOAM530xM/pinC0vIPlhl/cR9IvJ7iEb+QP5NZY+QdbCkUCV0d2I4AqP
        dmWDyFfqLT4E9g8PguYcAlo1rDoI0LQ=
X-Google-Smtp-Source: ABdhPJxsbbwRX3oe8BINj7VF2EhM60Xud2ed2kZPHNTcnPgfXiScYc38MdSjHD9IzpZCFjGVs9OsSw==
X-Received: by 2002:a63:564e:: with SMTP id g14mr28984034pgm.326.1593786832715;
        Fri, 03 Jul 2020 07:33:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r16sm11607347pfh.64.2020.07.03.07.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 07:33:51 -0700 (PDT)
Message-ID: <5eff41cf.1c69fb81.f3c05.e990@mx.google.com>
Date:   Fri, 03 Jul 2020 07:33:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc3-82-gcdd3bb54332f
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: mainline
X-Kernelci-Branch: master
X-Kernelci-Lab-Name: lab-cip
Subject: mainline/master bisection: baseline.dmesg.crit on
 qemu_arm-vexpress-a15
To:     kernelci-results@groups.io, gtucker@collabora.com,
        Andre Przywara <andre.przywara@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        linux-arm-kernel@lists.infradead.org,
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

mainline/master bisection: baseline.dmesg.crit on qemu_arm-vexpress-a15

Summary:
  Start:      cdd3bb54332f Merge tag 'm68knommu-for-v5.8-rc4' of git://git.=
kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu
  Plain log:  https://storage.kernelci.org/mainline/master/v5.8-rc3-82-gcdd=
3bb54332f/arm/vexpress_defconfig/gcc-8/lab-cip/baseline-vexpress-v2p-ca15-t=
c1.txt
  HTML log:   https://storage.kernelci.org/mainline/master/v5.8-rc3-82-gcdd=
3bb54332f/arm/vexpress_defconfig/gcc-8/lab-cip/baseline-vexpress-v2p-ca15-t=
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
# bad: [cdd3bb54332f82295ed90cd0c09c78cd0c0ee822] Merge tag 'm68knommu-for-=
v5.8-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu
git bisect bad cdd3bb54332f82295ed90cd0c09c78cd0c0ee822
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
