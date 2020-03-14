Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A578C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F63320578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584239069;
	bh=nlkSd9dZ2OzupyIAX3ttyXzPZ+1/uu0Tt8oO6gT4tTg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=D8DUvZoaOmoj41GUMs6b0/UNSC+h2oWo/JpM+2+zB1UfJn70HFz9oJlWtpWrlwn6J
	 xFo5tfQTCq4o7xgDm7J6NJ/DgzFnWezAZBAcuHjYwUZ6pPM9OBT4hSA0fEx9xRu8bb
	 byqvldd3f55HOB/qCC7tdA+t0HsL838WmdrdgfD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgCOCYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbgCOCYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:24:12 -0400
Subject: Re: [GIT PULL] clk fixes for v5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584203708;
        bh=nlkSd9dZ2OzupyIAX3ttyXzPZ+1/uu0Tt8oO6gT4tTg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zh4FGvEyBRXlInS75a2kUSdTtzf7g9HUQ7+EDh1ZSdyiINAMJL24+a7W1uRlq8FII
         1JCDnZ/BexU3Wj/5EbAvM+czCk5q0p19EHhecQrzWgjmsDg2dMzkFm7GOTtnEeiwzg
         FXirIhNvRU/415hL8+uCKd98JrrwLvMNKOZJ+a0w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200314012722.234270-1-sboyd@kernel.org>
References: <20200314012722.234270-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200314012722.234270-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 20055448dc1b439c87d0cb602e6d0469b0a3aaad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69a4d0baeeb14b6a3c47570a0ac2e0fc4474f0e0
Message-Id: <158420370808.8641.17291481150926081366.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Mar 2020 16:35:08 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Mar 2020 18:27:22 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69a4d0baeeb14b6a3c47570a0ac2e0fc4474f0e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
