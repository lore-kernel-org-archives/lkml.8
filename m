Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F62C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D4120738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590174307;
	bh=0rVtqh7fRvqxE3tVjH+rOOZTyf5e1uGhHW9Vzrt3L4U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UyHxMvwUMfPM9qks2aEvm7zTRn0LDGudZokwnzamUqgvr2dZShsDUUezAO09MdPFQ
	 yFzYnYPiAxfKPPUQeDWxr+ctPdnVwRJCyVJDMfvQKaZuW9Os3AQrb/MSs2bvCn9MKj
	 tyBld8J1xVmZtrLIglUaH4QXN6YS9ohdNc7Vufgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbgEVTFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 15:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730867AbgEVTFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 15:05:04 -0400
Subject: Re: [GIT PULL] RISC-V Fixes for 5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590174303;
        bh=0rVtqh7fRvqxE3tVjH+rOOZTyf5e1uGhHW9Vzrt3L4U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o19SXLPlHrKpcgS17TTk/uERx6vUemO5t4hfp5VX0BffI4YDJS4gGbQcfVYEBTB8h
         b3MC4gjBNaIyHGoCcSwO0YK8bqvaho6dIb7NdK2VEAbKe9m1X1mXRgybDH2Jysf8pr
         zn62slQfbe5/0+NK8nAvgyBNakGrx3c6WqKgus24=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-258df3d4-aa39-484e-9fde-7d93432f3205@palmerdabbelt-glaptop1>
References: <mhng-258df3d4-aa39-484e-9fde-7d93432f3205@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-258df3d4-aa39-484e-9fde-7d93432f3205@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-linus-5.7-rc7
X-PR-Tracked-Commit-Id: 8356c379cfba8b1b90b0a2423f6afbbe2cdc5d91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b09ca17a2a082299c787025b6c3e614a24a24ca8
Message-Id: <159017430370.18534.962452857450653471.pr-tracker-bot@kernel.org>
Date:   Fri, 22 May 2020 19:05:03 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 May 2020 11:01:05 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b09ca17a2a082299c787025b6c3e614a24a24ca8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
