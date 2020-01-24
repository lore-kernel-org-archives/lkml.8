Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FF3C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 03:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9633E21D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 03:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hdNcnu9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgAXDkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:40:04 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:52286 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbgAXDkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 22:40:04 -0500
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 00O3djBe007545
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 12:39:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 00O3djBe007545
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579837186;
        bh=s3lkUpOhniK8jQRTTs1U4BOtTESo73cdDDpCBPoFEGA=;
        h=From:Date:Subject:To:Cc:From;
        b=hdNcnu9jmDkLWPWwL7yrLPvX+xgWCIEMrG/iBaSlggoRCYQnn0ilyj2uVOWrJWLBg
         sRb5GMmodqntvtdfOkC3IrTri+VeKgi8KkCQW1t3X2W4DZkDxqTfT/xvkpW3byI5Y5
         W+ZkaLgRqdB8u0iNqe3OqBzFfrQABBEhm5IhnX5KaxAkDMgIwg28gGuDb4OfjmVvYl
         6brPd3H4rGoKOPvcGnt4KZyOg6oa/o4cLncoddDiWbnT0Ge40Jr5IbR3PfgeifsS21
         yvWxG2uNeF3RAlkCSxma/YryNcyolgCu5nPfsn3MG1EuMihGSDdJ2Zn/O+kfIRMXiR
         F87llQDOHdIQA==
X-Nifty-SrcIP: [209.85.221.182]
Received: by mail-vk1-f182.google.com with SMTP id w67so259081vkf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 19:39:46 -0800 (PST)
X-Gm-Message-State: APjAAAUS6ZIql7eM+XD385tR4L6hsRCqnwwOfnAyLZrlC9/9yqmPdLh2
        igy+53cu9j85ZHuqSmGY95hUCYJKLRZwlPGrdhU=
X-Google-Smtp-Source: APXvYqw1ZG0E84h4+qv6BgKdO/rj/ZOnhDN9r048cMXacxVlBB9RfIEywlchzHZs9uX2OLTp4nfEZ6rtvSmpKgAQwa0=
X-Received: by 2002:a1f:6344:: with SMTP id x65mr819981vkb.26.1579837185307;
 Thu, 23 Jan 2020 19:39:45 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 24 Jan 2020 12:39:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNASehDHWgOug=Rz0uBBSP2ntJnNLiarfSdj97tZu+OXLkA@mail.gmail.com>
Message-ID: <CAK7LNASehDHWgOug=Rz0uBBSP2ntJnNLiarfSdj97tZu+OXLkA@mail.gmail.com>
Subject: [GIT PULL (RESEND)] arm64: dts: uniphier: UniPhier DT updates for v5.6
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

Here are UniPhier DT (64bit) updates for the v5.6 merge window.
(I am resending this with soc@kernel.org in the To: list)

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
