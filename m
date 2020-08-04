Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CAFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5822F206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596502236;
	bh=c2ffU0kqVMOZzvXJb0RACn+nhpqqALYe2uH+qTRiPGA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=p0idry8eg6ij6ZxNrWTElAAmtRuDHnxpUIrB8QJLPHVCf48gOSmJy+R47BhDoxDa6
	 19NATDRrcxyYDU5D8nsIhOxS7fA3dbiMX1kha2BPEIUk2ui26WViYWd366rYQynJbE
	 TLAsmi8x4BPIK880HGojOJS7wdb7D8MEbSNRfj2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgHDAub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729168AbgHDAuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:50:06 -0400
Subject: Re: [GIT PULL] x86/cleanups for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596502206;
        bh=c2ffU0kqVMOZzvXJb0RACn+nhpqqALYe2uH+qTRiPGA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Zj+lKAYLiqXvuVCAGkA5ipPYQsZWJSte2PiwZvc0t+b76j/8c1UXyrAhbv8Lj21io
         jyw1C4jm1on9uPuG8CQCsNYOAZYasB+F/mlcy1L9CXTw7dhB+6zl+dMAaHyiyg46K6
         P5NJImoxGFhUmz0qfuBw8xD76eluX0fByef+6ie8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803172741.GA914875@gmail.com>
References: <20200803172741.GA914875@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803172741.GA914875@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-cleanups-2020-08-03
X-PR-Tracked-Commit-Id: 90fc73928fec2f62bbee1476781754c7392a7b61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37e88224c0003822b5309b7cab793064be803a3e
Message-Id: <159650220626.17631.11466677848774286721.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 00:50:06 +0000
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

The pull request you sent on Mon, 3 Aug 2020 19:27:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37e88224c0003822b5309b7cab793064be803a3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
