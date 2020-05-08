Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A60C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D8C2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588954512;
	bh=d46ujfpGRWTnHTboSWH9jDVt53w/tc7Sract1IxbE8w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pSrIX8XbBzzVLYzgDPGtQB7VsVtMALAG1KX7dUlYP3tjOuA/q/1K7g1msPcpJtmkF
	 IeMO9o5YnMmBqlzm8M44HJ1hqpukegIJHv60lK9kWYEAq4OnO31JVpAk4q8GT7OjPD
	 Cd4kznT1uByEP1hO072DH6B/nd40c3sm3ERu0atk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgEHQPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgEHQPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:15:05 -0400
Subject: Re: [git pull] drm fixes for 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588954504;
        bh=d46ujfpGRWTnHTboSWH9jDVt53w/tc7Sract1IxbE8w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=faXGL+0oOb+y5q28u/WXmvgT28QIwxfUWOLsmJ9Ho66p3lRMAlzXKOLEgaZkt5j86
         IX8w/cAyODuwRQ20QzMxrtOtkn5QqLzpW6ez49LYb4GKfE/OdDkr2jGhzwTajjH0tO
         fzG5cHkxIYJTGy9OI1TwpWkyTN+3P6VSgMaU4nlQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx_hR6GYxb6zSm4Z0XMExZ0BA1NJqR8bDy5k4Nzd4xwtg@mail.gmail.com>
References: <CAPM=9tx_hR6GYxb6zSm4Z0XMExZ0BA1NJqR8bDy5k4Nzd4xwtg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tx_hR6GYxb6zSm4Z0XMExZ0BA1NJqR8bDy5k4Nzd4xwtg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-05-08
X-PR-Tracked-Commit-Id: a9fe6f18cde03c20facbf75dc910a372c1c1025b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 775a8e0316bd5443a0f3faf771b1bdfb8f8e8342
Message-Id: <158895450479.20886.12327739213066146506.pr-tracker-bot@kernel.org>
Date:   Fri, 08 May 2020 16:15:04 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 May 2020 15:23:50 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-05-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/775a8e0316bd5443a0f3faf771b1bdfb8f8e8342

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
