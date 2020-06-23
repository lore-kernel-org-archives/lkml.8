Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F9EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B0420716
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="APdLuZED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732810AbgFWOXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732698AbgFWOXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:23:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AB1C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 07:23:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g12so9178728pll.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 07:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=qFlOj3wSSSINOzv90EaLpuVFFjebeMk4KVdQXi9/yNc=;
        b=APdLuZEDWd1OMGhDoMAaRMtSUxrpGGMQdnAaFCMsfp7ovPdt/FNXP3tG9r+eJj0kke
         CshHHxHrhRewRr0kn6wukWaOwPFKu1dh1mThMyIWPARfIf6kKEgseYCaOZpURqNL2VVh
         /j7L+IsrUaXRmIDOUrgJu+FLxfAyLxlXPmzGbN2t/zRFzanEpYP0ztX3sgM0yLaxK8qz
         KIwI2T01wURJcmv0UJFT8G4T/+PkYbHaOFTGNBXiS+9w4g6xEKwhgySmhuS1Lsi6YbHb
         ntNb/UrAQOTOhMpkEy6S6Q3I41963Ytvvp2DuTsi/4GHHl9quM6VGZAnoZX0tp4/+9kO
         vpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=qFlOj3wSSSINOzv90EaLpuVFFjebeMk4KVdQXi9/yNc=;
        b=LXLOn66taMtjQeh438eiICDriqZrvVvSDuvWS6op7IgtcKFeys2sdZKuIiTEES5jCx
         Uo/5r3PNyHtJxLEwzG3KVFhHe/oI5Od7bmirNTICd3vu3d1dss00WZmeltL7k0VQebBs
         Bd/ofrrMbWltrBCQdbi463i8wT3NQQ2fg1PWhUt7oKbk+viOmXDHbOC/KbVPkBpKMCMy
         1MAJT5QS8Ch1PM85qf7J+K7peHGHkRRfu7Lli3NIYYN0uk4Xd8AQ2FiZve5T2k3x/jDw
         IHQW6ByjNEKb/FvS+Xw9Wd9FmxvtAZtWradyDjwM9hq5a1aLNIiUKFweaz8gTU8j0Qsl
         ngDg==
X-Gm-Message-State: AOAM532iCANm7vaQg3WFjI3sWM4C+PYTQSZ9BEtiYmpaVf6oS7RwFuHj
        rQ7prDHXIMQQ0EyD/vh/JBJISA==
X-Google-Smtp-Source: ABdhPJxrmexBOtjGKXRnBtb20pi39k+MESf7jEYVkXYd2xA5n2oHhcYZyMhHzfr8sMsSWcTkevcFOw==
X-Received: by 2002:a17:90b:796:: with SMTP id l22mr21618759pjz.45.1592922196445;
        Tue, 23 Jun 2020 07:23:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y7sm2814095pjm.54.2020.06.23.07.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 07:23:15 -0700 (PDT)
Message-ID: <5ef21053.1c69fb81.b80ec.8649@mx.google.com>
Date:   Tue, 23 Jun 2020 07:23:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Branch: for-next
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Tree: krzysztof
X-Kernelci-Kernel: v5.8-rc1-14-gd6fe116541b7
Subject: krzysztof/for-next bisection: baseline.dmesg.crit on bcm2837-rpi-3-b
To:     "kernelci.org bot" <bot@kernelci.org>, gtucker@collabora.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kukjin Kim <kgene@kernel.org>
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

krzysztof/for-next bisection: baseline.dmesg.crit on bcm2837-rpi-3-b

Summary:
  Start:      d6fe116541b7 Merge branch 'next/soc' into for-next
  Plain log:  https://storage.kernelci.org/krzysztof/for-next/v5.8-rc1-14-g=
d6fe116541b7/arm64/defconfig+CONFIG_RANDOMIZE_BASE=3Dy/gcc-8/lab-baylibre/b=
aseline-bcm2837-rpi-3-b.txt
  HTML log:   https://storage.kernelci.org/krzysztof/for-next/v5.8-rc1-14-g=
