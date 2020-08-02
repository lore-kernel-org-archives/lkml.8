Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A282CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 20:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86DC320738
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 20:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596399313;
	bh=c4HUa2zyd17N3zS9aSB4blKgePk6o1UMnLiDfPUG7fI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Qtf+TiT/19IGelji5VoIbdTqZc9SZCpxMZO7xbbb8zZbBEBFlNvbIDjs3AZXMMXrr
	 wEe3l+BpI/ht2MHk27PNenXUOuB8/hL9YkR02VxdPqV2fspKVMfL1v0PvcSG0sp6F4
	 PoRmhRYt/S/GKDTKf7L++3h3xYJylxGKYan/GxHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgHBUPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 16:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgHBUPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 16:15:04 -0400
Subject: Re: [GIT PULL] x86 fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596399303;
        bh=c4HUa2zyd17N3zS9aSB4blKgePk6o1UMnLiDfPUG7fI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pJz3kiGXanJp2gjnCja90nhge++/ig/+sbrglKcyxUxBXHUs6ww/8fNxBEvLoBYPx
         ZdOZncwnzoDNhNM1XsAZuGeru1PFlA1X5dkkhe4lC4W6v7Gl00YNN0fCnWuWWq5qHg
         kDc0RKpE3A2Iihi/mH6Y4fpF4Tw6IU3FGOafk+x0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200802191745.GA122326@gmail.com>
References: <20200802191745.GA122326@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200802191745.GA122326@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-08-02
X-PR-Tracked-Commit-Id: bdd65589593edd79b6a12ce86b3b7a7c6dae5208
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a30a78924ecd97b0335d2e1d3e01a5023c1a3d8
Message-Id: <159639930382.2245.9642040496773900422.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Aug 2020 20:15:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 2 Aug 2020 21:17:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-08-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a30a78924ecd97b0335d2e1d3e01a5023c1a3d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
