Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F99C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5718D2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584631388;
	bh=SlljuaGs1KMSs3ky6qTJukGaUJLwqiTtskKLHAtiojY=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=s01WgRSBdgfvxaqq8cHaZ5UQNxS5Ws7eHLkvOqz80TfVayQqkQqv1luVvITxqs6p5
	 Xu8BX2X3zoEQWdBkO4CaFGXi/Ixgxuo/wg/TFTpmwPWtUvyfnAckCTOpyUNLl/2Fdg
	 fu95mn1kqc3nT7huaJNIoZc4w5UuRIigWJsfNeFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgCSPXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:23:07 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:62303 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgCSPXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:23:06 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 02JFMkBx018431;
        Fri, 20 Mar 2020 00:22:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 02JFMkBx018431
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584631367;
        bh=Tu2djgmKkAF8RYObtpeLT7Ttw9jLZvbbIJmApmRreD0=;
        h=From:Date:Subject:To:Cc:From;
        b=LRCjykCyVBAJvUCb6ajcQ+J4yAo1Luz0uuAUATklkclcu0fG7IP/A432OiBzK4naU
         21fS22cQTvtl6HGxUeCi+6u63BJqWNDXXKtcCKEi+P5Qrrn1jaC8ry64GKY0b+iPpH
         5900rfcdbp1v5OLZPSuOEot6K/GlYT/MtVYPf1e0HkY3WumWWMFvNlnJY79vVNs8YJ
         P65gOQ6dOshgpyFhL9X0czw1EXEd1Kk3UNrvEVtAnQRvnI8CmgIaNKdJy/Tzo9SAHP
         xlfNARNquflYbDt9yynKHGuPaymGKIJOs9y72MN9hxMzxnvrjnLfei+IaHLlBixHFl
         lRqtdSlplJEnw==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id r47so897672uad.11;
        Thu, 19 Mar 2020 08:22:47 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2U8IS2cjA4ImJpDDHitPRAWGNFxpGfOfCUXOxf9SoX9XNwMmIi
        TS+SzouFWtT4jxRJMzGctmYpt1XmxNc0RqvLWjA=
X-Google-Smtp-Source: ADFU+vuhm04AxBGx6dccv3oM51vQOCjxZbw1TUdNd2347ssYWgwR6Gk9KJUrX3UXpvAgfP2p1oTj13v3diMBQgPrRJI=
X-Received: by 2002:ab0:28d8:: with SMTP id g24mr2169125uaq.121.1584631365859;
 Thu, 19 Mar 2020 08:22:45 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 20 Mar 2020 00:22:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNASTxvF9AbddpkgABM2fAmvCP_bwCCrS9gmeDN0w-ZjfwA@mail.gmail.com>
Message-ID: <CAK7LNASTxvF9AbddpkgABM2fAmvCP_bwCCrS9gmeDN0w-ZjfwA@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v5.6-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull more Kbuild fixes.
Thanks.



The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b=
:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v5.6-3

for you to fetch changes up to 7883a14339299773b2ce08dcfd97c63c199a9289:

  scripts/kallsyms: fix wrong kallsyms_relative_base (2020-03-19 23:40:20 +=
0900)

----------------------------------------------------------------
Kbuild fixes for v5.6 (3rd)

 - fix __uint128_t capability test in Kconfig when GCC that defaults
   to 32-bit is used to build the 64-bit kernel

 - suppress new noisy Clang warnings -Wpointer-to-enum-cast

 - move the namespace field in Module.symvers for the backward
   compatibility reason for the depmod tool

 - use available compression for initramdisk when INTRAMFS_SOURCE
   is defined, which was the original behavior

 - fix modpost to handle correct large section numbers when it refers
   to modversion CRCs and module namespaces

 - fix comments and documents

----------------------------------------------------------------
Eugeniy Paltsev (1):
      initramfs: restore default compression behavior

Jessica Yu (1):
      modpost: move the namespace field in Module.symvers last

Masahiro Yamada (3):
      kconfig: introduce m32-flag and m64-flag
      int128: fix __uint128_t compiler test in Kconfig
      kbuild: doc: fix references to other documents

Mikhail Petrov (1):
      scripts/kallsyms: fix wrong kallsyms_relative_base

Nathan Chancellor (1):
      kbuild: Disable -Wpointer-to-enum-cast

SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) (1):
      kbuild: Fix inconsistent comment

Xiao Yang (1):
      modpost: Get proper section index by get_secindex() instead of st_shn=
dx

 Documentation/kbuild/kbuild.rst                 |  2 +-
 Documentation/kbuild/kconfig-macro-language.rst |  2 +-
 Documentation/kbuild/makefiles.rst              |  6 +++---
 Documentation/kbuild/modules.rst                |  4 ++--
 Makefile                                        |  2 +-
 init/Kconfig                                    |  3 +--
 scripts/Kconfig.include                         |  7 ++++++
 scripts/Makefile.extrawarn                      |  1 +
 scripts/export_report.pl                        |  2 +-
 scripts/kallsyms.c                              |  8 +++----
 scripts/mod/modpost.c                           | 27 ++++++++++++---------=
---
 usr/Kconfig                                     | 22 +++++++++----------
 12 files changed, 47 insertions(+), 39 deletions(-)


--=20
Best Regards
Masahiro Yamada
