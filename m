Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9AFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C4F2465B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580254811;
	bh=tUhXcy5ta6IIU8tmwDqL/iRBsLFREm3taAO1DytlLAg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aOcoiW4IB9hnEmhBQJoz/fSl9wVRdQSJDJQcZLbhPjmQpwoNDC3oZxeO7tqIxq3sb
	 BPqZ4JGzHfVjVlA14Mqazfvt1cph5LgRWeWAUKch6iZHSzBDm2mVew3/eEJ7HC5UoB
	 UptS7OnzKv9NX1x4SDMVMG6JkP3fW40qw86LbAKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgA1XkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 18:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgA1XkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:40:05 -0500
Subject: Re: [GIT PULL] fs: Deduplication ioctl fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580254805;
        bh=tUhXcy5ta6IIU8tmwDqL/iRBsLFREm3taAO1DytlLAg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VTFIwDPQnC7wXIFqKXQ6vGoBwhZkGiQeXpxaeZNXgVq4l0p6phULPaVbL882PX82v
         /5HgDrJ0QQpo8DhBBijslnMwaN4BvVzUgk4qSGkrK7rcIC94Yg6xB7BP8UfiVBjple
         gXRq7S3x8BypMYYwv4GwCfqqKwBMaps3Gl7WQiIQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1580142827.git.dsterba@suse.com>
References: <cover.1580142827.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1580142827.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
 fs-dedupe-last-block-tag
X-PR-Tracked-Commit-Id: 831d2fa25ab8e27592b1b0268dae6f2dfaf7cc43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5f7ab6b1c4ed967fb76258f79251193cb1ad41d
Message-Id: <158025480536.16364.16698686040672279236.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 23:40:05 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 18:19:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git fs-dedupe-last-block-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5f7ab6b1c4ed967fb76258f79251193cb1ad41d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
