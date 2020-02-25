Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BFBC4BA09
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C00824686
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgBYXZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:25:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55491 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbgBYXZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:47 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6ja3-0004Yf-RG; Wed, 26 Feb 2020 00:25:36 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 25561100375;
        Wed, 26 Feb 2020 00:25:32 +0100 (CET)
Message-Id: <20200225220801.571835584@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:08:01 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 0/8] x86/entry: Consolidation - Part II
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is the second batch of a 73 patches series which consolidates the x86
entry code. The larger explanation is in the part I cover letter:

 https://lore.kernel.org/r/20200225213636.689276920@linutronix.de

I applies on top of part I which can be found via the above link.

This part cleans up the entry code and lifts the irq tracing and entry/exit
work into C, which is a preliminary to make especially the exit work a
generic infrastructure.

It has some rough edges as some of the ASM code is shared with
exceptions/traps/interrupts, which will be addressed in later parts of the
series.

This applies on top of part one which is available here:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v1-part1

To get both part 1 and part 2 pull from here:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v1-part2

Thanks,

	tglx

8<---------------
 common.c          |   82 ++++++++++++++++++++++++++++++++++++++++--------------
 entry_32.S        |   24 ++-------------
 entry_64.S        |    6 ---
 entry_64_compat.S |   32 +++------------------
 4 files changed, 71 insertions(+), 73 deletions(-)




