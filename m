Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D37C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8A82073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgIDQ5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:57:15 -0400
Received: from verein.lst.de ([213.95.11.211]:42596 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbgIDQ5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:57:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 64FF168BEB; Fri,  4 Sep 2020 18:57:09 +0200 (CEST)
Date:   Fri, 4 Sep 2020 18:57:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@lst.de>, Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] RISC-V: Allow drivers to provide custom read_cycles64
 for M-mode kernel
Message-ID: <20200904165709.GA32667@lst.de>
References: <20200904162121.279578-1-anup.patel@wdc.com> <20200904162530.GA32095@lst.de> <CAAhSdy2ru2xuOC76UvCBhUoDNEv=f_w0Q4N+9UmQaVnNyMaE-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy2ru2xuOC76UvCBhUoDNEv=f_w0Q4N+9UmQaVnNyMaE-Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 10:13:18PM +0530, Anup Patel wrote:
> I respectfully disagree. IMHO, the previous code made the RISC-V
> timer driver convoluted (both SBI call and CLINT in one place) and
> mandated CLINT for NoMMU kernel. In fact, RISC-V spec does not
> mandate CLINT or PLIC. The RISC-V SOC vendors are free to
> implement their own timer device, IPI device and interrupt controller.

Yes, exactly what we need is everyone coming up with another stupid
non-standard timer and irq driver.

But the point is this crap came in after -rc1, and it adds totally
pointless indirect calls to the IPI path, and with your "fix" also
to get_cycles which all have exactly one implementation for MMU or
NOMMU kernels.

So the only sensible thing is to revert all this crap.  And if at some
point we actually have to deal with different implementations do it
with alternatives or static_branch infrastructure so that we don't
pay the price for indirect calls in the super hot path.
