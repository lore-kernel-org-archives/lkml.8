Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D7CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AF16206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ftibM33U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFZTLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:11:06 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F3EC03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 12:11:06 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh7so4587877plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 12:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=6UjzTo6kKJLkeVtxkIJDMzomu4dcIQKvoQRVUhtv+x8=;
        b=ftibM33UckAR0AQRwJCEc0N3RtukE/tcWr7W8C2v18E/QHcM3tbLBTqQSqVZ8e9PDa
         pTlaH8bhqVGpp6ZD6Jvn1VUJkukqNVhjUsapEOvwCwqSK1DmMbmJxbesGeEwRpZ2aVYB
         I2895JfEdF7L9L35GDRY0lcMuGP0VpzOfcL2KP0vpTPykQJ85Kf4OKA21q3paEMMuE76
         nxL2LZWsDUFNO0d+9JH+3+uKeNGUI46di8fvVAIwpS2pX4z/WmJxf4GEjmYYTWDNLonR
         /XkfhepSXp1asia6CiiT5hbwvvywp9szOSpbyH2TJ2v9UX9cO9yQEYno+0BemwVFrOeB
         zJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=6UjzTo6kKJLkeVtxkIJDMzomu4dcIQKvoQRVUhtv+x8=;
        b=IJyP+mWb6hJnSveJkHVDQz4LfFObNUmaaeX4zl4EqrbqraC5rt6KcJeCHauIluCynQ
         pOV758rxIw4k/b8IatMG2EFQLeoFVS77uCVW31scMRJ+3xhK+DV77Rj74ZRoYGsVlIlm
         Sf6V1v/CVMyKASFLOPW4gLbVL+Qi/ns9qZRu1oggQPfN60UZgm99RD7Nxob7PGtuwBw7
         La+sAKi2KF14GcBEBFQN1jCZuahI/VJY3sClapBvBziFFaUkVYf4mPFs0XWZxYPw3R/1
         4wxWXtheG5Sv0rkL7uNxi5yMwhnp4LjF757WxpIou+lr/Y1w6PVJR4ZrYqUzphwRJD47
         agSQ==
X-Gm-Message-State: AOAM531NEOYatFnxiGe1RG01x+RZW8Imwdtj5QXPRFuW/TCqjDbmMOjB
        EVgCh2FEYMfJIQAnWc3Y7cExsA==
X-Google-Smtp-Source: ABdhPJyWzCHTf8ufqy3E7/C4fSQ7qgRGKfRfK2NcfHD2I4t2KKzo7b1eCYSiyyc8Dygezj1pctsiUQ==
X-Received: by 2002:a17:90b:2350:: with SMTP id ms16mr5162309pjb.127.1593198665787;
        Fri, 26 Jun 2020 12:11:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z5sm978327pfn.117.2020.06.26.12.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 12:11:05 -0700 (PDT)
Message-ID: <5ef64849.1c69fb81.2d891.248a@mx.google.com>
Date:   Fri, 26 Jun 2020 12:11:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: next-20200626
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: next
X-Kernelci-Branch: master
X-Kernelci-Lab-Name: lab-collabora
Subject: next/master bisection: baseline.dmesg.crit on qemu_arm-vexpress-a15
To:     Sudeep Holla <sudeep.holla@arm.com>, gtucker@collabora.com,
        kernelci-results@groups.io, Andre Przywara <andre.przywara@arm.com>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Liviu Dudau <liviu.dudau@arm.com>
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

next/master bisection: baseline.dmesg.crit on qemu_arm-vexpress-a15

Summary:
  Start:      36e3135df4d4 Add linux-next specific files for 20200626
  Plain log:  https://storage.kernelci.org/next/master/next-20200626/arm/ve=
xpress_defconfig/gcc-8/lab-collabora/baseline-vexpress-v2p-ca15-tc1.txt
  HTML log:   https://storage.kernelci.org/next/master/next-20200626/arm/ve=
xpress_defconfig/gcc-8/lab-collabora/baseline-vexpress-v2p-ca15-tc1.html
  Result:     38ac46002d1d arm: dts: vexpress: Move mcc node back into moth=
erboard node

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-ne=
xt.git
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
# good: [52366a107bf0600cf366f5ff3ea1f147b285e41f] Merge tag 'fsnotify_for_=
v5.8-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
git bisect good 52366a107bf0600cf366f5ff3ea1f147b285e41f
# bad: [36e3135df4d426612fc77db26a312c2531108603] Add linux-next specific f=
iles for 20200626
git bisect bad 36e3135df4d426612fc77db26a312c2531108603
# bad: [11fdea666694c5c8c8a52cb75b2f0e70a2c2c201] Merge remote-tracking bra=
nch 'drm/drm-next'
git bisect bad 11fdea666694c5c8c8a52cb75b2f0e70a2c2c201
# bad: [39ac1a242d0940dabd9192d99113c2b082ba45bc] Merge remote-tracking bra=
nch 'printk/for-next'
git bisect bad 39ac1a242d0940dabd9192d99113c2b082ba45bc
# good: [4a750150d9fe543e2163998501b3ad947d6dff74] Merge remote-tracking br=
anch 'at91/at91-next'
git bisect good 4a750150d9fe543e2163998501b3ad947d6dff74
# bad: [d7645ac1101c5160a05e2dced672a8d63c2a7ec0] Merge remote-tracking bra=
nch 'scmi/for-linux-next'
git bisect bad d7645ac1101c5160a05e2dced672a8d63c2a7ec0
# good: [2408a915a05c109169ab689dc91ce31315406513] Merge branches 'arm64-de=
fconfig-for-5.9', 'arm64-for-5.9', 'drivers-for-5.9' and 'dts-for-5.9' into=
 for-next
git bisect good 2408a915a05c109169ab689dc91ce31315406513
# good: [1679681fb8b2d169ac9d98660d7390620990bf77] Merge remote-tracking br=
anch 'raspberrypi/for-next'
git bisect good 1679681fb8b2d169ac9d98660d7390620990bf77
# good: [137233bdcd265762a251dfa24e82ebc5468e0ec2] Merge remote-tracking br=
anch 'reset/reset/next'
git bisect good 137233bdcd265762a251dfa24e82ebc5468e0ec2
# good: [99bcf38dd05b76b41f8564b53d9be6b44613fa92] Merge branch 'v5.9-clk/n=
ext' into for-next
git bisect good 99bcf38dd05b76b41f8564b53d9be6b44613fa92
# good: [dc45e438fac0b5df3c31bb83f3d809cd0f67dcfe] Merge branch 'next/dt' i=
nto for-next
git bisect good dc45e438fac0b5df3c31bb83f3d809cd0f67dcfe
# good: [d6fe116541b73a56110310c39a270c99766cd909] Merge branch 'next/soc' =
into for-next
git bisect good d6fe116541b73a56110310c39a270c99766cd909
# bad: [24077bf8f9e69a3a6a2c714634e6c813566a152f] Merge tag 'juno-fix-5.8' =
of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into fo=
r-linux-next
git bisect bad 24077bf8f9e69a3a6a2c714634e6c813566a152f
# bad: [38ac46002d1df5707566a73486452851341028d2] arm: dts: vexpress: Move =
mcc node back into motherboard node
git bisect bad 38ac46002d1df5707566a73486452851341028d2
# first bad commit: [38ac46002d1df5707566a73486452851341028d2] arm: dts: ve=
xpress: Move mcc node back into motherboard node
---------------------------------------------------------------------------=
----
