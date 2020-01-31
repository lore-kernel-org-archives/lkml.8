Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F8DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 19:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6080B215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 19:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580499319;
	bh=D2wxrFmhq8eAB1U6alviK1YpgHZSVKoHrTIm8WomsZs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SzTbk+LpzR6KVh9ng253WR5YLVqdT2HTKODojfO9vkZHR9mGnOlQsdGFrswEv+W97
	 1XLuGoXwwibV/YDX2L80IXleRKLbAKi5qOIOJKWSQHjmqJYVBUsT1RPZtGLKcocAqt
	 SfCn+z/pUFepQoSy3fZegAYK/z5KmVFWyOUiBt70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgAaTfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 14:35:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgAaTfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 14:35:15 -0500
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580499315;
        bh=D2wxrFmhq8eAB1U6alviK1YpgHZSVKoHrTIm8WomsZs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kExD7pE4taV6WZthT4F+hdvu1mKDzLeFMF0c15r/1vLIHnOuy0qbtq9AcvZbtfMI+
         8LIc+g75UV2LE2CNf4IanfQcxWpuZ8hnz+0Zs1KNGK4jsbdWizW6sDQ+ICwPVgQMoc
         iIs81EU8g9WT9Sfr5kIb7eG0g2vr5au8dtuvJNZA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200131115259.GA91121@gmail.com>
References: <20200131115259.GA91121@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200131115259.GA91121@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 6bd3357b6181bd38c1a757168a8842e09ec6f3fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b70a2d6b29f7c5b621bf83f903f26fee5fe28efc
Message-Id: <158049931515.14867.2778933923429879184.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jan 2020 19:35:15 +0000
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

The pull request you sent on Fri, 31 Jan 2020 12:52:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b70a2d6b29f7c5b621bf83f903f26fee5fe28efc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
