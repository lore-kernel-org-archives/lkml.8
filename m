Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74B9C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10962253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579807812;
	bh=wfPih4pEkxvaFi3X7tfcdqKcEN0jbJmFJ5Ev6ois9+Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Cqfc2vB4iVRs04h5hYgZph7kPpXPsQVK02NCTh0VRdsOVQa1JlKgKieZN/n/J+5d4
	 6Q14MVonAmwv2MQYC6zPvsbmzPMR/TPP0lRvswO0hf33gbc1ZVmNKTsRijFK65IIjC
	 UoQ97mXMpeIj6cNskZggwQHt4Nqga5gyADXchzJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgAWTaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:30:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbgAWTaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:30:05 -0500
Subject: Re: [GIT PULL v2] tracing: Fixes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579807804;
        bh=wfPih4pEkxvaFi3X7tfcdqKcEN0jbJmFJ5Ev6ois9+Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pnV6HcIAfNporMRm7sRTUGo51ZyiijLldqSNwadvtPWgIZs77HdbvtjQLUsDbACr0
         GiSiZeFm5eRsy3o9vk6W80DWdhvrm7+b0x8/TvanPbNz+unRHE3UfBtYXxThP1oSVL
         3AeIwx4PBfWXSOrPtF5gQrR8z0i9ShCsCpaMAxSc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200123124331.3980539f@gandalf.local.home>
References: <20200123124331.3980539f@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200123124331.3980539f@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.5-rc6-2
X-PR-Tracked-Commit-Id: b61387cb732cf283d318b2165c44913525fe545f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34597c85be987cc731a840fa0c9bb969c92bd986
Message-Id: <157980780490.24133.816317284543396405.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jan 2020 19:30:04 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Jan 2020 12:43:31 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.5-rc6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34597c85be987cc731a840fa0c9bb969c92bd986

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
