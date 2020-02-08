Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A27AC2BA83
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 02:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B9F20838
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 02:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581127510;
	bh=VKwMrEOjf+pbAryXenvt1O89qe/OGTtrGybNATBS8eM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gWLnywAUe3DPuO9HukUWfH0KBM7YPoBornlj7H9rKge+rCByPKCNTC75dooUDjIgK
	 naBMiu87AuKKPS4JcUQlnYdJbByu5hEfDIGcb48R3TY8GpoXUDmA1IXZ5DCR/u01cl
	 cjkgcaf36Uc0CjkP6lc0QI8ACzkmGaTAnn81rEBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBHCFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 21:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgBHCFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 21:05:08 -0500
Subject: Re: [GIT PULL] fuse fixes for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581127507;
        bh=VKwMrEOjf+pbAryXenvt1O89qe/OGTtrGybNATBS8eM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qBXDwPtpErz1qFtn7h9wsDiZ71eWkIFWG9ijWEQiRPmVDUSGd4WeY3jgn744fbgUu
         eySPXTf6U3Dyu+5DIkSCVDwtVSb8JywN4lWJH5UxtCQIwbbqzL0276hujM9SAn2kb+
         zZPAl1aJiRfLzvzcsJYsB05zUbfVGKgtucdiUpZU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200207153401.GC7822@miu.piliscsaba.redhat.com>
References: <20200207153401.GC7822@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200207153401.GC7822@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-fixes-5.6-rc1
X-PR-Tracked-Commit-Id: cabdb4fa2f666fad21b21b04c84709204f60af21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f757165705e92db62f85a1ad287e9251d1f2cd82
Message-Id: <158112750750.31333.3995407389947059932.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Feb 2020 02:05:07 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Feb 2020 16:34:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f757165705e92db62f85a1ad287e9251d1f2cd82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
