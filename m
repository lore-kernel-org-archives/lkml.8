Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120CEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D7F2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ljbBHdns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgESVKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgESVKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:10:49 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FCBC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:10:49 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e2so607469eje.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AbC5vCRnUHjH33LjSKWOgN9hGAne5JahHYoJjapwL0Q=;
        b=ljbBHdnsSxiajpgO/HPrYEbtk1N6Xt3GFUfJbnBGRZSVLYIJQde5b8kYhCRrbxgwfN
         sbX9FySMYa3eJ30s3HEGUa+29pSAb7v52vbOf1Hwbs9aUFstJdP6ZVh2gM/dGVdpobR1
         rgxo3AtjBCDbbtnTHzbAxL1Ip2OcFI/qedS1cf4udJrK1MO0kJrLpovOXbokrwhXTFMd
         JEsjdPCGLJMHwA0fyD1N0LTsm3EANf7Cuu3oa5qvcQi+Y/kEJV2KlgKTMbk+EIhpdwz4
         I7h0RAO4yApe6+wmw00J/zjBG/VcVdti85KJjvq6G0FqriKka1ACszHq5JF1Z4kFEQNn
         2JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbC5vCRnUHjH33LjSKWOgN9hGAne5JahHYoJjapwL0Q=;
        b=P2bG7IXTvrQUd4pKgjtA7dBg1pFQtmLkeO7UKNux5nmPN2imtcA+sx0CK4rnWd498A
         zIFqXFJMbJx4/HY5f34giaviRviJMBSLoS9CMvO0pDDqjksFY8Pw8tynCfz4k9WuR78i
         RMyn3GKuK9JTBX0Nd3W2f7IhR0+VG1qg62kLDwxa1IPbc4floPx7Yk+GMqAkZIhPP6/U
         D+1c87+w/K1QA4Mr6V7do5oOlTJ4ddg1UE5jVsmu2xvRSvPaT93vTG8QcaTuyXLehaDG
         t1XD/6OSs/G4CEsKsmsEWQq5WqXoM3S+slld31XyZZ7ms1nq7tmbLaIyJ1oBIc+UiAv/
         CnmA==
X-Gm-Message-State: AOAM531B872+500Zhq8amj1DWm0MCr1OcHwXmRXSJ8R37/2FljRCX+tr
        McgJJhzWXXhqQknUMbqKlepPl9HcZ2iAPC6m/UWESg==
X-Google-Smtp-Source: ABdhPJz1opQ376XjpMFtE4CEzTFIEY+HHZJAj094q0u6sxUdFV9TtZA15QwzwGk1tOCkTB54anu9js/KaS/1AqFv93Y=
X-Received: by 2002:a17:906:f198:: with SMTP id gs24mr977304ejb.547.1589922647505;
 Tue, 19 May 2020 14:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200512183839.2373-1-elver@google.com> <20200512190910.GM2957@hirez.programming.kicks-ass.net>
In-Reply-To: <20200512190910.GM2957@hirez.programming.kicks-ass.net>
From:   Qian Cai <cai@lca.pw>
Date:   Tue, 19 May 2020 17:10:36 -0400
Message-ID: <CAG=TAF5S+n_W4KM9F8QuCisyV+s6_QA_gO70y6ckt=V7SS2BXw@mail.gmail.com>
Subject: Re: [PATCH] READ_ONCE, WRITE_ONCE, kcsan: Perform checks in __*_ONCE variants
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
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

On Tue, May 12, 2020 at 3:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, May 12, 2020 at 08:38:39PM +0200, Marco Elver wrote:
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 741c93c62ecf..e902ca5de811 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -224,13 +224,16 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >   * atomicity or dependency ordering guarantees. Note that this may result
> >   * in tears!
> >   */
> > -#define __READ_ONCE(x)       (*(const volatile __unqual_scalar_typeof(x) *)&(x))
> > +#define __READ_ONCE(x)                                                       \
> > +({                                                                   \
> > +     kcsan_check_atomic_read(&(x), sizeof(x));                       \
> > +     data_race((*(const volatile __unqual_scalar_typeof(x) *)&(x))); \
> > +})
>
> NAK
>
> This will actively insert instrumentation into __READ_ONCE() and I need
> it to not have any.

Any way to move this forward? Due to linux-next commit 6bcc8f459fe7
(locking/atomics: Flip fallbacks and instrumentation), it triggers a
lots of KCSAN warnings due to atomic ops are no longer marked. For
example,

[  197.318288][ T1041] write to 0xffff9302764ccc78 of 8 bytes by task
1048 on cpu 47:
[  197.353119][ T1041]  down_read_trylock+0x9e/0x1e0
atomic_long_set(&sem->owner, val);
__rwsem_set_reader_owned at kernel/locking/rwsem.c:205
(inlined by) rwsem_set_reader_owned at kernel/locking/rwsem.c:213
(inlined by) __down_read_trylock at kernel/locking/rwsem.c:1373
(inlined by) down_read_trylock at kernel/locking/rwsem.c:1517
[  197.374641][ T1041]  page_lock_anon_vma_read+0x19d/0x3c0
[  197.398894][ T1041]  rmap_walk_anon+0x30e/0x620

[  197.924695][ T1041] read to 0xffff9302764ccc78 of 8 bytes by task
1041 on cpu 43:
[  197.959501][ T1041]  up_read+0xb8/0x41a
arch_atomic64_read at arch/x86/include/asm/atomic64_64.h:22
(inlined by) atomic64_read at include/asm-generic/atomic-instrumented.h:838
(inlined by) atomic_long_read at include/asm-generic/atomic-long.h:29
(inlined by) rwsem_clear_reader_owned at kernel/locking/rwsem.c:242
(inlined by) __up_read at kernel/locking/rwsem.c:1433
(inlined by) up_read at kernel/locking/rwsem.c:1574
[  197.977728][ T1041]  rmap_walk_anon+0x2f2/0x620
[  197.999055][ T1041]  rmap_walk+0xb5/0xe0
