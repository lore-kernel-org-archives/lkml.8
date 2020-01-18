Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B869C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C5A2469D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579381529;
	bh=mFBwDwjR2jpgoaZwNhnsMUpJ9HZSAx7t01RN5eu6Kls=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1WEn09Su88nzn9If4t/c41QI6d1uXISQTMVhPIXUvq3Mhsjc3aUeHNiRtUQWgVk8B
	 A4xPey3fXQYNHG9cjOaSsgSk4vRdQYdhMPGznno9A73CEd+eiG1VioqwM85qKBy5aC
	 kryHTdylII5Wb3t6ltkQufOWbHyTt6ljvelGyMcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgARVFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 16:05:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbgARVFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:05:06 -0500
Subject: Re: [GIT PULL] cpu/SMT fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579381506;
        bh=mFBwDwjR2jpgoaZwNhnsMUpJ9HZSAx7t01RN5eu6Kls=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CLqoz3xmK4JGca6l1eZWwmGN8X3VYO1xH1nKunRDZW1tAsErF+lGWryEaXAejXSlm
         Fkc2noalML1IO04qVLhGsTaPCjYCuPy4MwqDA2VXFO6q1JeFrLKWr+0nhUOxpLbZ8d
         1XXJVImdXKxIj/CWfe/K5p/5GGDW8stVUYddlGrM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200118183711.GA52397@gmail.com>
References: <20200118183711.GA52397@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200118183711.GA52397@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 smp-urgent-for-linus
X-PR-Tracked-Commit-Id: dc8d37ed304eeeea47e65fb9edc1c6c8b0093386
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e79c5233290884d54addb601afc7ece2f70c79e
Message-Id: <157938150628.20598.378290493518678550.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 21:05:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Jan 2020 19:37:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e79c5233290884d54addb601afc7ece2f70c79e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
