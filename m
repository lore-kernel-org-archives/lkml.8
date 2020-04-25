Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6DEC55197
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F0F20A8B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587843022;
	bh=6dtNahQ+SGqG6EYsAVrJsJ6pOSe2rPat4StJj/d4pEs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jUmBGBY2oSndOFhJzjAaNaFResnvcEm4XRVCbV6r4RhsudFJWusxrTiZyLGPdYRZ/
	 3cV073BrCXXkzFUc8EtcWlw+sWyiIu/3dP74Q9FGyRhc1RpeiSWq6Jd1egvXHjaKk+
	 FiCgAeHdHoh5Tpn/j07n7/qLjvbSDp+LL3PrwR4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgDYTaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 15:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgDYTaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:30:17 -0400
Subject: Re: [GIT PULL] scheduler fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587843017;
        bh=6dtNahQ+SGqG6EYsAVrJsJ6pOSe2rPat4StJj/d4pEs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tY8hJLGWzkIIrzxBzX8f9BEjqI9jl7xNi7BRSsB4yWwPuG/PcYtoGEwfDIxLEFbPc
         3sjHlfAY1g3pkO4cHiA4PSDo/P+evirtSmCjhS2vZMpGmmt1UegTIV6fO1FsEqRx5o
         FLyhh5TC/li36mWhYoizPqKryYZCcINczPZZBN2I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200425092818.GA58070@gmail.com>
References: <20200425092818.GA58070@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200425092818.GA58070@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-2020-04-25
X-PR-Tracked-Commit-Id: eaf5a92ebde5bca3bb2565616115bd6d579486cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05db498ad94431315c73efe623eab7a7d2d961c6
Message-Id: <158784301730.5802.6201156772992452888.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Apr 2020 19:30:17 +0000
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

The pull request you sent on Sat, 25 Apr 2020 11:28:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-04-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05db498ad94431315c73efe623eab7a7d2d961c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
