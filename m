Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A9BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79959207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ghWKKb5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgGJIzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:55:01 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:62732 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgGJIzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:55:01 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 06A8saaK005019
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:54:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 06A8saaK005019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594371277;
        bh=0Q9D16DhxWs1xBAnPr62IwEtpJ/f0OZ70hr30AlXAJo=;
        h=From:Date:Subject:To:Cc:From;
        b=ghWKKb5vQ+P383msknbAJW/dVzwoGATzXEh7uxM0i/3K7haCQLGNivH3r11Lx8rvd
         WEEFzRRo/+M4QAm4jmO/zE2c6AfmASXGF1vZqRBXP3deTd3pdb1xOXZ7U6T2Q5qAsc
         P2of6jtVmYRhfu+4+fnAzT/N+h2avDF40tkAi0MLKG4/9jYAcd52/smkR8COvllvSI
         bh/Rt9cuThbj8mReZKnI/GfL4sWPX5B694DSbsfYO3YOSyqH7icCV9Zm9lETxmZkaR
         njChnyOOYuxKktPFvnnD/PqvcR68wxYwuB218v6s9P04nZYyDDi4xags8+UA/lrQo+
         THEosRlIeSoWA==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id d198so2597457vsc.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:54:37 -0700 (PDT)
X-Gm-Message-State: AOAM531wlz0YXeJfU2OX7I2czuZ3Dq/Xe99OaFkjPwpEzOqzZfl9voZD
        6Gu9jU2YqqJZkemvsH9KG7IUSmKacBDsiHCJjZA=
X-Google-Smtp-Source: ABdhPJwrs+pqi9pGjcMyWBcb5sTFWJ9s3vVaFosNnB/ENozPQIuRY8vgNVCHtfwoBxHf56VI9MFx6eeOojF7HcjD9Xc=
X-Received: by 2002:a67:694d:: with SMTP id e74mr52949969vsc.155.1594371276396;
 Fri, 10 Jul 2020 01:54:36 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 10 Jul 2020 17:53:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNARK4SKhSW-xwgc3vq7FO7N864jPgzm8NtsGOv8wVFVyBQ@mail.gmail.com>
Message-ID: <CAK7LNARK4SKhSW-xwgc3vq7FO7N864jPgzm8NtsGOv8wVFVyBQ@mail.gmail.com>
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v5.9
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

Here are UniPhier DT (64bit) updates for the v5.9 merge window.

Please pull!


The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v5.9

for you to fetch changes up to e6bd81a2290f03db8baf761d06071f269dc8e177:

  arm64: dts: uniphier: Add missing clock-names and reset-names to
pcie-phy (2020-07-10 10:33:28 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v5.9

- add missing interrupts property to support card serial

- fix node names to follow the DT schema

- add clock-names and reset-names to pcie-phy

----------------------------------------------------------------
Kunihiko Hayashi (2):
      arm64: dts: uniphier: Rename ethphy node to ethernet-phy
      arm64: dts: uniphier: Add missing clock-names and reset-names to pcie-phy

Masahiro Yamada (2):
      arm64: dts: uniphier: add interrupts to support card serial
      arm64: dts: uniphier: give fixed port number to support card serial

 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts  |  2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts     |  8 ++++++--
 arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts |  2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts  |  2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts     |  8 ++++++--
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi        |  2 ++
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts     | 10 +++++++---
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi        |  2 ++
 8 files changed, 26 insertions(+), 10 deletions(-)
