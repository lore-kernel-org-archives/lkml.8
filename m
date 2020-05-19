Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1D5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE80320872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589928304;
	bh=1rEwKeAHu0x2w87U6rsILzo3vjbxhpKzOkOF66tLHwc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oEE0Pe00HA5GU9IUh+MjYQbn9R+sB1iupPrPxVkMjashjMVI2GCw+XZYKe3guGTLh
	 qrbwczka8HaaXe3SsZlI9CqHC4llHhsVwvEBNLtgtIvzYYT+p3jrA0TvXJ2YcoEB6R
	 8b0GFYvewtInYpLLpVR3qnA5rc2zjR9dN1s2E7OQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgESWpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgESWpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:45:03 -0400
Subject: Re: [GIT PULL] ARC fixes for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589928303;
        bh=1rEwKeAHu0x2w87U6rsILzo3vjbxhpKzOkOF66tLHwc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b+SDd8jiKlAflj0dwyI5hGmba9jxbcvLTba58hPz4JEmCrUZi4SpnrWi1n+0fLewg
         RduzXAPqloq51MHXJXTBOvKEKpHjFjkTNsj9hMeT1blTJXsYFtD01BjDEvc7vPhe+H
         Jgj2Gm64JoXjgfIvC7ZMb/yC28GbSQf4LZ8Vkcz4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <249e6795-1eef-60b8-807c-e2385a62818a@synopsys.com>
References: <249e6795-1eef-60b8-807c-e2385a62818a@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <249e6795-1eef-60b8-807c-e2385a62818a@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.7-rc7
X-PR-Tracked-Commit-Id: 7915502377c54c9f58f6ac537bde0c2c342a6742
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c9e66568ad40dc17518fa00e2b28c3b450040d4
Message-Id: <158992830327.1177.8316319357981803847.pr-tracker-bot@kernel.org>
Date:   Tue, 19 May 2020 22:45:03 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 19 May 2020 21:36:13 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c9e66568ad40dc17518fa00e2b28c3b450040d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
