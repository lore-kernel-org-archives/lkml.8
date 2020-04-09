Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3FEC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E7E20757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586455832;
	bh=zfk9UF4E5Hw/Yt7i3ELzwvn8qWsEFSoq8wmnU0APKrw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xKw+te9Ta1RWiwwKMkPrHG2BYero8lHsDA6Rr1D5lAjcLPSB9uMnmgiXJu4hOqYOZ
	 dy0tIIoPvjoXUnrmO9otCJEhllBta6dcDmWIPqlhAYoQXLXAr/++F2EMhEwttg20xD
	 xB5YDcahQwv62SLo9lvz9k+Ss3ld6pb3CPBVXWfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgDISKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgDISK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:10:29 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586455829;
        bh=zfk9UF4E5Hw/Yt7i3ELzwvn8qWsEFSoq8wmnU0APKrw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Va/I7ipEJAQbQ81thbY0ExY0/e1Bkn7+g4IphgMIbNtw+ABxSP31W/c3LUmEZ2KP6
         bphHHangdBomYA47iAy+eGEJ6MgOTgFqsf+LuaFALeX2xB7pkr2ybJ5WHsS1oCsn36
         sNoP8BYFNkEzS+Rbllml1gT/mTJDqJQbITnhCx3I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200409165049.GA872@gaia>
References: <20200409165049.GA872@gaia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200409165049.GA872@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: fc2266011accd5aeb8ebc335c381991f20e26e33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87ebc45d2d32936fb1c8242032eb0b9bcd058858
Message-Id: <158645582947.26793.13263026472469961418.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Apr 2020 18:10:29 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Apr 2020 17:50:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87ebc45d2d32936fb1c8242032eb0b9bcd058858

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
