Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC89C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F62D2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MQdm6wE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCQR1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:27:22 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:32409 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgCQR1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:27:21 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 02HHR1sP025060
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 02:27:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 02HHR1sP025060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584466022;
        bh=KE22OfskZjd5vE5dPHURGA/IBqPekBZi9gfXTzufvbI=;
        h=From:Date:Subject:To:Cc:From;
        b=MQdm6wE0XYeYvVcXR7RcGU5vAvNGLkrXECUiqgh4HFMRQPPiCbVtTFVe0mOyU6tCP
         rD7CwWw+ibnDtLReWnMnQgKskBFckY8CjRi0ZLNOtWgmI+acpiNstswDkr11TK/FPH
         jdZUQg+9btEll4fBsuddfetnA4vQExGBjC7zD9IbGdQZUL8XPzd+oeMW75NrEBIV6m
         Us7fiZwoN4Q3R33U6Lv5mnysZwPFkaMn+e2RqTBJILQHW0Vaqx8Ib+76WoSgp3XeOw
         PouUpqmjWkmj/CClJbS07HVAj/buqai6wDwSVNedGh44egqPplcCkYa87K76jgi/sG
         jDdEVsjlHcnkA==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id e138so8571436vsc.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:27:01 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1/Hhald4shGee8Z6dCkh9W/sZOqTWMC0ByoqEJR7SktZpeEt80
        PujH7y0ph0Y6FRPHcEBtnbjJ0FzkWdpIXcYD6rU=
X-Google-Smtp-Source: ADFU+vubTUpqtaivmHWe3D2yWqtuuxkGL/Nx3ogaJy6wwOrcos6V3IHJWr0KPtRS9EP0E3hzsf4J64iSZ6L0rhqRbGg=
X-Received: by 2002:a67:8745:: with SMTP id j66mr4425184vsd.181.1584466020438;
 Tue, 17 Mar 2020 10:27:00 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 18 Mar 2020 02:26:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASMD-zqNfG02WhU1LeAJevnjBv=oT2N_7y6C8w7kryotQ@mail.gmail.com>
Message-ID: <CAK7LNASMD-zqNfG02WhU1LeAJevnjBv=oT2N_7y6C8w7kryotQ@mail.gmail.com>
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v5.7
List-Id: <soc.lore.kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        soc@kernel.org
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof, Arnd,

Here are UniPhier DT (64bit) updates for the v5.7 merge window.

Please pull!


The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v5.7

for you to fetch changes up to fdf9c17b51910d19113dd85d6b3b2dce0b88d7f0:

  arm64: dts: uniphier: Set SCSSI clock and reset IDs for each channel
(2020-03-17 00:01:27 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v5.7

- Rename nodes to avoid dt-schema warnings

- Enable SPI for PXs3 reference board

- Enable thermal monitor for PXs3 SoC

- Fix clock and reset of SPI nodes

----------------------------------------------------------------
Kunihiko Hayashi (3):
      arm64: dts: uniphier: Enable spi node for PXs3 reference board
      arm64: dts: uniphier: Add nodes of thermal monitor and thermal
zone for PXs3
      arm64: dts: uniphier: Set SCSSI clock and reset IDs for each channel

Masahiro Yamada (3):
      arm64: dts: uniphier: change SD/eMMC node names to follow json-schema
      arm64: dts: uniphier: rename aidet node names to follow json-schema
      arm64: dts: uniphier: rename NAND node names to follow json-schema

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi    | 10 +++----
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi    | 20 ++++++-------
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts | 10 +++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi    | 55
++++++++++++++++++++++++++++++++----
 4 files changed, 74 insertions(+), 21 deletions(-)


-- 
Best Regards
Masahiro Yamada
