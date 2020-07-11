Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CE9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 04:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD635207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 04:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594440905;
	bh=xsvZZhUiDO4BSdrPaNrfOOTdrynDJsAfhoST29CYk3k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=erMerGr7XA4csUY22uFLxgv/e0CxGS81MFC7YMg3hkRw7K+o6a1y+Hij+2KgD7sPU
	 v0gkupd/DDHKQ71Yu9lQmeuziAhLuq7hp1PcJxIdzIaneQWEtelJcmvKo5XCdu1TTc
	 n4CVEqWMwjJtRcfgB4MQ49u8ZWUGYiTAIkTcNpcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgGKEPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 00:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgGKEPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 00:15:03 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594440903;
        bh=xsvZZhUiDO4BSdrPaNrfOOTdrynDJsAfhoST29CYk3k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IqjWXLFPsutU4pU19J4IphNUfxgPxyxDimK3Pk6dosQ/qbh4FW8yY17FBpKJddcC7
         qo9U0loO9OpTPXGYelgZkH1NzwnQ+5VLzhhz1Ih05GyqaQvZXCaSINmbIOR8ALci2h
         Seu0/FLrVpwDkt/mlyTczuAqghNda3LYARBf5LJI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200710.165815.1749029533411123245.davem@davemloft.net>
References: <20200710.165815.1749029533411123245.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200710.165815.1749029533411123245.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 1195c7cebb95081d809f81a27b21829573cbd4a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a764898afec0bc097003e8c3e727792289f76d6
Message-Id: <159444090319.5420.4883542853034701813.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jul 2020 04:15:03 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 16:58:15 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a764898afec0bc097003e8c3e727792289f76d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
