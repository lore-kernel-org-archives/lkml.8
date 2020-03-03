Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3CAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D4C20842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583278516;
	bh=ZJrGth+dKSoxgkCLTLKaJRqJHUrvemfwsAqeuBLS784=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=15SIjiua5eykWg7oar5dQi7PtgXEIW2oHrtxnwRuqepRCKLa2NiukQzOtI/bWS0uh
	 r2j84W9C8NPVt8Fi+8PYbg68kFOnJZcb7QYO/Hh9fDUfGshsY4Eddyd40kWT3EXBTa
	 uwkHj0+nBnjJggiQUOSSQTaAxxrbrRl5Tj/z8ysc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgCCXfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:35:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbgCCXfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:35:06 -0500
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583278505;
        bh=ZJrGth+dKSoxgkCLTLKaJRqJHUrvemfwsAqeuBLS784=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JK5QU1ECtZ+HEKYJfg2urRE1lFXSkBf0iwvlOQsjl/8mZv73o8Rq/SsJsMLlamYpM
         9uF2rJSE+zn0ioQPTT2E6mZIV9Cf8qd7BpCQyKmkEV375ImmMn38k/HKyFYZmH2a9I
         KExUUDLhJMM0RUXdOy8mI06FtAkBjEnTQrJj0MQ0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200302084954.GA21837@gmail.com>
References: <20200302084954.GA21837@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200302084954.GA21837@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: bba42affa732d6fd5bd5c9678e6deacde2de1547
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2873dc25477f483997c99981cf14b43a0d4f84d4
Message-Id: <158327850587.6555.9216145818265396663.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Mar 2020 23:35:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 2 Mar 2020 09:49:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2873dc25477f483997c99981cf14b43a0d4f84d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
