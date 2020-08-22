Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5CCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 14:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E852078D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 14:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598104924;
	bh=RuuOuTFsBQxKDq+rAgJ/oGGcelgBwRH+cc12YY5IbkM=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=P1BKML7W5ipDbNwk4PSLlZdDIcKLS5vFRwpIbbpQSkQ4abaHc0y1txG28zcVhI/+q
	 pMr8sbXlMW5yDhk/+bwCJ0fJoCf5PdBcMoJI+cMrwqj7y/rkDpcqKQ1H8bbQKq4sVx
	 opSOFLrls1Nd7tASTHGOb9XWsQXF2jlvfkiAvMro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgHVOCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 10:02:00 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:17295 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgHVOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 10:01:51 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 07ME1ZUc017206;
        Sat, 22 Aug 2020 23:01:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 07ME1ZUc017206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598104896;
        bh=MjkieH40oii2YMzKu3SKODp3QDBS3K0rjAk0cDB5Zps=;
        h=From:Date:Subject:To:Cc:From;
        b=m4YXpdxHv5FCWkZBlVE2V/bI+YT4aJZRzj9uPL04CS8/uAiqF+LbgT1nSseLU5Vk0
         c8eBtE8sjAa2SZ/0boIi6aM+RzDJrP9LF811gZFpbbeaX9JzG6KOOJHuJKhgdQfwhQ
         JBksbv/vha3x5jLlQMhqTDnQTIwo1zIlSWAqYwJd8wQ6fY010tiVaSCG8yMHiyHGRX
         629FWTTXDpU5UV6i7eTgi+KuqsXNvHMWczYX4DgGXzSUKqr8H0rCeRPE+K57vYjFFV
         1XUtpOkuNMArDuDKexFy2/uUV1sU1us+7AOT9RkVIEkiNMp0Og9j3r8ygoa0JJY73J
         xuQDMd7tzd6sA==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id a127so2232660vsd.1;
        Sat, 22 Aug 2020 07:01:35 -0700 (PDT)
X-Gm-Message-State: AOAM532eCs+a/E92T70GDEZU6j+7sePeHc+Odq8t23fif/IAqpUzTQKf
        Y6grPLPzK5/oF61ym3yzedPgobnkOEfy9ofHM/w=
X-Google-Smtp-Source: ABdhPJwTDs8bYuPENZQB5UNqUoMUHEy0fXrC8V6VwN9Imrsde4mI+zHapfkCrzKWgmoD0Ar1yhhACBp+No6DOqLc5NA=
X-Received: by 2002:a67:7905:: with SMTP id u5mr4492670vsc.179.1598104894545;
 Sat, 22 Aug 2020 07:01:34 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 22 Aug 2020 23:00:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQO7kay52Dxku3sgyYk=4OGEB8m+gmN7wLemjc0f-pY-A@mail.gmail.com>
Message-ID: <CAK7LNAQO7kay52Dxku3sgyYk=4OGEB8m+gmN7wLemjc0f-pY-A@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v5.9-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull Kbuild fixes for v5.9-rc2

Thanks.



The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v5.9

for you to fetch changes up to 510bc3cb1ddc32f9533e6ed0a68c980544c3ca3f:

  kconfig: qconf: replace deprecated QString::sprintf() with
QTextStream (2020-08-21 10:23:38 +0900)

----------------------------------------------------------------
Kbuild fixes for v5.9

 - move -Wsign-compare warning from W=2 to W=3

 - fix the keyword _restrict to __restrict in genksyms

 - fix more bugs in qconf

----------------------------------------------------------------
Joe Perches (2):
      Makefile.extrawarn: Move sign-compare from W=2 to W=3
      genksyms: keywords: Use __restrict not _restrict

Masahiro Yamada (8):
      extract-cert: add static to local data
      kbuild: remove redundant patterns in filter/filter-out
      kconfig: qconf: fix signal connection to invalid slots
      kconfig: qconf: fix the popup menu in the ConfigInfoView window
      kconfig: qconf: remove unused colNr
      kconfig: qconf: remove qInfo() to get back Qt4 support
      kconfig: qconf: remove redundant help in the info view
      kconfig: qconf: replace deprecated QString::sprintf() with QTextStream

 Makefile                    |   5 +-
 scripts/Makefile.extrawarn  |   2 +-
 scripts/extract-cert.c      |   2 +-
 scripts/genksyms/keywords.c |   4 +-
 scripts/kconfig/qconf.cc    | 156 +++++++++++++++++++--------------------
 scripts/kconfig/qconf.h     |   6 +-
 6 files changed, 86 insertions(+), 89 deletions(-)


-- 
Best Regards
Masahiro Yamada
