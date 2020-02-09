Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82734C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 21:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560532080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 21:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581283804;
	bh=TUCmjBFAJ0Tq1y6EzDjRK16yDTG2myxMj+yMCKvTo1Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Jb7tbXVwWdBTO1S+l+k0EGtuhmJghOlKs5JS/OAqfQLsHj/tVfkjVVCW4WM8W4hKn
	 StqMgroAoqBr0FAYQFWGqWhZio0MtrVu396d1uUQEMAg89bZHCR11WiFmTS+DaMx7s
	 0OI+o7S5aOf9ZCHAbvnNUbpMJl2C3Pzb5pxnuplc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgBIVaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 16:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgBIVaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 16:30:03 -0500
Subject: Re: [git pull] vboxsf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581283802;
        bh=TUCmjBFAJ0Tq1y6EzDjRK16yDTG2myxMj+yMCKvTo1Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1HC7IXEhJ4cuF7w25a9+cEjsJjksnAkrgsIVEtjiObrFzlCMsgHUInF8rGoEJJ8xm
         6l8yImD9Uuol/2PtA+H40t7yGVXDZ9OMMsj3al7wp07+gcrcPGVvjym4abxQH6B+Gk
         35SPppDmY6nqRWmw+eXkeQpCNxLF+NAdrwKpwe+Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200208224637.GH23230@ZenIV.linux.org.uk>
References: <20200208224637.GH23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200208224637.GH23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.vboxsf
X-PR-Tracked-Commit-Id: 0fd169576648452725fa2949bf391d10883d3991
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5586c3c1e0eb04cb8b16684aef779e019c8cc64e
Message-Id: <158128380274.12209.2429992777686109870.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Feb 2020 21:30:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Feb 2020 22:46:37 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.vboxsf

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5586c3c1e0eb04cb8b16684aef779e019c8cc64e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
