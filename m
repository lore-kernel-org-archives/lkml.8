Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBC4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A862311A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596734410;
	bh=MWTsTuM14LK//ribvpf+b3znnXVCM8wVoaOXrxSSE9o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2n2RmIMHx23crv6b7qUIPpZp4gMfnDdc0G8dq3YjTzexuFQVVaeApJFbHlEtK7rkI
	 H2sHDS9jRkTNVVdlq3ncbx6a7rkdyv9FJtf3vjEAJmXWjBXxrqGVKOISCqXXwBnQ0e
	 brQcgQpLDsT1tsqEF0bX5nb6RS0E/9TKKzB5BS7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgHFRUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHFRTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:19:45 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596734385;
        bh=MWTsTuM14LK//ribvpf+b3znnXVCM8wVoaOXrxSSE9o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0rIZaA56cXdR2p8cTW/SYKouSmGz6+ieQvmbRK7fCsVaxGPhJUZnYpuDCmMUBwlmq
         zIlQSO13lVSjFdWAopfhGX60F9RW1kpppmiBhADIsEUytVM+QeVzMSJ/h6LolZSecp
         nzdYGLIR/Dp7VZEgnkelM2w01TV9pf61pY+pMwJ8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200805.185559.1225246192723680518.davem@davemloft.net>
References: <20200805.185559.1225246192723680518.davem@davemloft.net>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200805.185559.1225246192723680518.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git refs/heads/master
X-PR-Tracked-Commit-Id: c1055b76ad00aed0e8b79417080f212d736246b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47ec5303d73ea344e84f46660fff693c57641386
Message-Id: <159673438516.17279.6122070644524538248.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Aug 2020 17:19:45 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 05 Aug 2020 18:55:59 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47ec5303d73ea344e84f46660fff693c57641386

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
