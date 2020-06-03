Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D33EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 21:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E796A207ED
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 21:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591218309;
	bh=+ErPN/7jHEDGnx7xqGyyRyJbNyje75rdqmmSiJvKlZQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wndD0vhGlLa2KSdlBJxY0QeQ74c+GC/7rePiXlMD0Ox2d/sVKvab4RZRkjOnvP70T
	 c2oZDnILsav2HLmp82t/jdLb7OmHCOrIX2vv7Ac1RaCrOnDH3vBb5enl/kSg1UfP11
	 a5fsADDXiYD9vSrF2Gp01eOdtIMmKCYc1Qp5UV7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFCVFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 17:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgFCVFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:05:07 -0400
Subject: Re: [GIT PULL] scheduler changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591218307;
        bh=+ErPN/7jHEDGnx7xqGyyRyJbNyje75rdqmmSiJvKlZQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N5d1L/9WAia/vpV2skufCfPLO4JgbrzDX+xW5eln25KWdhvtuoPXQYukJeNH7s+On
         WYDg/V8xsGHfqgRmexGQFCR5hWwXgKxFIgsDqVbvUdq0c8E4hkBbcTs1mZ6mZ6a6rB
         GrSTJlftwu1dFzrg7Ed8/57c4Eh5poCcp8dt1S9U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200602121352.GA3812351@gmail.com>
References: <20200602121352.GA3812351@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200602121352.GA3812351@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-core-2020-06-02
X-PR-Tracked-Commit-Id: 25de110d148666752dc0e0da7a0b69de31cd7098
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d479c5a1919b4e569dcd3ae9c84ed74a675d0b94
Message-Id: <159121830707.19900.90209284103993358.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 21:05:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Jun 2020 14:13:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2020-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d479c5a1919b4e569dcd3ae9c84ed74a675d0b94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
