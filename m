Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A56C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C96D2065D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593381925;
	bh=Fnc9QOsASMf5/SbTLhYqgQ7Pg4bsdcxa7sFpscgc3o4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Hq/o9mplBuBTGMGQq957MvrXV7vmz5RbpXxjWP+ReI5q8ivMkcFr2GdQx/zO9zQQC
	 JSp6vCivjYbcVUH8egGVlIzaSZK7txnQym4ZtflgF5nM56X2kUbAhClUWCeLB5Jvq/
	 mOZJdOfdghROv6wmpniUG/CBAv1tB09eTbRZrH6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgF1WFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 18:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbgF1WFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 18:05:16 -0400
Subject: Re: [GIT PULL 2/2] ARM: OMAP fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593381916;
        bh=Fnc9QOsASMf5/SbTLhYqgQ7Pg4bsdcxa7sFpscgc3o4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RXOxG6AGk1NM9DHi5wOl5XFdKUBF2eAun0qn7RUcJhimDs30G5YNzc5VEUXEpynqy
         HJXCrEYPq1mN+YsRbzCsz2vdT0nqPWCcuWhSPgTUADm1JaWbbXPDoPNd9ZAQ8jQmDo
         EjHGc4vRxNu1zWzSgFOT0aMcuFGcv4npyatRQf88=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1v63iuCqs66kik7UiojjCDAr157MsU9_4+2iP-ZCiUvw@mail.gmail.com>
References: <CAK8P3a1rUGkoHanEGfc+o8bjgZO=T-40-e-wy+ECLxuU_pT97A@mail.gmail.com>
 <CAK8P3a1pbjKE7EX5+UYZbzWMAZ9kjftodURZ+vgrCQ3Cn2vj+A@mail.gmail.com>
 <CAK8P3a1v63iuCqs66kik7UiojjCDAr157MsU9_4+2iP-ZCiUvw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1v63iuCqs66kik7UiojjCDAr157MsU9_4+2iP-ZCiUvw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
 tags/arm-omap-fixes-5.8-1
X-PR-Tracked-Commit-Id: d528945d7762be94beca4c111bb95dcc9a9f39c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7db192b2d71ea42627a32349d59a5f99f2aafcc
Message-Id: <159338191611.4690.8999204724559676442.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jun 2020 22:05:16 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Jun 2020 22:01:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-omap-fixes-5.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7db192b2d71ea42627a32349d59a5f99f2aafcc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
