Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FCEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D48524681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580238614;
	bh=OqFMcHFtkk4/HMA4a/9a4t+73KkjLWmrdctNpRO0894=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Cn+uygoa52FMGEUlooUDypeUY13JwXM8QM+7afbjqnYvy4lLEi8qjYzEj1POEfjng
	 UBwSwTYRqyvx8uMKa0839rkN4DaIwyQ0WUlaSLoufLSUdYIebyhcl1WxKnYgQWxY7A
	 /71puBHkdsyVWKtgfFENpqPGOoa7XxTfQ9YA0BG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgA1TKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:10:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:45754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbgA1TKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:10:05 -0500
Subject: Re: [GIT PULL] objtool changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580238605;
        bh=OqFMcHFtkk4/HMA4a/9a4t+73KkjLWmrdctNpRO0894=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hFFxj6y/ftvei06znvM+p1zV6C1V+CEjzloJyxUY7iIWQ0ZPXgdj8COBr24M9HPFy
         pH/CuSKGHd7CTBT8Fja9TKuF5RRGiNc410BuKEOB4KB+aqjIxJoHPz1Ibb6MuF5/z9
         huqq4qn5eKmq//J+U755AY+nF25/8nncqlO4h6VU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128070844.GA6655@gmail.com>
References: <20200128070844.GA6655@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128070844.GA6655@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-objtool-for-linus
X-PR-Tracked-Commit-Id: 22a7fa8848c5e881d87ef2f7f3c2ea77b286e6f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b561778f29766675e88566215aa835fff9dc1f7
Message-Id: <158023860505.9583.12073470521850108384.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 19:10:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 08:08:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-objtool-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b561778f29766675e88566215aa835fff9dc1f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
