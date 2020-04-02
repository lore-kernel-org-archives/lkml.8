Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2957C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53792078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585859105;
	bh=9zKOneaNbe3WFi/I+f8XBuM9GaHulXKcXFpHcHNYb6Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=iAHory2YBXefiVWI8k5hKYG1+t1wSts2sIGQBJHvupRlv9HVEgN/WNYt17dKGf58V
	 wortOgJZsJKdImudDaTrFiByx+9+7m9AJjSr2+z5WE2HiaWKHeIW9zQbhBi+QnFnCc
	 AVQnZ9FkaHfBJZcuJ+poSy+wiS051PObQQULU6Po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388755AbgDBUZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389588AbgDBUZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:25:04 -0400
Subject: Re: [git pull] vfs.git pathwalk sanitizing
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585859103;
        bh=9zKOneaNbe3WFi/I+f8XBuM9GaHulXKcXFpHcHNYb6Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2Kbyk5kEr9qCIFWWdFsWNJ5o2MFTvzHn6sH0EFPFWXq9Szr8w6sIWgkUZ7i69uOvJ
         fICZCY4cmR7LqNQ6uzaUNHcmPAH/AtFz9AusgukRHK5wjnTkecKKzgLo5oLdGRF7R9
         WnnxDumetJa8QRPGQlAWadpXJ8wWfVntgUzvreoA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200402052414.GE23230@ZenIV.linux.org.uk>
References: <20200402052414.GE23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200402052414.GE23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dotdot1
X-PR-Tracked-Commit-Id: 99a4a90c8e9337e364136393286544e3753673c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c577491b985e1b27995abe69b32b041893798cf
Message-Id: <158585910370.7195.18418854991270255576.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Apr 2020 20:25:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Apr 2020 06:24:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dotdot1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c577491b985e1b27995abe69b32b041893798cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
