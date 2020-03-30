Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83754C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FAA2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585605305;
	bh=c2amDIMYQ29mFgURLqMfYuUXWuNx3BDS4WVL4bSInME=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=U30+L4Tf7f2DPcB2htWEPwmZc2K19i9qNJjPnop3n5086BYRz5N5pp1CHm2P+hHv3
	 /OgSeiEIwsa9qUBcZ4di6Babdj7jY24OxV5d2C/eAQx0gej1ed9tQkg4QIoJUucHd+
	 HUnH+v/Te0ZHj90c+8JlYWMRi7HlqyQc43BvUzGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgC3VzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729750AbgC3VzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:55:03 -0400
Subject: Re: [GIT PULL for v5.7-rc1] media updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585605303;
        bh=c2amDIMYQ29mFgURLqMfYuUXWuNx3BDS4WVL4bSInME=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ku8zHL/ntABqOo6cYRPC8Z3N5WpEdFqevEuI4pF9kK03bs3vyGl0HljWeodDvQFOc
         MKd9vZgsJpYHcbxGgP/4fbLkv8cs0k/hPhw9GGN9R51W97nlW3i6Ch/I4ceJA2WSar
         FiNW2bua8cgORSkOM9Cu9eTzhZb9IinxkE4xAuQU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330114824.46773eee@coco.lan>
References: <20200330114824.46773eee@coco.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330114824.46773eee@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
 tags/media/v5.7-1
X-PR-Tracked-Commit-Id: 2632e7b618a7730969f9782593c29ca53553aa22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 063d1942247668eb0bb800aef5afbbef337344be
Message-Id: <158560530314.23211.10552256266311366350.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 21:55:03 +0000
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 11:48:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/063d1942247668eb0bb800aef5afbbef337344be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
