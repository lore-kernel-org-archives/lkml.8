Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E28C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5FE22CA1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596577251;
	bh=eRXLB7Q8PBxf3qN7yitA/dXhAyY6HxC9dmS6qEP2vA8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DbCT0Z67nhhGihFlaWVj2Pqt1+w0ZRyxCLYpqMnINLIcoADGX61CdMA46fpUeXt7L
	 0ot0qUsEsjG7uZ/xQ+jOZQIj6by77w/1JdS0yY6vI4ohLlRPM23gbMuODBlqLT2u0F
	 qXaIY3rs7Izsk5Cb7M/2juqSrqC1xEJJs/zRjDKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgHDVkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgHDVkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:40:12 -0400
Subject: Re: [GIT PULL] exec cleanups for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596577212;
        bh=eRXLB7Q8PBxf3qN7yitA/dXhAyY6HxC9dmS6qEP2vA8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zlC55N9j35WKISwlAM9MLNPYE7r++HPvunVMtnahUpJlQBa/rlOUsCz/FMGgLSqFz
         wPZGS+KkTVSNvGsKQt7pw2u2HXiq25gASkvYDe/hc8+6OD0Oqrz0v8toQYg/0aVjmw
         dqAU648nuqCiRIlgpq1rUNtHRNn3yjHCIsYHQh8k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87k0yfscqw.fsf@x220.int.ebiederm.org>
References: <87k0yfscqw.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87k0yfscqw.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 exec-linus
X-PR-Tracked-Commit-Id: 7fce69dff8db30cb93aace0bbebda09972027af7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3950e975431bc914f7e81b8f2a2dbdf2064acb0f
Message-Id: <159657721204.17686.3382733682528948333.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 21:40:12 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 03 Aug 2020 15:20:07 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3950e975431bc914f7e81b8f2a2dbdf2064acb0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
