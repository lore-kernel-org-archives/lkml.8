Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2E8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3F920760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591825531;
	bh=p+R45FFiAN+F2iO/+uCw8wYLbyqei/KLQiNNDjKCKOU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=g64VuwEWS78yBu8chR16cJSJm4nm4gALWtpizvrdMnttCQUhX/wCwxbS3Uw+d+4cv
	 VVk+BCs5Ys3pScJImi6eLhbH/OJsmOK6ErcS30VAbD6cUAyqUz19WX/3VGMWipHHva
	 4QsMx0turHb6d68VXeVk/YS9L6HyI4ULUWe1LGxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgFJVpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgFJVpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:45:24 -0400
Subject: Re: [git pull] Input updates for v5.8-rc0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591825524;
        bh=p+R45FFiAN+F2iO/+uCw8wYLbyqei/KLQiNNDjKCKOU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hy/AlBNe5+pwxGLo1Oh91ZPNPkIH5baHYQ5VLpT11vYoiiFmbyXicW+oBhBAA9W+0
         jVZNl1r9Jj9faVOIXizbqRaxhZyjXoBBVwuRF7GipXl75VKpcq27AXVg/Em+qjTaAz
         a2JnPmO8Q7sH89hGwMAK4+D+f5hF057dn1sjUebc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200610044748.GA177775@dtor-ws>
References: <20200610044748.GA177775@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200610044748.GA177775@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 751ad34fbad74c3ed4a9ede24764b4253d4faa84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49f13b0921aaef0d5519358fd9fcc237c1c9124a
Message-Id: <159182552442.4867.16564912340186600303.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Jun 2020 21:45:24 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Jun 2020 21:47:48 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49f13b0921aaef0d5519358fd9fcc237c1c9124a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
