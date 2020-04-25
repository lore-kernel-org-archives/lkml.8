Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6405C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 871C121D7A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587843020;
	bh=rODkJh5UPvqmeotELAIc5Qark6Uc1NKGm2jnvlhXgI8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=l8Sw2FrktdUEZUNtAd04G3kGCkgoED8HeAJchg91ufEuhDtLUIK06+cXtcN7pSWu9
	 LW52awTWyT8No98ayIPJSI+Bl7tWWBoPKsZXvCmuqzp+PwrPC4R4hY7wYCmPWY7qnZ
	 BF2I6tIERZg9aluPgGSk2/oWRs4o/lvHfkiORdxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgDYTaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 15:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgDYTaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:30:17 -0400
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587843017;
        bh=rODkJh5UPvqmeotELAIc5Qark6Uc1NKGm2jnvlhXgI8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ioehEAf20ScaMe2lMhFODfM5vwT/YI/966feVmYrtC+8lXfJTAy46jzxnhVQazv+C
         U6mPkkx4Jo4W5e7D66umgDrv5+K7iJhL3sOX/KtnB9qvPjgNmd4O2LyyVGrE7+Hkdz
         SEJwXUIuwHe+viiszLna5QIAFmNqejvlhWHVTlQM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200425091918.GA21990@gmail.com>
References: <20200425091918.GA21990@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200425091918.GA21990@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-2020-04-25
X-PR-Tracked-Commit-Id: f3bed55e850926614b9898fe982f66d2541a36a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e18588005d79853c2d4101f9416e7c1e8c9584d2
Message-Id: <158784301697.5802.14475436758901577111.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Apr 2020 19:30:16 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Apr 2020 11:19:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-04-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e18588005d79853c2d4101f9416e7c1e8c9584d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
