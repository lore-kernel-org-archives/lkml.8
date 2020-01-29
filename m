Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8020AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC68207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580327407;
	bh=nrPAgHyyN9hZlixY0jaZ0L6peSuxsY6p+ORYuEp1f4U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=drQtCBWV5IRob3H2aSM+56HlGqCf2XhCr74IatbBibZRtrIuowOUD6uDOBjfrtyi2
	 mCjS/yWgBjIrrD/4y3mPkeh2WpRzLbVnaNQrJvDlojoMVNaqqdirf2pEfcH1e5V5cO
	 GsOFGCYyiHbfzfPeprkbzFTehaTwZ5bh+ITylb0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgA2TuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:50:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbgA2TuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:50:03 -0500
Subject: Re: [git pull] adfs series
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580327402;
        bh=nrPAgHyyN9hZlixY0jaZ0L6peSuxsY6p+ORYuEp1f4U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gxB8mkO0OvvCNYl0zmxFcqFTiOmGb7wn0kD1Zp1hGcW/7eo5norruIVQ2qmHe1hIf
         q3fqIL+R/AzlV09KbJZO3Y03BMOTj1jHaSc4IeJAFgmdcJK/6w7/5k3rpaVHMQdeM5
         ZsxqGLYxCy5Jxv2Firppka3HlfhmELx4LJQFpr3g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129142857.GY23230@ZenIV.linux.org.uk>
References: <20200129142857.GY23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129142857.GY23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.adfs
X-PR-Tracked-Commit-Id: 587065dcac64e88132803cdb0a7f26bb4a79cf46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5307040655d0b8d465a2f54d9c67be5b3a780bcd
Message-Id: <158032740285.31127.17722666730246602075.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 19:50:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 14:28:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.adfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5307040655d0b8d465a2f54d9c67be5b3a780bcd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
