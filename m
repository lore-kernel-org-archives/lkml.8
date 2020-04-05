Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F7C2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B749920731
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586115924;
	bh=Y+a4U7/edj40EU2AVkK8O7mx9QD5v1LGG1y7bwRZkmY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FCGqoSSFG6/IuFESQgqyuribMKGZTm4w2lBbDmP7FFPeoaWJzPTDiep9M4A9hqnHm
	 ksba2eUTPVbOKIHVrAHAFi1gz0dJ7xswsTUlfQiKcigNURsOE0Mfq7N/QxmMuMfR0T
	 qVrIbDLxNPekxpzUflgqIpj3M2dM5c3RR2lCKWh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgDETpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 15:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbgDETpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:45:23 -0400
Subject: Re: [GIT PULL] tracing: Updates for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586115922;
        bh=Y+a4U7/edj40EU2AVkK8O7mx9QD5v1LGG1y7bwRZkmY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=r2Q8aRm/hySjojAWJ+fw2ly7gFMJUbVMc6ivhn6PUGnFMXCoU/wNo957h9FmJRhyV
         uGZIHqfpAr9GUrpRLCoKvaGxLoJZd5v7e+iabbDZs8DtDQ4twypnnM3ACaSnvtMcza
         MqKNnhGZRIEmSftXw8RshRXUYDK7iaJI64g2Re4k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200404200723.26662e07@oasis.local.home>
References: <20200404200723.26662e07@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200404200723.26662e07@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.7
X-PR-Tracked-Commit-Id: 8e99cf91b99bb30e16727f10ad6828741c0e992f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa1a8ce533324d12696a9f4b71dbc5eb561a2e04
Message-Id: <158611592267.11305.17574540657638052191.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Apr 2020 19:45:22 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Apr 2020 20:07:23 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa1a8ce533324d12696a9f4b71dbc5eb561a2e04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
