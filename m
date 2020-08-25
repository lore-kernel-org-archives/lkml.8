Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94207C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E5492071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598382991;
	bh=ccl2PxpjV71b6R3oiNJ1mYGPWMxjhVotgiPqHQonsfU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ibvj+4zgctuATLgUH22V3btyT24aqgh39EZ9NJ1DajWl0JRJXZ56YMN1O7o6hRBFg
	 egC5ipX+VkBxlAhl51W4BuFWegk6EPjB4Ov4nrHdzL8I/EsbTHqgiKIXtW1tjHw7wB
	 0/U5cd2TNYv/iBuGNqWAf0TeHSS0PGYeUGt7NOo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHYTQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgHYTQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:16:22 -0400
Subject: Re: [git pull] m68knommu changes for v5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598382981;
        bh=ccl2PxpjV71b6R3oiNJ1mYGPWMxjhVotgiPqHQonsfU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZZkkW1EjyBFU7XK2Nmwn6EwJiTBSt7iEkT/IYG6ZYx41I2LH4Q0Jsw1p3bkQ4NB7g
         PKuZJyIGxrRsckt9F3kat8WCxITXLUNpLa+djm8waCf3KJX8+MzQ6m+lRU1TChSmsH
         otJoZzcCGFS2W6963B2HBB16Rq2S3egNzAkvVsaI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <97069a5f-fd94-8a75-3fc6-3e50f7e3ec3a@linux-m68k.org>
References: <97069a5f-fd94-8a75-3fc6-3e50f7e3ec3a@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <97069a5f-fd94-8a75-3fc6-3e50f7e3ec3a@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.9-rc3
X-PR-Tracked-Commit-Id: 2217b982624680d19a80ebb4600d05c8586c4f96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abb3438d69fb6dd5baa4ae23eafbf5b87945eff1
Message-Id: <159838298188.30843.12096079475236397075.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Aug 2020 19:16:21 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Aug 2020 23:40:42 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abb3438d69fb6dd5baa4ae23eafbf5b87945eff1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
