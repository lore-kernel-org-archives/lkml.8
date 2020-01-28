Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C04BC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38022467C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580175321;
	bh=8P4tKsHn4BJIyUqeDLor6y8yVhYtIQO7itZnd2K8bVo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fRHL7A62vepGlwwrnCH1NU8d1hkJhnk9/DF3aPcT6JzVia9921dIcfu3e5v/I483Y
	 PguSuGEq5hyX866YIIWW10anN6ENYUS+AdvU5Yyg/d7xQd1RayUYLeVZpd5YgG7oGf
	 ytduo/CL69UXAPp6B2beSmybQ+Ael46hxxPsv48g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgA1BfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 20:35:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbgA1BfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:35:07 -0500
Subject: Re: [GIT pull] timers/core for
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580175306;
        bh=8P4tKsHn4BJIyUqeDLor6y8yVhYtIQO7itZnd2K8bVo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lbpJpntoWBUF/FQCvEHUAF4+IyH17sExT6nYIKSblClXLUo9i9WCRcbU2JFCbMeyJ
         9peomutUdOS3NcprAIeoHMxP1jMVEM25JCVNlWXgps4k6BVUCYo41pd18M6GhD4Rv8
         O3hard6CHXGq9KJAzFEgT5xI54koIaCTrP7sRcr4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158016896588.31887.14143226032971732742.tglx@nanos.tec.linutronix.de>
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
 <158016896588.31887.14143226032971732742.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158016896588.31887.14143226032971732742.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-core-2020-01-27
X-PR-Tracked-Commit-Id: fd928f3e32ba09381b287f8b732418434d932855
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e279160f491392f1345f6eb4b0eeec5a6a2ecdd7
Message-Id: <158017530677.6677.6776402225203859860.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 01:35:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 23:49:25 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2020-01-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e279160f491392f1345f6eb4b0eeec5a6a2ecdd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
