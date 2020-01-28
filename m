Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A657CC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD982467C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580175317;
	bh=QudoQNuGwseCEQZJrFZnJgG/QlZ16kkcVre5voiSqAg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=O9CiFB8Vi2mbcRRL8aYRfLsBrWw1btsvn9uXXk0rQJl4aWA2fo42Umo2WKR5OleU9
	 pqk2sUMlZGr10My17Q+r9ErnN1j7RKlWpncukvBscJKRL9XbmfpOAGfWaJiuKoLtVd
	 QFUCTDyDiaB5tlSTWyeNMTgpoWjusqWAr6WJxuGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgA1BfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 20:35:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbgA1BfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:35:08 -0500
Subject: Re: [GIT pull] irq/core for
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580175307;
        bh=QudoQNuGwseCEQZJrFZnJgG/QlZ16kkcVre5voiSqAg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nEaUHoWJ+21k41Rk6mA6Ts8xUb8iA1dTtytLi8RlNwrjYAqJVJXYrH3tCKzsvJgPd
         KKf6DuJ0oUfPGoiW9+IrPdC2BpFa+KZVz+6/r3dRnQeBAgG4FldmYxOAqY70u11M9f
         8QMKRjJ7eXtV0w6CKUgR/ncKfHhrmGWCrWePvzdo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158016896589.31887.14545084921211172429.tglx@nanos.tec.linutronix.de>
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
 <158016896589.31887.14545084921211172429.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158016896589.31887.14545084921211172429.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-01-28
X-PR-Tracked-Commit-Id: 43ee74487bd2842cb4d37b5c62f074fbed2366b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d3b44a61a9cfd268fc071ea1b1c5dfea7ed133d
Message-Id: <158017530781.6677.8000989710436332928.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 01:35:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 23:49:25 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-01-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d3b44a61a9cfd268fc071ea1b1c5dfea7ed133d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
