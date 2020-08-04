Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AC6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462DE206D7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596502240;
	bh=GGAVXvbbsk0XQfNCW/27/xW22+cvOh3aEcfQ5Gemc0E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tRsUJFwqs6PUVpkE7sRYTfyLTCBwr+m1VZnmC+r7iQjRH2q27YNABF/0EuUbjGpCb
	 dhrM+IqJBhkkmz1Dd933TwetwtUgP4HtjxnT3NhvSsPzYXLx/uFgB+7vTK1zub6aF/
	 zJ0AnpcGUDHJJ1KQ1HACSFbjqydD9s/FFVpQEDjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgHDAui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbgHDAuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:50:05 -0400
Subject: Re: [GIT PULL] x86/boot changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596502205;
        bh=GGAVXvbbsk0XQfNCW/27/xW22+cvOh3aEcfQ5Gemc0E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SFMP5M6LbdM940LYcpDCzwiwPStwKoEWFUNK945LsZ8+4iNtL+lX/UTFLxTledP24
         q/T3E6X2085mWThvRDT+Hz2xMpHgQgrxGYoS3M56A90uF7O84EAPBqp5RNtHLdJ8mx
         7TXZjqRoI8QeqtgJ7E+ypidG54BTbZD1Y+x1jbnU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803165641.GA823733@gmail.com>
References: <20200803165641.GA823733@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803165641.GA823733@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2020-08-03
X-PR-Tracked-Commit-Id: 1ac1efa5f6950f8f126f2c1921bb699ce009ec7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0dfadfed87489fa6126ece161a14c2d15dbdc79
Message-Id: <159650220549.17631.12677951992044435157.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 00:50:05 +0000
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

The pull request you sent on Mon, 3 Aug 2020 18:56:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0dfadfed87489fa6126ece161a14c2d15dbdc79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
