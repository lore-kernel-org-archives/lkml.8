Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B9FC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF3A21789
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598814983;
	bh=ygXqQiT1YNsGCylF88L1Or4T2Owp+1zO/u/SpScr6mI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=B8EtQLWv/9BgHjjl77XReVcGm+/Wy9q3vax35Pog8DS1F3bFfTWtvXJS5ie5/BjG+
	 KD9+Aw+KezmqS2CWVo9GV/ZhoiBz+y7EtB32RtfL8/hv8bBoXXNMbh7cUQ4kLW6HEc
	 xlm0MNQ6eUII5flUboer0zXkuBuOidwxbZy7BRr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgH3TQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgH3TPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:15:42 -0400
Subject: Re: [GIT pull] x86/urgent for v5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598814937;
        bh=ygXqQiT1YNsGCylF88L1Or4T2Owp+1zO/u/SpScr6mI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ak2OfXfmZROD+mogRwfAmDizwAwN/Y12L19FdkXJ1GDvxIZYLZw5HyXqT1L4XEpfq
         UMupsYU2ZqT58q/S8sUZv/U9WKSkIM5i15MIFrR4VOQH97NiWy9Qjv9DTGcXBIv188
         EdCEUoBp4aWjAxJlLPTkYcZUR63jjBFIQ9wP+T0M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159881061925.27993.10669865438175129325.tglx@nanos>
References: <159881061564.27993.11909051048930389391.tglx@nanos> <159881061925.27993.10669865438175129325.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159881061925.27993.10669865438175129325.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-08-30
X-PR-Tracked-Commit-Id: 784a0830377d0761834e385975bc46861fea9fa0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcc5c6f013d841e9ae74d527d312d512dfc2e2f0
Message-Id: <159881493776.11576.16845010624396440596.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Aug 2020 19:15:37 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Aug 2020 18:03:39 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcc5c6f013d841e9ae74d527d312d512dfc2e2f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
