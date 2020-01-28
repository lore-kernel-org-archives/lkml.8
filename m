Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A03C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A7B2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580238616;
	bh=fcxwyYOqBKLYimEaDQaueJptGRRYjA3xmvuKGMucBKk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ujm4Q/NS9Lz9pLcg9GcqFx4Bcans/Jq9URX6q58rHHQnizck+7e+jBFKPwDo8Hufy
	 rIueJo9INO1DnWIL3bbWpAbXRxCb45216C8M5MrgiE0bV6nRikckpoXD2vFFjjasEV
	 lp1h7vXgg4+hBjq6YXlBIuWQzItzCCB4k2+LDhdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgA1TKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgA1TKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:10:05 -0500
Subject: Re: [GIT PULL] core/headers: Clean up x86 header interactions
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580238604;
        bh=fcxwyYOqBKLYimEaDQaueJptGRRYjA3xmvuKGMucBKk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1fwWChCvksHlguU2LJeuaKKGoSVxSHpmCqh1rnAt5RFQ9XNyw2YLA1waVV+7cSrVY
         oqF3jaUfrYX9RqXDBw0NB++CGX436MKPr0/5nKR7yGR4OCXILD25/xfDgXCZgRxbeI
         QXN0GxwQgPNyB+/AyLopwiR/UYLscq5IOL7mZ0u4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128065852.GA18416@gmail.com>
References: <20200128065852.GA18416@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128065852.GA18416@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-headers-for-linus
X-PR-Tracked-Commit-Id: 960786422fe90a86e81131f5dbd902cb5ebf8760
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f2a43019edc097347900daade277571834a3e2c
Message-Id: <158023860452.9583.12300508489625168349.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 19:10:04 +0000
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

The pull request you sent on Tue, 28 Jan 2020 07:58:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-headers-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f2a43019edc097347900daade277571834a3e2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
