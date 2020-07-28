Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D4BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEA12074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgG1Mjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:39:52 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39597 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgG1Mjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:39:52 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MUog3-1k9Zzg3LPN-00Qkwd for <linux-kernel@vger.kernel.org>; Tue, 28 Jul
 2020 14:39:50 +0200
Received: by mail-qt1-f173.google.com with SMTP id 6so14678893qtt.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:39:49 -0700 (PDT)
X-Gm-Message-State: AOAM532ft4bFBCo/3m9WqTWyB3PZdqwGm8dqMroXkea2B4dXUaFnPBHC
        tsKpbrmL94yt3NzTmE1Jr93a/YirQ77SOcrkj6M=
X-Google-Smtp-Source: ABdhPJwckDPqILh5MZkRtpAOJyIWt+IoSdWuyhbZ0XLUPLImYXJJ9BeuPhpe0XVCM6+9xRTY6vZBJIzcGahaTuBjVs0=
X-Received: by 2002:aed:33e7:: with SMTP id v94mr23912389qtd.18.1595939988628;
 Tue, 28 Jul 2020 05:39:48 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Jul 2020 14:39:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0enQsLLc=AsP+43R2XUswc5u4bKVikyEQBfCcsFbckyg@mail.gmail.com>
Message-ID: <CAK8P3a0enQsLLc=AsP+43R2XUswc5u4bKVikyEQBfCcsFbckyg@mail.gmail.com>
Subject: [GIT PULL] ARM: SoC DT fixes for v5.8, #3
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/9IOv+jCNbkIKyMPODw8LZS9oSvkkOEjjh+x77aMyXsqWZBo+mx
 51rG3FvZwt9X7ipjcs+3OSRKgNTa488fv5M3REnbdLHhk58caOV1mwFd/OtCU1tv7PztCve
 yrKo902vEWqfDnHKQYuRxVXe0ixIg0TWjVVf2dKoeRhHFmOBJC0e0MdO2NHtmI6JhPfVWnR
 CbiuBjADVEzX/nKWITT7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yXUJBWDVvpo=:116MXAX0C5yVnAeKq9L9JA
 ILcqeNeyTbf6j2D0E7zUjVMxNALcvby6kzHDBzhCMrMUn1eO0U0i3lQpxL6hA19yKubuo5ID7
 Y/rHeGin8uexwiSzp+Ht7qp5RjftcTpqyTHJq7hzwgcau+Wdw5Qb12i5+kiwxHQo66lxOYXZJ
 /w5M0vYGlRa4V1S5I5302jf1tIbZroZHb4Br2QOHTv1NEqkJP30dV8HeNAs+Sdw3lk0WjJ9gY
 9leQFXBvhcLbN7Cdy2CIEvvi9dkGmgGN8/zl2IWG0uYYlZnchxQBeS8JHFxPDLunRMPmgyWAx
 QvFqs3r9NonD3VRDmbsRc96ZmXQpOg8Gy8pIJk1Mi8mWyJeSf51N3c38HsyAkW53xWqmuw1Zd
 oe7ycceZIfHm1p7GchdOWBydkNSq7+sZMKL5dGe7n15z0ln76NnRtuuw1iTJXBs5XkPag1rVO
 10NRLf/7IqjaSf+4QMRmY7Tzrsgmh5F4JOsj7v+Mc/XCyfxXxDEtd6xOhyX47lu87o8+G52He
 R3AZcCeZGmfRO7pWD5soRBAWmhcKbwckBsJEb23JEs4zjD1C/u2hdf8rIje4FtWu3qMrKncQW
 k+T2ahmAx2bc6lR8ZUE2FcDhPA9QEYMsqmxtt5l8l53uJ0NgnJ3SD+W1rigVO98ThE2OZD6JK
 RDImJxtzVfjMUt/O7t5Hd/JBAVtQ89RRJvUSn3JqCfB2O5qH+kkfjcmZw7nxItI8YaoS1a5Si
 ZI5IndyOOsr8X+JPAm3mH0ooVCvulHQ++Yf4cGy6wxJbxAcgijtI1jGR0b6+wLbMITs7wyS3S
 ki82Xyzsrv0upQ0KQzDRjZkW7CQ2wsWS/rBgGe5f4tSxglfMbIfwN2wFA/HxuTPePNVmKov
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2648298a06ba7e902c4489a15c0db26032813c7b:

  Merge tag 'socfpga_fixes_for_v5.8_v2' of
git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into
arm/fixes (2020-07-17 18:01:41 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-5.8-3

for you to fetch changes up to fe1d899f4212a08dad98accb47cd335b58cc9085:

  ARM: dts: keystone-k2g-evm: fix rgmii phy-mode for ksz9031 phy
(2020-07-25 09:38:14 +0200)

----------------------------------------------------------------
ARM: SoC DT fixes for v5.8

These are the latest device tree fixes for Arm SoCs:

  - TI Keystone2 ethernet regressed after a driver change broke with
    incorrect phy-mode in a board's DT source.

  - A similar fix is needed for two i.MX boards that were missed in
    an earlier bugfix.

  - DT change for Armada 38x allowing to add the register needed to fix
    NETA lockup when repeatedly switching speed.

  - One fix on imx6qdl-icore pin muxing to get USB OTG_ID and SD card
    detect work correctly.

  - Two fixes for the Allwinner SoCs, one to relax the CMA allocation
    ranges that were failing on older SoCs and one to fix Cedrus on the H6.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (3):
      Merge tag 'sunxi-fixes-for-5.8-1' of
git://git.kernel.org/.../sunxi/linux into arm/fixes
      Merge tag 'imx-fixes-5.8-3' of
git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'mvebu-fixes-5.8-1' of
git://git.kernel.org/.../gclement/mvebu into arm/fixes

Fabio Estevam (2):
      ARM: dts: imx6sx-sdb: Fix the phy-mode on fec2
      ARM: dts: imx6sx-sabreauto: Fix the phy-mode on fec2

Grygorii Strashko (1):
      ARM: dts: keystone-k2g-evm: fix rgmii phy-mode for ksz9031 phy

Maxime Ripard (2):
      ARM: dts sunxi: Relax a bit the CMA pool allocation range
      arm64: dts: allwinner: h6: Fix Cedrus IOMMU usage

Michael Trimarchi (1):
      ARM: dts: imx6qdl-icore: Fix OTG_ID pin and sdcard detect

Russell King (1):
      ARM: dts: armada-38x: fix NETA lockup when repeatedly switching speeds

 .../devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml    | 3 +++
 arch/arm/boot/dts/armada-38x.dtsi                                      | 3 ++-
 arch/arm/boot/dts/imx6qdl-icore.dtsi                                   | 3 ++-
 arch/arm/boot/dts/imx6sx-sabreauto.dts                                 | 2 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                                      | 2 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts                                 | 2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                                       | 2 +-
 arch/arm/boot/dts/sun5i.dtsi                                           | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                                       | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi                           | 1 +
 10 files changed, 14 insertions(+), 8 deletions(-)
