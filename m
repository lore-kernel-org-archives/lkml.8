Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74372C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD93206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596502225;
	bh=9gKUGeHAU6ee00n3FUl0aecRNdGJnPnFln1DrKY1aAE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hls1g68tXa7hadggwlH6TmkYy22r4Vntl471rYvaOo+zHYhRO+OHD/JHjdtKJh6RK
	 2hNmaX+TFORjwrvFbU6wvlDeykz9gU+ZumSKctYOC0Hs0FeYXsmuGvNpH0jUvGRlx/
	 zgsV8t5Og7MIRqN2GgkN74eGt3gck3IqMInqlpdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgHDAuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbgHDAuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:50:09 -0400
Subject: Re: [GIT PULL] x86/mm changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596502209;
        bh=9gKUGeHAU6ee00n3FUl0aecRNdGJnPnFln1DrKY1aAE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A2/pfrUe4pnwTwmO6hhejWsvI7yqSF7idBSLMYyizH3GUUCTNYgoHQtp1gCKff8Go
         rE6bb4/gHNzySdAOdg1fT0Z8EyZ7jGhYwK4RhAvPQLZHCJsy6rb+6P7WREV/ScJNhn
         E+GCHkjH2ZZGkFEVEekd5BZCy3EMtJOROueYitSI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803190354.GA1293087@gmail.com>
References: <20200803190354.GA1293087@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803190354.GA1293087@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2020-08-03
X-PR-Tracked-Commit-Id: 2b32ab031e82a109e2c5b0d30ce563db0fe286b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e96ec8cf9ca12a8d6b3b896a2eccd4b92a1893ab
Message-Id: <159650220930.17631.17810026785828907374.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 00:50:09 +0000
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

The pull request you sent on Mon, 3 Aug 2020 21:03:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e96ec8cf9ca12a8d6b3b896a2eccd4b92a1893ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
