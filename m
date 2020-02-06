Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A09C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7EA21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580976022;
	bh=ignv/0d2i6zkKatS47I7NyI8lRsSCr4wQvzyVGdB8tA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VuWsYd+rGZ1H4tFxH15XOdnkOgn0kP4a/LJUiu3q6uh9h0NZatjPF47CgyT1UA9Fw
	 VPu5nLsp4TF5JpPih3zMnE4z2KtAGS4QUuWNUOJgSF5zls9V2O4LcIhWNIShr/AONF
	 KgBKljksQ6XgZ56ph6pkUdA9UI3W+Sz4apUc0AuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgBFIAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:00:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728291AbgBFIAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:00:18 -0500
Subject: Re: [GIT PULL v2] tracing: Changes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580976018;
        bh=ignv/0d2i6zkKatS47I7NyI8lRsSCr4wQvzyVGdB8tA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FMTzd2enw8DkHD2Wns3yXOSFFQhf7D8aV4XcTOdBcdZHI+HFspaKOClUcL2uv38Jz
         NemAf8u4Q8h/YmmJrrpXdX8GsyKnwJKKvi4Lew34MOBoJJMcjdWJCF8lQYz3vIh4Ql
         7HHY9NpgtiTOpEotFSg2ZC6DliLKjhEIQJZO1iB0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200205172914.3d4b831f@oasis.local.home>
References: <20200205172914.3d4b831f@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200205172914.3d4b831f@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.6-2
X-PR-Tracked-Commit-Id: a00574036c261421721fa770ccd21a1012e1fbbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e310396bb8d7db977a0e10ef7b5040e98b89c34c
Message-Id: <158097601819.20426.16273200815485493057.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Feb 2020 08:00:18 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Feb 2020 17:29:14 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e310396bb8d7db977a0e10ef7b5040e98b89c34c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
