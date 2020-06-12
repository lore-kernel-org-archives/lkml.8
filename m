Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD1DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 10:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C1E2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 10:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgFMKtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 06:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgFMKs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 06:48:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49128C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 03:48:59 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jk3iY-0007x7-3h; Sat, 13 Jun 2020 12:48:54 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 7DA6F100D1F;
        Sat, 13 Jun 2020 12:48:53 +0200 (CEST)
Date:   Fri, 12 Jun 2020 22:05:04 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT pull resend] x86/entry and ras/core
Message-ID: <159199950433.21782.7922990856385499228.tglx@nanos.tec.linutronix.de>
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

[ Resending because it did not make LKML due to header wreckage which my
  sleep deprived and RCU demolished brain did not notice yesterday night and
  my script safety net failed to correct. ]

Linus,

the following two pull requests contain the distangled and rebased
variants of the x86/entry and ras/core branches.

Part 1 is the rebased version of the entry code rework which is based
on

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-06-11

which you merged yesterday. The result is equivalent to the non rebased code
which was in -next up to:

 2823e83a3dc0 ("x86/entry: __always_inline CR2 for noinstr")

On top of that sit 4 smallish fixes for late bug reports including the RCU
mystery which kept Paul and me busy in the last couple of days.

The issue Paul was observing with the latest RCU change in one esoteric
corner case test turned out to be a red herring:

 https://lkml.kernel.org/r/20200612215650.GN4455@paulmck-ThinkPad-P72

Retesting from scratch on the now fully updated x86/entry branch does not
longer show the effect and all tests pass. There is a high propability that
this was a RCU debugging inflicted PEBKAC. Paul claims that this is a
service which RCU provides for free.

Part 2 is the redone ras/core branch which now includes and therefore
depends on x86/entry up to

 f0178fc01fe4 ("x86/entry: Unbreak __irqentry_text_start/end magic")

Omitting the merge was briefly considered, but that would have caused a
tricky merge conflict and a untested rework of

  17fae1294ad9 ("x86/{mce,mm}: Unmap the entire page if the whole page is affected and poisoned")

which already utilizes the sanitized MCE innards. Basically the same
reasoning on the merge decision as a few weeks ago.

The rebase results have been carefully checked, tested and cross diffed to
the extent possible.

Again thanks for your understanding and the exceptional allowance of
rebasing that late.

Thanks,

	Thomas

