Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1BFC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54112166E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586551243;
	bh=ewwpttksibnWt2lPjf6N6ZRQTUiPO4o7ICNlguMjiVw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2MrscK/D4K4e08bLF4TtHnx9Jyfn2Q03UTNm6sUo0mT47q2d9LYq74hDAWI+M8CbD
	 COV/mbq/sN16iM2Ef4vfhBL+KOlOwIycaLNJ4vwX2OIFydxvcMmv1j+GGR24GOFvVg
	 p90w+FZCxi1qmG/YLsH9mET1Z6zsVoXYUpno4MGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgDJUkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgDJUka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:40:30 -0400
Subject: Re: SUBJECT: [GIT PULL] IPMI bug fixes for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586551230;
        bh=ewwpttksibnWt2lPjf6N6ZRQTUiPO4o7ICNlguMjiVw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=C9xXCRlVQJQN51ImMT+dbmi2cIU2AjMdNmg8AuCVBMZ9MbdSsJA5PGwbGuT/Rv5Is
         aIGDoQKQuakwj7Ni0uI8NZ36HzkiPZcxN0SVbAbHhc223Kfe4qp7OLWjpJ0P5ZqbDS
         Pf1VahCqHbERrSFF7BfPLeVVw5GzPqys6dcHV9PI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200410132856.GI6130@minyard.net>
References: <20200410132856.GI6130@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200410132856.GI6130@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git
 tags/for-linus-5.7-1
X-PR-Tracked-Commit-Id: e96387677c2a4a35a0c8b16cd517696a04050062
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6900433e0fbca146d8170bdf876271cdf3053021
Message-Id: <158655123088.24997.5213845863425323885.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Apr 2020 20:40:30 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Apr 2020 08:28:56 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6900433e0fbca146d8170bdf876271cdf3053021

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
