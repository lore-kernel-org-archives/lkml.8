Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE7CC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 20:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04AC20838
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580674820;
	bh=GKuUAL4dTjqBl5hx3T3nm07ePFkvXZLt7KTf8eRwp3o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OA9+ymjgOFJ4T8BdJpBM0YWSWUhH/4NQZaVaCEaf9q5sDxAVKPYNv5/togXUy/lb0
	 YN7zzjP7vRe8DyGLm+2lCWws1jgCaJNd6gJh98mCEDJjZ77Dcq/eLR/1Pfbm9JfsOD
	 0DE5iycWhy1u4In+zZjuDfMVa7ofAy87+inDfJ3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgBBUUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 15:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:57266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgBBUUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 15:20:16 -0500
Subject: Re: [GIT PULL] LEDs changes for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580674816;
        bh=GKuUAL4dTjqBl5hx3T3nm07ePFkvXZLt7KTf8eRwp3o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Bg+Jyo/ZmkU1l3edxBYuQ6E7QBsVl4LhBqtRYsLtxioKAXUlx/e5W+b7hfkmbyZow
         8su2y/zALMf/CbqCUdvhr4bfi7ToI+ZuJB1VLtS8sIhUzydGE1wj8XVlLJsFZwricS
         CeFGB+P3YgJ2zGtoesgld0t3x03W8mIBiIvyj2cU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200202190943.GA4506@duo.ucw.cz>
References: <20200202190943.GA4506@duo.ucw.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200202190943.GA4506@duo.ucw.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/
 tags/leds-5.6-rc1
X-PR-Tracked-Commit-Id: 260718b3a35d23fe89d27cc7b5e8bd30f4bba1aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 545ae66582f7627870b719d318954d0252902519
Message-Id: <158067481634.26837.14390277512508430424.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Feb 2020 20:20:16 +0000
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 2 Feb 2020 20:09:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/leds-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/545ae66582f7627870b719d318954d0252902519

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
