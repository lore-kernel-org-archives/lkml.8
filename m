Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E402EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 05:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3B620759
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 05:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590210304;
	bh=nEpj/nOOCViKWPVZbXZFnL/xS/rRAxHHWdkrAzWw4zk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=D2SBnDNP1Jl3WNvODXhM+6d43LrXI/OUQ73TqFOx5sA9w/XfKEwdrlmDNwUPr4Brv
	 1iPynjRDkyTvKKdyAOCA0apEaz7CgD8uMap0ZRMqHY2D8g3xVXJ1OV0GO4bzJIFofQ
	 /nsQy8RsnKXpUMQezkmUtzf2NGhx8i5Yr8BRU4mQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbgEWFFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 01:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgEWFFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 01:05:03 -0400
Subject: Re: [git pull] drm fixes for v5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590210302;
        bh=nEpj/nOOCViKWPVZbXZFnL/xS/rRAxHHWdkrAzWw4zk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HiEp3FfbFeBDgO4/tPfUL0O8xdlItjqSxFg9XPI7QH1kCtYvTtlWghuhoMpXqljVP
         8TJhOi74hhmhgTZToCBda6igkckTr92Vio0lLZ5AadQomX+1OGLgHg6VZqrKZi1BQe
         qDdnPmLRtCpt5+aCpE6TmgofwmOUeMJz9YQh/OTE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzdB+BSVLCDwpCBLvKOmamqcwUoSUk4izUzBLK-nY2RRg@mail.gmail.com>
References: <CAPM=9tzdB+BSVLCDwpCBLvKOmamqcwUoSUk4izUzBLK-nY2RRg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzdB+BSVLCDwpCBLvKOmamqcwUoSUk4izUzBLK-nY2RRg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-05-23
X-PR-Tracked-Commit-Id: 7d9ff5eed4146bf026c69e766ff630bc0bd555bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a24deb9d68b423f3e5e190b9836d192ee3e0ff9d
Message-Id: <159021030287.8790.17032610237010684826.pr-tracker-bot@kernel.org>
Date:   Sat, 23 May 2020 05:05:02 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 May 2020 06:38:11 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a24deb9d68b423f3e5e190b9836d192ee3e0ff9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