d6fe116541b7/arm64/defconfig+CONFIG_RANDOMIZE_BASE=3Dy/gcc-8/lab-baylibre/b=
aseline-bcm2837-rpi-3-b.html
  Result:     5b17a04addc2 ARM: exynos: clear L310_AUX_CTRL_FULL_LINE_ZERO =
in default l2c_aux_val

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       krzysztof
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
  Branch:     for-next
  Target:     bcm2837-rpi-3-b
  CPU arch:   arm64
  Lab:        lab-baylibre
  Compiler:   gcc-8
  Config:     defconfig+CONFIG_RANDOMIZE_BASE=3Dy
  Test case:  baseline.dmesg.crit

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 5b17a04addc29201dc142c8d2c077eb7745d2e35
Author: Guillaume Tucker <guillaume.tucker@collabora.com>
Date:   Fri Jun 12 14:58:37 2020 +0100

    ARM: exynos: clear L310_AUX_CTRL_FULL_LINE_ZERO in default l2c_aux_val
    =

    This "alert" error message can be seen on exynos4412-odroidx2:
    =

        L2C: platform modifies aux control register: 0x02070000 -> 0x3e4700=
01
        L2C: platform provided aux values permit register corruption.
    =

    Followed by this plain error message:
    =

        L2C-310: enabling full line of zeros but not enabled in Cortex-A9
    =

    To fix it, don't set the L310_AUX_CTRL_FULL_LINE_ZERO flag (bit 0) in
    the default value of l2c_aux_val.  It may instead be enabled when
    applicable by the logic in l2c310_enable() if the attribute
    "arm,full-line-zero-disable" was set in the device tree.
    =

    The initial commit that introduced this default value was in v2.6.38
    commit 1cf0eb799759 ("ARM: S5PV310: Add L2 cache init function in
    cpu.c").
    =

    However, the code to set the L310_AUX_CTRL_FULL_LINE_ZERO flag and
    manage that feature was added much later and the default value was not
    updated then.  So this seems to have been a subtle oversight
    especially since enabling it only in the cache and not in the A9 core
    doesn't actually prevent the platform from running.  According to the
    TRM, the opposite would be a real issue, if the feature was enabled in
    the A9 core but not in the cache controller.
    =

    Reported-by: "kernelci.org bot" <bot@kernelci.org>
    Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
    Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 7a8d1555db40..36c37444485a 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -193,7 +193,7 @@ static void __init exynos_dt_fixup(void)
 }
 =

 DT_MACHINE_START(EXYNOS_DT, "Samsung Exynos (Flattened Device Tree)")
-	.l2c_aux_val	=3D 0x3c400001,
+	.l2c_aux_val	=3D 0x3c400000,
 	.l2c_aux_mask	=3D 0xc20fffff,
 	.smp		=3D smp_ops(exynos_smp_ops),
 	.map_io		=3D exynos_init_io,
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [b0953d8b7cdb39493e67cff4b20b0ebe3a2bba92] Merge branch 'next/drive=
rs' into for-next
git bisect good b0953d8b7cdb39493e67cff4b20b0ebe3a2bba92
# bad: [d6fe116541b73a56110310c39a270c99766cd909] Merge branch 'next/soc' i=
nto for-next
git bisect bad d6fe116541b73a56110310c39a270c99766cd909
# bad: [5b17a04addc29201dc142c8d2c077eb7745d2e35] ARM: exynos: clear L310_A=
UX_CTRL_FULL_LINE_ZERO in default l2c_aux_val
git bisect bad 5b17a04addc29201dc142c8d2c077eb7745d2e35
# first bad commit: [5b17a04addc29201dc142c8d2c077eb7745d2e35] ARM: exynos:=
 clear L310_AUX_CTRL_FULL_LINE_ZERO in default l2c_aux_val
---------------------------------------------------------------------------=
----
