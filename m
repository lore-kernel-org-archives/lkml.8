Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA37C433E8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 22:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7EB206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 22:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595716213;
	bh=5eei+xGbwhPCgRFXPyLEluUSF8hdPtvhc71bTraY59s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oW5fgHtCbyKW8Kdhrbh74sFkp6bBqNB5LRc0Cs/8mIV+1XIWRwPZtAsOkt50hzPL4
	 B22pZfEj10zNYtrMxQDLPnIlMt90E+nKh21/GzyeSBApNhpcm28sQDqvlCSNWEGk+v
	 uHt7YbOJ5FV9YLoFQe/J8GR+QzMzhBAfroKUpuPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgGYWaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 18:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbgGYWaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 18:30:04 -0400
Subject: Re: [GIT PULL] EFI fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595716204;
        bh=5eei+xGbwhPCgRFXPyLEluUSF8hdPtvhc71bTraY59s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kMEYfnvczl/wZ6Te4igQs4l4weuNwqnpnXiGZk2z/pVblBXMjzrht7FyL5qQ7oFmi
         BEntS77jkCD/s10QqCTpfe4GLuyhFbPgr5338a6lak4ladgvebIXoMA5vDu/dfY24N
         qKLRHRUiWK3rekZo3zuyd40Q2VgQojLaEwt16F6k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200725103259.GA823698@gmail.com>
References: <20200725103259.GA823698@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200725103259.GA823698@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-2020-07-25
X-PR-Tracked-Commit-Id: 74f85551666fe40bd739e95b5ecb20f53f8ad4df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17baa442864254cb2aadf3a4d668c0f81d2f07c5
Message-Id: <159571620453.7388.11647176182336327209.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jul 2020 22:30:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Jul 2020 12:32:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2020-07-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17baa442864254cb2aadf3a4d668c0f81d2f07c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
