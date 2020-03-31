Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CC5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E676E20784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585614346;
	bh=hWc8jz7pQEAlL8I1TIaaiVKR4GrhrqFFJrpyelHAKq4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Oo5uUcHWaO3ceZQH03g4+WvipgNuPXBi4OWI0+WTzIth4iJoas5e4iDUphmChUKIi
	 bJyM618202P0xwCcWVhdpwWkN3Bh83ySkvX21eNYDn+XeB1U2UuDCzO9Zs0it7vBYZ
	 jN5zqf35V73N81EGZ6fVzmNkIgI53fNkGO4W3MYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgCaAZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 20:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729573AbgCaAZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:25:11 -0400
Subject: Re: [GIT PULL] RCU changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585614311;
        bh=hWc8jz7pQEAlL8I1TIaaiVKR4GrhrqFFJrpyelHAKq4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OWersSryqkwfldoJrGnFA+AmuId/IZ9AV3WfbI4V95SS2r+1fciuuDzR98l3oIvgF
         YIGv3Bw0szYVdUOcPh8KAOzBOREX3avcG6jB5PCHgaMzS0OwMFmfztKv/LuH9PMuul
         +hLBoeTePUVF2qJHVZBtGzUePzMjr9/iNSz8fya0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330133259.GA113676@gmail.com>
References: <20200330133259.GA113676@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330133259.GA113676@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus
X-PR-Tracked-Commit-Id: baf5fe761846815164753d1bd0638fd3696db8fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c4fa150714fb319d4e2bb2303ebbd7307b0fb6d
Message-Id: <158561431115.380.6331404886263085755.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 00:25:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 15:32:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c4fa150714fb319d4e2bb2303ebbd7307b0fb6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
