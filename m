Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C2DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED50A206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591389624;
	bh=rEGORoeksA8fO+PraH4iuyDytBuq2byBAz6zP1JOL8A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0BZd5tO38Sz+GgYuqDerFGvv++4NUx+eQCAwEVn1uu5YchMFkGFiW8zaqUNJZqq4Y
	 xDGZoIma1ikp39LrncaYwb1FvyiTSy9N5reqTz6FJlDhbCeL+pwq4LwHUI/yMynglD
	 0zvhyWqaisqwL24IYpmbBmWj1PvVwswOgUTMb1vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgFEUkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728521AbgFEUkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:40:15 -0400
Subject: Re: [GIT PULL] Modules updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591389615;
        bh=rEGORoeksA8fO+PraH4iuyDytBuq2byBAz6zP1JOL8A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wq3OAwdWBF5LbarUuk3n4RsrJy+DdYaA2b/CS1QY7jXJ9NvKDiaq2pQby3wfw/hew
         I9gc63yJU8P5fQx1ghMFG2sIXDbTYNLFfhQwwaWxJC133T44cLWMSH5DERouBNK/Xq
         Rl3ztcufUBkJlbSalTYtqTK6VP178PAW7c7h16aA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200605093354.GA23721@linux-8ccs.fritz.box>
References: <20200605093354.GA23721@linux-8ccs.fritz.box>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200605093354.GA23721@linux-8ccs.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.8
X-PR-Tracked-Commit-Id: 5c3a7db0c7ec4bbd5bd3f48af9be859a8fa3e532
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 084623e468d535d98f883cc2ccf2c4fdf2108556
Message-Id: <159138961521.17917.11281954351584835389.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jun 2020 20:40:15 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Jun 2020 11:33:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/084623e468d535d98f883cc2ccf2c4fdf2108556

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
