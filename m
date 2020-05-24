Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611EFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432B92088E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590341407;
	bh=32qJ41PVy1zAsvyZ1pWwSeXjsqDthA+nUwhb2vX1ANE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=b1Hc5exU+pSmQ+QVNJCcxQnZAwH/WVRbGU/vU0GzG/mqtxKLhcACADM1nGhSTwklL
	 pLNmEytleLZ09Eegg9CDHQZslj3bJnBmSdrKExyHttned3N+UUYe9gt5+ey9wkU01b
	 Ll2TUZnLs7S55RGLIdecgjGYJkMbZay5VJHdT0NI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbgEXRaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 13:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387825AbgEXRaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:30:04 -0400
Subject: Re: [GIT pull] sched/urgent for v5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590341404;
        bh=32qJ41PVy1zAsvyZ1pWwSeXjsqDthA+nUwhb2vX1ANE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=a3nblEdzwBmTcDDXD/atza8UnXmeYpRl0g3JntLEfTIpYTkG+3Pr+6IA1et+T+Mcb
         WG1g87xJcLWfur4tVGLYer4zwYCLwGN74Mm28d1Wcq4407+b5X1A4BbINAStt0lzEy
         fAROOwNig1SKchcTKwWg7Zrw90pP9BA3nIpY0Cxo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159033288238.21635.76261789367356025.tglx@nanos.tec.linutronix.de>
References: <159033288117.21635.13199705716119914103.tglx@nanos.tec.linutronix.de>
 <159033288238.21635.76261789367356025.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159033288238.21635.76261789367356025.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-2020-05-24
X-PR-Tracked-Commit-Id: 39f23ce07b9355d05a64ae303ce20d1c4b92b957
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e61d12bac206e5e70176734604371ac3a6e50fd
Message-Id: <159034140421.27315.4928119136895804764.pr-tracker-bot@kernel.org>
Date:   Sun, 24 May 2020 17:30:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 May 2020 15:08:02 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-05-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e61d12bac206e5e70176734604371ac3a6e50fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
