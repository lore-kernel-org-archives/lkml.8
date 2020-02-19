Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C4CC3405F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEE8206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ezxabv3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgBSRoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:44:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37596 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSRon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:44:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so363591plz.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Zerwr5LVoD9w0G00G1YsmnKd+u52a5G2yVAzT73CuQ=;
        b=ezxabv3hlXaPKMrbyel92GCxKOdqEfJfkncTl9L1UwG6liI1neuaZftEVFBsHwlFGi
         ildP/XITFnjN+SBQsZOKh01ai+2P7DSunNk4ZxKbBkdxzVx5E2JFakDUiOwg2LzOmv6g
         kOn0EEwkPhT5wmsYUqUuG03F9EajzmECYOKF/X3EmUva/uldBTWbjlnlxTB/bufIEoEA
         f39vAdwOJe1DBsTeNBwAth2+QIXKU4Z383+etxjE9atpUHqRsLcFta4Z8kYt6MrFzQcw
         aOVgxiFcJxB0D/PMlQ1uKNxNRTolrBFoXqNOdRp5kMpKrH7MMqL9KAUM1eWk1NDA5CFy
         eKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Zerwr5LVoD9w0G00G1YsmnKd+u52a5G2yVAzT73CuQ=;
        b=SQt2pN1v6cPJBXHqdPTVkmE4y2crhk43KMzUATRcDUInTVIdx6jwtE/EfqZ0rA0qKm
         IVi1ch9+5ykMoKDJaqDE+3cWxMEfPjfZtfmH2Kse/+k0DSAJr+gUctgU6ThX60s5pbke
         2M7Trio20d3FMLrJv537/N3m2WOC9d66RyFLdF6xfz8Ex2XPeuFPl4HHxI7cuDO39FsI
         uBfhicId2q4IeFpf8KmeSPg5Ee1TIM+Qrh6VIVBjBsrfx5QQ9is5Jo5oSB9ozesRhMeI
         8nkW38jxLqt59R6NEd8KNURHmsmcgS4CG/LVG18F12XuRz1dbKglQBqnKOfswCMS1GSh
         BF3g==
X-Gm-Message-State: APjAAAVeElQCeQJa5Y6977+5o82fD6EbtDHIBiWxwQqL8lVujjSin+l3
        CHVb6klU09UDyNneRWallXS5KSXC83CeM78caBrlwQ==
X-Google-Smtp-Source: APXvYqwgwaJwqCbIGiJG/t9AN5GA3UaekcGZBPD9itMUe9n7Ox0RNcbqUdR+MZqmN6x0VvswiWfk9cfEyYh8GYYpsCY=
X-Received: by 2002:a17:902:8a88:: with SMTP id p8mr26529137plo.179.1582134282820;
 Wed, 19 Feb 2020 09:44:42 -0800 (PST)
MIME-Version: 1.0
References: <20200219045423.54190-1-natechancellor@gmail.com>
 <20200219045423.54190-4-natechancellor@gmail.com> <20200219093445.386f1c09@gandalf.local.home>
In-Reply-To: <20200219093445.386f1c09@gandalf.local.home>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Feb 2020 09:44:31 -0800
Message-ID: <CAKwvOdm-N1iX0SMxGDV5Vf=qS5uHPdH3S-TRs-065BuSOdKt1w@mail.gmail.com>
Subject: Re: [PATCH 3/6] tracing: Wrap section comparison in
 tracer_alloc_buffers with COMPARE_SECTIONS
To:     Steven Rostedt <rostedt@goodmis.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 6:34 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 18 Feb 2020 21:54:20 -0700
> Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> > Clang warns:
> >
> > ../kernel/trace/trace.c:9335:33: warning: array comparison always
> > evaluates to true [-Wtautological-compare]
> >         if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
> >                                        ^
> > 1 warning generated.
> >
> > These are not true arrays, they are linker defined symbols, which are
> > just addresses so there is not a real issue here. Use the
> > COMPARE_SECTIONS macro to silence this warning by casting the linker
> > defined symbols to unsigned long, which keeps the logic the same.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/765
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  kernel/trace/trace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index c797a15a1fc7..e1f3b16e457b 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -9332,7 +9332,7 @@ __init static int tracer_alloc_buffers(void)
> >               goto out_free_buffer_mask;
> >
> >       /* Only allocate trace_printk buffers if a trace_printk exists */
> > -     if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
> > +     if (COMPARE_SECTIONS(__stop___trace_bprintk_fmt, !=, __start___trace_bprintk_fmt))
>
> Sorry, but this is really ugly and unreadable. Please find some other
> solution to fix this.
>
> NAK-by: Steven Rostedt
>

Hey Nathan,
Thanks for the series; enabling the warning will help us find more
bugs.  Revisiting what the warning is about, I checked on this
"referring to symbols defined in linker scripts from C" pattern.  This
document [0] (by no means definitive, but I think it has a good idea)
says:

Linker symbols that represent a data address: In C code, declare the
variable as an extern variable. Then, refer to the value of the linker
symbol using the & operator. Because the variable is at a valid data
address, we know that a data pointer can represent the value.
Linker symbols for an arbitrary address: In C code, declare this as an
extern symbol. The type does not matter. If you are using GCC
extensions, declare it as "extern void".

Indeed, it seems that Clang is happier with that pattern:
https://godbolt.org/z/sW3t5W

Looking at __stop___trace_bprintk_fmt in particular:

kernel/trace/trace.h
1923:extern const char *__stop___trace_bprintk_fmt[];

(Should be `extern const void __stop___trace_bprintk_fmt;` void since
we don't access any data or function from that symbol, just compare
its address)

kernel/trace/trace_printk.c
260: start_index = __stop___trace_bprintk_fmt - __start___trace_bprintk_fmt;

(Should be `start_index = (uintptr_t)__stop___trace_bprintk_fmt -
(uintptr_t)__start___trace_bprintk_fmt;`) (storing the result in an
int worries me a little, but maybe that refactoring can be saved for
another day)

kernel/trace/trace.c
9335: if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)

(Should be `if (&__stop___trace_bprintk_fmt -
&__start___trace_bprintk_fmt)`.  That's not a significant change to
the existing code, and is quite legible IMO)

Steven, thoughts?

[0] http://downloads.ti.com/docs/esd/SPRUI03/using-linker-symbols-in-c-c-applications-slau1318080.html
-- 
Thanks,
~Nick Desaulniers
