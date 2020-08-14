Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D827C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05EEB20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597441882;
	bh=FZaiQ8VxvyxWvY/boCcLhA3BsvzvI8AVxduKAtbwHXU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2c7j/cFlYj/5p+wQOkA9HZagfanT4WmatWejeNFLr0zJbZyH9XT7CyRhXgfSLNg2D
	 ignKg4w6ZhZDb6U4NmOQZLz7rifQzRkzCKpaBorw2cbfWj1QZXD1d4+nuzLJZdR9Cw
	 obga/2V3EmJq8wFj/elYXFe/iWYd3HCC6GmGdAhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgHNVvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 17:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgHNVvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 17:51:19 -0400
Subject: Re: [GIT pull] timers/urgent for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597441878;
        bh=FZaiQ8VxvyxWvY/boCcLhA3BsvzvI8AVxduKAtbwHXU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yeZO/4Ft/q/XkabMj9/w4VP5/9dr1Z0F5a0/FLehbv+V7ad5bbUkx89nqUcTLjq7c
         0j2CzOIM2AWNa0+oCLea8jXu2Li1uJorFoCVSmRHN2SsIHg/UoPb1mta3SkCksL+44
         SvyowPYM92KwDvtbVkxG8G1sGQOtT6xO7CIefkbc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159742071432.30851.8730414087382693550.tglx@nanos>
References: <159742071192.30851.2328227964586183297.tglx@nanos> <159742071432.30851.8730414087382693550.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159742071432.30851.8730414087382693550.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-08-14
X-PR-Tracked-Commit-Id: b0294f30256bb6023b2044fd607855123863d98f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b923f1247b72fc100b87792fd2129d026bb10e66
Message-Id: <159744187880.11302.13127271812443521684.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Aug 2020 21:51:18 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Aug 2020 15:58:34 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-08-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b923f1247b72fc100b87792fd2129d026bb10e66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
