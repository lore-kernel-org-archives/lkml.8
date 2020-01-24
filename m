Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E61FC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 03:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6A621D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 03:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nbvWfBFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgAXDhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:37:17 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:58978 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729836AbgAXDhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 22:37:16 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 00O3akBr021813
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 12:36:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 00O3akBr021813
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579837007;
        bh=chlER5pUjChdgEZWVw3HaCka4WX6vPliYp05kErac5o=;
        h=From:Date:Subject:To:Cc:From;
        b=nbvWfBFzvpK3rBSHRcDyY6BifgF2wf7pdh4HhvtpXS3FVfChwHp90JapqE6ZvylkA
         bRssfQo8kACXA/5B/R+sWFjmF4iXwfhZDwiPJV9O90nsessrIDOq1gL3bWIHR1gR2C
         6+VxD2y9W/V45BWfpCyAeHQ1tF5Tx3ihyvpe7lhx4/btiT7dS5WYyIsdT9DdEK8YZX
         tBl8joox2T7IgoWUg0luWr5braI2u89kLdFsl+Rnrm34mLBfHvlCyyeLVnTTk4t2tM
         A7e+fvNey310JF5jQczNzeRKCyOGtsnt0yHwRnQPAkRKzYfSobvqEr0KgvU+qNknZk
         hIrQKsDPHMm1A==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id r18so413526vso.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 19:36:47 -0800 (PST)
X-Gm-Message-State: APjAAAWatHfVv1tcYgJUNz9421AkHodehEvoaH9Wnf6i9VuMruJv0Kz9
        +Q7D558An7JuDXCwWBK8l6EMk1HwgiQXPIEwwfY=
X-Google-Smtp-Source: APXvYqy/3sLs4nkX6yiO6kZcQfWXSBoGVFCwBd5TPBt7Lt2QNvKAs4sEQNUn1y8usOFTg4JrXZXwSAZs+XCXhbtM1d8=
X-Received: by 2002:a05:6102:3102:: with SMTP id e2mr949801vsh.179.1579837006036;
 Thu, 23 Jan 2020 19:36:46 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 24 Jan 2020 12:36:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNARYrzv4QU-eXxqYCcC9dziJmx9F02YNZ3mMnF47EfL3fA@mail.gmail.com>
Message-ID: <CAK7LNARYrzv4QU-eXxqYCcC9dziJmx9F02YNZ3mMnF47EfL3fA@mail.gmail.com>
Subject: [GIT PULL (RESEND)] ARM: dts: uniphier: UniPhier DT updates for v5.6
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

Here are UniPhier DT (32bit) updates for the v5.6 merge window.
(I am resending this with soc@kernel.org in the To: list)

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
