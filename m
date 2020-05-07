Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5802AC54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF3B215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588892408;
	bh=ZdjUl/8vOVqBj74i9PqvOXCF671anVwcGLh8JVQaRhU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=T/RJ6s5Q5aqS7H2WYyuP36PhzdD3icbOKQtjKN3DpTkfskDrVutIhMl1zV2uea9TL
	 nkgtIh5SGAhXrWDeBM3l4+SNWD4V3wF/l3BFQ/EqdydbV3G22DJRm1UJpRYCRFnnex
	 WsLdreqbQUzMoR2rt0tUsmYzRYbnkDwn9yWG+PFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgEGXAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 19:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgEGXAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 19:00:05 -0400
Subject: Re: [GIT PULL] tracing: Fixes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588892405;
        bh=ZdjUl/8vOVqBj74i9PqvOXCF671anVwcGLh8JVQaRhU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dmOVZlKkEaUtFEGuIIxpKQMVeVrjB/9P+5oHVvjl3ycUFiigg/kqNe1Mre5KfD33O
         mvIv4bCy94KFI+tg0yfFruMB45a8kmYcPVAlbl6dI8UheWVwv41oPLxk0OoOso43rU
         I9c3yEEWE0545fXOPsuwfKI6y26jGIBIuG9dI1KQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200507143353.3f92a389@gandalf.local.home>
References: <20200507143353.3f92a389@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200507143353.3f92a389@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.7-rc3
X-PR-Tracked-Commit-Id: 8842604446d1f005abcbf8c63c12eabdb5695094
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 192ffb7515839b1cc8457e0a8c1e09783de019d3
Message-Id: <158889240519.3631.764704828333907477.pr-tracker-bot@kernel.org>
Date:   Thu, 07 May 2020 23:00:05 +0000
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

The pull request you sent on Thu, 7 May 2020 14:33:53 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/192ffb7515839b1cc8457e0a8c1e09783de019d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
