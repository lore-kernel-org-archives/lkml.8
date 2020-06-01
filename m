Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2314C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F9A92073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591048526;
	bh=OhUVbkfcB6YaNRT9UzZ39iI0AhLkNb+kECvrMW6rR+U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kXau8zmWXN7nuX9keCfuqFo0E5PNajphbJYoaAoAByIyqz08nLjX8UjhnV2XrSkjz
	 bsFdvMyy8L6CL0jnO88XkhAghf2bVKDeVkC/1mQeWeUgZq+DX0ju4cUN1wKtazahAm
	 iV7dwGZGWPEq0qRmRHf53zSge3LdavnhqwWm5TJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgFAVzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbgFAVzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:12 -0400
Subject: Re: [GIT PULL] x86/cpu changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048512;
        bh=OhUVbkfcB6YaNRT9UzZ39iI0AhLkNb+kECvrMW6rR+U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e53gdMfe2Hh4UlZi0ZvwTcTXiRk4vHE9HqZNHOTwTqtlbG2S8Bus0B0bbzh05crni
         Bqzh48PgcSJnMdD68v3AZpx6+mQJrsWY8Acjapa8H/6+8iwmRMJGfvb4oENIEmTcwS
         9AZC6Sg45VgQmMnSgusOUE8MgbKkjbdnrwlGRm+g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601164326.GA1260535@gmail.com>
References: <20200601164326.GA1260535@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601164326.GA1260535@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2020-06-01
X-PR-Tracked-Commit-Id: 3d81b3d1e55a518837c3d1f722c6d93abe34aa85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eff5ddadab04dc7ae8c4588dd3eef2ecad770fd7
Message-Id: <159104851231.21074.7119545738940446872.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 21:55:12 +0000
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

The pull request you sent on Mon, 1 Jun 2020 18:43:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eff5ddadab04dc7ae8c4588dd3eef2ecad770fd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
