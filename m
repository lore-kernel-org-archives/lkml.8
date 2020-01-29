Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06210C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 02:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C8924685
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 02:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580265906;
	bh=AT0h+mnfFFcJ/JNRcIWbcJaljJIc1TSno9x3KbxAA+8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AkIe72NlPBu1XSGo35SrwIECue6hWpET002/GNGGlkXvYJaJVjkY/R0msARwFSkvU
	 pOpz3GKIIgbGyiAXahXjU4mDQHMH6fes2fuzWUpxpbgOlKVHprNyksTt/WNQZcYO5e
	 yMvDZmbfGIkVKtJqHCaelNzVcTYKumTXqAK/Misk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgA2CpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 21:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgA2CpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 21:45:05 -0500
Subject: Re: [GIT PULL][PATCH] tracing/kprobes: Have uname use __get_str() in
 print_fmt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580265905;
        bh=AT0h+mnfFFcJ/JNRcIWbcJaljJIc1TSno9x3KbxAA+8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FXcFlxuJ9/Pfq2SHdVrBU8rbMfBsGYV+rsbkdXZwDbZSNJp/Ez4dEamWEKn82vmzH
         Z+xljXEqBkbVBcYkvzomEWJe3eZbWVDHPuAMd3EIW4SPjHmQxioSRgt0l2KMDfyw4Y
         rbq08MXKMaI0ONe3hSltZkIzTUEvOlvUahotPmtQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127110449.512c13a1@gandalf.local.home>
References: <20200127110449.512c13a1@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127110449.512c13a1@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.5-rc7
X-PR-Tracked-Commit-Id: 20279420ae3a8ef4c5d9fedc360a2c37a1dbdf1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a78416d97425551b6790dc56626ac5c87415f3fc
Message-Id: <158026590524.23129.16214822288417115433.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 02:45:05 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 11:04:49 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a78416d97425551b6790dc56626ac5c87415f3fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
