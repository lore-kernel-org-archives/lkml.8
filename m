Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96135C2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CF421473
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585682115;
	bh=C0zMiijx35gj05ig4IgrWCqBVCZmR9ssiY0V8BZM4RM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LlLx74cfhegYXtVzE2jsg6zdDaZ3VzZE9Dh/oe66dL9MGUHh+R7fq79EWYDGj13Hh
	 nUnb0+3Y2i3MR9wGvBHSaXj2CMeXjqiOft44xYC7iatpUEJ2GD17kTGaxQaOgew5WX
	 GKCIecgAqmNvaKpgO7qWFfpZ9AvzvixKyqbnugDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgCaTPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbgCaTPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:15:13 -0400
Subject: Re: [GIT PULL] x86/build changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585682112;
        bh=C0zMiijx35gj05ig4IgrWCqBVCZmR9ssiY0V8BZM4RM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qFoU2eDL1x07hrzE3Q9vQZGczn2YhgX9V1FWtc0wIRSrt7RqgBfLO+QpYx02puujy
         +7Ag600M71beY8sh6HXe1j/84Ni41pE3OX3J8mh3q+AFGE8tvTVjmm8dPaCxUYrAOB
         za3YqTkOr29hE+QO4mYo1oyF2ejfSKpYX6W7rLNc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331075611.GA129965@gmail.com>
References: <20200331075611.GA129965@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331075611.GA129965@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus
X-PR-Tracked-Commit-Id: 4caffe6a28d3157c11cae923a40456a053c520ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97cddfc34549014b902f5954953ebd9a4f3f040a
Message-Id: <158568211292.28667.2508231665969350167.pr-tracker-bot@kernel.org>
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

The pull request you sent on Tue, 31 Mar 2020 09:56:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97cddfc34549014b902f5954953ebd9a4f3f040a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
