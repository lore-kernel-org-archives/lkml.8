Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA38C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4049A2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByLoZFy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgHDHp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbgHDHp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:45:27 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8039AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 00:45:27 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id n4so186339vsl.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 00:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=feh7RxUtSqLBph4VDa4rqiDTI4QQeVOJVHBSSi+EkrM=;
        b=ByLoZFy1lDsP2ZYMnrJyGhZ5pqOEDGHmvmVSriCKAlqXp6Me5DEHVUJreI+OvtTKiB
         Swb0P0if20yG15zV5I1T5h04BLnFTjkcC6JfxAKKve0GyeKUzxDLFJdRZJBTIZJSNFD5
         ng8rgKdkfntsQq6c8ustfeK4wb3yo2lR5H1Fn0YSSLA67xLctA43YsG+az62OBLD2/VB
         tvbcP9b7AYwvIem7UjZCsIyXBgAHvidwZCdYC3h5pLwBPaJNnSEZ2diEzZfjqTJnHBJp
         OWlD7OtsfnofEKJRl87WGHdbH4jMnGSPBBmedegEUDCnS9UyqwyM38VcdOBufYBTmy4o
         NMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=feh7RxUtSqLBph4VDa4rqiDTI4QQeVOJVHBSSi+EkrM=;
        b=cEKpE9McP/smO65KbSXucutPfE0aZY86+CJ1olLu2gY297e8OeQPblg3siwazkXg/i
         XOhiIruFSgwS6w0j0hU0LlU/Xhv0pNWqJUT1iyP/IVxei27MOWqe4vekE/gNHgfW43Y0
         rqgunFBKhcuOV2tTGvx2vFFsn7wKTi3X+SivTiQMVS4y3YRGYjg7uGsu4/kkADO8eKDA
         tzJ2T/1KJ7JWjoEb5F+g9w82BOP78IDywdD80AU7wtiNLCuItP4wol3s/K96Skri8hPx
         tQXL9Bh3plBA1YJOL0FcH1Z3m/YqMchjbjRiy7lKZ/mi8ea4XU7XaK9rI2q+vaN95FES
         gX7A==
X-Gm-Message-State: AOAM532Z+emw5g4qvOshRZTUoSXdvwRvF2/ED1+nJeUAafW5M1hlfKVr
        BEfOyPdT9g1a8jyXXybxHU6oh1AV4CpNLjRC+jMqwBu7TO+7UA==
X-Google-Smtp-Source: ABdhPJzYoqmCDolQz6cBgPMWbFtn29DKgO7L9ps4ITePL+WpAKuW8oBgmHNSSJftpZ4sacciBIStFpymtip1aV9f96c=
X-Received: by 2002:a67:f70c:: with SMTP id m12mr12835009vso.238.1596527125331;
 Tue, 04 Aug 2020 00:45:25 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Aug 2020 13:15:14 +0530
Message-ID: <CA+G9fYuvWVwvauqpfcwuJK+Zg5O=BWUG2_s1ceH-kTc9COZmHA@mail.gmail.com>
Subject: arm64: make dtbs broken - socfpga_agilex.dtsi:313.15-16 syntax error
 FATAL ERROR: Unable to parse input tree
List-Id: <soc.lore.kernel.org>
To:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkft-triage@lists.linaro.org, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Cc:     dinguyen@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux mainline master build breaks on arm64 while building dtbs.

make -sk KBUILD_BUILD_USER=TuxBuild -C/linux ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- HOSTCC=gcc CC="sccache
aarch64-linux-gnu-gcc" O=build dtbs
#
../arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14:
Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges"
property but its #address-cells (1) differs from / (2)
../arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14:
Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges"
property but its #size-cells (1) differs from / (2)
../arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14:
Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges"
property but its #address-cells (1) differs from / (2)
../arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14:
Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges"
property but its #size-cells (1) differs from / (2)
../arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14:
Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges"
property but its #address-cells (1) differs from / (2)
../arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14:
Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges"
property but its #size-cells (1) differs from / (2)
Error: ../arch/arm64/boot/dts/intel/socfpga_agilex.dtsi:313.15-16 syntax error
FATAL ERROR: Unable to parse input tree
make[3]: *** [scripts/Makefile.lib:314:
arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dtb] Error 1
Error: ../arch/arm64/boot/dts/intel/socfpga_agilex.dtsi:313.15-16 syntax error
FATAL ERROR: Unable to parse input tree
make[3]: *** [scripts/Makefile.lib:314:
arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dtb] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:497: arch/arm64/boot/dts/intel] Error 2
../arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: Warning
(dma_ranges_format): /soc:dma-ranges: empty "dma-ranges" property but
its #address-cells (1) differs from / (2)
../arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: Warning
(dma_ranges_format): /soc:dma-ranges: empty "dma-ranges" property but
its #size-cells (1) differs from / (2)
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/linux/Makefile:1307: dtbs] Error 2
make: *** [Makefile:185: __sub-make] Error 2

build url:
https://gitlab.com/Linaro/lkft/kernel-runs/-/jobs/669607311

git log --oneline arch/arm64/boot/dts/intel/ | head

60176e6be0bb arm64: dts: agilex: add status to qspi dts node
fd0d094531db arm64: dts: agilex: correct service layer driver's compatible value
8d6b6bbe6dde arm64: dts: agilex: correct FPGA manager driver's compatible value
854e80bcfdaf Merge tag 'arm-dt-5.7' of
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
80f132d73709 arm64: dts: increase the QSPI reg address for Stratix10 and Agilex
8c867387160e arm64: dts: socfpga: agilex: Fix gmac compatible
1afa9c3b7c9b Merge tag 'armsoc-dt' of
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
210de0e996ae arm64: dts: agilex/stratix10: fix pmu interrupt numbers
2f804ba7aa9e arm64: dts: agilex: Add SysMgr to Ethernet nodes
a6706bd60be7 arm64: dts: agilex: Add SysMgr compatible


-- 
Linaro LKFT
https://lkft.linaro.org
