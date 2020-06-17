Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EB1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E752089D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592418927;
	bh=tcpLLHq6ekGGxG5zR9yj/3ixxGQL7DOjyVhjSB/mzYQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kZZBWWG9hj/BogdocGi5nRkxCbhr9VDAeKQ7fSpu7QsVhsbZ6NLI8froS45i1xh6G
	 WJon1ZNnWTUnESWsrMTWbLhIMYwN2ED9T3oyWS1YDjOmJ9RuumqOVWH9WykMK7NK3U
	 hvjvpcgzd88361i7wWZ2ilEUHpF7oivVAvnxXa6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgFQSf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbgFQSfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:35:25 -0400
Subject: Re: [GIT PULL] dma-mapping fixes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592418925;
        bh=tcpLLHq6ekGGxG5zR9yj/3ixxGQL7DOjyVhjSB/mzYQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dtj58PLdIcYgWVXmgLpbvjE6DBEV/Q2eEmCcDEfRnSq5F0oI3O8LBbh1ATeazJSYU
         StdGAHKZfoY73suJVyKPwtkrnsv5CYtcLPnqXIuC4QZNOnhnNAZaJNNE3hldAS447S
         SljJEiXEExuM0fAd2k6S37Tf4faB7VgjygWdwKiM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200617072716.GA7356@infradead.org>
References: <20200617072716.GA7356@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200617072716.GA7356@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.8-3
X-PR-Tracked-Commit-Id: dbed452a078d56bc7f1abecc3edd6a75e8e4484e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b5044021070efa3259f3e9548dc35d1eb6aa844
Message-Id: <159241892542.2275.7100762619147699282.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jun 2020 18:35:25 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Jun 2020 09:27:16 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b5044021070efa3259f3e9548dc35d1eb6aa844

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
