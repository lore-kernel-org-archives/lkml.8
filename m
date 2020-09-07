Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055AEC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A134D2193E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgIGGS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:18:57 -0400
Received: from verein.lst.de ([213.95.11.211]:47760 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgIGGS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:18:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 90B7E68BFE; Mon,  7 Sep 2020 08:18:53 +0200 (CEST)
Date:   Mon, 7 Sep 2020 08:18:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] RISC-V: Allow drivers to provide custom read_cycles64
 for M-mode kernel
Message-ID: <20200907061853.GA19038@lst.de>
References: <20200904165709.GA32667@lst.de> <mhng-5249e999-3e82-417d-8d39-dcb4a159bd83@palmerdabbelt-glaptop1> <CAAhSdy0HW8Rjyoiu+Ldx31C9zCBdxJZxhDBcXC4sgitfXnPNDg@mail.gmail.com> <CAAhSdy3ESD6L_T1rFprDF2jduN8buTz173F6_mYCbTL3s4RG2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy3ESD6L_T1rFprDF2jduN8buTz173F6_mYCbTL3s4RG2A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 11:05:48AM +0530, Anup Patel wrote:
> Your patch will also break if the SOC specific timer has a 32bit
> free-running counter
> unlike the 64bit free-running counter found on CLINT.
> 
> I guess it's better to let the SOC timer driver provide the
> method/function to read the
> free-running counter.

Seriously, build the interfaces once you know the consumers.  Don't
build pie in the sky interfaces just because you can, because that
is what creates all the problems.

And of coruse at least for IPIs which absolutely are performance
criticical we need a standard interface (one that doesn't suck as much
as the SBI detour with the four extra context switches).  But I guess
I have already given up on RISC-V because the incompetency about things
like the irq design are just so horrible that it isn't worth bothering
any more.
