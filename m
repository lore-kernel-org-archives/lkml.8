Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE36BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C87FE20786
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592684727;
	bh=kfnA/lzqSbh7oaXhpAfyPlYMD7VmYW74cgsr7Sz9SuU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=O3A+DIASXak1INTU3cOezsdDfXB+94chuBAC4Ywjfxf746hOV93b1kr+MwHd2Lg/Q
	 hocwg1qDF/x5wAqKEL/AqLs6AiBNKCMupyz3TfZ9mB/Q5km379EIlhzgnhFSZgq1SK
	 7whlmM7uSE6RjMEgBH8OYvLzmx2/NvuBqS9eG44A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgFTUZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 16:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbgFTUZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 16:25:23 -0400
Subject: Re: [GIT PULL] tracing: Tracing fixes for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592684723;
        bh=kfnA/lzqSbh7oaXhpAfyPlYMD7VmYW74cgsr7Sz9SuU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vYDLr0HMbpABe/5W2MovAZo1d/7oO8bGZHNuIxvGeAh+/h7G1o/dGe7/ajjQNCR0K
         8xPipy2FBBlGfN6kNn4Um3wZCH1pSaDyesUtPu3+fHdzHoWCy3NpfeglZijj+VHEj8
         Mhk4J9yvf5bsKQmw9G07DlIXIzzWem+QlFvjB/Jg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200619212427.60abc603@oasis.local.home>
References: <20200619212427.60abc603@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200619212427.60abc603@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.8-rc1
X-PR-Tracked-Commit-Id: 026bb845b0fff6dec91fe24511dad7d3067dc3ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b6ddd10d678bebec32381f71b6b420bafc43ad0
Message-Id: <159268472324.18389.4393749772581374046.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jun 2020 20:25:23 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jun 2020 21:24:27 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b6ddd10d678bebec32381f71b6b420bafc43ad0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
