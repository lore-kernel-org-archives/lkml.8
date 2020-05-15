Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F01C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B7D20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589572805;
	bh=ukGxNID2VrjPL0mLqlzcVmDQqrmdh107FnZjZfBj8+Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=s9BNFV++v6JYIetQL3TI0W4+CxpsR4nrC+i0jpJ623Q7ve0vucBCkQkywhwK15c3f
	 ss+SoN/3NBQ08HsrPdYa/D9TWr80/aUKjNvIZYT941xHVuT43fhp6Od1jVXQFhjZ34
	 /ZFYVc6zuRIFPByLnL/PCLpstjigr8yYWfNoQA1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgEOUAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgEOUAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:00:04 -0400
Subject: Re: [GIT PULL] RISC-V Fixes for 5.7-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589572803;
        bh=ukGxNID2VrjPL0mLqlzcVmDQqrmdh107FnZjZfBj8+Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0Hxihb1CHr/tmFTGBDgBOhE0DmT3tl/s8Gyty7PynH0FcMrCvspYxpoo5rarj9W1p
         CSUSTTppFs/CH/rDBHop5HuUAS4S6KFd+b58pqAKUfg7OytpokeVF1rY5HWFIAIIoD
         ZDWaKff2Q6lxVvMg8O6VPt9/ES3zgwWpE47hTemU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-0786a015-369a-4f54-aa78-f4550588e4ef@palmerdabbelt-glaptop1>
References: <mhng-0786a015-369a-4f54-aa78-f4550588e4ef@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-0786a015-369a-4f54-aa78-f4550588e4ef@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-linus-5.7-rc6
X-PR-Tracked-Commit-Id: ed1ed4c0da5447c5e322481ce2ef9f03336c6ffb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67e45621af060a2de53a1ba24d052bd33c3acaa3
Message-Id: <158957280391.8762.3169691296478881193.pr-tracker-bot@kernel.org>
Date:   Fri, 15 May 2020 20:00:03 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 May 2020 12:01:15 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67e45621af060a2de53a1ba24d052bd33c3acaa3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
