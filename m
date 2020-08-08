Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B687CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 03:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8442086A
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 03:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596856613;
	bh=3IkRLEvFh8RcCU6VP7F4pfMkMUTrqrdnxVawuQ4g7U4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dPdU6VeEQHshfAJ6FNppccTW1jJwjXKQFF0XdAS1QcjdoRfBJfq/tbgoXWVdfv9yS
	 bVw41GTk3/9r4BkrEj83I2Iqoat8UwdkpYUve2TRPYdwePVBKpuMqZQbaFX1EFvKTy
	 MwhSvdxj/Y+kphSk+jQ4Ms7diN79svAy7SgonU9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHHDQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 23:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgHHDQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 23:16:13 -0400
Subject: Re: [GIT PULL] tracing: Updates for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596856572;
        bh=3IkRLEvFh8RcCU6VP7F4pfMkMUTrqrdnxVawuQ4g7U4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hOH2GBoghs5EQYLzAsWrBtJi287Eg+/T5j/Us95N4FLVLeOGuCBdqq5psEuIrLXly
         a8GoTKq4a9l+G0hWEULIOiot7TS8VGULTmjNYMZSw/CvPUGpAOyAr+1xpbwN1u/ONr
         E5tGw9eSA+L2kiFrEPRYOf47JT0K7Xnc3uV2xa64=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200807172804.031b9241@oasis.local.home>
References: <20200807172804.031b9241@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200807172804.031b9241@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.9
X-PR-Tracked-Commit-Id: 38ce2a9e33db61a3041840310077072d6210ead4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32663c78c10f80df90b832de0428a6cb98a64e9a
Message-Id: <159685657284.14222.5636694328436388979.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Aug 2020 03:16:12 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Aug 2020 17:28:04 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32663c78c10f80df90b832de0428a6cb98a64e9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
