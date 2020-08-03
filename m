Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CBCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E276022C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596492605;
	bh=CYyXnvZJCUaonsd/yI5h4FGaSrFy8joVfbR7BMSsyjY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pzusvwYr6JoR1nS67LqXSUwuus+cM6z21nHRgyOeB/usC9/qnw894nkBvuLD9Gsow
	 cg0avG9aCgyf2rAm9BK7TYZxxR+BrFNaIWj39OFrd83ai/4iQamx9goIdtTVTOGWbG
	 f8wiYHdjYJQ8ay+SDjZHFmii6Oti2jTXwbruYXDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgHCWKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgHCWKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:10:04 -0400
Subject: Re: [GIT PULL] IRQ fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596492604;
        bh=CYyXnvZJCUaonsd/yI5h4FGaSrFy8joVfbR7BMSsyjY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cbEDKUxvxwPLsJcN1GjojI2Z7AGelD9vHmKNrjeQxGB/Pp+qbF2/ef0I3YtOKUmLG
         hNKXUceuI6JQwnWHtgURQlvCYahuE4NqY+tgZ7t+1T5PF7FNGgMEdH7WUT3x9C5kcI
         ul7KkFxFUY3bIazN9jdNXRxKqgbBhx6Ny2iqNADI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803105419.GA256986@gmail.com>
References: <20200803105419.GA256986@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803105419.GA256986@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-2020-08-02
X-PR-Tracked-Commit-Id: aa251fc5b936d3ddb4b4c4b36427eb9aa3347c82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b4b84b2ea9938e44fffa356c7b95f496b4246ab
Message-Id: <159649260392.26696.17018771519961735618.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 22:10:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 12:54:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-08-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b4b84b2ea9938e44fffa356c7b95f496b4246ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
