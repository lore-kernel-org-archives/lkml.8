Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9ADC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E78206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598815035;
	bh=F7hcAYFvUCeTyqbwARDieiyWcNJVsGv7iLIafGdfoZU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZZsvoTx2rZcIYb3CSBJ8fEmLywTM68qcJJECNf+MhvzMLocRgHn0bWXZZiMC3bLsv
	 XLu03RgCDZy/uAnHVo751Q8ozq+0b2OFApj82fA1Usb0dfDNG8deOuymORLpexsWsy
	 yBA3LhaUa9ZMKQT980BlRGp18BMMEt0PA2ZFhf3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgH3TRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbgH3TPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:15:36 -0400
Subject: Re: [GIT pull] locking/urgent for v5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598814936;
        bh=F7hcAYFvUCeTyqbwARDieiyWcNJVsGv7iLIafGdfoZU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V5oaYynpMx/LcN94hjDRc8Z0ia4dkIJONcLhYn7zqHgKlOpn3OELtfdAHLRneOcTY
         eT1mv6dV0/xvhtGrq56VKp9wUIEYfPfV1A2ebz8FDp6USuQKCIo4MhC022QC4heD96
         kRzVo7k6cP8UicCx5/93yZYWcZULOBwRXhG4dfPc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159881061684.27993.2189953397609628514.tglx@nanos>
References: <159881061564.27993.11909051048930389391.tglx@nanos> <159881061684.27993.2189953397609628514.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159881061684.27993.2189953397609628514.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-08-30
X-PR-Tracked-Commit-Id: eb1f00237aca2e368b93db79303f8433d1976d10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b69bea8a657b681442765b06be92a2607b1bd875
Message-Id: <159881493602.11576.6825625358225070446.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Aug 2020 19:15:36 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Aug 2020 18:03:36 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b69bea8a657b681442765b06be92a2607b1bd875

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
