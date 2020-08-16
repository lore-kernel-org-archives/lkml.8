Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DA5C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 01:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC6D20708
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 01:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597542941;
	bh=DALgTvNHCnR4QjfiE6cXHvSJBf0Wi0v85qzzFQVcaaY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YtNN07hh/FeN+pWKbxs3L7+69kvWS5WOWODZ3e7GeEJnqZLwbLqS0X19aGg6ACon/
	 Pwd3kGM4fOmgtO2DXBlf54R13pGjqzCeHE2SFdVArgIyh97reshNzNJTOwWQdCx/JW
	 S5ADH08nsIu1lvgrizDWgiMmxKajQJRXJlWYkCkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgHPBzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 21:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729746AbgHPBzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 21:55:37 -0400
Subject: Re: [GIT PULL] locking fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597542937;
        bh=DALgTvNHCnR4QjfiE6cXHvSJBf0Wi0v85qzzFQVcaaY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KK2zts01xZ3sIT0ya+TnXBXmXQbil5XOzPJqP3g66kod+G/oW1w7eLqTodwzdx6BF
         Akx0PXQdzIy9UBwIMm1p30j1PMHkHZfy+STQPPbWVhDUS+D/Y6irguA8wQqlHEnamE
         U327DvK/BhpNyEdgntFKcGT4KleF9TiUC3R3RyoY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200815111323.GA2461929@gmail.com>
References: <20200815111323.GA2461929@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200815111323.GA2461929@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-08-15
X-PR-Tracked-Commit-Id: 405fa8ac89e7aaa87282df659e525992f2639e76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb1319af4119c4936e02c879295e9fd4d50bbe3a
Message-Id: <159754293709.18953.7269294319955303462.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Aug 2020 01:55:37 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Aug 2020 13:13:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-08-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb1319af4119c4936e02c879295e9fd4d50bbe3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
