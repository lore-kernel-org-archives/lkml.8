Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DF0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E8F20709
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SCC0VTxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgIDIbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgIDIbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:31:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A122C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 01:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gbluQpPNHdbiMWA4xN7pVTQSsV8hyhAkU366CTjL+84=; b=SCC0VTxHP3pVTSpFGnwSKYEfBk
        XxquMP8BzgfEKVT2S5qiZsHJTZWYbYb0Tzgp3GoNQ0w/xcrSUqciagxcx3+xxKrKDth7x4Qt3POFB
        kk2iTmtowbfDyXay2rZZ0SPx8Q9rXYVD1a7gAzJov2TM7Y6gHGdCfOs9UlWyPeiu4WvI1rgLl/dSX
        g4TuFLQ57A89IzenfSbedJadPLzUI71y4COT0uDtunDi1B/kM7abwCKaIrm2pD4Z0oAHBPI75IdqH
        2QyjShdyWlKQcRj2zs3QkKOoGpn0/YCHVCTRt7L1ljAq/1hdy5Eek+FXSScxgNnALV1s0DEi/I7Nj
        fPmoAizw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kE77l-0002YB-Im; Fri, 04 Sep 2020 08:31:09 +0000
Date:   Fri, 4 Sep 2020 09:31:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RISC-V Fixes for 5.9-rc2
Message-ID: <20200904083109.GA9182@infradead.org>
References: <mhng-32c8d053-acbd-4c72-b41d-8d6042ac639d@palmerdabbelt-glaptop1>
 <CAHk-=wi_tf4qsiBj5UD0GG3wz8Hi5NrHzqdrx+CwtfAY+_UiGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_tf4qsiBj5UD0GG3wz8Hi5NrHzqdrx+CwtfAY+_UiGg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 12:35:20PM -0700, Linus Torvalds wrote:
> On Fri, Aug 21, 2020 at 11:26 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > * The CLINT driver has been split in two: one to handle the M-mode CLINT
> >   (memory mapped and used on NOMMU systems) and one to handle the S-mode CLINT
> >   (via SBI).
> 
> This looks more like development than fixes.
> 
> I guess I don't care deeply enough about it, but please don't do this.

Well, I care because this late pull requests completely breaks nommu
(nommu_virt_defconfig).   More specifically commit 2bc3fc877aa9
("RISC-V: Remove CLINT related code from timer and arch") leas to this
spew when booting under qemu:

[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] riscv-intc: 64 local interrupts mapped
[    0.000000] plic: interrupt-controller@c000000: mapped 53 interrupts with 2 handlers for 4 contexts.
[    0.000000] Oops - illegal instruction [#1]
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc1-00003-g2bc3fc877aa9c4 #609
[    0.000000] epc: 000000008000de78 ra : 000000008000ddaa sp : 0000000080187f40
[    0.000000]  gp : 00000000801a3aa8 tp : 000000008018bd40 t0 : 0000000000000019
[    0.000000]  t1 : 0000000000000018 t2 : 0000000000000001 s0 : 0000000080187f80
[    0.000000]  s1 : 0000000000000200 a0 : 000000008019b738 a1 : 0000000000000000
[    0.000000]  a2 : ffffffff80187f50 a3 : 0000000000000000 a4 : 0000000000000000
[    0.000000]  a5 : 0000000080169018 a6 : 0000000000000000 a7 : 00000000000001e4
[    0.000000]  s2 : 00000000801a40a8 s3 : 00000000801a4068 s4 : 000000008fc7c040
[    0.000000]  s5 : 00000000801a4038 s6 : 00000000801a4030 s7 : 0000000080012da0
[    0.000000]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
[    0.000000]  s11: 0000000000000000 t3 : 00000000801c40d8 t4 : 0000000000000068
[    0.000000]  t5 : 000000000000004c t6 : 0000000000000033
[    0.000000] status: 0000000000001800 badaddr: 0000000000000000 cause: 0000000000000002
[    0.000000] random: get_random_bytes called from 0x00000000800210c4 with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
