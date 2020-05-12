Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6F7CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13AD223126
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589309712;
	bh=R95dA7xTUqIcm/Ci7IHPtCjj3/dX1JgGKNEj7n5xFa4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AYbK4YXnJPfBssPRcD8bO6Ayp6eQnSA9bRvcD6DF3yPZCNvUpKiy6oIwhQ+J8DJ74
	 I0Q+wu+242PyZ5m7mQdrcx1UuIIjUwoNJlLwfegJoOE/hIGtCMR28z2GPSJAik0lNr
	 Gv+PwJA9lBq7W1sOS9XKy9DTLNLhAzLgfZusgNF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbgELSzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgELSzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:55:04 -0400
Subject: Re: [GIT PULL] tracing: Fixes for v5.7 from previous fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589309703;
        bh=R95dA7xTUqIcm/Ci7IHPtCjj3/dX1JgGKNEj7n5xFa4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BBREiI1Q440QfyG0xgg2+ylxxQbjGl28FI5J0ZtACjFC6mvMxR+MrkFRVLl0r8UHi
         pBVEOr4dvn+pK9IQ2eyUIkanEBALORfNE3gmGmu9zQw0/X6RRriGH3SR+1n4cP9knm
         QeNVTS64YW87qgb7YmKXsoZIUlvuDUgTNwItgQxA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200512104835.7a39586b@gandalf.local.home>
References: <20200512104835.7a39586b@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200512104835.7a39586b@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.7-rc4
X-PR-Tracked-Commit-Id: 611d0a95d46b0977a530b4d538948c69d447b001
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24085f70a6e1b0cb647ec92623284641d8270637
Message-Id: <158930970384.9866.10665397189841124521.pr-tracker-bot@kernel.org>
Date:   Tue, 12 May 2020 18:55:03 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 May 2020 10:48:35 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24085f70a6e1b0cb647ec92623284641d8270637

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
