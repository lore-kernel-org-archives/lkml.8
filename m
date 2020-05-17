Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA38C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 23:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF539207D3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 23:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589759705;
	bh=oOvTehcYV4E+OT3swfDEHIa/Lg7C0PeBlGEfx3+p8So=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EORTTD+B7GpkJpGhZYbOd46a7MeBcKGk+xoSAtTnoieNJDKiWZiqGlS+TjrU4Xhpu
	 8022UGY3m9HBjyUOKz0szWMN0YD3dJQKlEnm7Oj5EgQ60uiycvQQz7dKahQQ9mpk3N
	 HUmGD1T4KMItxN7PX8Fjkzgr7UKhLlDwsHt2dwNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgEQXzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 19:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbgEQXzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 19:55:04 -0400
Subject: Re: [GIT PULL] IPMI second update for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589759703;
        bh=oOvTehcYV4E+OT3swfDEHIa/Lg7C0PeBlGEfx3+p8So=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rArrBEmxzUDzWIQTDYpPuCnHCI/t2IqUiZDF7sDKvIprvABQnEL3Eym8PebmmfUjS
         U1AGwIKa56gX4wN6elfFpH+tlOcHjeLIXy4TFa3Mgq9NJpwVlEbzvXnHqtLAlHhv6l
         3hDiYAOBZ9RiezigVXGIaRmn7TVgVTIrwMEARzaA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200517194251.GD30085@minyard.net>
References: <20200517194251.GD30085@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200517194251.GD30085@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git
 tags/for-linus-5.7-2
X-PR-Tracked-Commit-Id: 653d374771601a345296dd2904a10e6e479ad866
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8feea6233d2bf8e43ea99e78d8637ed0745d2732
Message-Id: <158975970364.15102.3209553325560370718.pr-tracker-bot@kernel.org>
Date:   Sun, 17 May 2020 23:55:03 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 May 2020 14:42:51 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8feea6233d2bf8e43ea99e78d8637ed0745d2732

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
