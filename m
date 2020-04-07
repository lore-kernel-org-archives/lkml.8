Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B18C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E859220730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586289335;
	bh=7YL7XPotzRGCWzzchqO5OTCahGneC+7ehXGVZsikb0Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HwvIFAtePj1CBBJIhxoLaySgiOrWaux3TL4XN3Af/YGgshi+IMdBkgziGBU8ZMBYj
	 14xStoJU9mCQejVp6ug7pvzFhbLdXf980voedtG4EQEbcQ3RozVtG4D5DFKprvtam/
	 QaE8uVEnoLSAATD4nti/KtiJkEmZ0+rR4ussHvlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgDGTz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbgDGTzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:55:24 -0400
Subject: Re: [GIT] Sparc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586289324;
        bh=7YL7XPotzRGCWzzchqO5OTCahGneC+7ehXGVZsikb0Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YegKSEKXGKQDH/ANtEDy3qOcj6a9EQ/Ht5XTidZzD+cBFeakk1KA5lDo2Wt4zs3SO
         z76MlW92rSMbwh+HBmnPU1lxFtNqpjYg5vMSL1cWxiaup45YTgEQS7yFcqDGEWe7Rn
         suA7tJfqTUwEGVmqAYQHBBE2QRniRRGwqD24fWYU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200406.112528.895031681027517472.davem@davemloft.net>
References: <20200406.112528.895031681027517472.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200406.112528.895031681027517472.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 255a69a94b8cbbcfef142137b5e7f99b5d168771
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12782fbe0f77dcc36c48de8b0ab36d336620a3e7
Message-Id: <158628932413.3792.18059030227180244818.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Apr 2020 19:55:24 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 06 Apr 2020 11:25:28 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12782fbe0f77dcc36c48de8b0ab36d336620a3e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
