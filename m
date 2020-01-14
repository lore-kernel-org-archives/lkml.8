Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A64C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF5B2187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgANQXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:23:07 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:40453 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANQXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:23:07 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MadGG-1jOni72MkU-00cAgg for <linux-kernel@vger.kernel.org>; Tue, 14 Jan
 2020 17:23:05 +0100
Received: by mail-qt1-f177.google.com with SMTP id e25so1616729qtr.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 08:23:05 -0800 (PST)
X-Gm-Message-State: APjAAAWYdj7e+xNIesLXUX4z+qvmTdLeJM+LP16d3X/kogzK/Wnwe98U
        TcnBSInHoRCwRX1vgYG1HJnYJy53xuyb0VWK0sk=
X-Google-Smtp-Source: APXvYqyQRl+RS+4lYhvE1+899F0TLsfD48pCLsOVltbaCq1aMotPe+CAUHfgKfZ14B7Ib3sDZnxXOK6/4sE99hB3IPY=
X-Received: by 2002:ac8:709a:: with SMTP id y26mr4384832qto.304.1579018984475;
 Tue, 14 Jan 2020 08:23:04 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Jan 2020 17:22:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3wHmr3hgb5H69V68ZA3KCDSFeOekAKmR80MWxgQ7JK=w@mail.gmail.com>
Message-ID: <CAK8P3a3wHmr3hgb5H69V68ZA3KCDSFeOekAKmR80MWxgQ7JK=w@mail.gmail.com>
Subject: asm-generic: fixes for v5.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CnUs0kVGHiAhk0kV3rWyYaSMio9KcVG43K+nMgnM/MoZEVMl9Qg
 H2BmezWgWLKYreseuCTjv2jBV0YE84NVhoGT6YQoHQxTN6vZB1mLXQglivlT9Izb/gZZ1R0
 b9kjxIOmGHFD3FUHhehYzDQdzZ5dthxAxs67dNklHD1+D/s4E1JlK80wAnTQArxaa9ucVZS
 04W4nhEOnCYtMC6uWHNfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+AaxaToq39s=:1uJTeA3AR8guXpZMY293Or
 250YoYabYahaFo5xKCRfbqqHAoZ+rFRm7FBNNP7tHZq59CZlgRUVHyvYFcgnNz5FPvZgc6sXZ
 i/5Bbb+XVhR76IcB7jCvphYJSLr92V8WPFfWydpXzrOGOrzBXwzjSBANPi0WdcoPavzXKoil8
 Vm5dL2FbEWgFbNJ2pZGHM0HxpYClepmqzVMMQ5hDVmaxHc74SUJWsrXKUfBGNTuPB8jMltiKG
 1k0YfEMUb9UccCEnvSltGClmzpDjxLFG0uUf9hbCRuHCEG0CwWrKQWc0bAfMPgsRdSApiRnOE
 Q6m4qizUcTtEzvUhsULQUTWX8aECKlJeRYmBoQHOwRe9iOoL0B5eAPLnXNDRUCWy/vgn3oYEQ
 O/rsNwLqa+sPqPyZbnknWELtQFBtphRwwujGoByeW35q4ZfGHABm1dPHxgcml/TaEoE2S4OXS
 WiQpvOQAVMIKpSOkmx6iWXjOHFoyPp0z28i/p3SmspKoBtLKr9HhYhomTbmYHdORDdO4a4P6h
 IAB1iI8uWj0oda2NMGFM36EGC7XOB1Vs3zNaAOAj8HJU6onCob0+sgmzdExZfrbbNRKp5u2nF
 +JJUJp8oW6N+tHQ7b6ny+RVJO4WkO2vzQ3jViCs3sVv5sMPCCvURjoCjLQE9fyaeT5p1jSzj9
 EBDHwfupUEky3H3hdgF2sEl0Re5PMvtaeULsho6va0oX2moPa6w1fpcFnEfaibgAMY7KEBlNW
 qEFqzqwHDw6DHxMXGP7kEd5277OBmmOdWvFLpQh3dRZLQGA9XDp4PibpqefHKXBpT/TPTcQmM
 nrzqZxD0vwxduuDvPL43cMTrqr5ENMbwjDy4Rq85oiEaquMsoZUMzo+wnh6/voGvGTaK+EPHL
 uAIA/BQzG8/Y6hoRf3Jw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
tags/asm-generic-5.5

for you to fetch changes up to 060dc911501f6ee222569304f50962172a52b1d6:

  nds32: fix build failure caused by page table folding updates
(2019-12-30 11:19:05 +0100)

----------------------------------------------------------------
asm-generic: fixes for v5.5

Here are two bugfixes from Mike Rapoport, both fixing
compile-time errors on the nds32 architecture that
were recently introduced.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Mike Rapoport (2):
      asm-generic/nds32: don't redefine cacheflush primitives
      nds32: fix build failure caused by page table folding updates

 arch/nds32/include/asm/cacheflush.h | 11 +++++++----
 arch/nds32/include/asm/pgtable.h    |  2 +-
 include/asm-generic/cacheflush.h    | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 40 insertions(+), 6 deletions(-)
