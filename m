Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B75C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4DB206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585605914;
	bh=Kx+bszbi0tZCQ9AWWmH2AJ7BYQY+XLdFMqg93ge9acU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=T1Bp1g05lwQyuno/vYnaOnCiK3jbbpA3cZ9eDwByhsyo/XqwNPQGtXS4j3VlpmDT1
	 cxArLoF9ZmNJbpg5d0PRYXSvGWdrENDvKkwtcM7icyUegsB6WSiCkQn+F/n35oV4eH
	 Nb+Nr0FArFc6qMan4Yl1s6TbpQXQBQKhtgI03dBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbgC3WFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730808AbgC3WFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:05:10 -0400
Subject: Re: [GIT PULL] regulator and spi updates for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585605910;
        bh=Kx+bszbi0tZCQ9AWWmH2AJ7BYQY+XLdFMqg93ge9acU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Nz5yDODWc+AC5vT0nYZ8JGuw8tML6hXLGqAHkLDvxnBeahE4tVFz224RNoIuXIew/
         zohT4f3+cMIdKO73yAVPQTOz5z+bM0FQO+hYxWZ334eZkxsbIwp1GXRNiE5xBl6pPG
         yUw7wc3415NMW4qL7aisMlc10zAXW1ML7iBtDJvo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330123732.GH4792@sirena.org.uk>
References: <20200330123732.GH4792@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330123732.GH4792@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
 tags/regulator-spi-v5.7
X-PR-Tracked-Commit-Id: 6dfae59d37aec535db5e462db1a1ff76c5e3fa25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a231bed2267cf45b0759da1d3ad62483b8bd0925
Message-Id: <158560591032.3338.15534951811568304834.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 22:05:10 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 13:37:32 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git tags/regulator-spi-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a231bed2267cf45b0759da1d3ad62483b8bd0925

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
