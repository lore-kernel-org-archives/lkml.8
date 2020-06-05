Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1F3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A61C720772
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591391720;
	bh=F0A2kCUpX7T/mvy4o2aR9Y2WyTBiQbiKJXIXhc9vnVY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=olOdquM+ThigcyjcM/Vpf/I2/XYY53nL3JFydDngFJDVG7ZAbvyqVnxeMhp2TB/fh
	 4aQdQ34OD7eFchPKLlTgTXBMT5qnyFYTEs4TwT0scUq7sy5slBiron2y1A4wM6vPr6
	 BnPRvBZsNj1qNqovEkYEFEAwH+qkHuljX5LdR8Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgFEVPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgFEVPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:15:15 -0400
Subject: Re: [GIT PULL] IPMI bug fixes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591391715;
        bh=F0A2kCUpX7T/mvy4o2aR9Y2WyTBiQbiKJXIXhc9vnVY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VzQzKiFLkyFcf6JJcjVXVaPMVLZx6HaEYXBdiXjtO8GXerVHTwgyFg9wmJO8gWGMa
         dZYDte/qwz+0j1Y7yMyUlRxDG9WAmg0JcljVOlASsGukMo3Mkk1qfXYaH60m+VE7yT
         kCNZOYBajKZI+AfpFMyievLryRftRnH7uec1u6d0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200604185912.GA19831@minyard.net>
References: <20200604185912.GA19831@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200604185912.GA19831@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git
 tags/for-linus-5.8-1
X-PR-Tracked-Commit-Id: 2a556ce779e39b15cbb74e896ca640e86baeb1a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f2dc7f5b6c1fffdb24e776b9d3529bd9414aa2c
Message-Id: <159139171508.26946.12108791057437684297.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jun 2020 21:15:15 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Jun 2020 13:59:12 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f2dc7f5b6c1fffdb24e776b9d3529bd9414aa2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
