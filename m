Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DE1C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 19:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD80E21D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587238224;
	bh=L1TVXpY7szCnL8/P4515l7eyNk2gMHrDpdnitkDBV44=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=j9iWNgA7NE0vLg0CJ0rla++u4LK/XwL+u/wPYDLMlSu3RYBvg8KIXFXts8Q0M6ZM6
	 0gwOd7OytEKTNqJuiP1M2ng31ip0rZLh+e1k78R86JAWq22f/t8L0ZsQMYdIUY6hqV
	 kBxdDhV6DxOc3jcaGA4eto8n5TrXVqVpIupu4IUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgDRTaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 15:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbgDRTaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 15:30:21 -0400
Subject: Re: [GIT PULL] thread fixes for v5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587238221;
        bh=L1TVXpY7szCnL8/P4515l7eyNk2gMHrDpdnitkDBV44=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o1VfYcodOtdnUnKnllYDwpDjbWEIq73uq7qNuAcuaFm5atg0+uvqC5AFvOW0ytHEV
         z1Nn0p/X8uzWwP4rczGB48NKULOe5U27wz0AiA1sIrKFwVL+WlTsqj5HSk8tqqwnHP
         TfKWnvPZzjsAtUZW3067DV3nQlPE/EAmfrDDvxJs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200418110945.1518581-1-christian.brauner@ubuntu.com>
References: <20200418110945.1518581-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200418110945.1518581-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-2020-04-18
X-PR-Tracked-Commit-Id: a966dcfe153ab0a3d8d79cd971a079411a489be7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 774acb2a094c218cb0129979afc67eda7e1ec4b9
Message-Id: <158723822097.11589.9660972430404455424.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Apr 2020 19:30:20 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Apr 2020 13:09:49 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-04-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/774acb2a094c218cb0129979afc67eda7e1ec4b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
