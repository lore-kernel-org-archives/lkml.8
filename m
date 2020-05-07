Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC025C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 04:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81912082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 04:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588824305;
	bh=zR6eET3bphOeSZcysi3IrmzpPhYrELY85eVha97LOyo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LJvKgyh/m5HeAkyah0x2bztQCQsHnDMH7ZHUSA96bG0bs1qBQUzmNxxGWtD/cz5Hz
	 7WZiu0MmuwosA7Ko6N142o/+KXgs/Kb60HPJ7suay7sKVbOtC/vOEzKq4j5LaBgez8
	 nKFRykGItPBvo2E6Ltw1ZOL193v5etAi2YJWh4Hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEGEFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 00:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgEGEFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 00:05:04 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588824304;
        bh=zR6eET3bphOeSZcysi3IrmzpPhYrELY85eVha97LOyo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=giY/MpGPhIfcsIbyF9/Lzmn+YTqfhUy9Xrdv5EYQNcx9A6+fAccmwkKfvMa5wXRQ/
         DRzTkAYJPijIJSzpgTYUj2ZJcOQQPFcw9hRzeko7Dn5QPNsUoD28d4e+JQpkunZu2Q
         KEFtcainv5tgHeElK/zAK3muploVM/xR6lkRKKtA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200506.204039.425872525231159617.davem@davemloft.net>
References: <20200506.204039.425872525231159617.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200506.204039.425872525231159617.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 16f8036086a929694c3c62f577bb5925fe4fd607
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a811c1fa0a02c062555b54651065899437bacdbe
Message-Id: <158882430420.24952.15328615514936952931.pr-tracker-bot@kernel.org>
Date:   Thu, 07 May 2020 04:05:04 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 06 May 2020 20:40:39 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a811c1fa0a02c062555b54651065899437bacdbe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
