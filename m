Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35C3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 07:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80653208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 07:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzJpaGei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHVHtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 03:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgHVHte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 03:49:34 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF710C061575
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 00:49:34 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c10so3467045edk.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 00:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ucDpivhSHRtEV7HP6/CuGlE8yRxOlZBKt8o/Etn070o=;
        b=RzJpaGeivfYrZB6/8QpMgePNgXSZgxvjjCmNdgzLkTFuK2BCrKzDyGmo+dCwY81gUe
         KQfdvuLcJF3/ThhUGTD10KOF053iWUDlb5u8fvCSmrbtUEX4U5Y7DT4o9QiVvGFQzBjU
         UlWqeq+aPsyqwtVdAvBmnSYOoqVQIMiLzu6+4D8IxS/7UYEefiVANyf/vc4G1ZaY4cpt
         5xywE/sKNUurpiR0fiYcKqPZ/n550px8T14eAy0ayieaDNz73uPwLXVdQ2iAyCw3wjPR
         PfAjnJrCU+g4zGt49Zeb60V/97lXpHYWNnhaiGSdhJAP0IsHgv+7E1Mim6Bc8V3Cfr/w
         W87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucDpivhSHRtEV7HP6/CuGlE8yRxOlZBKt8o/Etn070o=;
        b=OHul61QD4BE6KODapj82X62w3kzVBZnrBS5MkxfncdtStsdnL5mPDkaswrPP0Rg1qb
         S2lC4C3gMYmpN/57ei8p6/eE6ow/6soINVi9AMyHaje8aG9yx52qT9n7qx8kUWkjaD1T
         LteVyryGmYbrApb6uYe0Q6TfuYhuwYF7XkWAXSrVPpLsv1bqVsWR4yaOvF2ByXZyRIVS
         Zd0QXuRt7Eblcoqtwb+n6A2rZ6MK/H2XkHJUVv4j0t2X9Cg7SU9aXv4NYo0E4y6pG3Fp
         JJbNw1lNh5F7FknyRSTGW9i5CipEo0vLxfx8KZL1oW91qoad6dH5clL6A30mhyw72i7g
         PxHw==
X-Gm-Message-State: AOAM531xEPla00imEKvWqgosWyqRTLqFh8D4rNpaAfjwOaqCHVP4Iaqu
        TgXzUU974vdEwYK+74jcKJXf5g3/GameC/oF4FC5PA==
X-Google-Smtp-Source: ABdhPJwqwAO/SL6HH42pxzeRrtcM5ZSQQfJUp6NLAqYG4J83zPQVz9Wv76Syj3KgDpY3O1DUFaNHz5KBZJUmwY2rmSo=
X-Received: by 2002:a50:ee92:: with SMTP id f18mr6367467edr.80.1598082572822;
 Sat, 22 Aug 2020 00:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200819224030.1615203-1-haoluo@google.com> <20200819224030.1615203-7-haoluo@google.com>
 <CAEf4BzZY2LyJvF9HCdAzHM7WG26GO0qqX=Wc6EiXArks=kmazA@mail.gmail.com> <CAEf4BzZ+uqE73tM6W1vXyc-hu6fB8B9ZNniq-XHYhFDjhHg9gA@mail.gmail.com>
In-Reply-To: <CAEf4BzZ+uqE73tM6W1vXyc-hu6fB8B9ZNniq-XHYhFDjhHg9gA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Sat, 22 Aug 2020 00:49:21 -0700
Message-ID: <CA+khW7jQmdw-TZMnST_rBcQWmxZ_eVw4ja+nsrqCM9HSkeWaXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 6/8] bpf: Introduce bpf_per_cpu_ptr()
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Andrey Ignatov <rdna@fb.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 8:31 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Aug 21, 2020 at 8:26 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Aug 19, 2020 at 3:42 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > Add bpf_per_cpu_ptr() to help bpf programs access percpu vars.
> > > bpf_per_cpu_ptr() has the same semantic as per_cpu_ptr() in the kernel
> > > except that it may return NULL. This happens when the cpu parameter is
> > > out of range. So the caller must check the returned value.
> > >
> > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > ---
> >
> > The logic looks correct, few naming nits, but otherwise:
> >
> > Acked-by: Andrii Nakryiko <andriin@fb.com>
> >
> > >  include/linux/bpf.h      |  3 ++
> > >  include/linux/btf.h      | 11 +++++++
> > >  include/uapi/linux/bpf.h | 14 +++++++++
> > >  kernel/bpf/btf.c         | 10 -------
> > >  kernel/bpf/verifier.c    | 64 ++++++++++++++++++++++++++++++++++++++--
> > >  kernel/trace/bpf_trace.c | 18 +++++++++++
> > >  6 files changed, 107 insertions(+), 13 deletions(-)
[...]
>
> btw, having bpf_this_cpu_ptr(const void *ptr) seems worthwhile as well, WDYT?
>

It's probably not a good idea, IMHO. How does it interact with
preemption? Should we treat it as __this_cpu_ptr()? If so, I feel it's
easy to be misused, if the bpf program is called in a preemptible
context.

Btw, is bpf programs always called with preemption disabled? How about
interrupts? I haven't thought about these questions before but I think
they matter as we start to have more ways for bpf programs to interact
with the kernel.

Best,
Hao
