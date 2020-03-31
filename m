Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECDFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 03:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951EF2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 03:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585623624;
	bh=1peOCfAhlg/lTQ9/wg1xpmZ4pk9ATZZ8NnEpARbJxiw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yY72FlKyACaMOo8ikqvhR60rKtx3nJEeP3OXpBEuPSNVZszocU6QLD68t/Jt+YikW
	 mBNrmJqj5bHKFiT/pLWZBT9gJXRQivn13/al4pZcgY39AgfTeQnD2mguXoFAu3lBBp
	 WexSkadkrCMXCqqh2GEI2JLuvoSLztovyEjxFid0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgCaDAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 23:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730333AbgCaDAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 23:00:17 -0400
Subject: Re: [GIT pull] timers/nohz for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585623617;
        bh=1peOCfAhlg/lTQ9/wg1xpmZ4pk9ATZZ8NnEpARbJxiw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yYzhOo5TLBxewbErQ7/7kjYwUQZK6ulUrE81VWr969CtiWgmhf3Izj5bn7gVWYNCn
         ATazBZB0G/SgQtSJ3xShlk8U3nrkqQYB18lHR0gvuKgQ1NG7sJvHEaSlGb1FWnWLoN
         gfsxMPRTmRDRBagCcU72JXGVZbfdVaBmbwAET19A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158557963316.22376.738267793153757956.tglx@nanos.tec.linutronix.de>
References: <158557962955.22376.9136086165862170511.tglx@nanos.tec.linutronix.de>
 <158557963316.22376.738267793153757956.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158557963316.22376.738267793153757956.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-nohz-2020-03-30
X-PR-Tracked-Commit-Id: e4970c9c54d7cb4edc24d82ed27aef69aaf593de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 336622e9fce7a0b8243e1cd9f6e1c24d96f13cd8
Message-Id: <158562361736.8590.16449821837546208700.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 03:00:17 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 14:47:13 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-nohz-2020-03-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/336622e9fce7a0b8243e1cd9f6e1c24d96f13cd8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
