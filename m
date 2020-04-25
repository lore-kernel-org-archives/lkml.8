Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2C1C55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795D320714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587843029;
	bh=CnZqMUAwi7S3w6ahtvbwVWaw7SI6PbXGIraN3nPdiQA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=m+DgytalljHL5VQoosalTiBCU8LwB5A9KfclNlYm/GNfrlzDXy31vDbOLBUsjAMHQ
	 VD3fRxm7iEq8lHmdUtmJKFN3FAxgQxj1LuLd6sH6+JTg5/NmQxiJrkRpOHcpm70Xfo
	 bi+ckBkcuog5902muuSHSrjp1ymE8EXz4Kozy4DA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgDYTa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 15:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgDYTaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:30:17 -0400
Subject: Re: [GIT PULL] timer fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587843017;
        bh=CnZqMUAwi7S3w6ahtvbwVWaw7SI6PbXGIraN3nPdiQA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oIThm/mfIonvbmbNm2A1tELITO4fooFdQH5QYj4e5mgpJR+kv7YXstDaTiMRoU4o7
         NR4RD3hXvEy8HiuvvyadE6XjKgGCgnos3k7ufOcRrIQWUJ7q6ivY+W9GxTSDAqejeZ
         BKlPqISXI5TMu6gMDBqF1srRGkj39+brn6qng8HY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200425101611.GA70989@gmail.com>
References: <20200425101611.GA70989@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200425101611.GA70989@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-2020-04-25
X-PR-Tracked-Commit-Id: ac84bac4062e7fc24f5e2c61c6a414b2a00a29ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acd629446804617a8fe4700fc4ca16eb44aa4efd
Message-Id: <158784301758.5802.13130276554656212055.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Apr 2020 19:30:17 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Apr 2020 12:16:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-04-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acd629446804617a8fe4700fc4ca16eb44aa4efd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
