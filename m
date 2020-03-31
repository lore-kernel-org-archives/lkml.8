Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B16C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC80212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585682136;
	bh=nBMQ81gUbwcGyRMaV2E7zF1le6R6ubD9buwGx/4DA90=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OCm9u5G6c/7CSQSTeP+Esw2j7dzHKE2h0nDqyGKuVHSaPCFaiNtbc0kJDtYsuhx72
	 m1KoLLR8+VxVBcugckmPokp6QYzGAekntTwWu/lop+tQt9pmivoXEYq97bIgxOJhUf
	 c9TCCXAUxQXVTZdKiYvNG8t46eAX1e60AKa5y3oA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbgCaTPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731379AbgCaTPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:15:16 -0400
Subject: Re: [GIT PULL] x86/misc changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585682116;
        bh=nBMQ81gUbwcGyRMaV2E7zF1le6R6ubD9buwGx/4DA90=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WnnMNiNaGxvOEPBdj9wDsdgsQsYzgPUS+y5dBjy8WGh/NqiC4uIKZz8Io5jvJIpWG
         i4c1BULFT0elB1XBPHX3wKeUlXECfvAcfsTmFqNS3ssXQK7trb8mS1kYPCNDMqkzes
         Z46mnzWPkxSRK/TQy11X5ShuEgoRUIKaCz5nybjs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331083755.GA70287@gmail.com>
References: <20200331083755.GA70287@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331083755.GA70287@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-for-linus
X-PR-Tracked-Commit-Id: 1032f32645f8a650edb0134d52fa085642d0a492
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cc7e93519278401fcd9dce599296afb47e1f6ea
Message-Id: <158568211598.28667.7611487793955871702.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 19:15:15 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Mar 2020 10:37:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cc7e93519278401fcd9dce599296afb47e1f6ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
