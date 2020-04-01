Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7BEC2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8419220787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585783217;
	bh=7tNhRCZfYIn2yNu4FIznmAyGvHlVuSygoY2293d/oo8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TwOE7BKckPjm9MzEIz1WtDhNtLo1sDSfgrnQg0LtkuoB56qbqM8iL9sIfwwvUrPWr
	 aRdJtDEuv5CxS9qHLqY75tL3mMvTNPqRRmX9iOVQhkNwUufz8Moornv6sAuAEzHnUw
	 aZR0o1FBxR98jV7KeuI6zigOx8uQqyIHPw8uieIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbgDAXUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387443AbgDAXUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:20:15 -0400
Subject: Re: [GIT PULL] Kselftest update for Linux 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585783215;
        bh=7tNhRCZfYIn2yNu4FIznmAyGvHlVuSygoY2293d/oo8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HCdlwL1G0pIXDuby7iAD8s9BwEVs2gbuuL78T/0WYrakL1uPEtfwXteRli03tCGmH
         2hYSjt5cYGOB8XKactbgnYVS/ArAPe3RbUizkBV8opPww79a6wUCl1yMTKWwFEp9FL
         gGPB9a3X2ExZdkyzIi61ecBkgug5ySNsQKQvdKmI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fd5d86b2-34d2-54a8-9c44-7f22266202cf@linuxfoundation.org>
References: <fd5d86b2-34d2-54a8-9c44-7f22266202cf@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fd5d86b2-34d2-54a8-9c44-7f22266202cf@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.7-rc1
X-PR-Tracked-Commit-Id: 1056d3d2c97e47397d0037cbbdf24235ae8f88cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 397a97946798890b9bdaa6122fcfad7147690670
Message-Id: <158578321524.12544.9703235378833574287.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Apr 2020 23:20:15 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Apr 2020 10:44:57 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/397a97946798890b9bdaa6122fcfad7147690670

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
