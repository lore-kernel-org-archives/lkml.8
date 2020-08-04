Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5D3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89037206D7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596502221;
	bh=SQdOSRva1Hk/orxJ4M9rbIGOA8KOoGS47G42ozzwWnw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YkyNeoaYBDOOBfJj8fiEpX+LyBxr1QjwQZv+CiTFaAJ0biOPMpwSWcyo47YWoTLM1
	 6k5T+XF9fFsFmbL9S2GPyDI2COQ76Yc1p17Tp2NnNaQuLlHiQVm7jLANO84dn/Z/Re
	 FfUhLGoMqOR0uL/mQ4bswXM/eskBuR3N/SRQ46nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgHDAuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729329AbgHDAuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:50:11 -0400
Subject: Re: [GIT PULL] RAS changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596502210;
        bh=SQdOSRva1Hk/orxJ4M9rbIGOA8KOoGS47G42ozzwWnw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=i++p3hxpap6pzMw7ElqJKZVsmC+1kcCQnfwEeouOwLxCfoPabLWI4B4+6xIdZBIYC
         qT3OykpHhpeEvg6mlxaPqsY4H9wzewQ2tkdvjp0NuISMBryuuc2v+4BiB0qWDNt3/x
         CoXOuZkaK5gzX0w2VZ4yt9Cvs1DE8ZO04pEAJ9zI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803202542.GA1474582@gmail.com>
References: <20200803202542.GA1474582@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803202542.GA1474582@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-2020-08-03
X-PR-Tracked-Commit-Id: bb2de0adca217a114ce023489426e24152e4bfcf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e53bc3ff99b413083bfef80d0fdbf7da3a09fc0c
Message-Id: <159650221068.17631.13142984526186499763.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 00:50:10 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 22:25:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e53bc3ff99b413083bfef80d0fdbf7da3a09fc0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
