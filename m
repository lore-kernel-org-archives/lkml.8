Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4D4C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DFC620838
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595105406;
	bh=8399C5wjgWQGrgxa9vJL59qQFBb/UJ/8QpaxCn/llOw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TCbdzlSYPgLqRk4I0IFY2z7yHRBkADZxTRDJ6T9Dvd2ZYf3/fDfUsP4o3dwKUD1wR
	 aQjYdcBJubgvOawmO0vx5fI3a8sdzLpeXahb9Tunk4AxQhVsu8lw5ASNFwhkLMQazy
	 rrjU7Sqs+c13yfp+FBThidOIWHNSjjsMcYfKxZ8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgGRUuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgGRUuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:50:04 -0400
Subject: Re: [GIT PULL] hwmon fixes for v5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595105404;
        bh=8399C5wjgWQGrgxa9vJL59qQFBb/UJ/8QpaxCn/llOw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WN8CYM6+whMnNQtYOsUtKt+Mw2IFzKk8YMRfGCV988uN7wWjKD76n2E+XCU255yJ4
         Fmyp+pmd3zYtMmydc0Ua1iqLnN92eSIOPpZ4WxYGqN/VUZ9DHpt75Rm10fm02y/j7h
         z1nMBZi7FImLroef6mxd8xucakHzqMtG1jF5hkEA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200718152255.175469-1-linux@roeck-us.net>
References: <20200718152255.175469-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200718152255.175469-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.8-rc6
X-PR-Tracked-Commit-Id: c66ef39eb27fe123ee05082b90eb2985c33c7715
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e26aeee89f54e2e5867836231b4dc6448e45248b
Message-Id: <159510540431.20690.1524153901713935165.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jul 2020 20:50:04 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Jul 2020 08:22:55 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e26aeee89f54e2e5867836231b4dc6448e45248b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
