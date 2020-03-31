Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911E5C2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC07216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585682119;
	bh=AsAUOMZP8BUzeE22gpr9n2oCenopMl0RIw6JZ5JgUs8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Y/8wj/oxytXKX7V0AZU4KmtyoPf2hLvjV2lKAoMkl+RJh6L97VkihMkpSv4V5+F9b
	 Hy8j/+FxaEOiI0OwfbminEKEA+cU48fIigZoGN0uZJnKTPoyN5U09JAUUE64wAjE+G
	 T5JJl1dRV/i3bQErhkZhk7t5ysOO8NRWbRNvEbes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgCaTPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731390AbgCaTPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:15:16 -0400
Subject: Re: [GIT PULL] x86/mm changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585682116;
        bh=AsAUOMZP8BUzeE22gpr9n2oCenopMl0RIw6JZ5JgUs8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UlBttHeG+wC/fLkp5sBuiVc9a8xTww4KbPfnOn+AkgkS5nS92R62WaHbQHwiHijNR
         rlHYX2n3DoWUCjUfBcSYH6eXuIq72vaU6xQ1BsSwjoDgkicargzwuLQ5tYdnAgmGgY
         NncQqcKm2kRW1u1Jyy7yEzRNqZKBtSSLfp6lDLPs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331090336.GA5237@gmail.com>
References: <20200331090336.GA5237@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331090336.GA5237@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus
X-PR-Tracked-Commit-Id: aa61ee7b9ee3cb84c0d3a842b0d17937bf024c46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9d76778927dc953c553b83ab52287dfbd15ac6a
Message-Id: <158568211636.28667.1423360776900149279.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 19:15:16 +0000
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

The pull request you sent on Tue, 31 Mar 2020 11:03:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9d76778927dc953c553b83ab52287dfbd15ac6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
