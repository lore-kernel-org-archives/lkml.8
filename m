Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC248C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 18:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACCDE20656
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 18:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598207988;
	bh=nW31LJUiQBpYV32e+bvFLVnpTxFhXwgvwwryQS9MImw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=eKyTLz2r3IcqlX5HktumvqTZCaUO+o2oMhBthPIzPgR58PWz/B79iEBVasxYmCNdQ
	 NPMClmvZqiB1hTPbkD68rvkz2Sn8tNJNw4QwfjwIZ9YQwKz7eEyq/L0DrBNZXkdFL2
	 xUQAG7GxMa7m3EV2gshy/36ylIh+hoSFG7/sqwIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgHWSjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 14:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgHWSjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 14:39:24 -0400
Subject: Re: [GIT pull] core/urgent for v5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598207963;
        bh=nW31LJUiQBpYV32e+bvFLVnpTxFhXwgvwwryQS9MImw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nb0ZuOSwfEbdC+p7H3WZpHxoCU5B7jMPbQD+wzWzwLJ6lHA3mjxEaEyh4yEHmt8+w
         3crxzZaILHHfoD3laNNI/mzp4tNYpdQYo7/F5o7WZeTAOnZXJqHPgZ7xmuf4lEpKrp
         HeEH6qmKoDMJXC96IGgQf84iNn3DP/tibsVoiBTY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159817113401.5783.14776307451257171431.tglx@nanos>
References: <159817113401.5783.14776307451257171431.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159817113401.5783.14776307451257171431.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2020-08-23
X-PR-Tracked-Commit-Id: d88d59b64ca35abae208e2781fdb45e69cbed56c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e99b2507baccca79394ec646e3d1a0884667ea98
Message-Id: <159820796355.12134.4421321352772303.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Aug 2020 18:39:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Aug 2020 08:25:34 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2020-08-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e99b2507baccca79394ec646e3d1a0884667ea98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
