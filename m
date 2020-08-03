Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33748C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4480922CAF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596492623;
	bh=bg7I4TyIeOJslChEBpzmA3krPftBoJW+KHEHelgOODI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LO36d2CXg+Y4yKSaNT+y7gePf6Nv3gCARlFpV/Xx58AT4Y/4uczDmpXn3FhDZSBqU
	 JDSGXobf2R02oF44V3cbABBlnNSy6vdLvOuYUQ8crQPpgaJdJzOFF8fCXRY5P3P+vC
	 cvIO72GkXSiT3/H0TkSVw/x+9JgL9/Xkqw5ifB3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgHCWKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgHCWKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:10:05 -0400
Subject: Re: [GIT PULL] core/headers change for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596492604;
        bh=bg7I4TyIeOJslChEBpzmA3krPftBoJW+KHEHelgOODI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eSsnoYgyFEbnO8blkAUAcuhysxPtrymiiUcz1NLQzHTCED/D9T0PQOjcEykvihjWO
         r+QoN/AifyUtv7JVT9fTiMhrkJ1kyKNiA1YILX1I7/R1HGZEeyfoGhsCGYYZCraZER
         rd6yPGK5yXpWJfvGVtaBTtpC5TjV/8bulkNSgNqk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803111908.GA384254@gmail.com>
References: <20200803111908.GA384254@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803111908.GA384254@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-headers-2020-08-03
X-PR-Tracked-Commit-Id: d19e789f068b3d633cbac430764962f404198022
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ece08178d6567db5ef0090b1ae7f795c3c36161
Message-Id: <159649260475.26696.11132187862209551583.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 22:10:04 +0000
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

The pull request you sent on Mon, 3 Aug 2020 13:19:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-headers-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ece08178d6567db5ef0090b1ae7f795c3c36161

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
