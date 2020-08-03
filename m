Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB50C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 03:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2259B206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 03:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgHCDqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 23:46:15 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:39311 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgHCDqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 23:46:15 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 0733jlX7015511;
        Mon, 3 Aug 2020 05:45:47 +0200
Date:   Mon, 3 Aug 2020 05:45:47 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: powerpc: build failures in Linus' tree
Message-ID: <20200803034547.GA15501@1wt.eu>
References: <20200802204842.36bca162@canb.auug.org.au>
 <20200802172019.GB26677@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20200802172019.GB26677@1wt.eu>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi again Stephen,

On Sun, Aug 02, 2020 at 07:20:19PM +0200, Willy Tarreau wrote:
> On Sun, Aug 02, 2020 at 08:48:42PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > We are getting build failures in some PowerPC configs for Linus' tree.
> > See e.g. http://kisskb.ellerman.id.au/kisskb/buildresult/14306515/
> > 
> > In file included from /kisskb/src/arch/powerpc/include/asm/paca.h:18,
> >                  from /kisskb/src/arch/powerpc/include/asm/percpu.h:13,
> >                  from /kisskb/src/include/linux/random.h:14,
> >                  from /kisskb/src/include/linux/net.h:18,
> >                  from /kisskb/src/net/ipv6/ip6_fib.c:20:
> > /kisskb/src/arch/powerpc/include/asm/mmu.h:139:22: error: unknown type name 'next_tlbcam_idx'
> >   139 | DECLARE_PER_CPU(int, next_tlbcam_idx);
> > 
> > I assume this is caused by commit
> > 
> >   1c9df907da83 ("random: fix circular include dependency on arm64 after addition of percpu.h")
> > 
> > But I can't see how, sorry.
> 
> So there, asm/mmu.h includes asm/percpu.h, which includes asm/paca.h, which
> includes asm/mmu.h.
> 
> I suspect that we can remove asm/paca.h from asm/percpu.h as it *seems*
> to be only used by the #define __my_cpu_offset but I don't know if anything
> will break further, especially if this __my_cpu_offset is used anywhere
> without this paca definition.

I tried this and it fixed 5.8 for me with your config above. I'm appending
a patch that does just this. I didn't test other configs as I don't know
which ones to test though. If it fixes the problem for you, maybe it can
be picked by the PPC maintainers.

Willy

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-powerpc-fix-circular-dependency-in-percpu.h.patch"

From bcd64a7d0f3445c9a75d3b4dc4837d2ce61660c9 Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Mon, 3 Aug 2020 05:27:57 +0200
Subject: powerpc: fix circular dependency in percpu.h

After random.h started to include percpu.h (commit f227e3e), several
archs broke in circular dependencies around percpu.h.

In https://lore.kernel.org/lkml/20200802204842.36bca162@canb.auug.org.au/
Stephen Rothwell reported breakage for powerpc with CONFIG_PPC_FSL_BOOK3E.

It turns out that asm/percpu.h includes asm/paca.h, which itself
includes mmu.h, which includes percpu.h when CONFIG_PPC_FSL_BOOK3E=y.

Percpu seems to include asm/paca.h only for local_paca which is used in
the __my_cpu_offset macro. Removing this include solves the issue for
this config.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: f227e3e ("random32: update the net random state on interrupt and activity")
Link: https://lore.kernel.org/lkml/20200802204842.36bca162@canb.auug.org.au/
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/powerpc/include/asm/percpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm/percpu.h
index dce863a..cd3f6e5 100644
--- a/arch/powerpc/include/asm/percpu.h
+++ b/arch/powerpc/include/asm/percpu.h
@@ -10,8 +10,6 @@
 
 #ifdef CONFIG_SMP
 
-#include <asm/paca.h>
-
 #define __my_cpu_offset local_paca->data_offset
 
 #endif /* CONFIG_SMP */
-- 
2.9.0


--+QahgC5+KEYLbs62--
