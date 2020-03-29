Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDABC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FAF20784
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585505109;
	bh=IWfvkfvJkxpM4p7oHoAgZTePl4nhFRxYqe3rwLStxO0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fxB96SKXhPymigB+tnGbJugdlaQ8WyIdtCvLoUwEG+iskjcZ4TEoXegdyvn8xTpKL
	 eleoaEzO7sW7Mpk22t7d03pargecwk3q/WhC7n756wfBWTYDL+elmyBQ+UoTgH9CRZ
	 +SHDEHby+p46zzunPqkFIo5Iaa0E9VIcNkjYbixc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgC2SFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbgC2SFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:05:07 -0400
Subject: Re: [GIT pull] timers/urgent for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585505106;
        bh=IWfvkfvJkxpM4p7oHoAgZTePl4nhFRxYqe3rwLStxO0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xNy7JNTwQf2nBHiu1wn9mfVW3f+KAHj/JILY1uqCXfqtu+SeQhqa26SWf9nlUithN
         egRr/lBlZnCJiReMGoqrQbm/t5DKNwfpdXEGDdPMfbqhW0aQxc1GB+Tkb2LBmDkwyk
         DLfy6nbmTJ9JPuqh2tfOSgzFmhpt3MmY7AY5ouKw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158549780514.2870.11802053793870612265.tglx@nanos.tec.linutronix.de>
References: <158549780513.2870.9873806112977909523.tglx@nanos.tec.linutronix.de>
 <158549780514.2870.11802053793870612265.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158549780514.2870.11802053793870612265.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-2020-03-29
X-PR-Tracked-Commit-Id: 749da8ca978f19710aba496208c480ad42d37f79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab93e984dbb41578b41208cee52ce4e709951eb2
Message-Id: <158550510676.18128.12091390571694736108.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Mar 2020 18:05:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Mar 2020 16:03:25 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-03-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab93e984dbb41578b41208cee52ce4e709951eb2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
