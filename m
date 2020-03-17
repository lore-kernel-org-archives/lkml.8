Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC92CC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4F620663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vCHQorYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgCQRWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:22:23 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:19330 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgCQRWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:22:23 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 02HHMIbk024091
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 02:22:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 02HHMIbk024091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584465739;
        bh=qt1uWWm7ISvityjdtDvwYf1kohJ6ZdQMbO9zhQ0vl7Y=;
        h=From:Date:Subject:To:Cc:From;
        b=vCHQorYCgGGy5Ssc1rk314dwcVPWw2497vPo52OlnymJ7oGY5fJD7u62kSxJYfsFE
         4gYNpzZBuvbfr0LXw5fu7ieSO6IIo+QjV9IiJCl/7DzdyDpvJwkAEJ/DrwrPIgr04R
         oFPcV7WYOwxA+oXuicj2whWh8KQHrpb68SDx9OuLgeQfgqBvXib+b4WDZrAT+XLEpr
         XPenUX8MqTJ2fWpCcbn54lmBX7UxfdMQCLex1eKe+dyaWJvf+WrU8L5MArgeHw5AxG
         fvyPPSBQY50vrZsQfXzHqBDWGMId6UmYBc6csrspvhdFeo/tcWeMzAw0NJZR70vazv
         Fl9AOa2uW1cQA==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id p7so12235563vso.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:22:18 -0700 (PDT)
X-Gm-Message-State: ANhLgQ30b6XzLe/Z3FyYhLTryVIq5pnXXw8q+NiGhkqvcuVdx9y6WWHU
        F42zH2sAwyixEIYCH5grd/UTu6ksN37S9TkAui0=
X-Google-Smtp-Source: ADFU+vvbJG2vaP5bPmGeZEHouqfbCcWLyLooWYq6AiMCOy3mriUVlYcMoPQ04cCF0JYhs8EppYYiAs3qvm9I0pcm0RQ=
X-Received: by 2002:a67:3201:: with SMTP id y1mr11682vsy.54.1584465737556;
 Tue, 17 Mar 2020 10:22:17 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 18 Mar 2020 02:21:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ-AOTyqpV1E_S-hksjqexHfVauwGV9rrfDvjRVnu8-UQ@mail.gmail.com>
Message-ID: <CAK7LNAQ-AOTyqpV1E_S-hksjqexHfVauwGV9rrfDvjRVnu8-UQ@mail.gmail.com>
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v5.7
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof, Arnd,

Here are UniPhier DT (32bit) updates for the v5.7 merge window.

Please pull!



The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v5.7

for you to fetch changes up to d1876a0bcf3e57165ff7dda9725db81490ec081a:

  ARM: dts: uniphier: Set SCSSI clock and reset IDs for each channel
(2020-03-17 00:01:02 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v5.7

- Rename nodes to avoid dt-schema warnings

- Add a generic compatible to EEPROM so that it matches OF table

- Add USB controller nodes to Pro5 SoC

- Fix clock and reset of SPI nodes

----------------------------------------------------------------
Kunihiko Hayashi (2):
      ARM: dts: uniphier: Add USB3 controller nodes for Pro5
      ARM: dts: uniphier: Set SCSSI clock and reset IDs for each channel

Masahiro Yamada (5):
      ARM: dts: uniphier: change SD/eMMC node names to follow json-schema
      ARM: dts: uniphier: rename aidet node names to follow json-schema
      ARM: dts: uniphier: rename NAND node names to follow json-schema
      ARM: dts: uniphier: rename cache controller nodes to follow json-schema
      ARM: dts: uniphier: Add one more generic compatible string for I2C EEPROM

 arch/arm/boot/dts/uniphier-ld4.dtsi          |  10 +--
 arch/arm/boot/dts/uniphier-pro4.dtsi         |  12 ++--
 arch/arm/boot/dts/uniphier-pro5.dtsi         | 164
+++++++++++++++++++++++++++++++++++++++---
 arch/arm/boot/dts/uniphier-pxs2.dtsi         |  14 ++--
 arch/arm/boot/dts/uniphier-ref-daughter.dtsi |   2 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi         |  10 +--
 6 files changed, 180 insertions(+), 32 deletions(-)


-- 
Best Regards
Masahiro Yamada
