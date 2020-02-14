Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BD3C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594C12081E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oZz2i5Nb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgBNV7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:59:51 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43969 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgBNV7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:59:51 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so10554861oth.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 13:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKtuIXcYzsOMF6YWjfEnFlloh3WEO2jbYZIpGax7YKs=;
        b=oZz2i5NbdXHyXaqTu1uPe7G1OmqqhsiHVfcy2ZorvBYpIfGS8Zz2qSjFois+kLg+TC
         8dZscje1xU50nclFH3hKED+N6ng04PKp28jpFym9Fhq7c1ZgaR03SKvvj4NClrCRd/Ys
         kuNIbpnSSy/L3eKstCRpZxk1SYU7H0L7gzKTE2mxmappPPM8/KAdgk64odYrlQ+VYe5N
         2iZlSaSDJNz6LdbZmjaaervXra9rMPY/gA9++dtIqLqTOiqALJPuzRoBPI6vb2ki+sbW
         Djp3Mh8U/OdmaK8DSPDj+XLg1GGKOlLx2SZyApr95RX5AoITCPoxR0YIqqRFuJA4Jy9f
         p1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKtuIXcYzsOMF6YWjfEnFlloh3WEO2jbYZIpGax7YKs=;
        b=RW7iduQdt0E2mmmFFAbFtOqobMUkvWGHw68AnNbYyy3xPbY1hyUeUqVWRoNJli0CBS
         5at2IqaWjvOavaW1sq8LlXX7keSoqW+EcaqYaWZMXCjFS/9LM0VLzTLlQ3itpSnCJEpr
         Wke8vIBQ63N8ZTe7xqBDwYXLNJkqnJgtnWf009o7YRdWNSgGyfZi6r3Iv6pVSaKU4v68
         72WbK8dts0zbAQVi8v4o9Eo6Zrz4CJSj6EUiktGE/ZRNlpffZ3TTbsHwqXT+qA5Hc6SR
         LFplM15jLHjXLC/SnnbXo1uatfP6sdn7j2wXmzJGyLsy0Z7uEGZsXZUp4wVqRjSrEdkw
         IzHA==
X-Gm-Message-State: APjAAAU6RGsJEP5uNhw7RrZ2Nvrm7aqoNxbjpf9fIA1OBEFl4JLQ+ni2
        qSx5k9DR82oxkKZTc2qV9d4FqEoH8pycWcQkaUBeSw==
X-Google-Smtp-Source: APXvYqyEOdqZM+Z+TF3anIJRiMpWDV06BiwP7Mj8IZcjpcCep4DVoszFJQHbKYxA36khiooEpoGXXkPNMxSDom9U2n0=
X-Received: by 2002:a05:6830:1d7b:: with SMTP id l27mr3702226oti.251.1581717590307;
 Fri, 14 Feb 2020 13:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20200214190500.126066-1-elver@google.com> <1581708956.7365.75.camel@lca.pw>
In-Reply-To: <1581708956.7365.75.camel@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Fri, 14 Feb 2020 22:59:39 +0100
Message-ID: <CANpmjNOANOLz0mzaWt_N2kqr5EOzGM6=SfTA7doyZ4fh-tQpiA@mail.gmail.com>
Subject: Re: [PATCH] kcsan, trace: Make KCSAN compatible with tracing
To:     Qian Cai <cai@lca.pw>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2020 at 20:35, Qian Cai <cai@lca.pw> wrote:
>
> On Fri, 2020-02-14 at 20:05 +0100, Marco Elver wrote:
> > Previously the system would lock up if ftrace was enabled together with
> > KCSAN. This is due to recursion on reporting if the tracer code is
> > instrumented with KCSAN.
> >
> > To avoid this for all types of tracing, disable KCSAN instrumentation
> > for all of kernel/trace.
>
> I remembered that KCSAN + ftrace was working last week, but I probably had a bad
> memory. Anyway, this patch works fine. Feel free to add,
>
> Tested-by: Qian Cai <cai@lca.pw>

Based your further feedback I've sent v2:
  http://lkml.kernel.org/r/20200214211035.209972-1-elver@google.com

Thanks,
-- Marco

> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Reported-by: Qian Cai <cai@lca.pw>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > ---
> >  kernel/kcsan/Makefile | 2 ++
> >  kernel/trace/Makefile | 3 +++
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
> > index df6b7799e4927..d4999b38d1be5 100644
> > --- a/kernel/kcsan/Makefile
> > +++ b/kernel/kcsan/Makefile
> > @@ -4,6 +4,8 @@ KCOV_INSTRUMENT := n
> >  UBSAN_SANITIZE := n
> >
> >  CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
> > +CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
> > +CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
> >
> >  CFLAGS_core.o := $(call cc-option,-fno-conserve-stack,) \
> >       $(call cc-option,-fno-stack-protector,)
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index f9dcd19165fa2..6b601d88bf71e 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -6,6 +6,9 @@ ifdef CONFIG_FUNCTION_TRACER
> >  ORIG_CFLAGS := $(KBUILD_CFLAGS)
> >  KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
> >
> > +# Avoid recursion due to instrumentation.
> > +KCSAN_SANITIZE := n
> > +
> >  ifdef CONFIG_FTRACE_SELFTEST
> >  # selftest needs instrumentation
> >  CFLAGS_trace_selftest_dynamic.o = $(CC_FLAGS_FTRACE)
