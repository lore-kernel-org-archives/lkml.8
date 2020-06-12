Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553D7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3110E206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgFLAcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 20:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgFLAcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 20:32:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DEDC03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 17:32:21 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jjXcE-00015C-Ts; Fri, 12 Jun 2020 02:32:15 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 6FFDD100D0B;
        Fri, 12 Jun 2020 02:32:14 +0200 (CEST)
Date:   Fri, 12 Jun 2020 00:24:47 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT pull V2] locking: Atomics and KCSAN
Message-ID: <159192148730.1475.8112596092479045470.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

the following two pull requests contain the distangled and rebased
variants of the intial locking/kcsan pull request:

  https://lore.kernel.org/159110310259.14558.3096683243532489290.tglx@nanos.tec.linutronix.de

Part 1 is the rebased version of Peter Zijlstra's effort to fully isolate
the INT3 text poke handling code. This has been rebased on

  b29482fde649 ("Merge branch 'work.epoll' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")

which contains the now isolated read/write_once() rework from Will Deacon.

Part 2 is the rebased version of Marco Elver's work on KCSAN which now
depends on Part 1. The rebase has preserved most of the history except for
the parts which have been squashed into the rebase merge commit.

The rebase results have been sanity checked by Marco, Will and Peter and
the interdiffs (to the extent of being possible) have not shown any
hickups. Marco's testing did not reveal any regressions.

I'm well aware that this distangling and rebasing should have happened
earlier in the development cycle, but in hindsight we're always smarter.

Thanks for your understanding and the exceptional allowance of rebasing
that late.

Thanks,

	Thomas

