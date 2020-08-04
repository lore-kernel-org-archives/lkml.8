Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F3AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8874206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hg7DVeAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgHDSsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 14:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgHDSsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 14:48:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF6EC061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 11:48:45 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id kq25so30650824ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 11:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=k6n9Bx3dS7/rl5+hEQcop2J6ordeV//9xvdRouOCTy8=;
        b=hg7DVeAuoJ8QIOV9tq9Uk8NDmJQs7QY+/+0GaEmeFug3QJKKIl9TecClodaq5ryqwX
         bQCilQCYYffU16LTepCDIh+agVs9uQUSAQV6Zx4EpcaBJyd6yRu2vZkKqAjc+V8p6wD1
         sVeMAe3SNpy6Kx7H/NJxH6bmXtKpYRJfAls1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=k6n9Bx3dS7/rl5+hEQcop2J6ordeV//9xvdRouOCTy8=;
        b=l9OehUeYWi949iloqQSwAmpOqZuE/n6SEkiMlW51k3bROsMzb2gtvZ+eU7JFRZ5Z2T
         K57BvpV+REFE+hDVhKL972SkkyzB9e5yphy0Idj089+dvWgkmcvw78aqn5w1tLS2YMNr
         R/0kvxmwfduFaD3c233BkjZdWMFakRDax7IYzuFQRRI04McDtQrOrCVBfPIBy8YxP8Du
         moSh/HWjKZ+saQlYNYxd2vuYKUrbekS5owYskkpnxFtKOvTImYcXH+oghTaLR0y5nbj2
         FZqLEJLaeWzeRWry0Nv6hwUuza3C+O58qVzgD7Oktxt/53Fl9shY7KAXpdlkBszcrUNQ
         jQ0A==
X-Gm-Message-State: AOAM533pScn/znTUwM3mzW6xpPxhJTuE4JsadZnP1DQa+5b7Zxf0A4Bt
        Xs5wgHkZNtFmzrVCDOt3ULXtrj0dM0a/M5haPKCjHg==
X-Google-Smtp-Source: ABdhPJzErpOyOvNE+rPIf2h1XLHlZ/Z9OnqOzuXaEJHun6C5kwQFsKbupJpAwtgn1WjEhgl1H9J/a3e/s+vx+8dRcCU=
X-Received: by 2002:a17:906:d187:: with SMTP id c7mr23685263ejz.196.1596566924085;
 Tue, 04 Aug 2020 11:48:44 -0700 (PDT)
MIME-Version: 1.0
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Tue, 4 Aug 2020 11:48:32 -0700
Message-ID: <CAGt4E5tMdG9gZbx43MeXpiPnqe0sy9bYKQmZ1oJCSwTL=Xf7Dg@mail.gmail.com>
Subject: Build error caused by "arm64: dts: agilex: add nand clocks"
To:     Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Device Tree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know if anybody else is seeing this, but for me the commit
"arm64: dts: agilex: add nand clocks"[1] is causing a build error
while generating DTS files for ARM64.

The error goes away when I drop the commit.

$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make defconfig dtbs
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'defconfig'
[...]
  DTC     arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb
  DTC     arch/arm64/boot/dts/freescale/s32v234-evb.dtb
  DTC     arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dtb
  DTC     arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dtb
  DTC     arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dtb
  DTC     arch/arm64/boot/dts/hisilicon/hi6220-hikey.dtb
  DTC     arch/arm64/boot/dts/hisilicon/hip05-d02.dtb
  DTC     arch/arm64/boot/dts/hisilicon/hip06-d03.dtb
  DTC     arch/arm64/boot/dts/hisilicon/hip07-d05.dtb
  DTC     arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dtb
Error: arch/arm64/boot/dts/intel/socfpga_agilex.dtsi:313.15-16 syntax error
FATAL ERROR: Unable to parse input tree
make[3]: *** [scripts/Makefile.lib:309:
arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dtb] Error 1
make[2]: *** [scripts/Makefile.build:497: arch/arm64/boot/dts/intel] Error 2
make[1]: *** [Makefile:1306: dtbs] Error 2
make: *** [Makefile:336: __build_one_by_one] Error 2

Regards,
-Markus

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4ae4dd346cd49302d157b129ead2f60d3a82534
