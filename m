Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681DCC33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4125120679
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580581820;
	bh=oY4JjYsBkM4oaf5Qo8IqnuwCWWbNz5S4SGHZr8L0TRo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ME+wkRwUyv0lOCNz1fNESChaAHCMO8gXwIw6y7qpa3TlmSinG55DQtKDYEW/jjwF7
	 3FDZ0hIHTIIdSIsSDPoZ+cSYdCtUDBAPEzbWZmHyGYhg4ZpvDpE9f4igKo/khOyQPt
	 CXGAKFxaEAlceSPMbwT2stUoYFgD030QsgT/2rR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgBASaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:30:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgBASaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:30:16 -0500
Subject: Re: [GIT PULL 1/2] Kbuild updates for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580581816;
        bh=oY4JjYsBkM4oaf5Qo8IqnuwCWWbNz5S4SGHZr8L0TRo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Yq+E+5CnAxo36Zjp4eu1DYWFdvxZGmTe4m/olwhSO8LoqQyA12NjG3UJFJVN0fdxh
         dnnptu6Hs4WGmmKmmWKwdMTgpg5Yo5HgYpYpCWRG817Y6XV1Rev9DrFAV+vNq/2ufg
         uJdSj3fPJFMWG9TBVmjjFUps7UzUxYaBIaTnmngY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAS625YwKpv4wfKO78+Rexe2fP5pLDbMD4r71wwiQfN0Ng@mail.gmail.com>
References: <CAK7LNAS625YwKpv4wfKO78+Rexe2fP5pLDbMD4r71wwiQfN0Ng@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAS625YwKpv4wfKO78+Rexe2fP5pLDbMD4r71wwiQfN0Ng@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-v5.6
X-PR-Tracked-Commit-Id: 451dff37f0752cc8ad6f1bb82081a98d7b760310
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 368d060bb497775e42e323b9f676c45e2011da27
Message-Id: <158058181620.4504.1255517678258543821.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Feb 2020 18:30:16 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Feb 2020 13:05:32 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/368d060bb497775e42e323b9f676c45e2011da27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
