Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65416C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D27520756
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="OwsxdxHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgESAKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 20:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgESAJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 20:09:59 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E379CC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 17:09:58 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id se13so10302152ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 17:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IxrqFxJdqSnS7VAVDqLnJkOH5P3wut+0z7ZMFgHZj30=;
        b=OwsxdxHif5GFjHubXSJp6rvDOZwLJi7vXG5yU3ZO8BbDACR2v48yEeLiOPcdZtOo11
         9QCKurOKyqOiS4Pgas32x/doPXSRsxxLlAJXkpuXKIXLNbfXsue23L1hLeNzu9tLHGZs
         JooBGkjDk5B39aNx/i6N5D1BPrMGdednoHEoUPxRGgs/rMLBfMYsI+L34P3l/KLCIhAE
         Bcyz+XdzYrBu3iJk713GoaG18d7vyw8yTTFvmwUHJJKgbNu/6iOn7L5r/YskAnjCWFf/
         uu3R1h80bv8xGMkXT6HOWEdvCQmXWmY4WjF1ZkoAjSJH6uNo8IXKKLMPsOQqktMUqaCg
         S/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxrqFxJdqSnS7VAVDqLnJkOH5P3wut+0z7ZMFgHZj30=;
        b=fAvOmFgamvSlR122MPsjtONu3y2Be7cLzF1dPKjbvjPzkIim3OKpz+2ZTetaruLXSQ
         B6h+rALSN9++vB1deTgfaQocmiESs6kIIHaoonzn6pjQHO4aHtffbdK98Xk8kPOghfI7
         i+CVuK/A7oRxJdrTfRoJ2wzzpK1/PPO+ZLyO0pm/l5Hf50nu6dVQFdOwcFBgG/p0ZIGX
         YEwS+c7cwvHeChJPzKsPKqwvMFxzfdSQZaeZy/Rm1zZYGqhyPWYOI7YowgANbWDnnw5U
         iUOCYfJ2tQXuB3dW23sW5Wn6NU+bcTQmW7pQ7UUYsb+Duc+JfpGQH8Pe+WJo8T8xg/TJ
         SBMg==
X-Gm-Message-State: AOAM531xIMogr9xRgSJR5tvGiGC/o6Vd125t96v9XQHg9Wl1onE6+4Uh
        c+gNI1I53/RHrDrEdxz9fEc9xBxq2LMIcjG71HrjMA==
X-Google-Smtp-Source: ABdhPJyM9kGDV9TZPMgj39tKayJfeBGR62rAJ1b5FnKzloflEafk1UWqAI2Uso93q9XPvEKdMmcwZqvltLQWyV5XW88=
X-Received: by 2002:a17:906:4d9a:: with SMTP id s26mr16447641eju.153.1589846997488;
 Mon, 18 May 2020 17:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=TAF6mfrwxF1-xEJJ9dL675uMUa7RZrOa_eL2mJizZJ-U7iQ@mail.gmail.com>
 <CAEf4BzazvGOoJbm+zNMqTjhTPJAnVLVv9V=rXkdXZELJ4FPtiA@mail.gmail.com>
In-Reply-To: <CAEf4BzazvGOoJbm+zNMqTjhTPJAnVLVv9V=rXkdXZELJ4FPtiA@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Date:   Mon, 18 May 2020 20:09:46 -0400
Message-ID: <CAG=TAF6aqo-sT2YE30riqp7f47KyXH_uhNJ=M9L12QU6EEEfqQ@mail.gmail.com>
Subject: Re: UBSAN: array-index-out-of-bounds in kernel/bpf/arraymap.c:177
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 7:55 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, May 17, 2020 at 7:45 PM Qian Cai <cai@lca.pw> wrote:
> >
> > With Clang 9.0.1,
> >
> > return array->value + array->elem_size * (index & array->index_mask);
> >
> > but array->value is,
> >
> > char value[0] __aligned(8);
>
> This, and ptrs and pptrs, should be flexible arrays. But they are in a
> union, and unions don't support flexible arrays. Putting each of them
> into anonymous struct field also doesn't work:
>
> /data/users/andriin/linux/include/linux/bpf.h:820:18: error: flexible
> array member in a struct with no named members
>    struct { void *ptrs[] __aligned(8); };
>
> So it probably has to stay this way. Is there a way to silence UBSAN
> for this particular case?

I am not aware of any way to disable a particular function in UBSAN
except for the whole file in kernel/bpf/Makefile,

UBSAN_SANITIZE_arraymap.o := n

If there is no better way to do it, I'll send a patch for it.
