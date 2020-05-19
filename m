Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C43C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 318FF2072C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOxhHUdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgESV0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESV0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:26:02 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A9DC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:26:02 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 19so1085712oiy.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/DW1pZj1YNbWgzrr4MlM3GiIz1LA4FZ7zkZDxQ3+/E=;
        b=SOxhHUdF5aVkURIMUqLZSfCO16IDtsaxcATYSXXOV7Uy3Me1WBKsTQA8ldEVBy1MDf
         FIbQveeRlcMwBv/lGeNHNhtNv5idIinT8VezWnN9nZfywxCHSN+XrrXWheRyJ+EorNAH
         xD44DZ0kfGGuYmwEVXfGgtF3cnShbYD4UTL4/46wlHxa5jt8zJZ06D7dc8uR6iO9sMbv
         QAbUHJGBH0liQNxp8dlnqRTtzswct6efckiIiFL747yiR0ZJ49FHEYZN4CLhvllJziT+
         yB8sGqbgpk+CM2CLeXrO0lvSVUsdhADe9r1awZhvzww9Qk6bA4RPIaSFihjrxTX2+tsL
         Jsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/DW1pZj1YNbWgzrr4MlM3GiIz1LA4FZ7zkZDxQ3+/E=;
        b=rZrh3h/IELCdVaU3o5qSRtX+kB/I7Q1r1K9tmEyhwC2VW9RpdRiNp7rmRQSh/fvRhN
         uZoodZBRCVkFf2/dl2/IvvKTeRdplru5LRr8J5zFCF3TJMJcvcMEvSQuDgUASx0bEHuc
         dyAz9Bac5HFdxHXMt85qfOWa24v/DKospIxEGN14UHDyoNoBhbHKl9lU5KjnGGecaHu4
         otnIMeAR0GOlZZdykG8gLF7VYnIwi6jhf2GTFrOQC5gNdpQccYJFzvfhwSO25QMLftVz
         C5KsdKX3YPIcBgE7IfpNNs6wHno5TXjzb/sflEaYZUWeocXtiicvY3d7bPHUZRgEheiZ
         YjTQ==
X-Gm-Message-State: AOAM530SdbQ51ikJI5YdR98rSG8Q/s/S1rGxIApVdbs5rsH1xyAMda+P
        gKPHZPr2c/jmHif62ASTktWLTvX4scfo+OJsIdo9/A==
X-Google-Smtp-Source: ABdhPJwxJ91vZNt3aFO0c9nFQyUQ96gp/th2m+lM/IG4zTw2ixlyakzQVMwUgpbvUcbN93Zcsxa13MM7/JNOpDWPpRk=
X-Received: by 2002:aca:6747:: with SMTP id b7mr771179oiy.121.1589923561779;
 Tue, 19 May 2020 14:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200512183839.2373-1-elver@google.com> <20200512190910.GM2957@hirez.programming.kicks-ass.net>
 <CAG=TAF5S+n_W4KM9F8QuCisyV+s6_QA_gO70y6ckt=V7SS2BXw@mail.gmail.com>
In-Reply-To: <CAG=TAF5S+n_W4KM9F8QuCisyV+s6_QA_gO70y6ckt=V7SS2BXw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 19 May 2020 23:25:50 +0200
Message-ID: <CANpmjNMxvMpr=KaJEoEeRMuS3PGZEyi-VkeSmNywpQTAzFMSVA@mail.gmail.com>
Subject: Re: [PATCH] READ_ONCE, WRITE_ONCE, kcsan: Perform checks in __*_ONCE variants
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 at 23:10, Qian Cai <cai@lca.pw> wrote:
>
> On Tue, May 12, 2020 at 3:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, May 12, 2020 at 08:38:39PM +0200, Marco Elver wrote:
> > > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > > index 741c93c62ecf..e902ca5de811 100644
> > > --- a/include/linux/compiler.h
> > > +++ b/include/linux/compiler.h
> > > @@ -224,13 +224,16 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> > >   * atomicity or dependency ordering guarantees. Note that this may result
> > >   * in tears!
> > >   */
> > > -#define __READ_ONCE(x)       (*(const volatile __unqual_scalar_typeof(x) *)&(x))
> > > +#define __READ_ONCE(x)                                                       \
> > > +({                                                                   \
> > > +     kcsan_check_atomic_read(&(x), sizeof(x));                       \
> > > +     data_race((*(const volatile __unqual_scalar_typeof(x) *)&(x))); \
> > > +})
> >
> > NAK
> >
> > This will actively insert instrumentation into __READ_ONCE() and I need
> > it to not have any.
>
> Any way to move this forward? Due to linux-next commit 6bcc8f459fe7
> (locking/atomics: Flip fallbacks and instrumentation), it triggers a
> lots of KCSAN warnings due to atomic ops are no longer marked.

This is no longer the right solution we believe due to the various
requirements that Peter also mentioned. See the discussion here:
    https://lkml.kernel.org/r/CANpmjNOGFqhtDa9wWpXs2kztQsSozbwsuMO5BqqW0c0g0zGfSA@mail.gmail.com

The new solution is here:
    https://lkml.kernel.org/r/20200515150338.190344-1-elver@google.com
While it's a little inconvenient that we'll require Clang 11
(currently available by building yourself from LLVM repo), but until
we get GCC fixed (my patch there still pending :-/), this is probably
the right solution going forward.   If possible, please do test!

Thanks,
-- Marco

> For
> example,
> [  197.318288][ T1041] write to 0xffff9302764ccc78 of 8 bytes by task
> 1048 on cpu 47:
> [  197.353119][ T1041]  down_read_trylock+0x9e/0x1e0
> atomic_long_set(&sem->owner, val);
> __rwsem_set_reader_owned at kernel/locking/rwsem.c:205
> (inlined by) rwsem_set_reader_owned at kernel/locking/rwsem.c:213
> (inlined by) __down_read_trylock at kernel/locking/rwsem.c:1373
> (inlined by) down_read_trylock at kernel/locking/rwsem.c:1517
> [  197.374641][ T1041]  page_lock_anon_vma_read+0x19d/0x3c0
> [  197.398894][ T1041]  rmap_walk_anon+0x30e/0x620
>
> [  197.924695][ T1041] read to 0xffff9302764ccc78 of 8 bytes by task
> 1041 on cpu 43:
> [  197.959501][ T1041]  up_read+0xb8/0x41a
> arch_atomic64_read at arch/x86/include/asm/atomic64_64.h:22
> (inlined by) atomic64_read at include/asm-generic/atomic-instrumented.h:838
> (inlined by) atomic_long_read at include/asm-generic/atomic-long.h:29
> (inlined by) rwsem_clear_reader_owned at kernel/locking/rwsem.c:242
> (inlined by) __up_read at kernel/locking/rwsem.c:1433
> (inlined by) up_read at kernel/locking/rwsem.c:1574
> [  197.977728][ T1041]  rmap_walk_anon+0x2f2/0x620
> [  197.999055][ T1041]  rmap_walk+0xb5/0xe0
