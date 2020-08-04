Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA511C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A58206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596502216;
	bh=FampSeDYMvbQ5a4sGEURHCBlkUxB/ghpMWeOPgKWyDI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WnFNyGzcAmP3oHcd3uz5Ij9nPMMzXQXswSLy+hTnSXPqaGP1cAFasw9oMKzKCREzg
	 vLfePhIfs5r42WuPy/ZTGCGYgnFUAz1pqCIB7fSrQbiySfdwZr8+fTtF8pjNc8qGNg
	 Gx21WpyVTAItW0kwjEh0afr9jJlbe32i9ost5hss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgHDAuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729288AbgHDAuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:50:09 -0400
Subject: Re: [GIT PULL] x86/misc changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596502209;
        bh=FampSeDYMvbQ5a4sGEURHCBlkUxB/ghpMWeOPgKWyDI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hEFXpwtXr2wsrxJFQwJA6udqJW3t0LA+18pIHIbxmN+IrT4SrZgk4KxogD2gvAnZt
         sxWX2mYmfxUvi+ivxIVAbf2AM+5TS0NS/P56QKiKih+K0N6JPWJ9jkPBcvotujYBT1
         HPgkfMGPyzCsQeRODBjkfuDTrJzynSacEJMMoYoc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803184720.GA1230231@gmail.com>
References: <20200803184720.GA1230231@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803184720.GA1230231@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2020-08-03
X-PR-Tracked-Commit-Id: a7e1f67ed29f0c339e2aa7483d13b085127566ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c813e8c9dff344a3b46bc9bba8aff5a7ebbc67e7
Message-Id: <159650220889.17631.5451685366956159436.pr-tracker-bot@kernel.org>
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

The pull request you sent on Mon, 3 Aug 2020 20:47:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c813e8c9dff344a3b46bc9bba8aff5a7ebbc67e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
