Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66430C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B5C2078B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585614326;
	bh=iw7Z0AIQsg2l4FInJKgHqE43QtRw5KyJL/+lQ4I2eC8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cCzsd/zytiezYPt2CjosQrKNae6mOWbf9ddP01unZ3J5M2fyHFmCSMKQlJKo84vnK
	 /TnByridFE7tJymLhrEThFlb0trvOvUyLvGe930xlN2znaDSIundFqwTJKULX1FzVX
	 cdK3ALLc3a7Uyysn59WZfTGjVXhnN8JOiGekRL8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgCaAZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 20:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729648AbgCaAZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:25:13 -0400
Subject: Re: [GIT PULL] scheduler changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585614312;
        bh=iw7Z0AIQsg2l4FInJKgHqE43QtRw5KyJL/+lQ4I2eC8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WnTQ0KBhIzzVNgKAfAYCTJpvUxYpK3K+9Wmc9sKHmGbLCUoiYRL0D+sCUbriEAKy9
         ncP0c7aNpv3qdlWOxVx14LOZ6ZPkJBRQzoDYN8Y7ujRtW+xxycCgvKOHT8y9Q7NOj0
         poRoAv2OuHln6YklhtDAiKjB95jogj5KlX100mvs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330173159.GA128106@gmail.com>
References: <20200330173159.GA128106@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330173159.GA128106@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-core-for-linus
X-PR-Tracked-Commit-Id: 313f16e2e35abb833eab5bdebc6ae30699adca18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 642e53ead6aea8740a219ede509a5d138fd4f780
Message-Id: <158561431275.380.11330233809755788411.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 00:25:12 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 19:31:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/642e53ead6aea8740a219ede509a5d138fd4f780

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
