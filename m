Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9000EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 698B72053B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592080830;
	bh=dy5jDfh3kbYOoo2r2+W/5k9zlP7VV+UPrGObMuPfJKQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DZ37NdAXIWpbeBs3IeQTKvoOgk4/4NSR45KqK3WMnfC/j0fE22dXv/QF3AQxof4QI
	 d9Ws8/7ss7av/NcjfU4Qm4RaUNMbSfNlHYhwk21cM+s/XMthJy/lc6UAczSRwrX/Dn
	 SIBjcbgLm7hJ0jp0CZ8KgdWWET067uBZ5D32gqXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgFMUk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 16:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbgFMUk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 16:40:27 -0400
Subject: Re: [GIT PULL] more Kbuild updates for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592080827;
        bh=dy5jDfh3kbYOoo2r2+W/5k9zlP7VV+UPrGObMuPfJKQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CuBdKAEiiv0BzJh9DNlcu/Wzgtg4sOXn8pN2QjSm4xdWfQPYwHRnE8pcUmfAUrlvX
         QuZaQgoHqWmo9+geFkNizg9rDMQjD8klaQEQVLT0UxEyHP4/bGMvnQOzqCj5NG5EX0
         wW5fDlc+kwmRyTlGe6xj45RxYVgLykvipN2mTDFs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATsQRp=kkB+THaO23XiHZsU1xJ-B42p8sMieBgJ4uftMg@mail.gmail.com>
References: <CAK7LNATsQRp=kkB+THaO23XiHZsU1xJ-B42p8sMieBgJ4uftMg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATsQRp=kkB+THaO23XiHZsU1xJ-B42p8sMieBgJ4uftMg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-v5.8-2
X-PR-Tracked-Commit-Id: a7f7f6248d9740d710fd6bd190293fe5e16410ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6adc19fd13f11883c44df67b551cf8201e6bba1d
Message-Id: <159208082715.14121.4435125737965037221.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jun 2020 20:40:27 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Jun 2020 02:55:21 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6adc19fd13f11883c44df67b551cf8201e6bba1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
