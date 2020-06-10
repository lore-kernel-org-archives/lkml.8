Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACABC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E1E420842
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591815336;
	bh=LPvGRK27S7D297nZypj5cjXH6UqiCQh2JFo0bg4U0pc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=S9TCThXGRI+RJkpzsvAFiDi7or3239vJTPesSbrFETUiRTHWXcCwwJ0FQf0hmLLo3
	 RRtLXeSVjSuy3cOceYY7EV2w4B0iNrOhP8IqRP2PPYQQrleQy6Zy8jHUZ+38kkQ6oA
	 oopXYcj+DhIRBlwdw2eG7jJqkUJ6veWhPkq6a7IU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgFJSze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729692AbgFJSzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:55:24 -0400
Subject: Re: [GIT PULL] clk changes for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591815323;
        bh=LPvGRK27S7D297nZypj5cjXH6UqiCQh2JFo0bg4U0pc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z6wBN9mzGyhTwj0rkiZU7bMC7dpTjtnH1YVLYKLEVOBWzatN6zWbeiYQ5SiGx9b8T
         A7qI8HLmso5ADsNg/T3pH9iD+HWtgjHWjjjTss1/Dx5IYN/yQ0PHmoWcKOghM31sO9
         gPdUby0hiqBqj85+MhVErwrTvPUMC4mC4U/oJQ0s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200609225350.206940-1-sboyd@kernel.org>
References: <20200609225350.206940-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200609225350.206940-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-for-linus
X-PR-Tracked-Commit-Id: 9ac1eafa885a9b2d3becd4f2e622829b1f5b9b86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f630784cc0d92fb58ea326e2bc01aa056279ecb
Message-Id: <159181532369.20525.15031461668384988911.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Jun 2020 18:55:23 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  9 Jun 2020 15:53:50 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f630784cc0d92fb58ea326e2bc01aa056279ecb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
