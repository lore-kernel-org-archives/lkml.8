Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB165C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DD220828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583278521;
	bh=YEiwpyHMzWNVfdz3OiK5HEePksFJObEVKy6iMuPuIZE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vdniTJN1oB+tTa6a/2rAwin4mebANB9RxqsjzQmtyOUUE+KG76uEO/FWbzxqN0mA6
	 JT3Z2eG8PAWrZXWOELgC+GzhPu6O1vDDde2fcx0w3o6kWCDH2uqqRZ4366CwJt3wxE
	 BbbZ2zeF+b/gBt1a2xV+Sa9kK7k24kBVSUxouWcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgCCXfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:35:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:58038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgCCXfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:35:06 -0500
Subject: Re: [GIT PULL] scheduler fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583278505;
        bh=YEiwpyHMzWNVfdz3OiK5HEePksFJObEVKy6iMuPuIZE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xq1Cvw3z2fwSA8MNkjEK4gF5lJM263SIJADfVbWtRBQFyxlFKI8bA32dzhQEbJZn3
         q+kxsIulZyv+UFHSHMjPu4ZrnHRQkHm/aswvKMknxbQ97snlfrS6cKPfx8GKtuaLFz
         4oqqnn5KHeOf4qeq6w+nFEgXCtO/jrFYjPgQ/c2U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200302075136.GA48297@gmail.com>
References: <20200302075136.GA48297@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200302075136.GA48297@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: 289de35984815576793f579ec27248609e75976e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c105df5d865afbc10e9730b7b13abc831d5e9ac7
Message-Id: <158327850561.6555.5673455029272373758.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Mar 2020 23:35:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 2 Mar 2020 08:51:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c105df5d865afbc10e9730b7b13abc831d5e9ac7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
