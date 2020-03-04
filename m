Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A84DC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44EF20842
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583292053;
	bh=fxNureI0SDMgNHiWeGL7qS5Vck84hlUIsKAyHtA/trs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k7k1GYWrjVKf5ShXadkBVFDQeDH1ELGuiU470BuznISQ5/7KRM2//e7iJ+bOErY6O
	 u67kaUf6IxGogRHROVnh074xMpcKJCw8kEuMbkw4yvvqRZ0tp6NHK3E/40gTjqqCz8
	 ktEH2pYNaqUb8rLO0BnXm4xsR4DStLmUYKAz+SNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbgCDDUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:20:51 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:63010 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbgCDDUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 22:20:51 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 0243Kef4018747;
        Wed, 4 Mar 2020 12:20:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 0243Kef4018747
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583292043;
        bh=j/IEXPyN2YTrKsama+5BMbGYiocPgs/XNZE+gIHR2cA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTXMER0/QLCdEHNuzY3kb6EAOgk8Xb1FCck1+8E3Vfb9UvnmM4t2vJQEJLG7/1RZc
         QIw3hiPC+fMK2r6RokLrKcykZ4Gj/ZCkb01kLcu5NcTDTOcPo8etJNtWgqypLGeIP7
         3+3kPVAkwf3nYqzOxSNprLzAi22qAuXZMZVlJFjKPj2SdveH8BhAM4efooY0vbVWM1
         Op2cLYSogk3tDbY8mmFrA1vTRHJOCZp8eg4vzAwvUl162qJUt8A2lZPu2EkkzIsn4w
         hLHbDWnuah52ycOZLHxOiDLEtU/bPgi+Hylh8J0t2WEPDWZCQZJByERfnZ0RcDkDi3
         p6CxSY1HCFv/A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 1/3] kbuild: avoid concurrency issue in parallel building dtbs and dtbs_check
Date:   Wed,  4 Mar 2020 12:20:36 +0900
Message-Id: <20200304032038.14424-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304032038.14424-1-masahiroy@kernel.org>
References: <20200304032038.14424-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make dtbs_check' checks the shecma in addition to building *.dtb files,
in other words, 'make dtbs_check' is a super-set of 'make dtbs'.
So, you do not have to do 'make dtbs dtbs_check', but I want to keep
the build system robust in any use.

Currently, 'dtbs' and 'dtbs_check' are independent of each other.
In parallel building, two threads descend into arch/*/boot/dts/,
one for dtbs and the other for dtbs_check, then end up with building
the same DTB simultaneously.

This commit fixes the concurrency issue. Otherwise, I see build errors
like follows:

$ make ARCH=arm64 defconfig
$ make -j16 ARCH=arm64 DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/psci.yaml dtbs dtbs_check
  <snip>
  DTC     arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dtb
  DTC     arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtb
  DTC     arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dtb
  DTC     arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mn-evk.dtb
  DTC     arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dtb
  DTC     arch/arm64/boot/dts/zte/zx296718-pcbox.dtb
  DTC     arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dt.yaml
  DTC     arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dtb
  DTC     arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dtb
  DTC     arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dtb
  DTC     arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dtb
  DTC     arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dtb
  CHECK   arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dt.yaml
fixdep: error opening file: arch/arm64/boot/dts/allwinner/.sun50i-h6-orangepi-lite2.dtb.d: No such file or directory
make[2]: *** [scripts/Makefile.lib:296: arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dtb] Error 2
make[2]: *** Deleting file 'arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dtb'
make[2]: *** Waiting for unfinished jobs....
  DTC     arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dtb
  DTC     arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dtb
  DTC     arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dtb
fixdep: parse error; no targets found
make[2]: *** [scripts/Makefile.lib:296: arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dtb] Error 1
make[2]: *** Deleting file 'arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dtb'
make[1]: *** [scripts/Makefile.build:505: arch/arm64/boot/dts/allwinner] Error 2
make[1]: *** Waiting for unfinished jobs....
  DTC     arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1a1a0d271697..e94d4fe3ef77 100644
--- a/Makefile
+++ b/Makefile
@@ -1240,11 +1240,15 @@ ifneq ($(dtstree),)
 	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
 
 PHONY += dtbs dtbs_install dtbs_check
-dtbs dtbs_check: include/config/kernel.release scripts_dtc
+dtbs: include/config/kernel.release scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree)
 
+ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
+dtbs: dt_binding_check
+endif
+
 dtbs_check: export CHECK_DTBS=1
-dtbs_check: dt_binding_check
+dtbs_check: dtbs
 
 dtbs_install:
 	$(Q)$(MAKE) $(dtbinst)=$(dtstree)
-- 
2.17.1

