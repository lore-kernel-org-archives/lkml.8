Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B087C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D50320784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585614320;
	bh=kGpv+gTotwsEWUxJEDSu0IRGbFxdSuFup9aSkxmXTQU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VQjJYT6q1F5mtiVwY9KH9/DQJh1eq1pdztyGEwz98P98f/9ZzcUWeRAMWCHC33n2k
	 ye+JWkpumkiNoR/CMRSjy4oO/rtWBruJd/5ME6G+WNgEYOfZdTlIKmlN/GnPBxqraJ
	 WzlxX7gLzRfnCE4ka65+EhxevlkzqtYosgqs+wRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgCaAZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 20:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729624AbgCaAZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:25:12 -0400
Subject: Re: [GIT PULL] perf changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585614312;
        bh=kGpv+gTotwsEWUxJEDSu0IRGbFxdSuFup9aSkxmXTQU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=blqlPfCGNUai8wfbuFiMlirQ5P5xRVogeFqRN9eentAw3tvFsNoyY4kxJRujvFuUo
         daATAiJ+SXtteNb4zQgdWtvF125cRpaCioRmOSVeP/e8X27tbKf8r1p0JAOC2b/2xr
         Lnic3jxLYgWD4w6ghjuib5WHrLKVUc5ItuLvdbYg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330170252.GA125774@gmail.com>
References: <20200330170252.GA125774@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330170252.GA125774@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus
X-PR-Tracked-Commit-Id: 629b3df7ecb01fddfdf71cb5d3c563d143117c33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b82f05f869a823d43ea4186f5f732f2924d3693
Message-Id: <158561431236.380.6138358059255642016.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 00:25:12 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 19:02:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b82f05f869a823d43ea4186f5f732f2924d3693

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
