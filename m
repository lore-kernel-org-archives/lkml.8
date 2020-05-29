Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D763C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377ED2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590786626;
	bh=w6g+nha7VpDKf+ZVCuuZOQyb+qhp4yYZ4xyYjzEbmf0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=o4zSRGrRAmTa5txvVGs9ncm7EqdmdSsVQ0DS3NvpjyjLsAwnSxegjpvcR+Jrh9nwt
	 SF26lLjcPdVh8Ad6vy20McRmUtxyhWp2z7KquLmOHKHGmQfF2RevPuh9js89YQa7ac
	 6pkaDoBFTtQN3Gf2XofhqGWGkfNEd60VmVeuwCpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgE2VKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbgE2VKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:10:06 -0400
Subject: Re: [GIT PULL] arm64 fix for 5.7-rc8/final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786606;
        bh=w6g+nha7VpDKf+ZVCuuZOQyb+qhp4yYZ4xyYjzEbmf0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uKwPie6xtjQyUBowjhwdgrwhpSvUd2lpPQB50s7hJ5869xGZMlFlce902XuFs/8ZS
         yD/W+LSzdvaxNsusc5iJRprU/YZKMUKb7slCY0JoXHZotA2y+Be5W16IXF43l1itWV
         s05XVLUsLUryrzpiP3H6+N+GKQlM2Ti2TWhZpRaw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200529172055.28307-1-catalin.marinas@arm.com>
References: <20200529172055.28307-1-catalin.marinas@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200529172055.28307-1-catalin.marinas@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: ba051f097fc30b00f6b66044386901141351a557
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f23460cfa867aa560119e18a73616e784d3cd66
Message-Id: <159078660614.32003.16409266128818344436.pr-tracker-bot@kernel.org>
Date:   Fri, 29 May 2020 21:10:06 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 May 2020 18:20:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f23460cfa867aa560119e18a73616e784d3cd66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
