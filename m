Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85675C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A21520737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583959515;
	bh=n1xtT963Ze9x6xcOZWqOv7tuDm8DCoSaevBkcCJj0is=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=04XjY/bs1i8U6yDM0oFfJlcq3rBxIqBSvFWAXMtILx8BmG4SZS4JG9IqG7LElZeHN
	 2iDpjPmIUok8w+e/CwfD+o3swOQecNqIwRvBXTY42guSvBd8/ze7lP3JkbsKXtB9O3
	 TAyg72OZRaR83JyacoJzh7Se9PnpH+WrzOybEkBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgCKUpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729288AbgCKUpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:45:10 -0400
Subject: Re: [GIT PULL] thread fixes v5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583959510;
        bh=n1xtT963Ze9x6xcOZWqOv7tuDm8DCoSaevBkcCJj0is=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hGXckjNj7rUYst0+YFtPws0PTbpRwbwvbnqqhefwKsvLBGYyEgfkn2UiVzO4RNObT
         kktpru0jcUml3py7hcu2oXUhGTSeDYkngwCPP8px+oTT6Lgr6w72vXxqvI76GRVnfl
         NZ93KSqjqkXN6aWYz/NkQFSvf/Nb9F5fM10WdWuo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200311154405.3137527-1-christian.brauner@ubuntu.com>
References: <20200311154405.3137527-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200311154405.3137527-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-2020-03-10
X-PR-Tracked-Commit-Id: 10dab84caf400f2f5f8b010ebb0c7c4272ec5093
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: addcb1d0ee31aa1472a7afd31a63162423af9c93
Message-Id: <158395950996.14877.17485207481328452926.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Mar 2020 20:45:09 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Mar 2020 16:44:05 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-03-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/addcb1d0ee31aa1472a7afd31a63162423af9c93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
