Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6331C10DAA
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98AD52080A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599419672;
	bh=fZ96Nj90bU7q6aPJ+yotE6SgBpH/H2er5MoTHk9I7Ps=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=POQKHLrpzmU6P7oPtl9Pd/5b5Rjk1af+lbmtFd17plwYs4eRsiml0x+k4Bd3tPw08
	 yEut52756tq3h91f3ZJVaGbB38a33PWzMM3BD81W/lp1ARKOrLaK5McXzAtS5TrFdo
	 Pohj+3K4D870ok7bZJG5t0o6z97LmxDl7kQ+lDi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgIFTOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgIFTO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:14:29 -0400
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599419669;
        bh=fZ96Nj90bU7q6aPJ+yotE6SgBpH/H2er5MoTHk9I7Ps=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rbFd71bAHPUwFZxQdRIZ7B8GWsi9Cp/b9ZjMqQS29LGA+UiWJ8DkBvXNYsUb8oYXE
         BEreQ8u0H0wdA4WpZOpQizcwmVedoDzY7hnf172mwX7Ph4OGOz0xjubYqd8leCkrQa
         RUF7Dn52Uj8WL16JX9pgFwnjMFzrOcMFhMZiH6U4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200906081515.GA3034383@gmail.com>
References: <20200906081515.GA3034383@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200906081515.GA3034383@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-09-06
X-PR-Tracked-Commit-Id: 4facb95b7adaf77e2da73aafb9ba60996fe42a12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 015b3155c46a089f623c8a2e794ffad84143565d
Message-Id: <159941966917.19439.13821401849691747100.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Sep 2020 19:14:29 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Sep 2020 10:15:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-09-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/015b3155c46a089f623c8a2e794ffad84143565d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
