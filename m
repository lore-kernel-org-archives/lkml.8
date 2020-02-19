Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB53FC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5472465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jcMcqCD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgBSTLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:11:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35852 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgBSTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:11:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so461835plm.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 11:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ap2ctb13s1qbCfj4OTZiKRJIdNv9n1BdWeqlAwLw5Qg=;
        b=jcMcqCD/4wwPKW1BHPXI7rg577Xt5FZSRtafy05KYiATgkZDsr7BgHYLd+lGSHb+2C
         AVZ1aC8O25vV/DHzCNwchjAmiG2WZZSFwCt67Fss+0OVrlHba21K+6IYAmYgzxUEROYY
         xwtbemqIexJTa2NGIKygqTcwTw1znjQKZdY4IZ0gvY5dqKodKNQiEpLqmO2PqWCrCPI7
         L8qWqe5AKFU8sS3MtQoI9Bio+svQB7yq+GigZmKlYGHQGbQ2PyYxy+BA7zf+/MDJpvRB
         BLUNm/M8cExRUuK8PLQc7v9m1dAdNezOvibNmKaxQVKVl0l6e/DrLcgOyG/XsKgbabxP
         KLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ap2ctb13s1qbCfj4OTZiKRJIdNv9n1BdWeqlAwLw5Qg=;
        b=Uiuax8a54AGLoaWkt8mDDwqXrsPxfok5hCAogWwV8xXZpZsEQtcEViU7Yachy2SsAv
         xE0W0THRAl5V1nMVwTS+B2DruaUpoFO1rsYZRyDJhg6fc7rOI4g5AC3mY06pK4ENd7uN
         /w/LmSpXzw19WZHtPyOc564IcPm6l+FiDrW+90e5okoFZZKHh5Ip8mYvkMIZF1Pjnlwc
         dcYXr1N7UHYxarFLUOZTvYeZtyIJk36ROwQ7LMG9xmQAjXG3DGj/sliKVFYrb81zbk0T
         AABgf8kMYMH5J5NSZAHaJHnsUxhzXveM+z9a97bByJpSc9cqYLbS0LU2cChA39k8FwHz
         r99w==
X-Gm-Message-State: APjAAAU00gv5svMTyhfg0+tIIZByOfjnFMI5F0HixAjdMeccPt0neD7q
        P8ALzhPFYQXWbIktfAX5jTS1YBCn3ZJgJ3RFY9/0Gg==
X-Google-Smtp-Source: APXvYqztPgBIuE+BF1ZFh+oiIEmClwhAkgolIs71KHBbWVvRtiGt0/phNlarS8Hv9uDQY15pC7dm7FoVZLJyzFQZaQA=
X-Received: by 2002:a17:90a:3745:: with SMTP id u63mr10347452pjb.123.1582139490281;
 Wed, 19 Feb 2020 11:11:30 -0800 (PST)
MIME-Version: 1.0
References: <20200219045423.54190-1-natechancellor@gmail.com>
 <20200219045423.54190-4-natechancellor@gmail.com> <20200219093445.386f1c09@gandalf.local.home>
 <CAKwvOdm-N1iX0SMxGDV5Vf=qS5uHPdH3S-TRs-065BuSOdKt1w@mail.gmail.com> <20200219181619.GV31668@ziepe.ca>
In-Reply-To: <20200219181619.GV31668@ziepe.ca>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Feb 2020 11:11:19 -0800
Message-ID: <CAKwvOd=8vb5eOjiLg96zr25Xsq_Xge_Ym7RsNqKK8g+ZR9KWzA@mail.gmail.com>
Subject: Re: [PATCH 3/6] tracing: Wrap section comparison in
 tracer_alloc_buffers with COMPARE_SECTIONS
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
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

On Wed, Feb 19, 2020 at 10:16 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Feb 19, 2020 at 09:44:31AM -0800, Nick Desaulniers wrote:
> > Hey Nathan,
> > Thanks for the series; enabling the warning will help us find more
> > bugs.  Revisiting what the warning is about, I checked on this
> > "referring to symbols defined in linker scripts from C" pattern.  This
> > document [0] (by no means definitive, but I think it has a good idea)
> > says:
> >
> > Linker symbols that represent a data address: In C code, declare the
> > variable as an extern variable. Then, refer to the value of the linker
> > symbol using the & operator. Because the variable is at a valid data
> > address, we know that a data pointer can represent the value.
> > Linker symbols for an arbitrary address: In C code, declare this as an
> > extern symbol. The type does not matter. If you are using GCC
> > extensions, declare it as "extern void".
> >
> > Indeed, it seems that Clang is happier with that pattern:
> > https://godbolt.org/z/sW3t5W
> >
> > Looking at __stop___trace_bprintk_fmt in particular:
> >
> > kernel/trace/trace.h
> > 1923:extern const char *__stop___trace_bprintk_fmt[];
>
> Godbolt says clang is happy if it is written as:
>
>   if (&__stop___trace_bprintk_fmt[0] != &__start___trace_bprintk_fmt[0])
>
> Which is probably the best compromise. The type here is const char
> *[], so it would be a shame to see it go.

If the "address" is never dereferenced, but only used for arithmetic
(in a way that the the pointed to type is irrelevant), does the
pointed to type matter?  I don't feel strongly either way, but we seem
to have found two additional possible solutions for these warnings,
which is my ultimate goal. Nathan, hopefully those are some ideas you
can work with to address the additional cases throughout the kernel?

-- 
Thanks,
~Nick Desaulniers
