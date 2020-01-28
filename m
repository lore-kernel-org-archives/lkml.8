Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C304EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD3624685
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580246106;
	bh=SSlxifBdAKf3yqLV5UqVb1+/rphQVJ1iZrau1mVanfE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=akJNLdndH9unaLOHE8wVsvIY+H1Q6+WvSwFNaGsTK687TXtKMV09LidoYnyWeaM90
	 7wS37Pw+VRE4xbDSHIBLDnXJNbEB0e/iw56fe5qWAddM3Wx+Oa1+dVcYAGMAuXMKPJ
	 DEA5Pzrcj49lF0839bUHqfM/sS09zrPx4QHwT1Qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgA1VPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 16:15:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgA1VPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:15:05 -0500
Subject: Re: [GIT PULL] x86/apic fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580246104;
        bh=SSlxifBdAKf3yqLV5UqVb1+/rphQVJ1iZrau1mVanfE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Njua0Wqr4nJRhfFgrcX6yw6KKdeu3BJEveU0NvHDbEVuMDqjkeXfm31N9jF2UOFrN
         zbJtgT/chYdyWdgTAr9D6Lr6134uqlXJYfQyPGDSDahs50QAfLoE9AOpy/YcLDLQmV
         SNsO/QLFNTRoCLTTus1aP6UVSR2nt8pHD03GzT0s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128163530.GA122391@gmail.com>
References: <20200128163530.GA122391@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128163530.GA122391@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus
X-PR-Tracked-Commit-Id: d0b7788804482b2689946cd8d910ac3e03126c8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 435dd727a411004d9402ad0c868c958408271a48
Message-Id: <158024610490.20407.8232767933881946579.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 21:15:04 +0000
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

The pull request you sent on Tue, 28 Jan 2020 17:35:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/435dd727a411004d9402ad0c868c958408271a48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
