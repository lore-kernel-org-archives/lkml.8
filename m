Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5579BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2122065D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593381918;
	bh=UsJJbPwA3UyvgqeetJeF1TmC4Dwl9CaMyBSBBtIjEC8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ExXT70fs9nIxaIuGeERjr3R0EIawNJZm9QdBUtSLNq3Qaydv+fnTRFBXahGFf1tM2
	 MouObbrQrryhqjdO7FsqYSPeFz3tIxEBrLbTfzytLU7q9TrNzWQ6Hb71kL0kZr7eNK
	 PqTzCJm4XTAyv1fEp2kw0SgrCBwFKFpf6dTKZhG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgF1WFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 18:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgF1WFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 18:05:15 -0400
Subject: Re: [GIT PULL] timer fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593381915;
        bh=UsJJbPwA3UyvgqeetJeF1TmC4Dwl9CaMyBSBBtIjEC8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eZOQaMqY0bN5X1jYZPmHES3cYd6J6CYIX6g4QbhXH0WtKyzXKXsbVlxbgxevSKLre
         qduRbjOf65QriOu6wSyh3EvBX85h++t9Hc4GA+T8PmHIylbqv0okTahgQ52tvu2ZBC
         LyHB/VswT0eJfoufT8drGZOhYDv6mGj0w9jkC6NE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200628183925.GA219470@gmail.com>
References: <20200628183925.GA219470@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200628183925.GA219470@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-2020-06-28
X-PR-Tracked-Commit-Id: f097eb38f71391ff2cf078788bad5a00eb3bd96a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 668f532da4808688f5162cec6a38875390e1a91d
Message-Id: <159338191522.4690.7697315740161563257.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jun 2020 22:05:15 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Jun 2020 20:39:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/668f532da4808688f5162cec6a38875390e1a91d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
