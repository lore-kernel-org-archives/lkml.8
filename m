Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2894DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 03:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0245D20716
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 03:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597374847;
	bh=Wfx/cG7I3Sy17lxQkbbmAn2EnTgXhFepuhekao0n2PA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bGe3U1HZDa1xdxJEg+D5hb9+QFq6PVT0fUp4nC2o35S7zhzOeEBJAIPtY4Cr/dOon
	 m5TCtHHBENaYLBocqQEe4zKYQ1qaweUASOsFDi5/sjt27J2sx4yGcfgfAvRA059E7w
	 l5mFF/yeV64lW/uxyDQWROpNeF9wQp2HyMK/56sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgHNDOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 23:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgHNDOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 23:14:05 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597374845;
        bh=Wfx/cG7I3Sy17lxQkbbmAn2EnTgXhFepuhekao0n2PA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iMNNdYWvVXxLgV71GndS+3E5UDVzILaZzTRHEVQRczFwcddo4FKqFnjxViZwC24Fx
         gxrQiS4b007FTXtJi3g75UpRLwCruZKr/L7EKMi0kuLp7RLTFEFQ4o6VyoKY3F5DVg
         1zTxtBatNzHEbB7nbPXXQJ+VRSZrEfSCu0JMBfNQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200813.161057.1210508009320036989.davem@davemloft.net>
References: <20200813.161057.1210508009320036989.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200813.161057.1210508009320036989.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master
X-PR-Tracked-Commit-Id: 1f3a090b9033f69de380c03db3ea1a1015c850cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1d21081a60dfb7fddf4a38b66d9cef603b317a9
Message-Id: <159737484508.26888.3274355225863216375.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Aug 2020 03:14:05 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Aug 2020 16:10:57 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1d21081a60dfb7fddf4a38b66d9cef603b317a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
