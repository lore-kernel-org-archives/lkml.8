Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DF7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47556206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589746515;
	bh=nNZ6TNHOnl1sTcGXz3ahW3bVOuzuAYrofJyb5ODtNZg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yp8rTwI+8BWRWVgpAo55CaoRnFP8RhWyBUM0k6u0HMRAieYuwMP1vFhQU/76dquxp
	 vFQIEjvOLov8G2xVe82YvcXzJYErcJZ3egf4LWgEdEgIZxLn+lEVo2VJHuKSzd44oN
	 gSnRhII5NJBirdt0r00lHSbfgtBPcCMZoHocJrCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgEQUPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 16:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgEQUPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:15:03 -0400
Subject: Re: [GIT PULL] x86/urgent for v5.7-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589746503;
        bh=nNZ6TNHOnl1sTcGXz3ahW3bVOuzuAYrofJyb5ODtNZg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=klxmPhuOTicFLdmZO9rC/PQSKJJtiLrF/Mb+hSo/Ph9Y8HUNdGA8m9/zASjSryBnI
         56sLf49sygAMOLAX1yW9ocGIVL8cF94C0S9l1TEa8gWmhOIOTrXVxvGfZgId9QrXQF
         P7TN9ASngQ0jqu32L1MDKQAJiLumFM92o9OmnJaM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200517090404.GA26679@zn.tnic>
References: <20200517090404.GA26679@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200517090404.GA26679@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 tags/x86_urgent_for_v5.7-rc7
X-PR-Tracked-Commit-Id: a9a3ed1eff3601b63aea4fb462d8b3b92c7c1e7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43567139f5f3808cda4f61c956576f8a4f2232cb
Message-Id: <158974650297.31612.1387976828959514100.pr-tracker-bot@kernel.org>
Date:   Sun, 17 May 2020 20:15:02 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 May 2020 11:04:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43567139f5f3808cda4f61c956576f8a4f2232cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
