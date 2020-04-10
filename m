Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EACC2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17C02173E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586551229;
	bh=8yhGWbBlNuwLDJGgWdQH1Js7cmNmudrETKsU/1Ccf3A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Dc2e1pvzy6IAbBHB+9AJxKIAj8FuEQNO22kL11JnrhJfVpyt6B1LvYBUAscAkAR13
	 +VbW1Jk1XxekWn4divoeXyCeJLF8jXf16u+gz8DDyP52SiBeHa1SUxDaYR8mD+2r4Q
	 Z+qWYlqL7z+E3TwAn2GbyyzN6pULb7WW1AGswDJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgDJUk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgDJUkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:40:25 -0400
Subject: Re: [GIT PULL] sound fixes for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586551225;
        bh=8yhGWbBlNuwLDJGgWdQH1Js7cmNmudrETKsU/1Ccf3A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jjIHXPv4W9TGGmPWNr3LOIEdkvJruSOzi8BoLcDZxnBZ6dOxGBUTPggwR0zL4esFl
         5zdK9dZ2YtewDXEbAXhFcGekutvVkYCOThXpKqNF+DZL07251RScc3aeiIvKqs8CnS
         Exsh4N40O6tAAR3tXanlu8HeTEdFsXgRSttOKNoA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hd08goieb.wl-tiwai@suse.de>
References: <s5hd08goieb.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hd08goieb.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-fix-5.7-rc1
X-PR-Tracked-Commit-Id: ddd5609fe8b682fbe81f71b27561f14d3611d856
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4aafdf688360bacd4b48c87e9a3d0c208baf31c4
Message-Id: <158655122587.24997.12603451192488007555.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Apr 2020 20:40:25 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 09 Apr 2020 16:14:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4aafdf688360bacd4b48c87e9a3d0c208baf31c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
