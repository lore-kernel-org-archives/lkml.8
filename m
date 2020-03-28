Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467A4C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 20:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E79020714
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 20:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585427115;
	bh=aXLLyKMKzNzz6BZhOc5+8xGHh2188GiTSS71dD6zMOg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0a0Hlx5kPquEGkxwhYyXetC5olBkdUWonVYjxcQ9srW0G00DZ7gdowHcAR9xYo/K3
	 9MsfOyv5Net3dGV1dMfbqQJdftsvPfx+09MZhJ7qTH1qPe0bgkunI5hqQZv+4cpSsh
	 Yk9zRaWTaziGSaTylPGUg9ypojwG+3U9VZJvuGl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgC1UZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 16:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgC1UZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 16:25:07 -0400
Subject: Re: [PULL REQUEST] i2c for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585427107;
        bh=aXLLyKMKzNzz6BZhOc5+8xGHh2188GiTSS71dD6zMOg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ulMTegLmqfvVzS8grIZdNrZ2KHM0uulnNjgRLW6mO6PsTGKP584H4uf8eCydmOWXe
         b0JdZEwLHKx3VTac+ynxn97oL7ooiu0EHwEkOxnIXLjIUCwO5u1cNdrt8l4b6/SdFt
         QlkkGBapJ+zlkxoYsDaFhSZgNicl2oLmXRHIEiiE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200328194059.GA1632@kunai>
References: <20200328194059.GA1632@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200328194059.GA1632@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: 14c1fe699cad9cb0acda4559c584f136d18fea50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 906c40438bb669b253d0daeaf5f37a9f78a81b41
Message-Id: <158542710731.31099.4235816086457834705.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Mar 2020 20:25:07 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Mar 2020 20:41:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/906c40438bb669b253d0daeaf5f37a9f78a81b41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
