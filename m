Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E2DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB7C2081A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593127520;
	bh=GOOcAzZnIxtZmmW2bdnvh/yH2AG84131c6CGA/1DBQo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Q0Vbh14D7SKrewmGpYlRFKZ7HWrF1Q/nz+TfI6MSkprz0N2uH34HxOy/+KAGbeRk+
	 WmuVWfKJboUtDoJ8gRt5XXdbEj2vEfiz4lXYz7SmyNeOkrSdMaSoZyhfYIioDFzmKx
	 zf+tpVwJf2WhwsMr+wm3VIUMXgDjSjJcfsuh9vyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407804AbgFYXZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406798AbgFYXZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:25:17 -0400
Subject: Re: [GIT PULL] tracing: Fixes for 5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593127517;
        bh=GOOcAzZnIxtZmmW2bdnvh/yH2AG84131c6CGA/1DBQo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mRhqAS0a3lJH426WXzUyfhXQktMr1PGhFBjdIM0QQm7ugGxYt/ksG0CS26dq+yCQf
         SPLw6Qc+a8Zm4ugLzYQX2xg42wuHjYMg22Yw2hNBXJ+/r5g6xVP4fnhKDT+wHlMJ4/
         9CaT9nB8uVykWl7WlHon/dnt7M+dr5X5wWhzYQCM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200625182149.4af86715@oasis.local.home>
References: <20200625182149.4af86715@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200625182149.4af86715@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.8-rc2
X-PR-Tracked-Commit-Id: 20dc3847cc2fc886ee4eb9112e6e2fad9419b0c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42e9c85f5c7296c4ec02644a2b3debc7120e2bf4
Message-Id: <159312751742.4505.4810342800671697308.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Jun 2020 23:25:17 +0000
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

The pull request you sent on Thu, 25 Jun 2020 18:21:49 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42e9c85f5c7296c4ec02644a2b3debc7120e2bf4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
