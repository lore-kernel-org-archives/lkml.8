Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1322CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE0E2250E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596059109;
	bh=GiRSxXtKJEXQSm7FN4IpGktEM7esCYePh8QY4ItoVjk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=anGJipx9xzx1cY16yc78TMdVvBvleMKT3kyG1usd9BvLgZFV9HB+cH/pzYSmpvAXp
	 /Vtl+lvU+xVZVsfoe0yyt9ZFDwjKIpJs/6lIGg9sRRB1zHU7p9skRbNpUR9mHZbn0S
	 84VqSskLhiagBkFa6vzbZQGP5x2UlLJIN5HBrhJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgG2VpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbgG2VpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:45:06 -0400
Subject: Re: [GIT PULL] Audit fixes for v5.8 (#1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596059106;
        bh=GiRSxXtKJEXQSm7FN4IpGktEM7esCYePh8QY4ItoVjk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IxpLyBm9mgq9iqT3HSclMDP+UAu3oq5n8sXx4gM7nVTKjPfi+8TUs6eGpYhETA0M4
         AZyyFQiZYlQwoPbaT51XoADXu2BTWP8GcHaHKmGRLLojWqkqT/H52myVHajJyd128u
         yXNT3mIn5whHFyoN6iizLybMGgUctxrvuNSjTp/k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQSq87=vk63=Wr-0mdOZ3ExAKG3s6_9AMS=n_s8zGjhBQ@mail.gmail.com>
References: <CAHC9VhQSq87=vk63=Wr-0mdOZ3ExAKG3s6_9AMS=n_s8zGjhBQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQSq87=vk63=Wr-0mdOZ3ExAKG3s6_9AMS=n_s8zGjhBQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 tags/audit-pr-20200729
X-PR-Tracked-Commit-Id: 8ac68dc455d9d18241d44b96800d73229029ed34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3590ebf6f91350192737dd1d1b219c05277f067
Message-Id: <159605910640.4880.5720016071008602002.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jul 2020 21:45:06 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jul 2020 10:54:14 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20200729

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3590ebf6f91350192737dd1d1b219c05277f067

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
