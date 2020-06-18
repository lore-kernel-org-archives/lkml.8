Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97942C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7464720734
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAiJG3g6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgFRR7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgFRR7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:59:19 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBD8C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:59:18 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w15so3990638lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DG6waLEdFsnTtAqG8HhZhzhS+3kDlW87TTmqAjLBels=;
        b=HAiJG3g6G/CpYFtkYuVFmKHINe7HEwnNsj0UWq9tQhUoGwTSt+JY/PeARD43bIBeHE
         jSW8QmnYeJ+pDDXe1xEhacU1WsFANWz3Yl7XndOz3mv+ygcIVsgDfzS/zb5vthDW4ArW
         JYxwpHdLz34CYVrh5YDFKJHE18ALIlRDigbylfRCPGBlS5pkySARYh+gNvNYXYKe5vGM
         l3mj1acDYvBbJaPHDnNCEj5cxgsblEL8sGvyBLfsDuoTywGVQQ5EhfzZCPvLZzvy1wvp
         c/GJvgBxLpvsziygTakhVBkXOCXROjT8/91/XJK6CkuKwUZlk3e/pytpvIfkGcYhoNax
         cRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DG6waLEdFsnTtAqG8HhZhzhS+3kDlW87TTmqAjLBels=;
        b=gb86vOPM4kZqSMgx07w8t3b1gTP4RTLM+n/luUoWspdzWpw66dMYJTC5SdZ2bPJ+Ie
         8+JN/uBhqAsqm/NyebdFjo+A6O8gcPDKeYqdacoBCNsO1k4Ma/vADal1itB/jjUAK6pm
         WI+t+gTpC8hshS9DxOh9bD72zuusiTaaSKHSRO8EyVEwgCXdkmqmL5LGreiXBgZkoCg6
         1fIeTuLl/fyL6YHf3lB33utFLE04EMnkt7lhJwA4nccp6YHyzAxeZf37/8A1nxUzYbug
         mrExctZJg5xX44ZFxSY4VphT97zb3FJmHceVxZb+vNH1KvFxurKW50lqwORUu9yLZjiM
         sg5Q==
X-Gm-Message-State: AOAM533xal21H3j3j+p/CiDZvVHZuwRDwJ4FXxVqs3gUWmkJfjMD6s2W
        f6TuB+wHAef5hmLqdeUp0TnEvt8CPHpEl0UKYjtKzg==
X-Google-Smtp-Source: ABdhPJw0Nr4UcYZ+azSOMFTr5bmHtnJ60xr25YkyjwO2ZGRhyantwHE9yjV68k7d0RvM/M+3o9zhV97cR6vjiBrbYY4=
X-Received: by 2002:a05:6512:1103:: with SMTP id l3mr3016306lfg.108.1592503156546;
 Thu, 18 Jun 2020 10:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200617165616.52241bde@oasis.local.home> <CAG48ez2pOns4vF9M_4ubMJ+p9YFY29udMaH0wm8UuCwGQ4ZZAQ@mail.gmail.com>
 <20200617183628.3594271d@oasis.local.home> <CAG48ez04Fj=1p61KAxAQWZ3f_z073fVUr8LsQgtKA9c-kcHmDQ@mail.gmail.com>
 <20200618124157.0b9b8807@oasis.local.home>
In-Reply-To: <20200618124157.0b9b8807@oasis.local.home>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 18 Jun 2020 19:58:50 +0200
Message-ID: <CAG48ez1LoTLmHnAKFZCQFSvcb13Em6kc8y1xO8sNwyvzB=D2Lg@mail.gmail.com>
Subject: Re: [PATCH] tracing: Use linker magic instead of recasting ftrace_ops_list_func()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 6:42 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 18 Jun 2020 01:12:37 +0200
> Jann Horn <jannh@google.com> wrote:
>
> > static ftrace_func_t ftrace_ops_get_list_func(struct ftrace_ops *ops)
> > +static ftrace_asm_func_t ftrace_ops_get_list_func(struct ftrace_ops *ops)
> >  {
> > +#if FTRACE_FORCE_LIST_FUNC
> > +       return ftrace_ops_list_func;
> > +#else
> >         /*
> >          * If this is a dynamic, RCU, or per CPU ops, or we force list func,
> >          * then it needs to call the list anyway.
> >          */
> > -       if (ops->flags & (FTRACE_OPS_FL_DYNAMIC | FTRACE_OPS_FL_RCU) ||
> > -           FTRACE_FORCE_LIST_FUNC)
> > +       if (ops->flags & (FTRACE_OPS_FL_DYNAMIC | FTRACE_OPS_FL_RCU))
> >                 return ftrace_ops_list_func;
> >
> >         return ftrace_ops_get_func(ops);
>
> But ftrace_ops_get_func() returns ftrace_func_t type, wont this complain?

No, because we only compile this case under FTRACE_FORCE_LIST_FUNC==0,
which means ARCH_SUPPORTS_FTRACE_OPS, which means the preprocessor
turns all occurrences of ftrace_asm_func_t into ftrace_func_t.

Essentially my idea here is to take the high-level rule "you can only
directly call ftrace_func_t-typed functions from assembly if
ARCH_SUPPORTS_FTRACE_OPS", and encode it in the type system. And then
the compiler won't complain as long as we make sure that we never cast
between the two types under ARCH_SUPPORTS_FTRACE_OPS==0.
