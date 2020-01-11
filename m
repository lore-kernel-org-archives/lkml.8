Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBBBC33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 14:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E63E20842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578753917;
	bh=ntWKRjfhrkxblw6e+Swu+Jo1keRIKl36fISIJooAxvw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PXJCvDqaGvPzgSWu2yzt4oO6RI08Wa2P0QFKbzTVB2kc7h0b0qYp1bM6jzicIWJ1w
	 qClZIRnLlx4C3X3wJBfB/xaHxXEAXnLxZerqc4XsjPQwKnyzLlmdp9dE0PSVdWzEaP
	 AdtefFYBTPY+yO/NLKGHUTCsPrvlwK3RiKrVnfKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgAKOpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 09:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729824AbgAKOpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:07 -0500
Subject: Re: [GIT PULL] sound fixes for 5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753907;
        bh=ntWKRjfhrkxblw6e+Swu+Jo1keRIKl36fISIJooAxvw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=r2Y5Xkklu7OHSVIsQFVBIdlDoaNe3xa+WAh/UoJ1Ci41/69hukWET449xH1P7RHU1
         vnTR1rbFBTuIzoo6oCcG2Q3VNA0wSxCCoyFt/k+RnTRrRAdacm2TXwfrj8aZA9U5AE
         gCEV9dVEmTrHDK7BgkZoAR/S88SqfxU1aE2zJgvY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hy2uflgik.wl-tiwai@suse.de>
References: <s5hy2uflgik.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hy2uflgik.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.5-rc6
X-PR-Tracked-Commit-Id: 8e85def5723eccea30ebf22645673692ab8cb3e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1d198c08ccc8fc794384a50c5202dbdf8eba8c6
Message-Id: <157875390722.30634.1270620098990742774.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:07 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jan 2020 12:04:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1d198c08ccc8fc794384a50c5202dbdf8eba8c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
