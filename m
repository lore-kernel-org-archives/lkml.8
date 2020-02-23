Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF676C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DE321741
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582426515;
	bh=KSiOAQ0UspIkvXSz/D3qE96dbNK0yFOPRsVVpzaWoQk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0B3AokfT4odfHxl8Gruot9bYQ9rLOWa4JhNRrCfEKYqlrNHhEZqPBh1GKX8QUsKpY
	 r9z0gCojmgwW9lAugaDXWbvcqngNeCQE5EBuQi7ihlRaJSTtb1/IJEo4KToqGWNpGG
	 PxlytDVmpKvoKT9+vP+I1nRgsAFVDsCyZ8Zai7QU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgBWCzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:55:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgBWCzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:55:14 -0500
Subject: Re: [GIT pull] ras fixes for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582426513;
        bh=KSiOAQ0UspIkvXSz/D3qE96dbNK0yFOPRsVVpzaWoQk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XVPVSY8zPpKlCJLJvHGsihTU3Aqwyn6WsEZznzbzMDswUqhCK9wjG4Qid91+RnXQc
         xzjR/IAT8yMa8thOLcAhPxZ3ntZmj3B2/jzYSCm7ZCG4ZoPwwZqD9CkFklrsco+Xzi
         FQlXMKj6AG0vOxoZVK7OCyoNKmo4vF7d1wo7bR9E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158240520445.852.9501937854549164336.tglx@nanos.tec.linutronix.de>
References: <158240520445.852.16454463053831663511.tglx@nanos.tec.linutronix.de>
 <158240520445.852.9501937854549164336.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158240520445.852.9501937854549164336.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 ras-urgent-2020-02-22
X-PR-Tracked-Commit-Id: 51dede9c05df2b78acd6dcf6a17d21f0877d2d7b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dca132a60f226f4cbaa98807518a5ca6cff112ce
Message-Id: <158242651366.13467.1575918525477672783.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Feb 2020 02:55:13 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Feb 2020 21:00:04 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-urgent-2020-02-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dca132a60f226f4cbaa98807518a5ca6cff112ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
