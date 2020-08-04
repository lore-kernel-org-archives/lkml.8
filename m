Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C85BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 867A920781
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596502214;
	bh=JyQTmbN6Rp+Od5a618N8c5dIhgRoU4HxDvZgyfd3xJ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=u1+6Ff8+ewETTVVqacPV02RlOTOmol9PNu6R+LnbRF8T7k7UOQ0CcRLSD6Qd1ryok
	 IrJE6gHzzBRXgBPdvjf49i/0HnVE1Jzyz6W1IyqQi/k1iZa+zrrEal9Mf/RJflLFSC
	 YKo9y56fDsXphjwaNiGygrL62FPhFyh3hBy0CIhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgHDAuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729312AbgHDAuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:50:10 -0400
Subject: Re: [GIT PULL] x86/platform changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596502209;
        bh=JyQTmbN6Rp+Od5a618N8c5dIhgRoU4HxDvZgyfd3xJ8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UbUOJHrRcwcxyP96or6+LfkG2IiGg9NKGS/MHqM1FswSrIrvVeIwa93jCzGiwjFb5
         XLoZ17pZzf+FnWmEACem+qIpy4aFdXBrDud330Vi6nH/8tds8HO/kxC3q9P1TsAH1O
         BwyOkEk9XypPJCQHTJNw4sgBzqC/Lu8KGmRcw32Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803191352.GA1352094@gmail.com>
References: <20200803191352.GA1352094@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803191352.GA1352094@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-platform-2020-08-03
X-PR-Tracked-Commit-Id: 3bcf25a40b018e632d70bb866d75746748953fbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5183a617ecbf01805c4abb33c3165a276eec7234
Message-Id: <159650220968.17631.13976387509419944989.pr-tracker-bot@kernel.org>
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

The pull request you sent on Mon, 3 Aug 2020 21:13:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5183a617ecbf01805c4abb33c3165a276eec7234

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
