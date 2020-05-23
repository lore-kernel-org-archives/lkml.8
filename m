Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825BAC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FFFF20872
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590258608;
	bh=qcmaWcBKtHhB823njdSaJ6vU3i5zmE4p+PqJTxLSdCE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tJ+ov05dwCkcbJmsMEAqRyGVadcH5/F2PdqvOiYDJvHyXse/b2wJA2IY5J3r0ovgp
	 +xWz8S+ADX6QoPIcHkSQbDnRprmblk0DVRipHdoVMP8w7haut5JTwi5hWhOCC+SNhZ
	 joR9UgnUgtsq1+FDxRne9cV9wSJC0ZMkfMw7gN/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbgEWSaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387980AbgEWSaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:30:04 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590258603;
        bh=qcmaWcBKtHhB823njdSaJ6vU3i5zmE4p+PqJTxLSdCE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pcU3SU0zbKnK91m4Qy8aiHuVnKCyzew3+ucfZeXrrORvMD+6Jm/EV+7/z5LY0U8w/
         lldxhfB9j26s+MfSrP/xHyphZ6Y+FqKgLvKKIpLKH0dCs2jNWJF2KdkCztw1wBJM75
         bjS0W3LXXVn02NEwKqJJDzcfL2TtChc4Uj8Bi4Xk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200523131815.GA56291@kroah.com>
References: <20200523131815.GA56291@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200523131815.GA56291@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.7-rc7
X-PR-Tracked-Commit-Id: 7a839dbab1be59f5ed3b3b046de29e166784c9b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e36fd45e37e0b4151d70cfae4d7e3e9a75c5c99
Message-Id: <159025860375.7121.6349006271360724776.pr-tracker-bot@kernel.org>
Date:   Sat, 23 May 2020 18:30:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 May 2020 15:18:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e36fd45e37e0b4151d70cfae4d7e3e9a75c5c99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
