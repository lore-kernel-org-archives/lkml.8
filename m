Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AE4C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 20:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807562071A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593289524;
	bh=4ZVFImtbaCKd0Np4tmJJBMCy0Tek++XCgT1Ml2ZJ58o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0itzBSN6vJlN1V81eMaT+u197b16NAXEX98yQX6zMozNrySbA4Yfguq/SB7aakFlI
	 K8c2+YeLlRJDkwgeSTa88fzQ7Rv3+UL5wV0ygGfxsLwOt8kOlxR0oD0yf4V6RQcnoX
	 tUH+vR8tTrSl5Ydlxl5u6qOW++cUJtfGN47WaO8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgF0UZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 16:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgF0UZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 16:25:14 -0400
Subject: Re: [GIT PULL] EDAC urgent for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593289513;
        bh=4ZVFImtbaCKd0Np4tmJJBMCy0Tek++XCgT1Ml2ZJ58o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XF0TTRWVKcxQVKy9PRFvVilaIIIt5ERquPMGDf22xNAgPSW0UdMc2V2b8EDdy3B9r
         VFuLlXHWgra8se6gw/tUFuOvyd99dJ6AOwQSyz6ze5EgJ3zi6s9Z9146K1FQair54U
         yMPgUBbZvUn/1gfITnd9OZiNFwXSyahcpJdLFPcI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200627105918.GD18956@zn.tnic>
References: <20200627105918.GD18956@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200627105918.GD18956@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
 tags/edac_urgent_for_5.8
X-PR-Tracked-Commit-Id: ee470bb25d0dcdf126f586ec0ae6dca66cb340a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42f8f9bc5cb7c35ca04a6867cc01c24538d59f7f
Message-Id: <159328951364.11719.14509799335240723936.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jun 2020 20:25:13 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Jun 2020 12:59:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42f8f9bc5cb7c35ca04a6867cc01c24538d59f7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
