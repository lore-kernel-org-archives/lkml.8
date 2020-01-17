Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855D9C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D112073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pnkROUmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAQQRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:17:34 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:54632 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgAQQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:17:33 -0500
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 00HGHP4j010840
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 01:17:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 00HGHP4j010840
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579277845;
        bh=I3ut7fRPhrMVRpNLHqwLkp4DT8+R+lRU1N1ykqfVyVM=;
        h=From:Date:Subject:To:Cc:From;
        b=pnkROUmJt/MX4GjaBlKa/emow39nhrsPKAn3pGbnMt4fvsxMIuUAtFMTLUWn2T47M
         QUdeEHRdoyNavCWqEIhyY2QP1ELygS8k2NElSAEwAyoNnpZDqFN6LxKltGXZ3KJAb0
         bjFPUx/J5gC2GRxmP9QLTRjyvQ5YgPtThl7P1Jx67Wky26hYFkagoQPCVP/YfISLRV
         OgHzoWnDV5d8t23lukaKz8s1B5BQJQQRPxcQdL7suzbeT+l3oh3Xs+XmONRWH9FeEh
         zyrgMdzCR2Qr29krv33sQbn26EykZFx95LWqo5WkJjd2MmQIIwKRHOAGJ6hOUGtkpM
         0J0HKsrG+fLtw==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id y184so6769207vkc.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 08:17:25 -0800 (PST)
X-Gm-Message-State: APjAAAVPe40ALiq4Upkj8kqqyxakHV4MOsizYpmDxzlR9/cbmwC1ynMr
        /fuwdZqIFvnyFNA8cAxaZ9hyk8GZO4PzVylzrHA=
X-Google-Smtp-Source: APXvYqxHSvowQPk4UTnHnWLjFJjpHtO78N8FWGDQXqpkhwKdrjrCbTgyX27LLY6X4gDjRNNR9AcXazktPpwapFpPbRw=
X-Received: by 2002:a1f:72c3:: with SMTP id n186mr23949934vkc.12.1579277844236;
 Fri, 17 Jan 2020 08:17:24 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 18 Jan 2020 01:16:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNASSVYHunCn154ktOVDm=MOe+jhEq8Xc8g0JAtCjjJRHwQ@mail.gmail.com>
Message-ID: <CAK7LNASSVYHunCn154ktOVDm=MOe+jhEq8Xc8g0JAtCjjJRHwQ@mail.gmail.com>
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v5.6
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

Here are UniPhier DT (32bit) updates for the v5.6 merge window.
Please pull!



The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v5.6

for you to fetch changes up to 37f3e0096f716b06338a4771633b32b8e2a36f7f:

  ARM: dts: uniphier: add reset-names to NAND controller node
(2020-01-18 00:56:09 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v5.6

- Add pinmux nodes for I2C ch5, ch6

- Add reset-names to NAND controller node

----------------------------------------------------------------
Masahiro Yamada (2):
      ARM: dts: uniphier: add pinmux nodes for I2C ch5, ch6
      ARM: dts: uniphier: add reset-names to NAND controller node

 arch/arm/boot/dts/uniphier-ld4.dtsi     |  3 ++-
 arch/arm/boot/dts/uniphier-pinctrl.dtsi | 10 ++++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi    |  3 ++-
 arch/arm/boot/dts/uniphier-pro5.dtsi    |  3 ++-
 arch/arm/boot/dts/uniphier-pxs2.dtsi    |  3 ++-
 arch/arm/boot/dts/uniphier-sld8.dtsi    |  3 ++-
 6 files changed, 20 insertions(+), 5 deletions(-)


-- 
Best Regards
Masahiro Yamada
