Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F2FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D754207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YarFmJJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGJIv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:51:28 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:29932 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgGJIvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:51:25 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 06A8orCp001998
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:50:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 06A8orCp001998
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594371054;
        bh=L2agycBkWuNPWcp2GvrsWJYrwV4nURk1F02slKECrU4=;
        h=From:Date:Subject:To:Cc:From;
        b=YarFmJJrd+LaO9bK0TJ09lqCrsIniY3oPjiScdFcwUwCPwp0dg2c4Jl3xCXJqSrr1
         nqwoW1oXOeP5DPS4N89G3aUxmuAW5QC9zCONVsqv2fWaWEreWoSZYxQlFLAmOnCKfA
         TAfr+zRcciluK5ENmmvttJuXXx5DuYzQ4t16x+VLWEub2bXqHuKg4wZhq3cfmeJ9MH
         DUomNKvG5+O6qMH5HM5nbC4oeOOOcayBZ3iv0+jJ9MvPYziYxsiDBRff56Utbs/cBT
         7Q8gy8oeBVBj4GMcsynaIh8Jg+pxXg1PPyz4AyufPZ1r2xhkkJB2NZ95pUf62Xl5s/
         oLrYKYgs9x0Vw==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id k7so2588043vso.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:50:54 -0700 (PDT)
X-Gm-Message-State: AOAM530xCYg5XvaBsJkwrLv1hM6KOhsCsQFm6+4vQVy5VPCLwqAysvLw
        mn8EWxYKqXjk2OB6GxLEbIrygtkL56/tK/EpL9I=
X-Google-Smtp-Source: ABdhPJxZQnZP+1HPzAFDuZUj6XewWgNJEeV6YYJKLVbcJqwX2kwvQBNzT9TG5lf25xFd5h7EJnYh1XYSrnF1NKxYhSU=
X-Received: by 2002:a67:2e4d:: with SMTP id u74mr39844334vsu.215.1594371053268;
 Fri, 10 Jul 2020 01:50:53 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 10 Jul 2020 17:50:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNARGDcCKxV3-H7WmuZAVe49n0QF+672-KN0tsP0och0a_A@mail.gmail.com>
Message-ID: <CAK7LNARGDcCKxV3-H7WmuZAVe49n0QF+672-KN0tsP0och0a_A@mail.gmail.com>
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v5.9
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof, Arnd,

Here are UniPhier DT (32bit) updates for the v5.9 merge window.

Please pull!



The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v5.9

for you to fetch changes up to 781865604d1695314df901e106d27b26446359d8:

  ARM: dts: uniphier: simplify support-card node structure (2020-07-10
17:13:20 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v5.9

- add missing interrupts property to support card serial

- fix node names to follow the DT schema

- add PCIe endpoint and PHY nodes for Pro5 SoC

- simplify device hierarchy of support-card.dtsi

----------------------------------------------------------------
Kunihiko Hayashi (2):
      ARM: dts: uniphier: Rename ethphy node to ethernet-phy
      ARM: dts: uniphier: Add PCIe endpoint and PHY node for Pro5

Masahiro Yamada (4):
      ARM: dts: uniphier: add interrupts to support card serial
      ARM: dts: uniphier: rename support card serial node to fix schema warning
      ARM: dts: uniphier: give fixed port number to support card serial
      ARM: dts: uniphier: simplify support-card node structure

 arch/arm/boot/dts/uniphier-ld4-ref.dts       |  6 +++++-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts      |  7 ++++++-
 arch/arm/boot/dts/uniphier-pinctrl.dtsi      |  5 +++++
 arch/arm/boot/dts/uniphier-pro4-ace.dts      |  2 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts      |  8 ++++++--
 arch/arm/boot/dts/uniphier-pro4-sanji.dts    |  2 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi         | 30
++++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts   |  2 +-
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts    |  2 +-
 arch/arm/boot/dts/uniphier-sld8-ref.dts      |  6 +++++-
 arch/arm/boot/dts/uniphier-support-card.dtsi | 31
++++++++++++-------------------
 11 files changed, 73 insertions(+), 28 deletions(-)
