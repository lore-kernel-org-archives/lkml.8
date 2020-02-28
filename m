Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0606EC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08F6246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582869611;
	bh=O0lItgxGsadBxEBFcdX7qF0516IN24GExKcYpPLQ50o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rxYUJQMk3cwlJ5KQO1i3G0ByH+PH7bjs8vdF9hAENbfVaTmcjooXJLJB8ryDSpvt2
	 X4QDqdcxr2afmO6y+8t3MlFJuGkLq1dpH8nq3O6idpbeAx/CeZrvjsAVYFgKKF9NNu
	 t2EMVmLo85X9VEteOAjbENamz4IhpUv/ZoiqM4KU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgB1GAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:00:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgB1GAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:00:08 -0500
Subject: Re: [git pull] drm fixes for 5.6-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582869607;
        bh=O0lItgxGsadBxEBFcdX7qF0516IN24GExKcYpPLQ50o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Jz4tyufQn4566NNmpUnuwFoyUBYsNW385azRjBLysyRZ1kMYLVE1eGKsLZgfazb0J
         wjTgItrCKVekXrX3NdE1gn4V+szyj0giED/ye37WVZ0NGHvdqFWhqWQ6poeiODH5+P
         CVxU1lgzsQCZ2U2Nzp/k80+0yu179G4WUrs2Kzl0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tya9tFH13gF8AyOyP8SLMB-wyUNxBen=NY2ik9hr1Brjw@mail.gmail.com>
References: <CAPM=9tya9tFH13gF8AyOyP8SLMB-wyUNxBen=NY2ik9hr1Brjw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tya9tFH13gF8AyOyP8SLMB-wyUNxBen=NY2ik9hr1Brjw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-02-28
X-PR-Tracked-Commit-Id: f091bf39700dd086ab244c823f389556fed0c513
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45d0b75b98bf1de4b3a5b09188c75f3bfa3152b0
Message-Id: <158286960784.11613.5194916749172956851.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Feb 2020 06:00:07 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Feb 2020 15:22:04 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-02-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45d0b75b98bf1de4b3a5b09188c75f3bfa3152b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
