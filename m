Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39786C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06315206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593381928;
	bh=CMitQAgzuTuCzEPIljF+i0eqWn3F0yeWMk3TQdjacxM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=z1ICOTjXidU9Ww4+fH7OBumiYzDJlD2rnl3QaK2jzosUosDJNYjaoPVcItduCgJGA
	 aliSsyCCDiqGKKUL2sd8bOpwvw9Qcyb5a1dloByjMSkg6E3h2tck0fxQoLvwZHk4Mn
	 yabDfXyYpsqoFp2kkvXDBAauakiEmNUTOvPXK+OI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgF1WFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 18:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgF1WFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 18:05:16 -0400
Subject: Re: [GIT PULL 1/2] ARM: SoC fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593381915;
        bh=CMitQAgzuTuCzEPIljF+i0eqWn3F0yeWMk3TQdjacxM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o1w9TGiDZhbyFZhVFSUwKK8OScc0Vnc6IwevgZTf/uC9r602GGPMwRMICQddu3YsP
         QCTmlmAr/00l0QaeS1Ewv4CapGLmFDMawNFI334JmwLQNWoRrt6rF7lIrus+RwE3bh
         NMLLh3v34wWOW317GZZ+60U4BEwTXXdlz7L1jHJc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1pbjKE7EX5+UYZbzWMAZ9kjftodURZ+vgrCQ3Cn2vj+A@mail.gmail.com>
References: <CAK8P3a1rUGkoHanEGfc+o8bjgZO=T-40-e-wy+ECLxuU_pT97A@mail.gmail.com>
 <CAK8P3a1pbjKE7EX5+UYZbzWMAZ9kjftodURZ+vgrCQ3Cn2vj+A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1pbjKE7EX5+UYZbzWMAZ9kjftodURZ+vgrCQ3Cn2vj+A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
 tags/arm-fixes-5.8-1
X-PR-Tracked-Commit-Id: 42d3f7e8da1bc55e3109f612c519c945f6587194
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e44b59cd758acdd413512d4597a1fabdadfe3abf
Message-Id: <159338191573.4690.13167744037438436642.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jun 2020 22:05:15 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Jun 2020 22:00:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-5.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e44b59cd758acdd413512d4597a1fabdadfe3abf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
