Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD07C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144332063A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SFsU/76c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgFOPEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbgFOPEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:04:08 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656E8C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jNEVxB8K8qkb0jxDWu2/VVQDIry1tExCa9xuuvd1cs0=; b=SFsU/76cAf/cYf4hUgNJOHfJ0j
        17FLfyK9bUDLjXvy8yoEhllceLlOwr5/xLuPtgYVvX8et5ZvjBknrKLgWQYlpWwJbQHnziNy95SkH
        Eda6lq/FS29jNdz2WwNMn7T1xN6qaodxPcHwMsMbrahnZ4+j3kWGSNEalil6t5+HMFgaeunDXA+gm
        pxY22UgG/Id/MONFk3WJIm6TNH7hkCp6KsEto04/zJSefFe18iO0flvl0vQAN//ibFOH+gxVtIsbf
        8AmoCohlPKw67hKDBq0kdY/8CAOctuvOU3MmYeQf29nE0sWm1kPJmyW8S8CoCiHgh3ybrZX6KCrKy
        eajqibMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkqe1-0007MO-Lu; Mon, 15 Jun 2020 15:03:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D85B83003E1;
        Mon, 15 Jun 2020 17:03:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDCF2203C3763; Mon, 15 Jun 2020 17:03:27 +0200 (CEST)
Date:   Mon, 15 Jun 2020 17:03:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions
 noinstr-compatible
Message-ID: <20200615150327.GW2531@hirez.programming.kicks-ass.net>
References: <CANpmjNPNa2f=kAF6c199oYVJ0iSyirQRGxeOBLxa9PmakSXRbA@mail.gmail.com>
 <CACT4Y+Z+FFHFGSgEJGkd+zCBgUOck_odOf9_=5YQLNJQVMGNdw@mail.gmail.com>
 <20200608110108.GB2497@hirez.programming.kicks-ass.net>
 <20200611215538.GE4496@worktop.programming.kicks-ass.net>
 <CACT4Y+aKVKEp1yoBYSH0ebJxeqKj8TPR9MVtHC1Mh=jgX0ZvLw@mail.gmail.com>
 <20200612114900.GA187027@google.com>
 <CACT4Y+bBtCbEk2tg60gn5bgfBjARQFBgtqkQg8VnLLg5JwyL5g@mail.gmail.com>
 <CANpmjNM+Tcn40MsfFKvKxNTtev-TXDsosN+z9ATL8hVJdK1yug@mail.gmail.com>
 <20200615142949.GT2531@hirez.programming.kicks-ass.net>
 <20200615145336.GA220132@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615145336.GA220132@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 04:53:36PM +0200, Marco Elver wrote:
> On Mon, 15 Jun 2020, Peter Zijlstra wrote:
> 
> > On Mon, Jun 15, 2020 at 09:53:06AM +0200, Marco Elver wrote:
> > > 
> > > Disabling KCOV for smp_processor_id now moves the crash elsewhere. In
> > > the case of KASAN into its 'memcpy' wrapper, called after
> > > __this_cpu_read in fixup_bad_iret. This is making me suspicious,
> > > because it shouldn't be called from the noinstr functions.
> > 
> > With your .config, objtool complains about exactly that though:
> > 
> > vmlinux.o: warning: objtool: fixup_bad_iret()+0x8e: call to memcpy() leaves .noinstr.text section
> > 
> > The utterly gruesome thing below 'cures' that.
> 
> Is __memcpy() generally available? I think that bypasses KASAN and
> whatever else.

Yes, I think so. x86_64 needs lib/memcpy_64.S in .noinstr.text then. For
i386 it's an __always_inline inline-asm thing.
