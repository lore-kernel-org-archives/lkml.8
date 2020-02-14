Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A635AC3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761BB206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581716432;
	bh=JcHQEAivJjVB7nOyC+fgi899tgsxC/Od5LG9YHWlQFQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TANLpszdcj+bYXLglFbByt+z4lvi+AYqHuzTzmvT3xt8ZROjmHPr6xKoBWxhsnt/3
	 CI7q+UnWVO7SNloqiTm/ZC3NEnLx0/dUddlhKLUqMBY99tWV4I7QHqHH0+eAwm7v1g
	 0milO/ed1MkvDcxCGjO9pAO+UVT5HjoK9fvyCNjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389872AbgBNVkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:40:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389355AbgBNVka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:40:30 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581716429;
        bh=JcHQEAivJjVB7nOyC+fgi899tgsxC/Od5LG9YHWlQFQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Zq78vLKePfslRNDSt6lfRpLyvj4HtzXESIEpbVGIgrhMbt9BJElLiyKFtw8cpksOj
         8aoPQj+5ReaoaQwe9Ml5SuLPmDB9sxsZVtFip7mtVC+V/iz9p9jk1oCBs9Kdy3IUw+
         7C9zpJVx6YSLyMT5AGWKUv4Zd+uBi7tEU1xeXAeI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200214.075409.535471157405842746.davem@davemloft.net>
References: <20200214.075409.535471157405842746.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200214.075409.535471157405842746.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: a1fa83bdab784fa0ff2e92870011c0dcdbd2f680
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2019fc96af228b412bdb2e8e0ad4b1fc12046a51
Message-Id: <158171642970.8400.17015637792175992858.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Feb 2020 21:40:29 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Feb 2020 07:54:09 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2019fc96af228b412bdb2e8e0ad4b1fc12046a51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
