Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4CEC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 02:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA60A206BE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 02:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgGDCaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 22:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgGDCaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 22:30:18 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937D3C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 19:30:18 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrXwP-004yEA-S0; Sat, 04 Jul 2020 02:30:10 +0000
Date:   Sat, 4 Jul 2020 03:30:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
Message-ID: <20200704023009.GA2786714@ZenIV.linux.org.uk>
References: <87lfk26nx4.fsf@mpe.ellerman.id.au>
 <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk>
 <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
 <20200702205902.GP2786714@ZenIV.linux.org.uk>
 <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
 <20200703013328.GQ2786714@ZenIV.linux.org.uk>
 <20200703210237.GS2786714@ZenIV.linux.org.uk>
 <20200704004959.GY2786714@ZenIV.linux.org.uk>
 <CAHk-=whxLURD=qsF3ijmQYxGRPSyjS8_zoxZz-AsD-7tmRBM0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whxLURD=qsF3ijmQYxGRPSyjS8_zoxZz-AsD-7tmRBM0w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 06:54:15PM -0700, Linus Torvalds wrote:

>  "Software Prefetches May Report A Page Fault
> 
>   Description Software prefetch instructions are defined to ignore
> page faults. Under highly specific and detailed internal
> circumstances, a prefetch instruction may report a page fault if both
> of the following conditions are true:
> 
>    • The target address of the prefetch would cause a page fault if
> the address was accessed by an actual memory load or store instruction
> under the current privilege mode;
> 
>    • The prefetch instruction is followed in execution-order by an
> actual or speculative byte-sized memory access of the same
> modify-intent to the same address. PREFETCH and PREFETCHNTA/0/1/2 have
> the same modify-intent as a memory load access.
> 
>   PREFETCHW has the same modify-intent as a memory store access. The
> page fault exception error code bits for the faulting prefetch will be
> identical to that for a bytesized memory access of the same-modify
> intent to the same address. Note that some misaligned accesses can be
> broken up by the processor into multiple accesses where at least one
> of the accesses is a byte-sized access. If the target address of the
> subsequent memory access of the same modify-intent is aligned and not
> byte-sized, this errata does not occur and no workaround is needed.
> 
>   Potential Effect on System An unexpected page fault may occur
> infrequently on a prefetch instruction."

Lovely...  So basically this is the rare place where we might use those
insns on userland addresses?
