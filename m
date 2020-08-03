Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CC6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A913922B40
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596492616;
	bh=UGx3K91HkiSxecGTX8NZ5ZO9EAIcr58jAIBdAP9ykBg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gOqNBFBmKI/fFFL660kpll3FLhGo9dr5LA/TxDMTW5TKCJHE5NCGLzoYraVuoe9/V
	 kCDYqD/zYF0pHFkytgZCmoWAdqX9jh0I1/ZM4sF2+1AdzNcgQAzNZm4WocJVEBVqQN
	 MZ0wb+8GW4LEHTXWDIdLlyw4IseYsrphI0sIGen8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgHCWKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729515AbgHCWKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:10:07 -0400
Subject: Re: [GIT PULL] scheduler updates for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596492607;
        bh=UGx3K91HkiSxecGTX8NZ5ZO9EAIcr58jAIBdAP9ykBg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MR/hqqqtY9jjX3uJUNPFOKDZQQsGVCQa3AVaIUGgAEiGQYHXpcDQlr2OtxgzN5shm
         13E9xFm0SZXn+UYlpWhl3r1t/vy2mP7XgRW0IN/DB/+O4clxeuVRBDtVBQRMPIjRMH
         k6+6D7zP4/u/CEx5T60u7a9RwH+Wk/JJZch1HK68=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803145519.GA633133@gmail.com>
References: <20200803145519.GA633133@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803145519.GA633133@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-core-2020-08-03
X-PR-Tracked-Commit-Id: 949bcb8135a96a6923e676646bd29cbe69e8350f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4cbce4d131753eca271d9d67f58c6377f27ad21
Message-Id: <159649260694.26696.3677446521502368285.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 22:10:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 16:55:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4cbce4d131753eca271d9d67f58c6377f27ad21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
