Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A59CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407DA24681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580238617;
	bh=swaEhFbQn3jJh+O8Bwv7sKvqLvrQTudg/K1lDk3x8bE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fVTJnDeKCTTGUnFPfyMuoGJlVLiHvRJsIxtZ3/V65B2YBq7Kr2IcPgKnB/hBqkX4v
	 JN1qhEg0I6JA5rSeFdCJ9V2v7vVMidMn5onP/cRy6i2WuHNwzPAeMgqON1vuMM1XDA
	 kaUFtWiYUa0zlUoPmocRcPWpSUXm5yxJbaBOw/Rk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgA1TKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbgA1TKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:10:06 -0500
Subject: Re: [GIT PULL] perf changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580238606;
        bh=swaEhFbQn3jJh+O8Bwv7sKvqLvrQTudg/K1lDk3x8bE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NkaX6hQvfQzaTzMng5ZOr57zwkA7IwsZHrqs+nseVkWlLrDkdZgkmARm0Y0/G0wmX
         h5CeP36VdGH0xl/zBNCS2Zr8VO0wHbgvxT1/RYDQJyPtTKFyOMJ+0XdILzrYlgUkKX
         Vp082wAhI18q2xTO8F6oaSCIhMmvPOkQvotbLYoE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128082424.GA41606@gmail.com>
References: <20200128082424.GA41606@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128082424.GA41606@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus
X-PR-Tracked-Commit-Id: 0cc4bd8f70d1ea2940295f1050508c663fe9eff9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0e809e244804d428bcd976eaf9369f60508ea8a
Message-Id: <158023860644.9583.7384133981160894157.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 19:10:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 09:24:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0e809e244804d428bcd976eaf9369f60508ea8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
