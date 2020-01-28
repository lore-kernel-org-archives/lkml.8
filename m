Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E47C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10062173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580238612;
	bh=q+GcdtJbfe+EBx252Q6VmwDod3pjzbB34uPZjmwz2O0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HliNoe/Sj9XjmpfmOMpI8/vL6aZCinByWJrdb2LLYcR+e5h8OlfvV3PwmJ0S5rcj6
	 MqA6KCyY0cp8IEcBhfUjbBIRUjDGCDSXWS5R6B9kn9amQF52vuwtVN1bBoqbbMSrBT
	 uoXhmO/lyeEjTRC7uQeVH8ZxMr7v2yonA3zQ1cKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgA1TKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:10:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbgA1TKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:10:07 -0500
Subject: Re: [GIT PULL] scheduler updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580238607;
        bh=q+GcdtJbfe+EBx252Q6VmwDod3pjzbB34uPZjmwz2O0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WdZ4VvNMOFawxFpuHnxOiil8Nub9XSh/vhC+GZhY6l0rbC1ULdVyDF3HLaTPzTuRi
         1MaRYSCOwusWEVUDDZgmxcg0SuABT6vlloI7dVaOGWcA3iEMa9gba41xxvvGeyAfe9
         TPRwkDMJZFDcQCQ4U408PFfAbkQ1obbsJ/ERGszk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128161444.GA38989@gmail.com>
References: <20200128161444.GA38989@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128161444.GA38989@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-core-for-linus
X-PR-Tracked-Commit-Id: afa70d941f663c69c9a64ec1021bbcfa82f0e54a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c677124e631d97130e4ff7db6e10acdfb7a82321
Message-Id: <158023860696.9583.6517229346510034297.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 19:10:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 17:14:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c677124e631d97130e4ff7db6e10acdfb7a82321

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
