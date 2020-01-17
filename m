Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5D2C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A2C20684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ec1g249k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAQQVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:21:34 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:59724 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgAQQVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:21:34 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 00HGLMAf012801
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 01:21:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 00HGLMAf012801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579278083;
        bh=TeeWya+TG9Xy0gXdSPIQIspK/bwebir0dZTvUEpgOjM=;
        h=From:Date:Subject:To:Cc:From;
        b=ec1g249kdc0PQhw3ujyJ1T+jDGiYuST9J9aKBsRSpDerNwnFzShEX/DHHg40+8Gz1
         cEnkEzA7jps6tAfyPZemBP0LSIdcI2wHDo0IVBcXPNaFcCd5Ogu2i6C0taogbjPH51
         de3XLaA49zyPFoj1VixoTDhf2zxyj68HiaoIwxMU7KEzwKKiSfG7bKrR95a4dz+Nbi
         9E0v7Y3E0PC3fv1nB995RCpVyij50nduOIzNDnn3nSf7BNVY0sHCd/5Fa+c4FBq0Iq
         /Fkg/EH0YLjyl9PROpToKkUfAEcI/gR7CLvEh200EkJHZaGLCrAO2YOE0RYZ8ydKuw
         Occ+WDCiRR5eA==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id g15so15179053vsf.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 08:21:23 -0800 (PST)
X-Gm-Message-State: APjAAAXImPpq0H7vnKvgVojHHXtc6UDH791bEbIh9zLOmvDhP5rd7aUA
        1UJbO1VnxY+guBKLwu2Tb6YNUkYQ8PGrzbAsEUQ=
X-Google-Smtp-Source: APXvYqy5BIDYBDfunLSR9P1Boe13pWwbJ1agFjiJyemKtIJCKx+EHk7ILLhM1Y9qkDkJakd14A6OxFbWNB+6Yz7m5jA=
X-Received: by 2002:a05:6102:2334:: with SMTP id b20mr5253722vsa.155.1579278081911;
 Fri, 17 Jan 2020 08:21:21 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 18 Jan 2020 01:20:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNASEaiFia8NKZN8++-9RfGXOPKSFuCkdukBk9Jy7+nHecQ@mail.gmail.com>
Message-ID: <CAK7LNASEaiFia8NKZN8++-9RfGXOPKSFuCkdukBk9Jy7+nHecQ@mail.gmail.com>
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v5.6
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

Here are UniPhier DT (64bit) updates for the v5.6 merge window.
Please pull!



The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v5.6

for you to fetch changes up to e98d5023fe1f062bb549354a2428d930775fd67e:

  arm64: dts: uniphier: add reset-names to NAND controller node
(2020-01-18 00:56:18 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v5.6

- Add reset-names to NAND controller node

----------------------------------------------------------------
Masahiro Yamada (1):
      arm64: dts: uniphier: add reset-names to NAND controller node

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 3 ++-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 3 ++-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)


-- 
Best Regards
Masahiro Yamada
