Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF39C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 19:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC06B2053B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 19:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591470924;
	bh=+/Y+/CAmaEAKQsXCL+gpBjtEiIaF136fQjCXymxECNU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZkIv4BUdiX8PTi6NLfdXctqRUPVmeqCm/Lukzf6yu6ydSRDW+NNSCOuKqbQp1GTes
	 fQEhTcwW3/dEB8vySL7xBXQRI6FOGM/dFJyz4eYUhEGpCT2rgEOZdhEpXezSmvjP1r
	 9m/j3lOMOWaVuvdyyLCqGZbx5i2WQH+mG7qYW8Eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgFFTPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 15:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbgFFTPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 15:15:16 -0400
Subject: Re: [GIT PULL 1/2] Kbuild updates for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591470916;
        bh=+/Y+/CAmaEAKQsXCL+gpBjtEiIaF136fQjCXymxECNU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lmCjsEqKKq5haTutFfGmdxrGstZlMDLwmTe07TngVDmYpEU5b+2kFBh2DYUtriU8K
         ggo/miXALGmu6tCrZgf/Ol6flUwGV6bpVv3q1WxoQ5YtyKdSI4IyW89psu5qXZOomp
         Ct1qmuB6N6wuD6+6KDn2fcP+r/l9g0a3rfhyEdhI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQde47uabtuAZXpCubw_bcjfh==+xnci-5_hOxgPUSO9g@mail.gmail.com>
References: <CAK7LNAQde47uabtuAZXpCubw_bcjfh==+xnci-5_hOxgPUSO9g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQde47uabtuAZXpCubw_bcjfh==+xnci-5_hOxgPUSO9g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-v5.8
X-PR-Tracked-Commit-Id: 8dfb61dcbaceb19a5ded5e9c9dcf8d05acc32294
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cff11abeca78aa782378401ca2800bd2194aa14e
Message-Id: <159147091646.3313.5226604419447206332.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jun 2020 19:15:16 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Jun 2020 00:18:22 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cff11abeca78aa782378401ca2800bd2194aa14e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
