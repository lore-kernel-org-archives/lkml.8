Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5CEC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E386F20857
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587753629;
	bh=oGYtWO0myYIyjZeo9Jqvu/EFmmZXm1TEha+Yj0s0WQc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lgDL2hkLqkhZFzcWstkdlJ2htCue9dDabERXm1aJyb2D7vUWOLiTIHn8T8o05FgTX
	 1TKf8cWcFNDucXM9MEFlO6nNOFgPP1T2ipUUnJJ2v12IpZQG2mLxLL8+yHpjjH58+S
	 3o+yxEBQtA7cKOIItRN/DIVA+++gjk0zoIqX1b6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgDXSkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728915AbgDXSkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:40:21 -0400
Subject: Re: [GIT PULL] afs: Miscellaneous fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587753620;
        bh=oGYtWO0myYIyjZeo9Jqvu/EFmmZXm1TEha+Yj0s0WQc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hSi5bio/7iNaTmm9YrrxQ/973QH26dTS21KKIyTNdqwhccRX75aPly+ikt99Fk8tg
         8X74fOctGBp5nq3xZ3neTi7GzmS9NUoCZrUdQ0YR+Xrb5bGFKeLw+JAkJCTgyXa4Hs
         NGNrHSKCiELd4NLY1Hg2wSGN1xN4Mw25NtYF98uE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3632016.1587744742@warthog.procyon.org.uk>
References: <3632016.1587744742@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3632016.1587744742@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-fixes-20200424
X-PR-Tracked-Commit-Id: c4bfda16d1b40d1c5941c61b5aa336bdd2d9904a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a195628522c08f36b3bbd0df96582a07ab272bf
Message-Id: <158775362070.26557.15195413938093187702.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Apr 2020 18:40:20 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Apr 2020 17:12:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20200424

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a195628522c08f36b3bbd0df96582a07ab272bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
