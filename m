Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECABC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97080206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596502219;
	bh=ZoO+g1N5XnwHONmOlAEhwVqJiVL6xf+o9n+Go/VFt/s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Qf4rhKzoUooLta0FH6rqtwWgXSjKSUpGCoEnlKGfMg98kCAmVqxze65CRNvvROsFP
	 3JyUVJXU/jslFpe/3EAOraz7XG4kWLgIFftZ71vK0ctneIOyfcgt0lL4tLAhw8X4yz
	 H2svJsDxDfQyR6ebZyQJYvLk7LGL+KZp4ZsKYVdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgHDAuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:50:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgHDAuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:50:10 -0400
Subject: Re: [GIT PULL] x86/timers change for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596502210;
        bh=ZoO+g1N5XnwHONmOlAEhwVqJiVL6xf+o9n+Go/VFt/s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FiaZc0zAi7xJZPlqBBUKTrD+ksXjWJLi78mj4hgag03s+ZvVQjyM3Algn5531zk4W
         mp9gpJoswPtpNVGa3mIpDWEKg9klMEFi+Z3EacZsbQ11sTBDwEZGTHh/z32pBX9qTG
         uVEWZlVQy4p7gwfzM4T9/c+OyvRwIHMuox7G/HfY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803193539.GA1411343@gmail.com>
References: <20200803193539.GA1411343@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803193539.GA1411343@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-timers-2020-08-03
X-PR-Tracked-Commit-Id: 898ec52d2ba05915aaedcdb21bff2e944c883cb8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a92ad11fb209c8de0d358b78415fda5f01308202
Message-Id: <159650221007.17631.10487364717462990613.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 00:50:10 +0000
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

The pull request you sent on Mon, 3 Aug 2020 21:35:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a92ad11fb209c8de0d358b78415fda5f01308202

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
