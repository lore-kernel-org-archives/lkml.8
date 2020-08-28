Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5638C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A61FA208A9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598644722;
	bh=hNSpkX8O6rpH/6N/ZJ43Lz813yGy+C6ef9k8pd3Wkuk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=m+t/OMhRZ3gc353tFd3jw0go0/peZ52Hu6a7DG7Cx1KaRkgLS8FRmd6LgiX9SL2TM
	 txk2kVj4T2j4L1LiVB2UThM5xI9mIqa6akdO6ct2R+cu7lBKwHJ3uLWiDgp1usP9Q0
	 5dG6QdzOfmL8KklmjHBMAp7fAQv14/hmEcJP+Eww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgH1T6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbgH1T62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:58:28 -0400
Subject: Re: [GIT PULL] gfs2: Fix memory leak on filesystem withdraw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598644707;
        bh=hNSpkX8O6rpH/6N/ZJ43Lz813yGy+C6ef9k8pd3Wkuk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=h5J0yTcWm+yBlbai5b+dVC7JZkXCjm+q9W/yhKOA/QgH4zKm/vXV2G/8CwCogRaSs
         KbWbtdVtXNAGOxFt5FDRNfGIjfMuiEqZs7BqyKSWjHAT54GijJJ6nHfG3zxJ1Ae5w9
         otSSxaDeRCVVdYdnl7AoBsH2hrccJTHXhKRCqJxI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200828133233.1147149-1-agruenba@redhat.com>
References: <20200828133233.1147149-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200828133233.1147149-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.9-rc2-fixes
X-PR-Tracked-Commit-Id: 462582b99b6079a6fbcdfc65bac49f5c2a27cfff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40129b8cb41704c98901e08c3edf8224b8af1b31
Message-Id: <159864470779.31636.16376200262996849061.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Aug 2020 19:58:27 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Aug 2020 15:32:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.9-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40129b8cb41704c98901e08c3edf8224b8af1b31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
