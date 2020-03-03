Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BD3C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B70020870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583278512;
	bh=dsuRqt+4YuOPwB7PVVT4J2705PVIer6fHcveLezNevA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=l98MOR3iKxC15ZpMvJoufKZvrttDjwHKzqdr3Bz3OmcbpikCQvEF9eXqNtdIveoS/
	 tQtuiVco/aJF+w3RFTj/3Nxb4Ffq+ZP4sFxyPvnKkovp/7rbf8An80blpTi4gwGMKu
	 FH3r8LqyHjE1hwoMyfQnfJkaYR7WVEUfw+tOr9DQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgCCXfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbgCCXfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:35:05 -0500
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583278505;
        bh=dsuRqt+4YuOPwB7PVVT4J2705PVIer6fHcveLezNevA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2iLrRaJS1EEjXHfuTGUt+OrRUDQuGe3SwkpsDJDuvr4PTs9tyVhrz0YJkQAEnlPua
         LCPaw9KUumKELYgK74vZvS90k0NAeRpYIvz6yrpsDmGE6pombQNWX/Xz3baYjAewxY
         BPQH/NWP81Hb+3obXw3YxJVWssd/NZ1723QCD5G4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200302072314.GA89045@gmail.com>
References: <20200302072314.GA89045@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200302072314.GA89045@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 7977fed974d60a72733243cf54d7955cd6dccd91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 852fb4a72822b6c03bcf6cf1d51fb05b319d301e
Message-Id: <158327850535.6555.2884245638321090407.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Mar 2020 23:35:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 2 Mar 2020 08:23:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/852fb4a72822b6c03bcf6cf1d51fb05b319d301e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
