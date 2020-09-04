Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443D6C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1651B21481
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599252573;
	bh=Dbe+ZU7NeU/LYWkuVfmdnBJ892z1QCYezrf2zSz/xc4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KHWlehM8Kgg9GVyaItUwv9m0pHydTdqG2IiIs2G3K+X9Rc8jzn4ZeFtrYqyVrDh9Y
	 KGQ5jV+L5lcR7NyChl64j4T6WSiszR1iZ+G8K1dXImrKzAQwICt4g+cV+jd3/kbqUJ
	 IiXVwDZappEmnAKITv57i9bVEizI8SMIe8Di1kDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgIDUtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbgIDUtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:49:11 -0400
Subject: Re: [GIT PULL] Kbuild fixes for v5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599252550;
        bh=Dbe+ZU7NeU/LYWkuVfmdnBJ892z1QCYezrf2zSz/xc4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JCP9pS1/1Pj5XfNJs2EHHGsHqwvWtCrDw2ZHVy3qTgYjaKadwQLwaOYJYV0WdCOSa
         Z3cwt+/SkvDTBnwjEUpMdjk+dS0KEaKFV30MY+wDdIHEAUVbOY+AZNK3rc2CO8uQPc
         uyM0VHKOySthRoUOSNcIjwXNw3pi3VtTAD9Ltg+k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNARx_s1pyrU=PKSWLr6nX7=+=U78OjXVNdX7B2-bXzpX6Q@mail.gmail.com>
References: <CAK7LNARx_s1pyrU=PKSWLr6nX7=+=U78OjXVNdX7B2-bXzpX6Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNARx_s1pyrU=PKSWLr6nX7=+=U78OjXVNdX7B2-bXzpX6Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.9-2
X-PR-Tracked-Commit-Id: 163e0c27fead96fd6804fa59a55fc4f841d38db8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41bef91c8aa351255cd19e7e72608ee86f7f4bab
Message-Id: <159925255074.25529.6568571537959073713.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Sep 2020 20:49:10 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Sep 2020 21:21:15 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41bef91c8aa351255cd19e7e72608ee86f7f4bab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
