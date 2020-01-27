Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E746C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0150E22527
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580152510;
	bh=h9YPZJ2wnmpT4FdGg1rAZDdugtJvXe2QyoiEvLSqvU0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ivqnoAu5t/nOp4W707MxiHydgmTWhd9niYZaimr1hd00xmje9CLU7o1Jjewk3hT+m
	 zfbCxFYjpRPE+8ljirIeSFJDqGZW8aGhIQP3dVP127IhTspwUhiRuDlaKTtv4lomwS
	 vsTh8F8os0N4Ps1tlSaEnCfTCkgybIi4xwSz2Yks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgA0TPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:15:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgA0TPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:15:07 -0500
Subject: Re: [GIT PULL] HID updates for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580152507;
        bh=h9YPZJ2wnmpT4FdGg1rAZDdugtJvXe2QyoiEvLSqvU0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FBPF1/mLBkbxXM6AAJLioAyJtxRjcM+LEw8Fz6pxgzn0Nd+/wCfzMUGUcrJKAAhaP
         mRaYczdMAhnJIYEvVnsFMtKQMTm+sTubGLHqrZW5wAzxr04SM3Cp9brHB4dlvZEBop
         +lrw2PWmXLnF+MDkBhCFjBWxDbgo3EQV7xBuBxjw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2001271551490.31058@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2001271551490.31058@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2001271551490.31058@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: fef684af392b91ade9c83f7ed0f8164af2aae142
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12fb2b993e1508a0d9032a2314dfdda2a3a5535e
Message-Id: <158015250698.1024.16731796633129787463.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 19:15:06 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 15:54:19 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12fb2b993e1508a0d9032a2314dfdda2a3a5535e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
