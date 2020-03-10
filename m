Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5193C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BB22051A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583879711;
	bh=OiyOwPBVVsas1wr/EMz3KIDf/El4Sdt80DfMU4nueaI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mlGFDelK/hVfCS62A/3MjRwUA42MZiNwuvSQoHhseJbeVAXQ8EBYCovrVMhBcUlxm
	 bkBUhHR3/ocgluSOoHl0dD5mfHZgKqXekX4EcDjhwzd++LMDF4PvDuMmWkZLTuFa2C
	 TsJzHW3rN5tD9hnZt9tU5kK+zDP4fvclpkikYhb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgCJWfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgCJWfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:35:08 -0400
Subject: Re: [GIT PULL] cgroup fixes for v5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583879708;
        bh=OiyOwPBVVsas1wr/EMz3KIDf/El4Sdt80DfMU4nueaI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KzZcV/6pdNuM5Vfj24L6tV5gCNCdVVhFUyIYd6UY7i3kfqf4ftpFgP7WXcL1k0r9i
         /2FtboX6xtBA7rytUsTTMD+ZmcpbQu/Cp7dCvD7tBt2hKZs2rRYfSkEJ6oYJxbfL9Z
         0ufL/w+zbHyXy6Y4VajDQlbMnus5cSbvpBa/8TjM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200310144107.GC79873@mtj.duckdns.org>
References: <20200310144107.GC79873@mtj.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200310144107.GC79873@mtj.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.6-fixes
X-PR-Tracked-Commit-Id: 2e5383d7904e60529136727e49629a82058a5607
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e941484541036ba3652b658ed5536c7bca5bdb89
Message-Id: <158387970815.8298.8296123785213357417.pr-tracker-bot@kernel.org>
Date:   Tue, 10 Mar 2020 22:35:08 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 10 Mar 2020 10:41:07 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e941484541036ba3652b658ed5536c7bca5bdb89

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
