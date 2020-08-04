Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB3FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A56206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596502212;
	bh=Uk9RmCXWALB90xvFtuI0l/Yi7yKQhDkPwQac2KtoubA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IBCL4zyq2yheoFLXJPxXzFBJr+L7Dne//gp7iMkuJyfjGNTax+h0grvpdsvYKvKIh
	 QWAG8bBL/uPpwgKxvqglBLDjRqPhYZWtd39VGr95mrk8xgW9b/0K77NccWsQpQ0lQT
	 CaY4n/2vKSpdKN+p9h3FO6lbXcVDO/cixdCXZpEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgHDAuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbgHDAuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:50:08 -0400
Subject: Re: [GIT PULL] x86/microcode change for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596502208;
        bh=Uk9RmCXWALB90xvFtuI0l/Yi7yKQhDkPwQac2KtoubA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dA6fLQBn/Jqczegig9ClPqxRVUgMdkZWIsMsO8NH9q44k40UykoeiaoICMRr0n5uR
         s4rfQX4Jzq1pouTVSbDRxJ2YlWmeXWeWtzk4sZwyTifCLoFRssA0Svv0S9y/TkbF/p
         aRNbmte7+mwF6kefN8sxMEqR4y7YKhV8qwONr8YA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803183256.GA1167269@gmail.com>
References: <20200803183256.GA1167269@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803183256.GA1167269@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-microcode-2020-08-03
X-PR-Tracked-Commit-Id: c8a59a4d8e3c9e609fa915e39c3628c6dd08aeea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69094c20323c5efff462a2e02d0bb7b6608779ad
Message-Id: <159650220828.17631.7400212364559444723.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 00:50:08 +0000
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

The pull request you sent on Mon, 3 Aug 2020 20:32:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-microcode-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69094c20323c5efff462a2e02d0bb7b6608779ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
