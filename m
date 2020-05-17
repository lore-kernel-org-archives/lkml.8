Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A08C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68663206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589746510;
	bh=j/AwKnTpUgFy8aXOjDQHEvtIZJQbknoqa+joHEaEqG8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pufTs9XknRqorF38lYLodDfLpV5uy4Q9n+7fzZyJQBqTq4kz75Jn9qFjNmDb+HvsY
	 ELrUHokpiyVYaLpVNI6yo9NhfFN2rkTCNgmH2RyWHCJ532W+VTy2JkhCsfDoBXlslj
	 bYvGJqb919tvtI37X3B2VmJ3/Lw/gaGyIL7C814o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgEQUPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 16:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgEQUPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:15:04 -0400
Subject: Re: [GIT PULL] Please pull exec fix for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589746503;
        bh=j/AwKnTpUgFy8aXOjDQHEvtIZJQbknoqa+joHEaEqG8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cljdGm3KQGj2YodMp+y22aAN173Uj6c3NBt60egV882EDhwxkcvvuBcc4Eq4pDnbc
         bnmvHZC8/DnXkw70tRjccUnbVFkSyfkf8yF0N1CVZiquBkKJ0mlaKC3DNDA2XDZT6V
         iUqTWFgP6WvKrIqrWdLSaHWc7054nBqfnImhnFUk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87imgu7dio.fsf@x220.int.ebiederm.org>
References: <87imgu7dio.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87imgu7dio.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 exec-linus
X-PR-Tracked-Commit-Id: f87d1c9559164294040e58f5e3b74a162bf7c6e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b48397cb75ac17a5c6f99b3b41fab0ab1f879826
Message-Id: <158974650372.31612.727158402282060572.pr-tracker-bot@kernel.org>
Date:   Sun, 17 May 2020 20:15:03 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Willy Tarreau <w@1wt.eu>, Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 May 2020 11:05:35 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b48397cb75ac17a5c6f99b3b41fab0ab1f879826

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
