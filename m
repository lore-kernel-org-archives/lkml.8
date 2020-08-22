Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAADC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 17:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DBD0206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 17:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598117544;
	bh=CW0BFa3lqAoKRheOJs8wvJct9GqCYqUGvshYzWb9CQ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=A3jp91Cbc3Dxjx5tDpIlJeBPm67PCf95wcmJ+75rb72t2ErhPGXm8Blv2cvEBCGkk
	 ANPfk0RoeU5/DykLi9l1SDZZgBjJRAbjUQcHLRfZRZ41ndjzmKBLqVFa8/eGw4UexC
	 dxCzTYKUGUfYMlcxAGX6+TBW9Y2wh/TVOLK/5WNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgHVRcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 13:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbgHVRcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 13:32:16 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598117536;
        bh=CW0BFa3lqAoKRheOJs8wvJct9GqCYqUGvshYzWb9CQ4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RxOCnYR7rAKMRGNcL2eSAiU2co7gK5BUD7k5CCgtlmHOy3JZuH0z74CjQTqtkPzF8
         wsUn4eGpBwhLZ2NfEo2fsNO50K/GmOQD/602YKDRU2Ms78fS3X5UPWzhBpnJwt4qJ7
         fdK4OTR5udA06ExUi9U6+d3bV/n+IUi9Xus3x/kQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1598075304.3547.4.camel@HansenPartnership.com>
References: <1598075304.3547.4.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <1598075304.3547.4.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: dca93232b361d260413933903cd4bdbd92ebcc7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e574b74b781f14fa7348ba8b980b19a250a9c83
Message-Id: <159811753625.17427.14465916040387699392.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Aug 2020 17:32:16 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Aug 2020 22:48:24 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e574b74b781f14fa7348ba8b980b19a250a9c83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
