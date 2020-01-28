Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6492EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3232E2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580246119;
	bh=iyUKrpESJgiDHBBItwIowRh9nat0Ciorms1cU1Ac0AI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=T7RpLakolJF1StqhWwfcrp4LfXnSwJCr9sUVRjfaDMfk/lVBYvv6t1bRvkSLtkgZP
	 VQ8kdHElxtj50lEonrpvv40f0xgt19i15NaRGdr8/3gEw0hAiN+UvNoIW1w9EUMrfj
	 ThqmF+IRIM4Cj3DVPBhaIl17P86PCe5zb1zcIE5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgA1VPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 16:15:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgA1VPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:15:09 -0500
Subject: Re: [GIT PULL] x86/mtrr changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580246108;
        bh=iyUKrpESJgiDHBBItwIowRh9nat0Ciorms1cU1Ac0AI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zeZfA7W9B1RfgOfMPFwbBU5tXdE5bMF131q1P8CZBU1GSAXoD9o4ojop26cwwU3y6
         jPHC3svh+hUKeqb74SJjd/qgwuV0W07MyayzHmePyvETf0KvLsvf0hidKtI2jrK0wF
         mZn/ipkvWcOyIqeovyXZHu+fZhAM7SkkEQMzDea8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128182911.GA109695@gmail.com>
References: <20200128182911.GA109695@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128182911.GA109695@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mtrr-for-linus
X-PR-Tracked-Commit-Id: 4fc265a9c9b258ddd7eafbd0dbfca66687c3d8aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 511fdb78442229ac11057b4a55c3f03c253c062f
Message-Id: <158024610890.20407.3416300164111779319.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 21:15:08 +0000
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

The pull request you sent on Tue, 28 Jan 2020 19:29:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mtrr-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/511fdb78442229ac11057b4a55c3f03c253c062f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
