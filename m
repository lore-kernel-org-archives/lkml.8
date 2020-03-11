Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ED7C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917B720737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583959519;
	bh=lZxw1nm+5UwKrB9/CrSzq5bCEIAIsM5vF94fOL4iP3g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tfah1gPCf8vmum3g2nDDeO288dOfKLhC9oohkZKrg6CCPaBTVE9bvLAumhL4OoPjx
	 GT6YjQhOdNl6xU4/RLHQq89/6NVFjjOgePIN7NwpofznIpVQu6wpc7ZEZ8C6YaO1qO
	 kAaQ3WIvyPL4+phYXe0/zxXtJKvImH8bMBM/+EUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgCKUpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgCKUpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:45:09 -0400
Subject: Re: [GIT PULL] ftrace: Return the first found result in lookup_rec()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583959510;
        bh=lZxw1nm+5UwKrB9/CrSzq5bCEIAIsM5vF94fOL4iP3g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ySHAtY3m5HkNi7KNlvQnVi0ih7JQntxHZslOnESkqdy/fA4rkmJjXHDfu0+zqtWaX
         epRy6V445G1PYLLefneHWmOuoPOxBPKvFFGiDRx6h4SCS7tthy14brFYFDbvSEwv4s
         UnCgr0dV4fDxWttBlMiKfD8DR1YNw014twfCZL7s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200311104536.59de3c5a@gandalf.local.home>
References: <20200311104536.59de3c5a@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200311104536.59de3c5a@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.6-rc4
X-PR-Tracked-Commit-Id: d9815bff6b379ff46981bea9dfeb146081eab314
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36feb996308ec3392495e3341bab2570b11cb1bd
Message-Id: <158395950967.14877.4276380737517624215.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Mar 2020 20:45:09 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Artem Savkov <asavkov@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Mar 2020 10:45:36 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36feb996308ec3392495e3341bab2570b11cb1bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
