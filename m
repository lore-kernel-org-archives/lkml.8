Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1609DC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA15824656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aAobjYpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBSVcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:32:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34664 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgBSVcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:32:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so739292pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 13:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EmqhwxfTOPH5Jwang1lE3QOy4zcv0gzG5lBl/plns9w=;
        b=aAobjYpFklyAkqlSG70awWRHMtlHSvugns/9mnKxCnZbo5CBJsQf4GsGU2DC6SwVxM
         PqCQwGEARKxeFBmbEdcjD4vQwtPfRz6yplo6lJvfbOvKffn7U//Av3nzUBjvTKIQA1SI
         3rRlpdcbJ6/nTMZrkb86TdZfyolv0kDit/gwKe4Yw2DPTokH2zcFLvoCc46OIl/x/aHB
         nLS5TEWP/iXmuWbKI4NopOwy54x337xvKNUJeEV6goeSU4DERoVDEYnQ6uruiyaODWt2
         KjfY0l2/gfssEmO9emTMo66m1oaAYdh6bkuZvzRLFE9ZCl2+5QErp/rw6O16d+fE/Uim
         MbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EmqhwxfTOPH5Jwang1lE3QOy4zcv0gzG5lBl/plns9w=;
        b=oG40ZwgmsUMhalcBT3/UeXbFwR9QaNzQr05tn9/k5rPpvVfthv+sB0V+PLkRvGgMiU
         iZzabbg9a0J3F6t7PrtDmdAyYy3B3Ua5u/0PTVqZSS/a7iRJADb2hE1k89ogfDkwA7wp
         PV9ZW1s5VLcaDJgI6AgvVqkY0LniI2byLG50YtXeC0tljYhyXSUteGT0Sz7xF95H2zCm
         4Bdg4ayEMzFjaMFwMcTjEsbj58Q1nhQ+FDm1/fGIV3y7W82dgQ0O4o6q00uYLkUcMFRq
         YN3giDUQ/W24BcpjgDCx9I9zL7+eOY6oLPUSXc/QPUfbhC/i070WiWkZpGuJXT3lVDRG
         xyKw==
X-Gm-Message-State: APjAAAUaxu1jj5HoaSARJux0Nmmmr1Q2A/LYeVmYGvyaktJJTzm4yVmI
        iNUifOLA7KfNro0hfokSp32DFKVgSOqpB3y8uvM4ug==
X-Google-Smtp-Source: APXvYqxQilzonYgGRhT+QA+AwfuB+IZ31TKJHQheCGHzsJIF3F3Ns2HplQu/HPC/eZCCe/ALDkwRksUMLFmdHy1Hrik=
X-Received: by 2002:a63:af52:: with SMTP id s18mr30581478pgo.263.1582147969204;
 Wed, 19 Feb 2020 13:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20200219045423.54190-1-natechancellor@gmail.com>
 <20200219045423.54190-4-natechancellor@gmail.com> <20200219093445.386f1c09@gandalf.local.home>
 <CAKwvOdm-N1iX0SMxGDV5Vf=qS5uHPdH3S-TRs-065BuSOdKt1w@mail.gmail.com>
 <20200219181619.GV31668@ziepe.ca> <CAKwvOd=8vb5eOjiLg96zr25Xsq_Xge_Ym7RsNqKK8g+ZR9KWzA@mail.gmail.com>
 <20200219195424.GW31668@ziepe.ca>
In-Reply-To: <20200219195424.GW31668@ziepe.ca>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Feb 2020 13:32:38 -0800
Message-ID: <CAKwvOdktG0vZOZVtNJBk1COhOnLYv3MU5KNQ8Z40L4ph5QcnRg@mail.gmail.com>
Subject: Re: [PATCH 3/6] tracing: Wrap section comparison in
 tracer_alloc_buffers with COMPARE_SECTIONS
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On Wed, Feb 19, 2020 at 11:54 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Feb 19, 2020 at 11:11:19AM -0800, Nick Desaulniers wrote:
> > > Godbolt says clang is happy if it is written as:
> > >
> > >   if (&__stop___trace_bprintk_fmt[0] != &__start___trace_bprintk_fmt[0])
> > >
> > > Which is probably the best compromise. The type here is const char
> > > *[], so it would be a shame to see it go.
> >
> > If the "address" is never dereferenced, but only used for arithmetic
> > (in a way that the the pointed to type is irrelevant), does the
> > pointed to type matter?
>
> The type is used here:
>
>         if (*pos < start_index)
>                 return __start___trace_bprintk_fmt + *pos;
>
> The return expression should be a const char **
>
> Presumably the caller of find_next derferences it.
>
> Jason

And the callers of find_next just return the return value from
find_next, but suddenly as `void*` (find_next()'s return type is
`char**`).  So it doesn't seem like the pointed to type matters, hence
the recommendation of `void` and then address-of (&) used in
comparison+arithmetic.

-- 
Thanks,
~Nick Desaulniers
