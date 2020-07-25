Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E160C433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 22:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431DB206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 22:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595716215;
	bh=LiH7ghpFyjIxyFjKFEpsMpPqnVCzGwVcSJlmToPZAAc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=e6ghdusBj6SFEo9RrynWhZrewhBn5RmgcIaH24IMjtMl11BRRKO+AL7Bq/kIAknEh
	 ZvyakO16NnL1VXDWncFCTGPtAAvqL8OHRXEBbNCclzDGyHY4dnu91rgLvKULhSPEyr
	 Arv/2ZAbPNSii//2GsJ54FBeuc/LpBG/+WT1sYLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgGYWaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 18:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbgGYWaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 18:30:06 -0400
Subject: Re: [GIT PULL] RISC-V Fixes for 5.8-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595716206;
        bh=LiH7ghpFyjIxyFjKFEpsMpPqnVCzGwVcSJlmToPZAAc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iy+zFC9XEdxro1O25f5vVsUzSczJ5EWorn8G9q1yh9/j2OUL43vSoetRGWxlEyITR
         oSWW6DGMvnCzujWxDLk0viFLg3a+CBD98/vdc6+bCnJBTBm0HdEeiYsj+isgJkvxsw
         4hA2HCWq/rZpzgGq7XxO16L0bS+Lc00XEj29JRBs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-f2bb3f7e-e2d6-48e5-a8f6-5e47edf5441e@palmerdabbelt-glaptop1>
References: <mhng-f2bb3f7e-e2d6-48e5-a8f6-5e47edf5441e@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-f2bb3f7e-e2d6-48e5-a8f6-5e47edf5441e@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-linus-5.8-rc7
X-PR-Tracked-Commit-Id: fa5a198359053c8e21dcc2b39c0e13871059bc9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04300d66f0a06d572d9f2ad6768c38cabde22179
Message-Id: <159571620619.7388.9227787519310326935.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jul 2020 22:30:06 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Jul 2020 11:30:54 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04300d66f0a06d572d9f2ad6768c38cabde22179

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
