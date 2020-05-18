Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E053BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFDA207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hmZBvJCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgERHuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:50:55 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:29922 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERHuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:50:54 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 04I7oe6G015704
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:50:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 04I7oe6G015704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589788241;
        bh=BAeKR/CP8c+c34Jrd/Sa5Uac4xG1EKW7xJ1dkN7birA=;
        h=From:Date:Subject:To:Cc:From;
        b=hmZBvJCvFZ/p+FvqzNJxJo+5AbmElt/8YxHvjygTfb80nk20m3vi/zGhDKQgQoYBi
         q3eypeh6FRRfA6WG1EWsP1bVcDLt4EPJynPe1MMKJM1aaJ3IwYBFsjjffjg2jgbzpj
         da4fBZd9/Fgm6AsLEJSZCgBEXaR1UckzzHPBxj+SAUlIuED0CKgDw37RcDsg6nLnf6
         eC8Tafyza2KnEAb9u8FQu3WibpcPH8hFQ+dIR2VrG7SZSSnobpJ5SakD48EXv0V2MT
         oZRU/egizOBwpil5sHPeS+/VdBNqpw5jLr7Iii2k41LCRk8vXRCr39w3OgUsnS5O9J
         qEaakKXRGR6rg==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id l15so3101197vsr.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:50:40 -0700 (PDT)
X-Gm-Message-State: AOAM530hDAaFkFnB92DuFUeEOv3m8uuYQsWYQ3rL2DKBi4p0Is9rJF9V
        G7TZICc/7LhYqN1yRsZuN3N1bMBolaqmgD1GPKw=
X-Google-Smtp-Source: ABdhPJz+rRVl4TNOdWB+sVuKR/NvML4+a3CfHecIfsBbBz3Bot35tpH4pAKiTBv9bpirXHJkVnhxj0hz/T+OmvGHJg0=
X-Received: by 2002:a67:d016:: with SMTP id r22mr9596614vsi.215.1589788239877;
 Mon, 18 May 2020 00:50:39 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 18 May 2020 16:50:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNARUL52pBhg8AD9XeScVqhD8qr2eVEfu4+1v8D+KPyOwNw@mail.gmail.com>
Message-ID: <CAK7LNARUL52pBhg8AD9XeScVqhD8qr2eVEfu4+1v8D+KPyOwNw@mail.gmail.com>
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v5.8
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof, Arnd,


Here are UniPhier DT (64bit) updates for the v5.8 merge window.

(I intentionally based this on -rc4.
because I needed a dt-binding fix from DMA engine tree
to avoid 'make ARCH=arm dtbs_check' regression.
I hope this is OK.)


Please pull!



The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v5.8

for you to fetch changes up to 7d5620d31ecc8d19f6e4ad73196955ec0bb4a507:

  arm64: dts: uniphier: Add support for Akebi96 (2020-05-04 10:07:35 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v5.8

- add DMA controller nodes

- add Akebi96 board support

----------------------------------------------------------------
Kunihiko Hayashi (3):
      arm64: dts: uniphier: Add XDMAC node
      arm64: dts: uniphier: Add ethernet aliases
      arm64: dts: uniphier: Stabilize Ethernet RGMII mode of PXs3 ref board

Masahiro Yamada (1):
      arm64: dts: uniphier: add #address-cells and #size-cells to SPI nodes

Masami Hiramatsu (2):
      dt-bindings: arm: Add Akebi96 board support
      arm64: dts: uniphier: Add support for Akebi96

 .../bindings/arm/socionext/uniphier.yaml   |   1 +
 arch/arm64/boot/dts/socionext/Makefile     |   1 +
 .../dts/socionext/uniphier-ld11-global.dts |   1 +
 .../dts/socionext/uniphier-ld11-ref.dts    |   1 +
 .../boot/dts/socionext/uniphier-ld11.dtsi  |  12 +
 .../socionext/uniphier-ld20-akebi96.dts    | 189 ++++++++++++++++
 .../dts/socionext/uniphier-ld20-global.dts |   1 +
 .../dts/socionext/uniphier-ld20-ref.dts    |   1 +
 .../boot/dts/socionext/uniphier-ld20.dtsi  |  16 ++
 .../dts/socionext/uniphier-pxs3-ref.dts    |  18 ++
 .../boot/dts/socionext/uniphier-pxs3.dtsi  |  12 +
 11 files changed, 253 insertions(+)
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts
