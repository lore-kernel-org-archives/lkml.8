Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEC3C7114D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90B02072D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 18:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581792020;
	bh=PHUb353zBW3aeQZgLODzyPPAWvqbdN/NLmw7Yh+qKAY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cpmrNVhvrjPDtNB2HNxXuWPanIaHhbiLsqi/alP2mrt/+r12+ItssDH/MZfvS65uX
	 LOZXl8lGf9Njovmr9QmXUtteM90d3xgSbyRceWfg+yuIf5ekJeKSnGuKeRvXvluVR7
	 Uv/ip1EqPb8b1XV180FimhxCpcSDoVWmRjkgC7IU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgBOSkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 13:40:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbgBOSkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 13:40:19 -0500
Subject: Re: [GIT PULL] io_uring fixes for 5.6-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581792018;
        bh=PHUb353zBW3aeQZgLODzyPPAWvqbdN/NLmw7Yh+qKAY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iA3YISaJodW7nbs2+b1dhfWDM7m0pxnC1YTTMWCG9MS7LPJpdZXGKFxHnoUINnJZ0
         HLP+6TLK7xcObzTKLlwbWIhfxPe+TbzFv70HLW4L0t0QVepSNBz2F4g5iHQJQ3jDUf
         K8pIaPP/a+VRX/wf/9hUoWRvsv4zwwpGcfzC1B40=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d72d51a9-488d-c75b-4daf-bb74960c7531@kernel.dk>
References: <d72d51a9-488d-c75b-4daf-bb74960c7531@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d72d51a9-488d-c75b-4daf-bb74960c7531@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/io_uring-5.6-2020-02-14
X-PR-Tracked-Commit-Id: 2ca10259b4189a433c309054496dd6af1415f992
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca60ad6a6bc4aa88c02c6f103dd80df54689ea4d
Message-Id: <158179201871.28665.3497269847144936800.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Feb 2020 18:40:18 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Feb 2020 09:45:26 -0700:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.6-2020-02-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca60ad6a6bc4aa88c02c6f103dd80df54689ea4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
