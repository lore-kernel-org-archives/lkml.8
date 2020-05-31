Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68E0C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C46207C4
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590948324;
	bh=Z7PQ+Jkh6/5WQIVbuvRh+SBbrgs4k880MmH6EeewDGQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SKSZ4/mRGrwjCsByAeSkdHeKEecc4Dgf7bAiQfi14Q/0TMh2g27gRkPCFeEGGTjmU
	 tvDpeeDD1pLrpWI4M0FbS4IGdh6wR63DiIaoZ8OB1b8dvQMRrZnqn5/MavCV1x9TXT
	 Ds09onY+Y4+T1dT04Y1Y+OmVIGQOBBXpPrZXKBpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgEaSFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 14:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgEaSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 14:05:03 -0400
Subject: Re: [git pull] coredump infoleak fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590948302;
        bh=Z7PQ+Jkh6/5WQIVbuvRh+SBbrgs4k880MmH6EeewDGQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kf1luaZTPpNuCGdGe0TSTi/VVaIuPyeqM4oPy5MB75rDg58cG0S0FheDUM8b9JHKj
         NdHrJ1Gifku36LLC65YupxMkgtxffsttX5tth/e1La2XKu5rNN7d41hrMS/DwtxhYi
         vQ5RjfO61a6xt3xqLWE22mizxc010bKdJ+xD/CA4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200527213447.GH23230@ZenIV.linux.org.uk>
References: <20200527213447.GH23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200527213447.GH23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 9e4636545933131de15e1ecd06733538ae939b2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa61b7bb00f7c0738823237a06161d568442b93c
Message-Id: <159094830265.9121.9364144659983285973.pr-tracker-bot@kernel.org>
Date:   Sun, 31 May 2020 18:05:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 May 2020 22:34:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa61b7bb00f7c0738823237a06161d568442b93c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
