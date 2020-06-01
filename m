Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAB6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60EA2207BB
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591055704;
	bh=MoUu60NYsXeP5Uag9clrWlvwKZqqibA3Qh+X93+U7ac=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qqA+rFGk5+gfOLb+JkrZcZRo3I/DqtfnIrWV5l8SFzIs53RJIjC9dM+fX0n+ei6wA
	 2pw7hW3hr8nnFD+uigg7H3uP/WA/K1KlLkPwZVDaBuSiH0GE377Vj7KsSY28t7+6MH
	 4Yok6MeuvORgRiXcpPZSMoKp/ROChBSfz4+FsQps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgFAXzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgFAXzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:55:03 -0400
Subject: Re: [git pull] vfs patches from Miklos
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591055702;
        bh=MoUu60NYsXeP5Uag9clrWlvwKZqqibA3Qh+X93+U7ac=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=il0HK6KmJ0V9W4qmDDejd5+wkS0sgWiwh5/BjEU1T2V2TwOuN/hTsKYnJmImEhsFp
         0l8QkKGH85hP/G3JZCWIG74XkihgUoguxS7nCO42XqcF7u/YfS33B3ZVDdTL5P3T7B
         3uu9rYJNvbkUmaHwm0dY2yWXPs6UWR/1V3d0GzMw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601184036.GH23230@ZenIV.linux.org.uk>
References: <20200601184036.GH23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601184036.GH23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git from-miklos
X-PR-Tracked-Commit-Id: c8ffd8bcdd28296a198f237cc595148a8d4adfbe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f359287765c04711ff54fbd11645271d8e5ff763
Message-Id: <159105570255.29263.11096578901806814897.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 23:55:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 19:40:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git from-miklos

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f359287765c04711ff54fbd11645271d8e5ff763

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
