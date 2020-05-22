Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BABDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474672078D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590165609;
	bh=fhzeGBywkt5k8K9tNhMN6TpPV2iq4wl2nvNPQtkS5g8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZKh5XBt2YDziTIL2b8efIG6adgV3XnMvqNGmV3xBonYs8/cNk2rlvVfkbsieEWIbV
	 W84N2z0j5/O3geTi1fmOllHkJmgECeeeM9JUEy2v99h2CfRsSw60bO7BaGp7YNR0Ki
	 tYVgxxYgEbn9LGGttoljJd+ck56mrGM4vwq0JGm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgEVQkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730635AbgEVQkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:40:04 -0400
Subject: Re: [GIT PULL] sound fixes for 5.6-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590165603;
        bh=fhzeGBywkt5k8K9tNhMN6TpPV2iq4wl2nvNPQtkS5g8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YoV5k9b4qoFN/zggJvjNO26otdxqoioAK/6Z7YFCB9G6N+OCuJrPGW307XjU1niEb
         Gp7GyZp9pLX0TL/3rlHRuT90a9njYEzB6ZFGPyAdzoGGGgdvwSkeQzEKypOl4LKi8i
         +dwaG8xjH40uV/OcCR94RNnTQ0D54O4fUWQ9zbk4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hlflkxc6o.wl-tiwai@suse.de>
References: <s5hlflkxc6o.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hlflkxc6o.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.7-rc7
X-PR-Tracked-Commit-Id: 259eb82475316672a5d682a94dc8bdd53cf8d8c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5ca7a7161028db5ac5bcd06db03d7f2e340a20d
Message-Id: <159016560391.11923.4794201137029035479.pr-tracker-bot@kernel.org>
Date:   Fri, 22 May 2020 16:40:03 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 May 2020 16:43:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5ca7a7161028db5ac5bcd06db03d7f2e340a20d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
