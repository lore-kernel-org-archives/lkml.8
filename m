Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA10C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4E020727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589563804;
	bh=Pf1tsLcBs/Y3BpVvvfGVzXifg+Z9+bcZxpw4QrJ9LyI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=id3gs3YSvTgkfCcztWwJp6D4iZm3Ld2xhcrFRMbsdYA4YewReF8IEfNOIhBVl32s8
	 lHMhlMx6QHmqs42UrDebJI25+2ricNBAIEFd2RHKR9OgpcjWJbmzs8Wwyp9bjqQLlq
	 ikIVec7ipwL5gGjg2fsj0eLA63lkCS+zZJFH5Rfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgEORaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEORaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:30:03 -0400
Subject: Re: [git pull] drm fixes for 5.7-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589563803;
        bh=Pf1tsLcBs/Y3BpVvvfGVzXifg+Z9+bcZxpw4QrJ9LyI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JbSmKtd/XmQ5AIi8ZbPBH6mMyyc8kxq/LWls+ufPaaBY5ruQ1qzcoIEwyCi2yrUDb
         54DXtf7F7gAEbWFh8CMdNmSX/DUKxfbJMENJeWCsqxD30x0JEjmyS35WQ6CuQL38fd
         3hm99ihusV1sCq6mVo6m2SKhYqYWISqXCYIwctv0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx=si98hr3_MvAviRZ6LZMUFnFOJBFBk+Lpj3aLQz5M6A@mail.gmail.com>
References: <CAPM=9tx=si98hr3_MvAviRZ6LZMUFnFOJBFBk+Lpj3aLQz5M6A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tx=si98hr3_MvAviRZ6LZMUFnFOJBFBk+Lpj3aLQz5M6A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-05-15
X-PR-Tracked-Commit-Id: 1d2a1eb13610a9c8ec95f6f1e02cef55000f28e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7cea7905815ac938e6e90b0cb6b91bcd22f6a15
Message-Id: <158956380317.31776.9034439701885701502.pr-tracker-bot@kernel.org>
Date:   Fri, 15 May 2020 17:30:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 May 2020 16:12:52 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-05-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7cea7905815ac938e6e90b0cb6b91bcd22f6a15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
