Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26A7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2A4206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593369924;
	bh=4kTue6ojvrs7Uz9CHXzAocbYWGdzG1u+Tkw6SDLppmc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=k5PUC0qMxK6SIzbUH+zf5yTcSVmySgGZbIXLflzNaxUpn+Z85sOmN7nA4LreWMWBy
	 vGW4MNDxNBaNXlyLxMp3Gh4icgBXizOdhg99FuAB3H+2vW8iwYFDGqcwpS+J2Pd6c6
	 ugrTn2QU5D8a8xpI33ja7GS5p62UeJWesNokIqDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgF1SpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 14:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:32938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgF1SpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 14:45:14 -0400
Subject: Re: [GIT PULL] x86/urgent for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593369913;
        bh=4kTue6ojvrs7Uz9CHXzAocbYWGdzG1u+Tkw6SDLppmc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CCsf+Hsp49mBIcWqV5xkBbQr/Ldvf0MFigCP7M+y+Z4xF/fwJVpXCM72/ag86L4yK
         yG6yyerJL2IL6BCm9q2oRPblsXlRxhtouz4wTbz+C7wRaXPHLRnSxax+mBnsjFBPT0
         TQJlpl0Mx9hssbKIuPS9lBSkHm4wVuQXKk5LkG5k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200628144319.GD18884@zn.tnic>
References: <20200628144319.GD18884@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200628144319.GD18884@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 tags/x86_urgent_for_5.8_rc3
X-PR-Tracked-Commit-Id: bb5570ad3b54e7930997aec76ab68256d5236d94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 098c7938217dfd5ef61720bb93d08cc836274b55
Message-Id: <159336991384.7125.18075087391674329019.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jun 2020 18:45:13 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Jun 2020 16:43:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_5.8_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/098c7938217dfd5ef61720bb93d08cc836274b55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
