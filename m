Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B22C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E61DA20DD4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599252638;
	bh=PvB4DkPOxFuGOgSWUOxsQjmURrkgJbD47BnL0h1Yo1Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rN7oGXGKd64zmsnsBNVgl2q7OhhZTwlJPdeXQotb8aSfgmA7Rty6T64qYCZNKg17e
	 sT9vh46ASsytXks1qjL0KtP1fv4z73rOCbMNFYc21QOHlJ6SEIPk9fgsZmKr5Hd5PA
	 ff4aETM8e5l3uP3/DQkg72jjhwF7Xg5QiGVqbC3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgIDUtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbgIDUt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:49:29 -0400
Subject: Re: [git pull] drm fixes for 5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599252569;
        bh=PvB4DkPOxFuGOgSWUOxsQjmURrkgJbD47BnL0h1Yo1Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dQgtwbhlhAOqt+rla2zTnqRD85WBxkOzVZhsgeEg7Gcl3oIN6sqna/Y7K0v/E1tCd
         GPxD7R5uXm4r9Jm8wctWnnyObiFBCDmrNw1qqqmYCTvKCoNrez3ERV4lMFJgqfwKXB
         hHBHb0Y01pk/Eb2z9rGeqtHHAv7YjWY75yAk0l4Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz0whDeamM+k_8Wu8TVzz0TDr+qMNMXo8rKeeNRKxBuiQ@mail.gmail.com>
References: <CAPM=9tz0whDeamM+k_8Wu8TVzz0TDr+qMNMXo8rKeeNRKxBuiQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tz0whDeamM+k_8Wu8TVzz0TDr+qMNMXo8rKeeNRKxBuiQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-04
X-PR-Tracked-Commit-Id: d37d56920004cae612fa32d1f92aaacca5e145f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf85f5de83b19361c3d575fa0ea05d8194bb0d05
Message-Id: <159925256932.25529.13873694892912208460.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Sep 2020 20:49:29 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Sep 2020 13:52:56 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf85f5de83b19361c3d575fa0ea05d8194bb0d05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
