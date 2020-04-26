Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D940C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413B521D7B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587925518;
	bh=eEJsBl8MzyjMo9IFqxWtu6Dz5EiPFRx76TAO8Yh2VBc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WrYkEgsCC3JlRMVQifpH/6jqqCY3BxZ5xEXp5Xe0qeezvCcMP51ZEs5f61Ke72pjl
	 uVX0tLZGqiyKMfzneLMVsMY96br3kum1ncE+MKg91sTpe0ueki0pOTz7yXBGlwdcB8
	 +Be56OYmh3zbHWpp26E8fT1shUYpd84QuvYsYtCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDZSZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgDZSZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:25:16 -0400
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587925516;
        bh=eEJsBl8MzyjMo9IFqxWtu6Dz5EiPFRx76TAO8Yh2VBc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HBoA4mW5s4KKg1BPbyxQKqlwRrdnjb7R+bzuaPDU5kQobSGlAc7BcBPKBwNobdL1B
         A89xLbkfZej9pEiUqcJoHBm+yrDWmGX8l53csPJAlrBGVHF/n1Lc1g+wvgG/gc5P3C
         +7auITuxAhzmmnNX5PQIacnAGDHNOAuqEvnGvPKA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200426104842.GA2121011@kroah.com>
References: <20200426104842.GA2121011@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200426104842.GA2121011@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc3
X-PR-Tracked-Commit-Id: 9a9fc42b86c06120744555fea43fdcabe297c656
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5f33785719596047b0bb9df98d39fab9d1c51da
Message-Id: <158792551598.16875.6467921451635160771.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Apr 2020 18:25:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Apr 2020 12:48:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5f33785719596047b0bb9df98d39fab9d1c51da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
