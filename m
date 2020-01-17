Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86785C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B98217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579279504;
	bh=fVE+0N0oojmzHgj1pK+YMOh+N14ezNYscrWVCJbH5Z8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GurdFC8Cx+GFaXmJcN30q3B4QmUoRsYRivfOJ9kH/JIsVx2s6wnpEgH2KcLaKUjS4
	 ZpuRWzgaFRAXBQe6tAjBRDOZWXQWIGedAh0xP5AuOkVT/OPJBzjdq4Yb7aORPI1AmJ
	 7AObIGbW8wjrpDdUhESBuF+K+zmTBCPK83Z4PvOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgAQQpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgAQQpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:45:02 -0500
Subject: Re: [GIT PULL] fuse fix for 5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579279502;
        bh=fVE+0N0oojmzHgj1pK+YMOh+N14ezNYscrWVCJbH5Z8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b4UmKhRgLBtOjcfBo94Dwi3Nh0xLbjvkoQa+yWUuEwn85lSFuGpbMEWHRNeC0EQAC
         aPUaORT5ALKEnrBJclXrkjDYxpebgyrjthFj251FS0zpnmhxq/mqLveqy9lCkYBAAB
         AW1hH104ow3ttrC10B9xRCZhIPcbgaquaQGNG9IU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200117123243.GA14341@miu.piliscsaba.redhat.com>
References: <20200117123243.GA14341@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200117123243.GA14341@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-fixes-5.5-rc7
X-PR-Tracked-Commit-Id: 7df1e988c723a066754090b22d047c3225342152
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab7541c3addd344939e76d0636da0048ce24f2db
Message-Id: <157927950223.32282.1633384377186078257.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jan 2020 16:45:02 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jan 2020 13:32:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab7541c3addd344939e76d0636da0048ce24f2db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
