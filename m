Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5F1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D25D2076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591048522;
	bh=MNfSQYkjP7Di5EJYjsrvZI8Hp+0dwfqDmkUWYIe3jm4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NzIeC06Hn17imD5OjfpluIFPPvi7Jk/iKAIkYupp10aQWt2XN8qnpvDtW3Oab0G2I
	 7V+I+up2VNZxoBxqrcHR9u28e3gGKg1qBELuMCSYPoIVe8BBXHVqHe2QcUhN3idwx4
	 ZKr5U8RJlhXA8+vPGmIfdCfAWPc7aLIYBfRp7hK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgFAVzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbgFAVzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:14 -0400
Subject: Re: [GIT PULL] x86/platform updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048513;
        bh=MNfSQYkjP7Di5EJYjsrvZI8Hp+0dwfqDmkUWYIe3jm4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dF2aiiOGCdiQDXkeeu7hmUnCus2HwifEQGukCXLqQYdza1E7fjowr0h0n0BtziF+T
         npOlV5r/47XwM8B3wjaWxJ0cYtNA2rnAulCvAm5OI2Eidk6BAMO3If1dmTQ18lT2aP
         3m7dIkyBq9YwAGdr0Ropgq6Ef6e655I8etdnrFF8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601170500.GA1392237@gmail.com>
References: <20200601170500.GA1392237@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601170500.GA1392237@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-platform-2020-06-01
X-PR-Tracked-Commit-Id: 33649bf4494c1feaf1956a84895fcc0621aafd90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88bc1de11cf5b5fa14dbeff7c613ce62fdfae7f6
Message-Id: <159104851371.21074.1770085638139458881.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 21:55:13 +0000
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

The pull request you sent on Mon, 1 Jun 2020 19:05:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88bc1de11cf5b5fa14dbeff7c613ce62fdfae7f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
