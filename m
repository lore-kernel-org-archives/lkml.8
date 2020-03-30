Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D299C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0466220733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585600829;
	bh=NQ1k3fWVPvg9NnSMJ7beNEYSjM1Z/sjqcheZX8FpXkk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=e1ry3NSWyUM2y23GPDryGA8nRsxZRNlgtqUNevkuHZQ+KUe03BvwLfBQ7Tkqjd0OZ
	 GyNIz3JkkRDkSXdx1ZDrDtw1w7FHr8xz8POTCpIY+yvutlHVB0+i5Q4i9O/GKpGOau
	 kDQfD+BmsNa5WMrDftF5VWcU6kp82ICvBLJNwS70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgC3Uk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728777AbgC3UkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:40:09 -0400
Subject: Re: [GIT PULL] pstore updates for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585600809;
        bh=NQ1k3fWVPvg9NnSMJ7beNEYSjM1Z/sjqcheZX8FpXkk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fuZTR6xXWpKO9JOWmBd2ZSxjLHoGw1BYRkbfibQT64eEUe1eN1Lb9A2SBuLLRyOXK
         jIjdzmXwR0EId/VSGfz33Hyie7gpMlyNwiQfa5hGbi78oMUg4s9+rqNUK8J2efdRTC
         cuFYpAIIEGyqKnwA0YXrCcoWgsH1Upb4HgpZv1HY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202003292120.2BDCB41@keescook>
References: <202003292120.2BDCB41@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202003292120.2BDCB41@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/pstore-v5.7-rc1
X-PR-Tracked-Commit-Id: 8128d3aac0ee3420ede34950c9c0ef9ee118bec9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c271bdbf38e03ea0c19ce0041c1eaefb42227110
Message-Id: <158560080947.3259.16025577198813919075.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 20:40:09 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Vasily Averin <vvs@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Mar 2020 21:21:57 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c271bdbf38e03ea0c19ce0041c1eaefb42227110

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
