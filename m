Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C314AC2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD4621744
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586551249;
	bh=oOv3CwkEyko+fCDnzl6l3AQqecpAY+zpIP5adfq6H64=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=H7zxaefugj058ippRZWsDM8aI6UYumrNbvvsL6EmYpsDfqtXSU+fVKb1cuGKcNR0U
	 HjTnOruviGJKO2tQ7RsF1g4dEMK2wh0vxG4w8zbDxp8lKoIzYq8cnGyJ4HUA+Y9eOL
	 B3Nq0/G/yRbM5uNJae8OGWxNr3JdnULIb9xGmK6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgDJUkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgDJUk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:40:28 -0400
Subject: Re: [git pull] drm fixes for 5.7-rc1 (part two)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586551228;
        bh=oOv3CwkEyko+fCDnzl6l3AQqecpAY+zpIP5adfq6H64=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qo1Aamm9MLkerDjrfH0TN1IkTpjaIj5M33UKUZBSd+/M6dsS993ypkgTVtS3iE5IN
         gEOr4Gc7I86OmYWEVBCO9ystrXU0XKa6y7Mt4dcw9bofRCgBvhhJo/oO15Ob9kyCPn
         noTGHGRp2N9dpDW+Y9TQNM0sGI9u2pRZbVRmH2Bk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw-uwox1_LrO_9S=Fh_E+Syc9G2EtV9CehKvYWcKEMY+g@mail.gmail.com>
References: <CAPM=9tw-uwox1_LrO_9S=Fh_E+Syc9G2EtV9CehKvYWcKEMY+g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw-uwox1_LrO_9S=Fh_E+Syc9G2EtV9CehKvYWcKEMY+g@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2020-04-10
X-PR-Tracked-Commit-Id: 74bd4f0c921cc9cf5f99ba4129dafe35496de6f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21c5b3c6d7579944d21ff268f241d6bec425a9b4
Message-Id: <158655122825.24997.16162177415615172004.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Apr 2020 20:40:28 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Apr 2020 07:10:29 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-04-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21c5b3c6d7579944d21ff268f241d6bec425a9b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
