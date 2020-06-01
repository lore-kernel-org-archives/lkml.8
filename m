Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEEDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8579C2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgFASlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:41:04 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:37866 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731299AbgFASNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:13:01 -0400
Date:   Mon, 1 Jun 2020 14:13:00 -0400
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-ID: <20200601181259.GV1079@brightrain.aerifal.cx>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org>
 <20200529175335.GK1079@brightrain.aerifal.cx>
 <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 10:08:09AM +0200, John Paul Adrian Glaubitz wrote:
> On 5/29/20 7:53 PM, Rich Felker wrote:
> > Frustratingly, I _still_ don't have an official tree on kernel.org for
> > the purpose of being the canonical place for linux-next to pull from,
> > due to policies around pgp keys and nobody following up on signing
> > mine. This is all really silly since there are ridiculously many
> > independent channels I could cryptographically validate identity
> > through with vanishing probability that they're all compromised. For
> > the time being I'll reactivate my repo on git.musl-libc.org.
> 
> May I suggest to pick up these patches, for example? There might be
> more I missed, but getting these merged should already help a lot with
> the clean-up of arch/sh.

This was really helpful, but one thing that would make it easier if
you have any more to list is including message-ids rather than (or in
addition to) marc.info links. I had to go through and reverse them all
to message-ids (or at least subjects) to find the patches from my
mailbox to git-am.

> > [RESEND PATCH v2] sh: sh4a: Bring back tmu3_device early device
> > https://marc.info/?l=linux-sh&m=159061283109675&w=2

OK.

> > [PATCH] sh: Drop CONFIG_MTD_M25P80 in sh7757lcr_defconfig
> > https://marc.info/?l=linux-sh&m=158839364811658&w=2
> 
> > [PATCH v2] sh: Replace CONFIG_MTD_M25P80 with CONFIG_MTD_SPI_NOR in sh7757lcr_defconfig
> > https://marc.info/?l=linux-sh&m=158841749817761&w=2

Doesn't the second one here replace the first?

> > [PATCH 1/1] sh: remove sh5 support
> > https://marc.info/?l=linux-sh&m=158776683125080&w=2

I'm trying to figure out how to apply this since it was generated with
-D and git-am maliciously rejects it for that reason with an arcane
error message.

> > sh/mm: Fix a build failure via adding a missing bracket
> > https://marc.info/?l=linux-sh&m=158736532105299&w=2

Already upstream.

> > [PATCH 1/2] arch/sh: vmlinux.scr
> > https://marc.info/?l=linux-sh&m=158429470120959&w=2

OK.

> > [PATCH] sh: configs: Cleanup old Kconfig IO scheduler options
> > https://marc.info/?l=linux-sh&m=158195850120215&w=2

OK.

> > [PATCH resend 0/3] SH: compile fixup patches
> > https://marc.info/?l=linux-renesas-soc&m=157948330821790&w=2
> > https://marc.info/?l=linux-sh&m=157852970316892&w=2
> > https://marc.info/?l=linux-sh&m=157852984016938&w=2

OK.

> > [PATCH][repost] sh: clkfwk: remove r8/r16/r32
> > https://marc.info/?l=linux-renesas-soc&m=157852973916903&w=2

This one had objections by Geert that called for a v2, and was
teplaced by:

> > [PATCH] sh: clk: Fix discarding const qualifier warning
> > https://marc.info/?l=linux-sh&m=157839999010776&w=2

But this still had objections that the definitions on all archs should
be fixed for const correctness. It looks like that patch series is
still bouncing around; should I apply the SH part of it now?

> > [PATCH next] sh: remove call to memset after dma_alloc_coherent
> > https://marc.info/?l=linux-sh&m=157793031102356&w=2

Can anyone confirm that this is correct/safe?

> > [PATCH] sh: use generic strncpy()
> > https://marc.info/?l=linux-renesas-soc&m=157664657013309&w=2

Can you fill me in on the status of this? It looks like you were
following it. The subject says "use generic strncpy" but it's updating
the asm, and I think there are problems with the proposed asm.

> > [PATCH v2] SH: Convert ins[bwl]/outs[bwl] macros to inline functions
> > https://marc.info/?l=linux-sh&m=157656907716201&w=2

OK.

> > [PATCH v2] SH: Convert iounmap() macros to inline functions
> > https://marc.info/?l=linux-sh&m=157656903716172&w=2

OK.

> > [PATCH v2] sh: add missing DECLARE_EXPORT() for __ashiftrt_r4_xx
> > https://marc.info/?l=linux-sh&m=157619891030685&w=2

OK.

> > [PATCH] sh: add missing EXPORT_SYMBOL() for __delay
> > https://marc.info/?l=linux-kernel&m=157611811927852&w=2

OK.

> > [PATCH] sh: kgdb: Mark expected switch fall-throughs
> > https://marc.info/?l=linux-sh&m=157241987926081&w=2

This is already upstream.

Rich
