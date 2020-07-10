Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32046C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D12206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594345207;
	bh=i4HIRRheC66Dla3cyYkRyLg0MIuXZImCZW/QuJUVC00=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gS6n6loChZSiWyPH8h/+8LVUPkJzhOwINCmbn6xZep6ldgf9UmCc492vuTGoEhgQ9
	 liwx84MV7sqWMQvdZ9KUtRrCFrjylH15TDEHUt76moBX+FFucUWhFl2jt1qjKrQVMU
	 PIN4/rAXDYb0g31WK56jwKeNOy2r1b5F6T/pLt80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgGJBkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgGJBkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:40:03 -0400
Subject: Re: [git pull] drm fixes for 5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594345203;
        bh=i4HIRRheC66Dla3cyYkRyLg0MIuXZImCZW/QuJUVC00=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fKk+mEuG6gNtiLsL3N0AVSDu5xFhBbFlKjlPdUJR1jiRspEtqMBvmKqbimBUdHL4H
         JDPE61YxX/tEHZpZcdcLOw7JebFguH4mUInraQ19Fm+mmNORH06ecWYIxjHFI1qHV0
         4/0y/wNreclsFXyIwO+1sMiGnt0REGd0BcVbMZYo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzAJTvCx4_2o1RyK78n-Sr6MCByLTF=_P8mhDntxf4v4g@mail.gmail.com>
References: <CAPM=9tzAJTvCx4_2o1RyK78n-Sr6MCByLTF=_P8mhDntxf4v4g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzAJTvCx4_2o1RyK78n-Sr6MCByLTF=_P8mhDntxf4v4g@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-07-10
X-PR-Tracked-Commit-Id: 38794a5465b752118098e36cf95c59083f9f1f88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42f82040ee66db13525dc6f14b8559890b2f4c1c
Message-Id: <159434520350.26610.12870276466678802161.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jul 2020 01:40:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 11:13:41 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-07-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42f82040ee66db13525dc6f14b8559890b2f4c1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
