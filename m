Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7EEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 22:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B47B20773
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 22:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595716206;
	bh=hrgUAaVY0nZ2DscyzB9qMMHobXhohMJTC365wzL9Cqw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=q8H7i+0/f5/3uBayIDMOwI5vf4L+rq/O2aLG74Aq61g6Kx+CnV3BBv9g/sSjzDJn6
	 82faO81Pc6cJnAuFYWKmcRXJarNKdJ9HmdrXGJOhoZUBJHdiXPUFlc8cmdqUewQJCG
	 zAOR4lV3fD7uKkhBfide7FoVWUhy8dKWUe0NUgAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgGYWaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 18:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgGYWaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 18:30:04 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595716204;
        bh=hrgUAaVY0nZ2DscyzB9qMMHobXhohMJTC365wzL9Cqw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=efGe2/VjS8IBNGG/8jRPtPPerM5PDnmc+YzGfNHm8OYi/aEBBDtmXuyGOCPHe0oaR
         eaghZePwwOnWSnajwmjYlhLjVxzwTinu1NY+Eiw81w8IfQeFJeLTMnsrpqyXoM9WqZ
         i3p/x05rBBnp6H6kfwk4bBfOXIbLr/e2VXykMlqY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200724.221204.1658413840252419526.davem@davemloft.net>
References: <20200724.221204.1658413840252419526.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200724.221204.1658413840252419526.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
 refs/heads/master
X-PR-Tracked-Commit-Id: 8754e1379e7089516a449821f88e1fe1ebbae5e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b64b2e2444c11b8dd2b657f8538c05cb699ed25
Message-Id: <159571620398.7388.18215185389779078820.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jul 2020 22:30:03 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jul 2020 22:12:04 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b64b2e2444c11b8dd2b657f8538c05cb699ed25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
