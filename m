Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9931C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA4320724
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593200427;
	bh=sumYEiYj4agMZCjapVLL0DEwnnKEekY+2rshZJfFCB0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Df0rVHI+s1L9Z5ZNZrhIB84fL914LCJpCELLtqOy9eJ1c6qgDAXexc0YHpkuLJJqr
	 SkykUBVlRrzEgNkZVH0axzo+pyNjRuPEdwFzwMPJup2FbIIwCIn2MG66qsPhFNnQs+
	 bkkdDCY1Xh3vyo92tpZ40sDLe0eiWi1BrGrnTuGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgFZTkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgFZTkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:40:14 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593200413;
        bh=sumYEiYj4agMZCjapVLL0DEwnnKEekY+2rshZJfFCB0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hsSiGlPiREJWygTLSYSanI3tlSUPDi2fEj7B58UhiVj90BcKg2bY+CkxD28RXAHmb
         EsSP/WiITGDBeMxoo1pm85nGrmAEauCPugT510kKDmIwt7YLDcxcs0N5vf/fEQpp2B
         zZx/2dy4Sd1YDAOO+Wdw0TEAAkjpMAxXtCg7CcfM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200626144655.GA20234@8bytes.org>
References: <20200626144655.GA20234@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200626144655.GA20234@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.8-rc2
X-PR-Tracked-Commit-Id: 48f0bcfb7aad2c6eb4c1e66476b58475aa14393e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd37cdf8ba1b56a968173560314398d5d3b2d37a
Message-Id: <159320041384.11855.1244021860580748750.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jun 2020 19:40:13 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jun 2020 16:47:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd37cdf8ba1b56a968173560314398d5d3b2d37a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
