Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6DEC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 04:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C39C2067D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 04:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589690707;
	bh=SweHTvu+PJIfFXBzOv61A7qSs3KErvxIRGR1py4o8k8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WLb7nddKNAH8HDG5zF6oFp+ybtUtuVVFQ0qUdtg2+77azGoIxKBEYbM3oy69VLLee
	 ugbyPx5gtFWIBS/ChC9lQeI7j5SgXr5APfMvpdCzQhN3XIOMmFJQ+xYodpJt4dbLlb
	 RKc0CQQc5QiU3R7fmVCBCsYlbysDPgLPtZIfT5mQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgEQEpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 00:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgEQEpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 00:45:04 -0400
Subject: Re: [GIT PULL] KVM changes for Linux 5.7-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589690703;
        bh=SweHTvu+PJIfFXBzOv61A7qSs3KErvxIRGR1py4o8k8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=acPE1HDrBFlqB9DP+6dKn7AaXhvBvCFajBbVyqBzBfKRg98NtwzUjJeBLdpALRWUe
         209rWm8pe0OPVkcLcx1LAO6yt6t+YDJ9HNd+nvljWnTDQV1U64n+evHO7oXfjypMKX
         OZybL6PRPUZerRSWXssFELVCnIyfYZI2aamgMyPQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200516122413.693424-1-pbonzini@redhat.com>
References: <20200516122413.693424-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200516122413.693424-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: c4e0e4ab4cf3ec2b3f0b628ead108d677644ebd9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d438e071f09845f0abd1464b52cddee880c2364
Message-Id: <158969070377.26561.9873386854860145706.pr-tracker-bot@kernel.org>
Date:   Sun, 17 May 2020 04:45:03 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 May 2020 08:24:13 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d438e071f09845f0abd1464b52cddee880c2364

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
