Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBA6C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC2520737
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588110305;
	bh=Gw608eUfMB9sxFqlDSjhvls7OCZQY2mHd3rra4RTmlk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Rr0fDcKGviDoBpC/DsWlFddnVmwWDprCJpdlVJW84LXBEevckA1K2eW6D5vylXDIk
	 DLWTQxtM7QpwGf81zCzwmX3SdyZ80pcUBGhkzFsXyyPjMvI4y/2M7qkTUnxUYTVrek
	 P0vcKbLA2dk+sGBQPFlof333YcDmCNbCkznvflK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgD1VpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgD1VpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:45:03 -0400
Subject: Re: [git pull] vfs.git fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588110303;
        bh=Gw608eUfMB9sxFqlDSjhvls7OCZQY2mHd3rra4RTmlk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TsJ5eTb6NQv5v8kJ9+c+oBKcgY/kis5WJpfbLCY3r8vutKsUP0Vf3FRpqqqF3WQV/
         52pn0WPKgzaSdwVInJwQXRyoEmPF+pEMBBpTebzy/tXA54Qno5xOmWOFXOBYIfBMMK
         VPH30evZzhzSArXh3VH0GZD784QDguvVDQVxZ5no=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200428211855.GZ23230@ZenIV.linux.org.uk>
References: <20200428211855.GZ23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200428211855.GZ23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: b0d3869ce9eeacbb1bbd541909beeef4126426d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96c9a7802af7d500a582d89a8b864584fe878c1b
Message-Id: <158811030351.16166.2400535673270943914.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Apr 2020 21:45:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Apr 2020 22:18:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96c9a7802af7d500a582d89a8b864584fe878c1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
