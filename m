Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7B3C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5145C2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587761425;
	bh=9E95HEqXoDnn7ervT0Y6N7oZefaP6eQL46dyFjXnmSE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TIESSoBbvFYFOj0KejvL30XjqjgzSNuebEGpjWA0NZT0B+ww94E/9yuM68ncHaPR0
	 XydPr4IX7ovGxs2ZCplxHGlQLLLJuf3AekN6zGzTZAp26uRVsZn8LAXpP0EZlbGKAo
	 m5erDz7vXTM95B8pWVQ/2HhyGwcRTxuYVmLurHFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDXUuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgDXUuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:50:19 -0400
Subject: Re: [GIT PULL] Power management updates for v5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587761419;
        bh=9E95HEqXoDnn7ervT0Y6N7oZefaP6eQL46dyFjXnmSE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OthLnzFNtgDtHrCkNtsGZKGauhhwmwdT2J97HWnL2wbXR9I0n1mISiEkx19W9KtO2
         M63j08e66UenF4SnhpDkSc+jQ2DKegJ8ArzmIN2pIQ7agkc0mOS8EiPsCm1QoVSBAN
         SXhDUaWC5DM0CiuUDJR/Vma0eWj05OsNQc1VaviY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j1yk2k-tT+LxNH+Vq53og+rVRH413xGnzBqKd=AoQyHQ@mail.gmail.com>
References: <CAJZ5v0j1yk2k-tT+LxNH+Vq53og+rVRH413xGnzBqKd=AoQyHQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j1yk2k-tT+LxNH+Vq53og+rVRH413xGnzBqKd=AoQyHQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.7-rc3
X-PR-Tracked-Commit-Id: 4bee16d7cccddafd769e8d8ec0625ba239d11a26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e9ccd0f26b082139c985ed8c0bbe2e44c2ffe2c
Message-Id: <158776141908.11860.17473296954161578562.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Apr 2020 20:50:19 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Apr 2020 21:20:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e9ccd0f26b082139c985ed8c0bbe2e44c2ffe2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
