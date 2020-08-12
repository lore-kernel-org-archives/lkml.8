Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490F8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD042087C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597262323;
	bh=oSerybZiCZ2r7fIDLGtD9iA1v05FrR2CY1upkTXAff8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ahblcVtT1/4hMLKeTvd7UF2Xjiy900lqwTt1WG3aPmxZ+IB5+SSLVKuo1aCPzpsHS
	 IZM9ZZsOeqkas811K6mgSoOepJFLv5tE1bqb0dKBHCQhB0g5kOa2e2v6SgodjYRi99
	 LvBO43wyH7VaYcv97oidONRvYI+1RyTPlnwPCx4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgHLT6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbgHLT6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:58:33 -0400
Subject: Re: [GIT PULL] parisc architecture updates for kernel v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597262312;
        bh=oSerybZiCZ2r7fIDLGtD9iA1v05FrR2CY1upkTXAff8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0CN0pycNUWPtu2IlqvDygxEP8RQmxQiE95d5B+12XaGHRqbP684RF8L0orcwFsCTH
         2OBVnssRdEGov27bMHtbruXqA162KPpyVYBUwr3O7TmiPGt1/7bD0rM1NDuk2dnASK
         igB3pPE6fOqckMY9xowT/yvjVqWBsPQXlItQmgUY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200812135750.GA17014@ls3530.fritz.box>
References: <20200812135750.GA17014@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200812135750.GA17014@ls3530.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.9-2
X-PR-Tracked-Commit-Id: e96ebd589debd9a6a793608c4ec7019c38785dea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a02c8d45bbf65cf432292c2032147fa7529de58
Message-Id: <159726231293.30367.12649145892221134071.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Aug 2020 19:58:32 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Aug 2020 15:57:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a02c8d45bbf65cf432292c2032147fa7529de58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
