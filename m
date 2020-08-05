Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE262C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577AB22D00
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596659624;
	bh=TEaZAFW6TbT9QX+FpDhnmuFjqkkdK4jmxgI0Rl0n904=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=x4qGVKRcwhc6BMuanIA0ykvSEP9+RUcTSwkhiGZSrNC9MGjHvHkO7eYvPa2874Ryp
	 B4QKkZbbX/gghgHkFfpPOiI7TCInOF8T2p3vxyRI5zpM7rXn/cakflS92CzMQ/hWu+
	 v1k2r9I8iwfpnmO0+vtAziRwPC3XHwg8Exd8EZhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgHEUdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725139AbgHEUdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:33:41 -0400
Subject: Re: [GIT PULL] Please pull hmm changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596659621;
        bh=TEaZAFW6TbT9QX+FpDhnmuFjqkkdK4jmxgI0Rl0n904=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R8MbyD/AYv83vXpCfRImiiZPoaeGMxTx8cSNlPnXleGwHpon3QPvM22QxAQ48CY3g
         Y2A8XxUNB8QL8qsHCSenGE0Ns2Gih0wjxm/SOB4ShOddGMgE05GaLmkzXqq5cDEHsr
         oaGRnXCVEr2dZFGzeCdAOb3qxEKYl0QHIN1bY9/k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200804150606.GA809710@nvidia.com>
References: <20200804150606.GA809710@nvidia.com>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20200804150606.GA809710@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-hmm
X-PR-Tracked-Commit-Id: 7d17e83abec1be3355260b3e4812044c65c32907
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fffe3ae0ee84e25d2befe2ae59bc32aa2b6bc77b
Message-Id: <159665962113.13939.11530932869371174519.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 20:33:41 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Aug 2020 12:06:06 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-hmm

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fffe3ae0ee84e25d2befe2ae59bc32aa2b6bc77b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
