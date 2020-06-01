Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2861FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F772073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591048551;
	bh=RqrMePYWtzk3A5//IcsJtJlukTwL9rhljb3WP9eJ048=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xdh0bslgsnarTiYEw0ajWMLSC9C9435I1zoxKlBY2HVbi/FWAnbiMJRjwz+X3Vbu1
	 pq9bdA6Vh8OnxDaUWNf+HjJN6nKZrecmoM4ejHvyAuku4VbMfrWkumDU6+qe1jPYoq
	 yrHzA8drMEJ8TSKC5s2JXt0UtJwKSdPQ78jWlSMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgFAVzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbgFAVzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:11 -0400
Subject: Re: [GIT PULL] x86/cleanups for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048511;
        bh=RqrMePYWtzk3A5//IcsJtJlukTwL9rhljb3WP9eJ048=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1VFjQ7pxN0P5Ie5DUi0aMvYxEfRqrZcO6/P7Q+L2BYuWx8jibSiEP27tSLeR3besz
         zA084aOtwKk5zNoCAGdR29jtEoagIpwWaJ7xLrv2s3fFDRLPQkStGnduC2Jm5NKnqc
         sm/xNLPDJVjU93qKFPM6QyEsmmB4M4eBrchhn9ow=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601163418.GA1220330@gmail.com>
References: <20200601163418.GA1220330@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601163418.GA1220330@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-cleanups-2020-06-01
X-PR-Tracked-Commit-Id: 2ca41f555e857ec5beef6063bfa43a17ee76d7ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17e0a7cb6a254c6d086562e7adf8b7ac24d267f3
Message-Id: <159104851160.21074.7552235878468044887.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 21:55:11 +0000
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

The pull request you sent on Mon, 1 Jun 2020 18:34:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17e0a7cb6a254c6d086562e7adf8b7ac24d267f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
