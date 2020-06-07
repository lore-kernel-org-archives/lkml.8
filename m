Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEB8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6BE2074B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591553430;
	bh=goWHSU69DgunIHSZhMOVriQoN0xFdTTetVCIsGRHiNo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=egGT/4qv8gnN6E+DyGg8VOdk2rtp1RDQVqYhGLCOC5HSpXjNZGECD5zdMKshfQ5Bc
	 FXsdbZ51A/EUz9jwUiKMwIIbmEaVRJEsjBpy6EOemkT0DhGOp2BSDwUmcxxAAgw3uh
	 Oo7YmUP0mEFAdg/Je3IWXVm3mcZWrM3O9qI0fBAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgFGSK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 14:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbgFGSKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 14:10:23 -0400
Subject: Re: [GIT PULL] Char/Misc driver patches for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591553422;
        bh=goWHSU69DgunIHSZhMOVriQoN0xFdTTetVCIsGRHiNo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DaRFLDr7UVBZzsC83AvDmWqjU8do+mp08ftD115v2Ou6u8Fefnn3TUpax/a3euQvy
         njIz8ES4Zt63YH9QYK0C92VXQnI2ty1ZA3j9PtxUqSiHIfpwq4H1zS6e9zxPHrFCUS
         LiCxUbgZ7PigHuTnShPvH4TeVIUG21/xbZhmjucA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200607132904.GA168539@kroah.com>
References: <20200607132904.GA168539@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200607132904.GA168539@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.8-rc1
X-PR-Tracked-Commit-Id: 05c8a4fc44a916dd897769ca69b42381f9177ec4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9aa900c8094dba7a60dc805ecec1e9f720744ba1
Message-Id: <159155342285.28494.4026527781169599977.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Jun 2020 18:10:22 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Jun 2020 15:29:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9aa900c8094dba7a60dc805ecec1e9f720744ba1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
