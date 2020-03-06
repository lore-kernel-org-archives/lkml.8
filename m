Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C989C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CC0206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583533207;
	bh=/OjKbsdDosmkYw5qMfoveQTi2Qaoij2tQEr59zWCVd8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EnND2m1vLcyNfFFwntM61H77r2LiNmGysnRdWiQZA2J0hFFuZGUmWc3SyH8mVSrAB
	 eiyhcWtPiP0WYFVKGopRq8ve7/0PBBlM0gMH4q8BdjOEHv3w1vbvG+JCo8ZDchwrvJ
	 Jvl0HkthGkwoblTflGqDtq+6tq9OyJvpUEjKnKCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgCFWUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFWUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:20:05 -0500
Subject: Re: [PULL] drm-fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583533205;
        bh=/OjKbsdDosmkYw5qMfoveQTi2Qaoij2tQEr59zWCVd8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Pbi6qkzAYIIdmfQHODB7Bvo4/1JJfHKiV0N/cJV5TLkz+thR02bdEZ78/me8syiui
         aiAwxIhWH5OIVNHhbL+NXwVrOsdKlN5ImCHd7CFTeiTz60XbS8Ijool4IVT+fGye77
         AqNu159aIPQiwjgAkccWXyVYL0IcPedHai3vlFmY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200306210854.GA638432@phenom.ffwll.local>
References: <20200306210854.GA638432@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200306210854.GA638432@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-03-06-1
X-PR-Tracked-Commit-Id: 513dc792d6060d5ef572e43852683097a8420f56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f501bb1802dbbf1467e7999954588da31f635ad
Message-Id: <158353320521.11032.15552999513812279872.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Mar 2020 22:20:05 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Mar 2020 22:08:54 +0100:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-03-06-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f501bb1802dbbf1467e7999954588da31f635ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
