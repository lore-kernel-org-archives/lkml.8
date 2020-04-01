Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3797C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB214207FF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585780526;
	bh=EyhDYKYutDY7xJzUZP7IFXMKH2P0GjJOxUJbcxEI7Kw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=J7WDpUmsVNiDuTvGHYtBiGcW4gHUa7/aKAVLLzMj5Qz3uxHLi9whRaozpD4JrPx5U
	 4OsQ9PEt53wwcdShljHQQyI4ieJaKlGoh6iiR/h9iI8dx9o28T18FQyF59hN6f1Fqk
	 g1WlIBbqXI3II1uP0OEsE2eyGxwnB+sLZB49oiP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbgDAWfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733254AbgDAWfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:35:20 -0400
Subject: Re: [GIT PULL] HID for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585780520;
        bh=EyhDYKYutDY7xJzUZP7IFXMKH2P0GjJOxUJbcxEI7Kw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uPbt3VcxLZVx39oqjA5qUMLNPXCS1VeTcaGaKB2ikI8boScSezwUyOHMaSpQCsBbm
         X7GT1Ei18UfVe1D2ww6NtEuT37kP2pFsC4to3YCX5DH0D+N+WAPHzYND0NYjXa2b0n
         mhSwlJ1tiZdaDG+8uifPZDjJt6yNvtHewZcS2wqs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2004011353080.19500@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2004011353080.19500@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2004011353080.19500@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 4f8a21a6a9335fdf0952af3cadfa88c33dddacd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c101e9bbce4ae2947b35a660f17d617fc3827595
Message-Id: <158578052043.24680.1816797200540896352.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Apr 2020 22:35:20 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Apr 2020 14:11:24 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c101e9bbce4ae2947b35a660f17d617fc3827595

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
