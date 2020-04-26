Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78723C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C28A2070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587924920;
	bh=+70Nkhy1Sm1u0LTpVo+LhJHx0taDHWiTc7WBnW9U+7k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VeGAfkUc7z/Y65jEOlgiw6kXN/R3lCJZqMrREs5DQ2LoGW0nPd/+074i1sYuA5L9q
	 cLGSIAfnBTk4S/v0cwQ0+3fbh+hLsGSNs5HfpqcYPdSV9FHiQGBz94GLmFdbFgjE9e
	 XfOwo0b7C17Sfkc/hsbxssQRHk4M+5DDJ1MtXJec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgDZSPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgDZSPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:15:18 -0400
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587924917;
        bh=+70Nkhy1Sm1u0LTpVo+LhJHx0taDHWiTc7WBnW9U+7k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nl42cEOElev+Nqe/qbznp9eB/QSIY7vjcWskzbTScJCKEME1lK1ck7Zda0HS/bUZE
         V5jhpEGVOr9xU0zviSK7R+9vkq3GoDljk5JLjuuaIXP2cnjv7aP6RqsToS2w3hZYp2
         AAHDqOSNgaNDWX5FKGzRWtd5OVZX1po0WI1m2iig=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200426104730.GA2120674@kroah.com>
References: <20200426104730.GA2120674@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200426104730.GA2120674@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 staging-5.7-rc3
X-PR-Tracked-Commit-Id: 664ba5180234593b4b8517530e8198bf2f7359e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: edf17b283844a21b338b9618107c8817105d0ffa
Message-Id: <158792491776.6795.10238582975247910789.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Apr 2020 18:15:17 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Apr 2020 12:47:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git staging-5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/edf17b283844a21b338b9618107c8817105d0ffa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
