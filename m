Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B72C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5322074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595029506;
	bh=GBoAZFxI1M8YUQ7VXJnSqv3kwgFaNrCQiwjJt1/64Tc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SHFQqDBbgUbo5mn1D+ybIs2u2mKS5XrFgLJ75vC1arl889QuAFTSjOC0BrP19//QZ
	 RapY84+wQtGEfUKNNf5zPze7X7ifVK0r5YvAMyvVUso8otPwUDSSbDmWZFc4SMXGsX
	 0d7l/FgFI/qQFPT8XTd1PuAR6kDwmMzvblMfef+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgGQXpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgGQXpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:45:04 -0400
Subject: Re: [GIT PULL] arm64 fixes for -rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595029504;
        bh=GBoAZFxI1M8YUQ7VXJnSqv3kwgFaNrCQiwjJt1/64Tc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Bu40Oh8iBp9PySgHLazZXoliXta1qNHVGxGOWFF/rrS3wi3by6w33qxUUpYo5Fg4d
         poOK0sLQ3P/bFVWytnsmiL5T3JZs54tU8vpwffAVT4/HThY1TFNARVZW5VRb2WaRY3
         gxHiLqmIgvS7y1hEudcwfi2ofvthgApUFzp0Jz1g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200717152020.GA9056@willie-the-truck>
References: <20200717152020.GA9056@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200717152020.GA9056@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: f32ed8eb0e3f0d0ef4ddb854554d60ca5863a9f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a570f4198906a88b959ddcc56ddabc634397e810
Message-Id: <159502950417.15008.13348362614299347178.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jul 2020 23:45:04 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jul 2020 16:20:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a570f4198906a88b959ddcc56ddabc634397e810

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
