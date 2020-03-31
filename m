Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363D9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD4F20784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585682134;
	bh=L9DlXM/NXjWaGLPlVin5g3xG/wd/2ORSzTRHGs+wXKg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=b5KLRcoSd2CD90z7YaSACk06278JCVPXsLCCkne119VsnAKU//wXchIL43DnrVPil
	 4TijxrY8hQormSnly/clz0EKy0ikp6X45kjLRiRak/UGIzyEGdBxFW9dVuiH5PpkAq
	 c95nuHnxv76a696X6HwMnt8onMR3aBGFjxO4iz4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbgCaTPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbgCaTPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:15:14 -0400
Subject: Re: [GIT PULL] x86 cleanups for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585682114;
        bh=L9DlXM/NXjWaGLPlVin5g3xG/wd/2ORSzTRHGs+wXKg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=H5Mh6GVEG6Ex2aT+XYN9XEHI5FmnIOLsK1rVamPfaRCR2fyZu+4EHDIdJzmlW+dXc
         ltk9UpAOT0xIp6LZxr2J0SjuHi+Gvzl8hea2QypjY1cpttij/lTem49IMcEwQSY7c5
         vuiz8IvhW21JjTlGDSz2Ys/AQQQ0hav4V+Hhd914=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331080111.GA20569@gmail.com>
References: <20200331080111.GA20569@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331080111.GA20569@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-cleanups-for-linus
X-PR-Tracked-Commit-Id: a2150327250efa866c412caee84aaf05ebff9a8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fdf5563a720004199324371c08071b8ea27bd994
Message-Id: <158568211425.28667.10121610889361532358.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 19:15:14 +0000
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

The pull request you sent on Tue, 31 Mar 2020 10:01:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fdf5563a720004199324371c08071b8ea27bd994

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
