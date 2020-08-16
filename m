Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE2EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 01:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 791012070B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 01:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597542935;
	bh=or1BcC2f50qZdlJbyuo6uPB0rU4k852IS+RXhF16BIs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cl3KYbJSoxbbQZdAiNYk28YmE5+QhXmOnp6lhrxKGumXG5wlVhZSjPKFgaEMdp0+6
	 Kmc030h8YRCO2j6yJS/AVZohbMVIdmZ/9Yn019TOBHa9UAO/tAzg7Huud/Xc7l0TwP
	 JizbpzUX0h7MuQOfCYMXexfaPgtqaN0cAdj1YXQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgHPBze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 21:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbgHPBzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 21:55:33 -0400
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597542933;
        bh=or1BcC2f50qZdlJbyuo6uPB0rU4k852IS+RXhF16BIs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gTA4bTJcsGUKGIhoeDWaL3fnsAjTkdZ+R58Et61j44iRRs9JaL7uup1Kn8fdswlIT
         GwrOB953PIX8Ck1TdLWZaJD/OI/sWeonIiv6ObepdkMuCVdHQk1VDX5cf9IilleH/T
         iQxV4HVvUBp4ivLoy3ENxLdo5pxXQX2UpHctkq4U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200815112133.GA2582267@gmail.com>
References: <20200815112133.GA2582267@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200815112133.GA2582267@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-08-15
X-PR-Tracked-Commit-Id: bcfd218b66790243ef303c1b35ce59f786ded225
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f5faaaa5909bb0b26dcd309424da14bdf0c7e93
Message-Id: <159754293307.18953.412353404308233388.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Aug 2020 01:55:33 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Aug 2020 13:21:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-08-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f5faaaa5909bb0b26dcd309424da14bdf0c7e93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
