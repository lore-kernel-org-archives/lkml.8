Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8A1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CC620825
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vK03JGNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgERHri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:47:38 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:57087 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERHrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:47:37 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 04I7lLUU009322
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:47:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 04I7lLUU009322
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589788042;
        bh=wlkpEnjVQhrTfI3Q/lY2Xz/QnYWGwFaUeURa+uAY6S8=;
        h=From:Date:Subject:To:Cc:From;
        b=vK03JGNW26ZyF7VyTqccspUPZCl+JqHrYb2iiq3KwDXW/bHPgY+yMouTgEgFOTzoj
         6rE6xMWObtEtHizUN8IdUWwOIcl+CQJGSWjlMzOKqQpbIX7MB06EBdSpqgjbb6s/G9
         XidclT+FpRCBEYOIpdYeyHewXwKs8T6N/DkK5nDEUdFvYhgc4PXAUhIK3R2Z5qS3xN
         g00o+1voPDCp2hpDWpgEoUXrchdN1wW6bdB6XX6YdYvUvGSWS9cU0EYgz8lGF+X6qE
         ZQmLHlxwoyBQKRSnPX4GH30uAZC2tEuepIAYfKKYHyVsLSpIl4D64LYD3WemBNl9kL
         WduaZaHjBpa/w==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id k4so3112312uaq.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:47:22 -0700 (PDT)
X-Gm-Message-State: AOAM532mvbde0dF1W76JcP5DTaKPpYfD3glCp/KkLK+gRiLKbx7BADMr
        3UfR3FrZeHeQ6Dr1CkhB4cYBARnN+BruyYMROiE=
X-Google-Smtp-Source: ABdhPJx36t2lq6XUgRP8aZsWzniDSVT/3mB//NzrYGT15Oui9iLyTfcNDeSJpxItpJS9c+QQGTVe7lk7FYYZTxe6p7Y=
X-Received: by 2002:a9f:3e0d:: with SMTP id o13mr10445027uai.25.1589788041123;
 Mon, 18 May 2020 00:47:21 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 18 May 2020 16:46:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQXSpg4s0e0d-tp9j85Sj01t13zAa5+rqsOWu4ZvkpYhg@mail.gmail.com>
Message-ID: <CAK7LNAQXSpg4s0e0d-tp9j85Sj01t13zAa5+rqsOWu4ZvkpYhg@mail.gmail.com>
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v5.8
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


Here are UniPhier DT (32bit) updates for the v5.8 merge window.

(I intentionally based this on -rc4
because I needed a dt-binding fix from DMA engine tree
to avoid 'make ARCH=arm dtbs_check' regression.
I hope this is OK.)


Please pull!





The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v5.8

for you to fetch changes up to 137a1cecb89a024f8c92d71e07e73b14fc4d4161:

  ARM: dts: uniphier: add #address-cells and #size-cells to SPI nodes
(2020-05-04 10:07:22 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v5.8

- add DMA controller nodes

----------------------------------------------------------------
Kunihiko Hayashi (2):
      ARM: dts: uniphier: Add XDMAC node
      ARM: dts: uniphier: Add ethernet aliases

Masahiro Yamada (1):
      ARM: dts: uniphier: add #address-cells and #size-cells to SPI nodes

 arch/arm/boot/dts/uniphier-ld4.dtsi        |  2 ++
 arch/arm/boot/dts/uniphier-ld6b-ref.dts    |  1 +
 arch/arm/boot/dts/uniphier-pro4-ace.dts    |  1 +
 arch/arm/boot/dts/uniphier-pro4-ref.dts    |  1 +
 arch/arm/boot/dts/uniphier-pro4-sanji.dts  |  1 +
 arch/arm/boot/dts/uniphier-pro4.dtsi       | 10 ++++++++++
 arch/arm/boot/dts/uniphier-pro5.dtsi       | 12 ++++++++++++
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts |  1 +
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts  |  1 +
 arch/arm/boot/dts/uniphier-pxs2.dtsi       | 12 ++++++++++++
 arch/arm/boot/dts/uniphier-sld8.dtsi       |  2 ++
 11 files changed, 44 insertions(+)
