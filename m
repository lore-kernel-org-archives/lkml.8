Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EAEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D1F207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LM5GQuhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgHTNHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbgHTNGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:06:45 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253DAC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 06:06:45 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so1097337qtg.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 06:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6sOeSsarGxFkc/+IF5UxnDuuMZBTO6G7PiDa6w0ehU4=;
        b=LM5GQuhFGEsLF8MQ6iOdC11qBa7tnj8sX0Xil7PxLzz/UMQLxDRtcvKVnl1hsnEW3B
         icW4hW5rJquat9cuaRLYXwjPc69Id1R75PgEiZK66cy0exPj/r3d8qLlYwhkS18l5ifx
         73P1btmYPz9Qg/EwV8gf+/md6kgGYdrBDEw0GA1l/HYrJ5vU6uwgZQAB+Pk5iKxaDaPj
         p6NJ/ajFj2loXTCG/WdpbtmPs4jlcnvtQ+yOu2dbQcLz8I6nDj2yEkE7YDSZ6DgwNywy
         /ByoGAJ4Q1GtihDUQfhHQlVhNEp7M0JSHZFztUT7nMAmHo2nRwLUhBsT9/toWMJ2uZIk
         ebSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6sOeSsarGxFkc/+IF5UxnDuuMZBTO6G7PiDa6w0ehU4=;
        b=Vz/ZLVX8Z/Ti8x3o3EZxlJoDwTBrTLIw0mkVq9S5m+hEOjD4X6NAK1h3KllGvZuvlZ
         iNBFeSmjnULzgncffXSw0kc7wonIc+ofyJTZKw3W2UKXLE2BoKbmDhBE5XcPJAxlgy3U
         uBR5RDrNopu/3KwFzulkgXwq8k7tIdNGFSIJHptC1MAjRhp6CjmEr40yYPH0B1jxmgVs
         jo6j6mf4SJ8aRR4PqA21Epf44cIGgAlDDr6pvuVNXGzhxBhBJtRPki7XGjXp1YkoDC/N
         fDcjG20qERiBj/8gBxnM2/fItRquOexzd+ZVCoymztYRLoLqhtg2slRYgW5xOBAbyZfs
         Veyg==
X-Gm-Message-State: AOAM5313N7Hpnn3Ab7OICHPnvg1mzRy3/Gd9KWvgcUBuoAaFvekCAAa5
        xdkiLlFCHWCHllmWWuCCJUw=
X-Google-Smtp-Source: ABdhPJxccojle6U7opjzSg53Z05Mn86zUb3l5HAJ/ag2n1hc/KXp+E192r2u5Dp8CHeo4TtBW6Ckvg==
X-Received: by 2002:ac8:4e91:: with SMTP id 17mr2582988qtp.284.1597928804224;
        Thu, 20 Aug 2020 06:06:44 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q126sm1998857qke.34.2020.08.20.06.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 06:06:43 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 20 Aug 2020 09:06:41 -0400
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
Message-ID: <20200820130641.GA536306@rani.riverdale.lan>
References: <20200527135329.1172644-1-arnd@arndb.de>
 <878serh1b9.fsf@nanos.tec.linutronix.de>
 <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com>
 <87h7t6tpye.fsf@nanos.tec.linutronix.de>
 <20200813173701.GC4295@paulmck-ThinkPad-P72>
 <20200813180933.GA532283@rani.riverdale.lan>
 <875z9dioll.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875z9dioll.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 12:44:06PM +0200, Thomas Gleixner wrote:
> On Thu, Aug 13 2020 at 14:09, Arvind Sankar wrote:
> > On Thu, Aug 13, 2020 at 10:37:01AM -0700, Paul E. McKenney wrote:
> >> > Let me ask (hopefully) useful questions this time:
> >> > 
> >> >   Is a compiler allowed to reorder two 'asm volatile()'?
> >> > 
> >> >   Are there compilers (gcc >= 4.9 or other supported ones) which do that?
> >> 
> >> I would hope that the answer to both of these questions is "no"!
> >> 
> >> But I freely confess that I have been disappointed before on this sort
> >> of thing.  :-/
> >> 
> >> 							Thanx, Paul
> >
> > Ok, I found this, so gcc developers consider re-ordering volatile asm
> > wrt each other a bug at least.
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602
> 
> Yes. It prevents reordering of volatiles, but it does not necessarily
> prevent reorder of something like this:
> 
>         asm volatile(...);
>         foo();
>         asm volatile(...);
> 
> it might turn that into
> 
>         foo();
>         asm volatile(...);
>         asm volatile(...);
> 
> if I understood their discussion correctly. So removing this magic is
> not really straight forward.
> 
> Thanks,
> 
>         tglx
> 
> 

I don't think that's an issue, or at least, not one where force_order
helps.

If the source for foo() is not visible to the compiler, the only reason
force_order prevents the reordering is because foo() might have
references to it, but equally foo() might have volatile asm, so the
reordering isn't possible anyway.

If the source is visible, force_order won't prevent any reordering
except across references to force_order, but the only references are
from the volatile asm's which already prevent reordering.

I think force_order can only help with buggy compilers, and for those it
should really have been an input-output operand -- it wouldn't currently
do anything to prevent cr writes from being reordered.

Thanks.
