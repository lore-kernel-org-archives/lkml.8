Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489F4C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2290E20777
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584724535;
	bh=BMlDDju+7N4ql4KauIYLPY1ecNi0BOVA6ax7v2sJXJ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BW469pWEwNJTTtItg8zRQB/6gHnp+BKd+EUm9FmDHY+YCGwJZWK43kxFrX/GYNywn
	 RFHJXjpPUMBSIA6uWOBiNTR0he9B8+W8CcTY8/EgRy5fbv99nQGcSJ43umHqK7QHpr
	 PE2Klke11tF2aelVnu511/DIJKRsdf0CGkOxQHYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgCTRPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbgCTRPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:15:10 -0400
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.6-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584724509;
        bh=BMlDDju+7N4ql4KauIYLPY1ecNi0BOVA6ax7v2sJXJ0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ocqpNAVtyShLUdjrqZ/eCWyYpI0QjSGYPfDrOcZBr9Q1P9Hpd0iDivlc6DDeZR/2G
         nunFqWPs+8QAP8WZGHzfkvgW65YPC1jB8pJyCAGOGBTl7RouKRVZFQgSjcizw4z7Gm
         XYgkhnDgVgOXmOuJpNsbrjaakuLp/UT6HieN8jS0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200320142758.GA760533@kroah.com>
References: <20200320142758.GA760533@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200320142758.GA760533@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.6-rc7
X-PR-Tracked-Commit-Id: 14800df6a020d38847fec77ac5a43dc221e5edfc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bd14829d3275d96ff723a6c57429e9238117779
Message-Id: <158472450942.23492.17753241722400520969.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Mar 2020 17:15:09 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Mar 2020 15:27:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bd14829d3275d96ff723a6c57429e9238117779

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
