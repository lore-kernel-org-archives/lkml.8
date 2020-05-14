Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9DDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E868206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iZ8lBoHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgENNOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726056AbgENNOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:14:33 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF76BC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K4yRXfBE6Kumf0RteQ59RKHAoo/xaI0w9/3Qtk/InMg=; b=iZ8lBoHlXLdkxFqPbB/Agxm8ix
        31/ut5izgfIci1Z70gYmMDgmrpmqo7bvkQdNZaTS+FKx+uN+3eayh5YxRN8tJOGrdm+xCzHCymb2b
        iWNd5G2YghcIsXBKQnEnd1WF3KiRD6blxpU1RkU+oOU7P4oXp/zA+1ufUCBZPoKeKlLHy169l3Rub
        j4H6OTw1LGWREw324FnMstFtyTIHx8PuOx+jHEGO1uoFwJNlp6N4Q3Ewj9Xbg3n97c46FEVl17AHJ
        6L18sdVhZCWMztkJ2SQUakG+kWhZMFsiuR2yJv3Q9MtxpEWHCekEizukILUqkFNkeZJVUaGdY1Bv+
        I6v+h4sA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZDgj-0007lq-OX; Thu, 14 May 2020 13:14:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 556163007CD;
        Thu, 14 May 2020 15:14:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C7E4213C8B61; Thu, 14 May 2020 15:14:12 +0200 (CEST)
Date:   Thu, 14 May 2020 15:14:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200514131412.GP2957@hirez.programming.kicks-ass.net>
References: <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net>
 <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513132440.GN2978@hirez.programming.kicks-ass.net>
 <CANpmjNM5dD1VH0hoQwsZYEL=mhWunKwAEJMQgASzHSN019OCnw@mail.gmail.com>
 <20200514112142.GV2978@hirez.programming.kicks-ass.net>
 <20200514120104.GD4280@willie-the-truck>
 <20200514122735.GW2978@hirez.programming.kicks-ass.net>
 <CANpmjNPmZv6TBQJ93TRuxCxJCpvJy8+XS5u9+ucOE2eEebEw9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPmZv6TBQJ93TRuxCxJCpvJy8+XS5u9+ucOE2eEebEw9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 03:07:08PM +0200, Marco Elver wrote:
> On Thu, 14 May 2020 at 14:27, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, May 14, 2020 at 01:01:04PM +0100, Will Deacon wrote:
> >
> > > > +#if __has_feature(undefined_sanitizer)
> > >
> > > Hmm, this might want to be __has_feature(undefined_behavior_sanitizer)
> > > (and damn is that hard for a Brit to type out!)
> >
> > (I know right, it should be behaviour, dammit!)
> >
> > I tried without the condition, eg.:
> >
> > +#define __no_sanitize_undefined \
> > +               __attribute__((no_sanitize("undefined")))
> >
> > and it still generated UBSAN gunk.
> 
> Which ubsan calls are left? I'm trying to reproduce.

To be more precise, the patches were on top of:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v5-the-rest

$ grep ubsan poke_int3_handler-clang10.asm
0074                    74: R_X86_64_PLT32      __ubsan_handle_load_invalid_value-0x4
0083                    83: R_X86_64_PLT32      __ubsan_handle_load_invalid_value-0x4
01c5                    1c5: R_X86_64_PLT32     __ubsan_handle_builtin_unreachable-0x4

I think the config was defconfig_x86-64 inspired with KASAN+UBSAN
enabled.

So I build with:

  touch arch/x86/kernel/alterantive.c;
  make CC=clang-10 V=1 O=defconfig-build/ arch/x86/kernel/alterantive.o

And then dump the output with:

  ./objdump-func.sh defconfig-build/arch/x86/kernel/alterantive.o poke_int3_handler

$ # cat objdump-func.sh
#!/bin/bash
objdump -dr $1 | awk "/^\$/ { P=0; } /$2[^>]*>:\$/ { P=1; O=strtonum(\"0x\" \$1); } { if (P) { o=strtonum(\"0x\" \$1); printf(\"%04x \", o-O); print \$0; } }"


Hope that is enough to reproduce.
