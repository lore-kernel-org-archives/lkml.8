Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A99C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B414E2082F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585947026;
	bh=HvwTk848zfpSTTvdFPP2kBDliDKHfoEwH8BS3M9xRrQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JdGH2QRRflAfcme/fy+oSD+HRhhDgvnCHd8/QvH/Y/wfvTTmuGkGdDWG0MStWDvSw
	 hlRJFsNiT886uQwvq8wCsnC0PXk+ieKAkrFtWaNfS76iU1Lvc7MLHzipodmPGl0Bei
	 aw2pODmVbrfNK4RQ2QQd3qED2PAiNYwAs/8YC6nI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgDCUuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728996AbgDCUuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:50:22 -0400
Subject: Re: [GIT PULL] Char/Misc driver patches for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585947021;
        bh=HvwTk848zfpSTTvdFPP2kBDliDKHfoEwH8BS3M9xRrQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2hY5zAyxf6dChDcuaeSWvI/iHM38ZaP7yfJd3Ij49C6sTIHtwmGTy+AflbN8Ba2PV
         Qi9gt07UZGLNGFptAX4bUcxyffFxwtNXlVbDVFbPP3SKfccXIlnjH43glOjM7I3Nx1
         cJ4BmA/2NyiN7Fgu64pDdbjVxhYLxi2eQ8bmshbI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200403161127.GA4104105@kroah.com>
References: <20200403161127.GA4104105@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200403161127.GA4104105@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.7-rc1
X-PR-Tracked-Commit-Id: 885a64715fd81e6af6d94a038556e0b2e6deb19c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ad5b053d438990fabaa324499abb6131b9d2202
Message-Id: <158594702168.4594.14794016071338767070.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 20:50:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Apr 2020 18:11:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ad5b053d438990fabaa324499abb6131b9d2202

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
