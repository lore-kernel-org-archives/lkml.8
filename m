Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86798C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 14:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEA520842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 14:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578753925;
	bh=cO1wjOjYcxCtX8KilZ8TVi7y3f0TknkORVJfIF/+3vY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=l/+zoEM6TI/3iUdL1NENMk9stQLJpHj64MqDPn4ryuyEtwsFQ0oCc8JaCSLSXdQQ6
	 GNe/eUORi2RsUk2jgJyI80bGfmf+pNSjqYx/JrejVwohivIsO08hPAMqZ1qYiskeLw
	 dkrfCGfgTJaGxZ3Tyj+Fe2OusFq9XaPveKom0974=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbgAKOpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 09:45:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729923AbgAKOpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:08 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753908;
        bh=cO1wjOjYcxCtX8KilZ8TVi7y3f0TknkORVJfIF/+3vY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZN1PObGIqHepHrf93eP7Yw/jpGd8RKsyI3n4rKy1R2Lc3t4jptXc3Tj4ZsdNntMPY
         eWTIooCv/w4cseX1xLs6PIupyGm2FDRCZKYMV9MW2i58eX17s7oZoMWJaYoH6Dt0Mj
         xVcz625qZ9IAR6q2VEfIrt2TdbpSceXxpqMIR5RE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200110210906.GA1871197@kroah.com>
References: <20200110210906.GA1871197@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200110210906.GA1871197@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.5-rc6
X-PR-Tracked-Commit-Id: 68faa679b8be1a74e6663c21c3a9d25d32f1c079
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fb7007de8a2a80e4b55a850311fca10de62f1b5
Message-Id: <157875390813.30634.5471701512268793748.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jan 2020 22:09:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fb7007de8a2a80e4b55a850311fca10de62f1b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
