Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981F7C10F27
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 15:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D52B2187F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 15:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583682911;
	bh=pmI5N47lVnRz4IF7ZehT6mh0m8yDgfb2qRPwFHTDzvQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WptBLl3nu33Y41ef3TYdgULvuVU70NWHvB6IkwpxMDkOxuOLU1a6lMxVoUQUxzdCy
	 n+4j8kxSVrAH48KZkRyNNUjlifwtbkmnU7hkM9IIKPAtFz+qQXt2huCJDLcC8fUEpf
	 0WBtKqmgSWlXZz/+ZTMU7KDYpXeVNUioBU2HXDXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgCHPzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 11:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCHPzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 11:55:07 -0400
Subject: Re: [GIT PULL] Driver core fixes for 5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583682906;
        bh=pmI5N47lVnRz4IF7ZehT6mh0m8yDgfb2qRPwFHTDzvQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Hn7Q3lOEgTygmtXfjYAx9OdU5CKr9pA+jGj2BacZkJfFJF4OGta6GrH69Kn9e1zWv
         XPmgDy9k+qHJyoyKoat9I+iLXD3JeWNYEuzbDqljjwxdFq8rl5/Wcihpd6DOOwlDVS
         sXxGGleRCuLIghhrw0R4mmb90jg4rbLbBTYroQgw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200308095254.GA4027132@kroah.com>
References: <20200308095254.GA4027132@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200308095254.GA4027132@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.6-rc5
X-PR-Tracked-Commit-Id: 77036165d8bcf7c7b2a2df28a601ec2c52bb172d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b34e5c13327ef723362c88c43da176a439badeea
Message-Id: <158368290677.12496.8200984633169779199.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Mar 2020 15:55:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 Mar 2020 10:52:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b34e5c13327ef723362c88c43da176a439badeea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
