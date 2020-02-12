Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5E4C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA92221569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U76D1PMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgBLWZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:25:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46465 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgBLWZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:25:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so4290588wrl.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 14:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqLUL5r8C+tgnaPYz9HWPNgipcce1YW5/q3ifbXu5oA=;
        b=U76D1PMAXPdzH4McXJdNoTnfNeoSGktudQQ1kymC7k9nvj7Zk4vDoele3b2Lrz9Oya
         b54jfgEa7JSp061Us5huRzQQ5F0Rf103vwiM9otTrX5KJkmvmB+ApZE69JEXFEQBoL/r
         Ri7tNBp3bMiN2qRsHUnImekTPzSVfGWQuZP72HZRVmoGTCc2nbisVgVlRWhGaGs/2s2z
         F5hNx4EYeFNXVYM5nRZ2osI6aPGVkQkewa2ylVFo5X9XhIYeweuSSCrX2tVbQ3uHuL0Q
         ViDDI3K0pcWiwdwbVbAPW/uV51nAsJ5iL4W8K6azD3Y3DcdbDk6jopUjiCj21iVG9bQX
         q+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqLUL5r8C+tgnaPYz9HWPNgipcce1YW5/q3ifbXu5oA=;
        b=mNLSsHEHoeuPyB3wWPrKIdrsKamyoRa1FkzlO03iA7Xg4e0046We47fpiw1yurI3NG
         DV51nz2LrfoPYF+QbTRYWx/CfDdBwYzSc/8Z7M/oVN6cI569YnZZWn+eqokL4xiEALlR
         v1xJCUCdWCAzmah2ydJdC4mAa/aa1+yfs0M3NCYewQM1frP+WJLxnV6nkKXiROLBHAYL
         fOu9YegJ5IDEFglH/+Q+1b/TMH0PWLS0WlCePhSQoprZg1OOHzjihdREGn3VJBOv+a5N
         Y/JOeFXtNT8qboiMzk1z1PKSBIPMzv9tLfBBo4ktRDluYwKm7eeiixeByNbjTQltQ6tC
         odAw==
X-Gm-Message-State: APjAAAU11FYPNUySDK+Xr5OcWTeFfA0VoGyEWfW2cJ7LEPotMnhbTCmS
        rExiUq7BF76bAwJRb1B8rXc4Uc7C3QVJD+y+IMqdwQ==
X-Google-Smtp-Source: APXvYqyKikEA7Oc5ye0Hcm8hVCfh8p99mW4CCfUw/3zz4/Aw4Wf+K1jVzp8VtANBdH3QvrdqXsRTpZE+8a0lgaOsAV4=
X-Received: by 2002:adf:81e3:: with SMTP id 90mr16580061wra.23.1581546349050;
 Wed, 12 Feb 2020 14:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <CACT4Y+b4+5PQvUeeHi=3g0my0WbaRaNEWY3P-MOVJXYSO7U5aA@mail.gmail.com>
 <CAKFsvU+zaY6B_+g=UTpOddKXXgVaKWxH3c8nw6GSLceb1Mg2qA@mail.gmail.com> <CACT4Y+aHRiR_7hiRE0DmaCQV2NzaqL0-kbMoVPJU=5-pcOBxJA@mail.gmail.com>
In-Reply-To: <CACT4Y+aHRiR_7hiRE0DmaCQV2NzaqL0-kbMoVPJU=5-pcOBxJA@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Wed, 12 Feb 2020 14:25:37 -0800
Message-ID: <CAKFsvUJ2w=re_-q5PTV8c30aVwot8zMOipRvhD9cCx-9cc-Ksw@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um@lists.infradead.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 10:24 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Feb 12, 2020 at 1:19 AM Patricia Alfonso
> <trishalfonso@google.com> wrote:
> >
> > On Thu, Jan 16, 2020 at 12:53 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > > +void kasan_init(void)
> > > > +{
> > > > +       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
> > > > +
> > > > +       // unpoison the kernel text which is form uml_physmem -> uml_reserved
> > > > +       kasan_unpoison_shadow((void *)uml_physmem, physmem_size);
> > > > +
> > > > +       // unpoison the vmalloc region, which is start_vm -> end_vm
> > > > +       kasan_unpoison_shadow((void *)start_vm, (end_vm - start_vm + 1));
> > > > +
> > > > +       init_task.kasan_depth = 0;
> > > > +       pr_info("KernelAddressSanitizer initialized\n");
> > > > +}
> > >
> > > Was this tested with stack instrumentation? Stack instrumentation
> > > changes what shadow is being read/written and when. We don't need to
> > > get it working right now, but if it does not work it would be nice to
> > > restrict the setting and leave some comment traces for future
> > > generations.
> > If you are referring to KASAN_STACK_ENABLE, I just tested it and it
> > seems to work fine.
>
>
> I mean stack instrumentation which is enabled with CONFIG_KASAN_STACK.

I believe I was testing with CONFIG_KASAN_STACK set to 1 since that is
the default value when compiling with GCC.The syscall_stub_data error
disappears when the value of CONFIG_KASAN_STACK is 0, though.


-- 
Patricia Alfonso
