Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7B5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A61F2076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591642838;
	bh=20GOHEGnTLHtKSes10YWvIXaEGpIcgRIsG6BC5LEk9w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=c+sDcoZpqqDA5eXQdI9/qR3kKVtrXlaZD+K9EjiMrYTUW6GTHft2yUKRnvTTKuCNw
	 B1SkoHp2H1tstDcmzHczl/zsDfb3/Ih/M36qnxdQM2mM+CqIlRfsrsbV/FqEJekXIs
	 Fj2kbAG5bBJMhsweo48q6gfEeKi50cB6uGpQaDh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgFHTAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgFHTAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:00:25 -0400
Subject: Re: [git pull] drm msm next for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591642825;
        bh=20GOHEGnTLHtKSes10YWvIXaEGpIcgRIsG6BC5LEk9w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=C/lwrc3OZrYGmQVDt/SzfsGuf5HUY7W91Il40py5kURUR4mmzUxmQG6/qK2L/6k2g
         EqsXpm5DUn2339scNmdPwTW0rOS7On59UD21WjWxIgXapm1b+qIBf7tcaaPh1qVwD5
         AZr85DVbJ92YT67o40Y2WZeNLxr6ukiQHW41cEAE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9two=B8nCSP9+9x3oGM9HUm0dDk3aY=ePUuVeh6530v94Q@mail.gmail.com>
References: <CAPM=9two=B8nCSP9+9x3oGM9HUm0dDk3aY=ePUuVeh6530v94Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9two=B8nCSP9+9x3oGM9HUm0dDk3aY=ePUuVeh6530v94Q@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-msm-5.8-2020-06-08
X-PR-Tracked-Commit-Id: efe792f39ddbc6396b9142afff97855ee357b492
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9413b9a690ec8aeaedea74bb875079d36f295304
Message-Id: <159164282533.16000.2743885630055800944.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jun 2020 19:00:25 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jun 2020 13:33:51 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-msm-5.8-2020-06-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9413b9a690ec8aeaedea74bb875079d36f295304

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
