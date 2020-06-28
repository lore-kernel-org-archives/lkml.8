Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA124C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B203206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593369919;
	bh=LRJlPayleIxtxwgjNlHlzBH7SdpinfpRtsKogNJgqRo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dM2ztJlw2fp1q/uPVB1b41gD7cU5+HN1pPgQ8o6HadIPBfrzk8G5oDPQK4xGD8jRl
	 jKP3iWb/wDgYQR6oL/euIc/FS4s6Z37ANmBYFsw7P0K0FG+hVfvz9X7YWcNS9DjoPS
	 /NxsOxMaeO96sK9ifEvXw5WaGJ8wLzHtqLOuJA9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgF1SpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 14:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:32894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbgF1SpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 14:45:13 -0400
Subject: Re: [GIT PULL] rcu/urgent for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593369913;
        bh=LRJlPayleIxtxwgjNlHlzBH7SdpinfpRtsKogNJgqRo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AavHHXpdBhoysY5b/edTVj+irfIBO3s0ngV7/R6Q289EjuN4zkDw9vkqTGM1uq2ei
         +Fk4gJwm1lFm2MIe4J9rnsZqOFmIGgjenyLJRCc7OgIvz0EU3m00UnjyoGEhOZZxKe
         DNO2VlmPztvuT3KdL4RDfLF1wTK5JAUSrttJsidw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200628143835.GC18884@zn.tnic>
References: <20200628143835.GC18884@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200628143835.GC18884@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 tags/rcu_urgent_for_5.8_rc3
X-PR-Tracked-Commit-Id: b58e733fd774f3f4b49d9e7640d172a57e35200e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c141b30e9960e81455ad9c3658c079051eea7e2d
Message-Id: <159336991342.7125.13612861784913036069.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jun 2020 18:45:13 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Jun 2020 16:38:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/rcu_urgent_for_5.8_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c141b30e9960e81455ad9c3658c079051eea7e2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
