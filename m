Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10750C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 20:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3673207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 20:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598732245;
	bh=D8gf26wOK6tiRt8SHWa/2l4QNuI4CNQWRa9onggt46w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rA+ov+WA8ubD5tUeILSGHGGn9852jXa1ZP2cd5Fs6CNNJSCitz33OeuMurS6hCW/v
	 uqw3I4o5xXGxqj7fG4G0dx9FFUePW5LNNaTZf2NJyxBBonC2NTgdl2CsvFyXy7QL2J
	 ihdXwQNRWot/BRMpRBbFkFOPQ+kuHdm9GB6uoG0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgH2URW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 16:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbgH2URV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 16:17:21 -0400
Subject: Re: [GIT PULL] hwmon fixes for v5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598732241;
        bh=D8gf26wOK6tiRt8SHWa/2l4QNuI4CNQWRa9onggt46w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uICdcIJ0J+KqC9t50nWL8rou3ps100GGjsik027YmZ/MhuKc5QokureC5CcLoSAb5
         cNHbOCjHOPfsBGa1wsyxt9g9kWpMDXuVQ6LtP8luoNV9Wjf8fD0RV4pDjAYaunyH1l
         KEg84QaZGvW8mqtYiGBTEa1HZXU52bq6FPx9Jw/Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200829101329.147475-1-linux@roeck-us.net>
References: <20200829101329.147475-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200829101329.147475-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.9-rc3
X-PR-Tracked-Commit-Id: c1ae18d313e24bc7833e1749dd36dba5d47f259c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4cad138aa4f73cd88c624a88cfd63ddcdd1c098
Message-Id: <159873224127.9079.11829251468728596999.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Aug 2020 20:17:21 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Aug 2020 03:13:29 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4cad138aa4f73cd88c624a88cfd63ddcdd1c098

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
