Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92751C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1512072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579888812;
	bh=Nubgd0VnKoemhsq3MYyl9oVwFq/tKKocTSnqxjr2ugo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wCvbCwt4hdjpIxILm+zoZFrLbdd1BMCaw7FPu5j/lLrbDEIpLNZ55HH6utdfTh+Dr
	 NqOnHbjtNgDcOKfs+1WrTJ5cs/gmjKLjcGk8cYDEIPdC2+DFGT2uazMECJySOU2l5I
	 vQhpZdCPG25Ex/LSx+/5xM4IqJZFNScCeXpbYQrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391075AbgAXSAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390538AbgAXSAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:00:04 -0500
Subject: Re: [git pull] drm fixes for 5.5-rc8/final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579888803;
        bh=Nubgd0VnKoemhsq3MYyl9oVwFq/tKKocTSnqxjr2ugo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xzAQYkoSgymiCK+fx7yMP07TZEghDlGzoTPa65lnZnzPrIBNyHlYlN+bqNIJYjpSo
         JntS324sCNy9W0QHjgFE3bK4TtBBXfR8vRxjXHCGkALk472FGV5vjm7QYC/38TVyXR
         k1DaXM7BNTHQk8iTqrtB97CpWVx8ePtlN++4k5o0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty8zJzPMuvaO4=AuvviKjqMO-VXbZgs+f93wiPFFhg0kw@mail.gmail.com>
References: <CAPM=9ty8zJzPMuvaO4=AuvviKjqMO-VXbZgs+f93wiPFFhg0kw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty8zJzPMuvaO4=AuvviKjqMO-VXbZgs+f93wiPFFhg0kw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-01-24
X-PR-Tracked-Commit-Id: 49412f6636bab17dbdc25e36d6482013e4188c88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 274adbff45e3c26c65b2e103581d2ab5834b0b7c
Message-Id: <157988880389.9531.3140625412730040133.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jan 2020 18:00:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jan 2020 16:03:04 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-01-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/274adbff45e3c26c65b2e103581d2ab5834b0b7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
