Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82073C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5747421473
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585682114;
	bh=ipWldwekQACa3F4pZSmHxxZ38u1Uf0opsUEr9Ud9wvE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=iH/rQ3sxunlZZd3hBih+4tlGO77XmqXBEAuWs5LBMxgVr4BqI/c9dKcdkHKwNR/NK
	 6q33y9mueEWvBkduhc9oiGCOw00bdu+t4YyIiyBcvY+T1U0NMiFe1yfUg7l1+Rf8Vx
	 7igvX0plOy50/a4/pD7Tqr8d8ZTo6kM9oDPBU7W4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgCaTPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgCaTPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:15:13 -0400
Subject: Re: [GIT PULL] x86/boot changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585682112;
        bh=ipWldwekQACa3F4pZSmHxxZ38u1Uf0opsUEr9Ud9wvE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CV5wM0OqdvpQ2JweJlmptl0q9NWOuPA3xStYsHgDuJUjyrlUPTWm+pI2YcBA6tn5m
         ugoCZQKBVNpHobRT7PNZgCfjo8qgFd6eT5E8QyASHeb/iI0xrKJndIxxuYS5/+FF/Q
         056K52HUMXJSKZxwSh3dHQM4q5Zc2spGC3cvg0gg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331075305.GA57035@gmail.com>
References: <20200331075305.GA57035@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331075305.GA57035@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus
X-PR-Tracked-Commit-Id: c90beea22a2bece4b0bbb39789bf835504421594
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9589351ccf47a85a75180a430627c16bc28da929
Message-Id: <158568211250.28667.9170862913662280977.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 19:15:12 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Mar 2020 09:53:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9589351ccf47a85a75180a430627c16bc28da929

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
