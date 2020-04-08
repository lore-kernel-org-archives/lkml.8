Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86729C2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC8A2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586317228;
	bh=R0FPu+moxhWt8pZumzMJx9MRf6efiK+/hdISliL9aIE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gYCHgeRXEB4VJy7dmlIJW7/e9IA7HDzuUfxps1gkkuNQhEAA2TZyo4PVMTt6Fwi42
	 LHwhNl5iIOthERMfnlt3L/guB2WTpoBSevPld+aHzuFkCbvMQO2cpDQxCga3pMMxHJ
	 f41la4EmvsS8glWb3zN2WYwNRVXBpzLhVNA/kVpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDHDk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 23:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgDHDk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:40:26 -0400
Subject: Re: [git pull] drm fixes for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586317226;
        bh=R0FPu+moxhWt8pZumzMJx9MRf6efiK+/hdISliL9aIE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X6baiEe2uIcfaCOf+ITNhkiDNdWLmsPzzm5iocngBZVPDUO/N9s2JTXe5RaFetY+b
         xB/6419wf6rSqT3RJTq0XQD6Fc7kp0/plBieOlpJ8MHvJitnshjSRIEv3KEGyyVr+e
         XGIEzTIwfwWMlAfaQOm/bE4NlY/eYwaF1e3jCie0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzqR6HkM_XyijcKozqfh-WXKRWhe+Ay7mwA0o3kSooOEw@mail.gmail.com>
References: <CAPM=9tzqR6HkM_XyijcKozqfh-WXKRWhe+Ay7mwA0o3kSooOEw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzqR6HkM_XyijcKozqfh-WXKRWhe+Ay7mwA0o3kSooOEw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2020-04-08
X-PR-Tracked-Commit-Id: 12ab316ced2c5f32ced0e6300a054db644b5444a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5e94d10e4c468357019e5c28d48499f677b284f
Message-Id: <158631722630.10073.13307037756719527646.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Apr 2020 03:40:26 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 8 Apr 2020 10:49:06 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-04-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5e94d10e4c468357019e5c28d48499f677b284f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
