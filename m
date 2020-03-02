Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FEFC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCAE22B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/s+axMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgCBSDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:03:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37528 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBSDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:03:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id q8so924310wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0h74RVykrNA7k579On8OcnwZEZe5yNvwYKOREsVWIY8=;
        b=I/s+axMNmv+VyTdOjBSJkHBAbIlNVDQVD77Qp/vb6Rm4EPPoXaoz+v99Pb7XLqFiZa
         7GTxzsdtgy9pA/7v1RyHIlKkKyg7D+JXninSpdNuIud5mHzaXUj17St6NUU58oibeB5o
         JgN4vx3JSSKvkutMx8qdrUW9M/mpLXnervq/Tg6OE63ON1FJ+cqtx3db39BzyNQt3Ea0
         O2/Cc9xh2zKcELCw28Y+pH+Mq11AsIAFEgh21MGyu0+ta1SNdF99bV1p2CgAf2v2QwSk
         g5MAW05CkwwN/trw5jqgZCZTbekS2zvpzvE0b+FQOKo7KsHAxQGn7AS+9eQ7GOS8MGaT
         tchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0h74RVykrNA7k579On8OcnwZEZe5yNvwYKOREsVWIY8=;
        b=nPco4+acPU8nwKzDUPje0BvqD3WI0YjoZ+CsqJ2rfhPwHJ4cZIfxYDwdKznT+WP+Jr
         01PY+L7MOeIKvbb7AWxlU8++WAru+Ljo5+3nmKx68nvsExqx0ew+7J0/RTUnjiJYaA6I
         kHD0hxSVBaU4KbZ9WNqBA3NyCBR9pB1DOnQzAGLA1RV6UxmSzJTbZfRk80rFW+WUhulh
         jzqqHlsHDIAH+HOJbTI+q6G/H0pztPIW2L1NxcjJ3okUHGpSnLVrAA+VyUDdQwVQya7z
         O/bcT/RWGBSNLHfTeDmqFX4peMOxYnk9UWNDW2v8Gt63FQqcuD1YUGJnKNdPdmjkYiaT
         vE1Q==
X-Gm-Message-State: ANhLgQ3eAkQTHT1lQSwBG71AoN0s3EujkGh1utiOAyHdvup32aDaLlXQ
        1LdYOY0QPTd7CiX6TpPZjc4sm8Jwvgjo8PW547pOCQ==
X-Google-Smtp-Source: ADFU+vurl8/N8tgOctMPEVIHiN7p0GODtIIU/MvsE8dsg2UnMEHHF6bTxs0viI0YFRimkhtPJy+xVScizd4Gj7CxKdg=
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr764573wrp.200.1583172211274;
 Mon, 02 Mar 2020 10:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20200302130430.201037-1-glider@google.com> <20200302130430.201037-3-glider@google.com>
 <CAHRSSEwe=jZAEVhGw4ACBU0m-76TzZfJFv1Rzw=_UVm6HbTvAw@mail.gmail.com>
In-Reply-To: <CAHRSSEwe=jZAEVhGw4ACBU0m-76TzZfJFv1Rzw=_UVm6HbTvAw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 2 Mar 2020 19:03:19 +0100
Message-ID: <CAG_fn=W96H3kMcoTxfqVq9Ec=1HZsJjnTjuX74dhZJe0QNuMrw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sched/wait: avoid double initialization in ___wait_event()
To:     Todd Kjos <tkjos@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 5:57 PM Todd Kjos <tkjos@google.com> wrote:
>
> On Mon, Mar 2, 2020 at 5:04 AM <glider@google.com> wrote:
> >
> > With CONFIG_INIT_STACK_ALL enabled, the local __wq_entry is initialized
> > twice. Because Clang is currently unable to optimize the automatic
> > initialization away (init_wait_entry() is defined in another translation
> > unit), remove it with the __no_initialize annotation.
> >
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> >
> > ---
> >  v2:
> >   - changed __do_not_initialize to __no_initialize as requested by Kees
> >     Cook
> > ---
> >  drivers/android/binder.c | 4 ++--
> >  include/linux/wait.h     | 3 ++-
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index a59871532ff6b..66984e7c33094 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -4827,7 +4827,7 @@ static int binder_ioctl_write_read(struct file *filp,
> >         struct binder_proc *proc = filp->private_data;
> >         unsigned int size = _IOC_SIZE(cmd);
> >         void __user *ubuf = (void __user *)arg;
> > -       struct binder_write_read bwr __no_initialize;
> > +       struct binder_write_read bwr;
>
> How did __no_initialize get set so that it can be removed here? Should
> the addition of __no_initilize be removed earlier in the series (tip
> doesn't have the __no_initialize).

Sorry, I messed up this patch. It should not be touching binder.c at
all. All binder changes should go into patch 2/3.


> >         case BINDER_SET_MAX_THREADS: {
> > -               int max_threads;
> > +               int max_threads __no_initialize;
>
> Is this really needed? A single integer in a rarely called ioctl()
> being initialized twice doesn't warrant this optimization.

It really does not, and I didn't have this bit in v1.
But if we don't want this diff to bit rot, we'd better have a
Coccinelle script generating it.
The script I added to the description of patch 2/3 introduced this
annotation, and I thought keeping it is better than trying to teach
the script about the size of the arguments.
