Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D74EC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B9B2065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595786715;
	bh=aW3e2MDXzilnF8u4iYtoRyftxb7mBlv23j84tJzDY/0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Kss+xlsDiM5/0ejjgFiud07nbjZtNupQZwiNJvX12IU9Dpd8w55blWnWhypPWdxWl
	 rZoT0fF0qHRw/gN80u580WFtyfBWaxHOhECTjxxHPM5rmUUdHpU5oS9DdSABllcPna
	 P483HgwSzVPWjrX2Seewyjc5Mbt5yWiE7sQHTh5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGZSFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 14:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgGZSFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 14:05:06 -0400
Subject: Re: [GIT PULL] Driver core fixes for 5.8-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595786706;
        bh=aW3e2MDXzilnF8u4iYtoRyftxb7mBlv23j84tJzDY/0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2qHiaOvpgahT9EQP4eoQr1C3TFcONnl2Y2vTVOn60vsNzUt2fQfqXZNZb0MhCq8e8
         l60bR4Mg3LeHTUME4n6tTtqO4/YZ/NPvUeOwijgs0irhLluUBXITL5SgVjYpFrM2I/
         4H6mQLgRNIO0QsNA/+N7Zydu0BlZHlM3C3NPZocI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200726111306.GA1283843@kroah.com>
References: <20200726111306.GA1283843@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200726111306.GA1283843@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.8-rc7
X-PR-Tracked-Commit-Id: 29c4a54bc645c8b6745eeb58519e9ad794ceb419
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f2e231c316591246284b10b008cadfc953f16d3
Message-Id: <159578670604.6689.1408032475062855646.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jul 2020 18:05:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jul 2020 13:13:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f2e231c316591246284b10b008cadfc953f16d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
