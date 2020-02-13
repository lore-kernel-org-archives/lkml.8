Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFCEC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC99D20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="urydw5lY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgBMW4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:56:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34466 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgBMW4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:56:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id s144so754041wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 14:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6x9Zqpmo0Kh0pEK6dhHMoc2fR4pHbKz2xssvvuJ+eg=;
        b=urydw5lYY5vJgwd8FRvILoQGCMlRsTDfAVEfOaierEk2RVXOD2/09OboVi0HE7EkCg
         iGmcf+lE97XETbj3sy4SqtxylcG4IpEDtYaxgyn9UojTV2yuWyp6K6yu1EhygSaMNAmi
         VVb/VfHcJoMA0Y6pQO/UTET2mRw9IlgaP0FKJnItCSRFlGg9APANB6qflmdpWbpgHGUg
         DuwQ3YxGplNx0/E1yBc5i1oaKkCfOutOkC4ty5CwXZ4kVap6b250vhuBJl0w0zsL5V5+
         fRt2h1soQ0iVMjuZrGljZBFpS2VQskQdiaXSLff/N09RyP48wkikkZmHSRBddNe1Ze3h
         QZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6x9Zqpmo0Kh0pEK6dhHMoc2fR4pHbKz2xssvvuJ+eg=;
        b=Bnh7hAQ+X7EBmthV7O6LQqK17tzkig+6mDEbDE9P1dcqJPkVOr1v7MeNsqyXvOQW3t
         C1pnhKNTUN/m7aqbjLfyicKaK1KSys4oFG/L4JYgzOkJ2RByoJcq1stUZYYp17jVNZGN
         JUhllBQarHFp1ZImPKE+K09NCC68tLL1uyVRXLFTSda11SwtM5U9NmJqUX8lilpjCKTm
         Rg036HmYuygACl2GQ+34uUppFz7Ced6uI1HMmbwJ5b23uz7QakE2KlOzQePo5C9tFZjq
         lt0H7R8grsaYRBn3IfUGH7gT77EsuFtt0ZDnm1aMSrQg6M7tZV/j95bPq/93v1SiuuP9
         Ak1A==
X-Gm-Message-State: APjAAAUDUjV/+Ydl2nORSxcwvI9WXVrFT1+09MPMKZuCjFURppAATD1i
        7jV+nVDaVIGbdZn3AlU5y2ENoZ62eo1OA2vJKQEs1A==
X-Google-Smtp-Source: APXvYqx06jZt8vrbv6eVBnnD7GocL1hRyTRGSv1YPeYRd/X71vnxpByWoxW4f+U9Te7bcne7rl2M+KF0MFCiAq07b3k=
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr352785wml.110.1581634570688;
 Thu, 13 Feb 2020 14:56:10 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <CACT4Y+b4+5PQvUeeHi=3g0my0WbaRaNEWY3P-MOVJXYSO7U5aA@mail.gmail.com>
 <CAKFsvU+zaY6B_+g=UTpOddKXXgVaKWxH3c8nw6GSLceb1Mg2qA@mail.gmail.com>
 <CACT4Y+aHRiR_7hiRE0DmaCQV2NzaqL0-kbMoVPJU=5-pcOBxJA@mail.gmail.com>
 <CAKFsvUJ2w=re_-q5PTV8c30aVwot8zMOipRvhD9cCx-9cc-Ksw@mail.gmail.com> <CACT4Y+ZJeABriqRZkThVa-MNDBwe7cH=Hmq1vonNmyCTMZOu6w@mail.gmail.com>
In-Reply-To: <CACT4Y+ZJeABriqRZkThVa-MNDBwe7cH=Hmq1vonNmyCTMZOu6w@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Thu, 13 Feb 2020 14:55:59 -0800
Message-ID: <CAKFsvUKun6HOk_9ocZ81YebEp90jr3WsAah24HDQQQqY9eamjg@mail.gmail.com>
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

On Wed, Feb 12, 2020 at 9:40 PM 'Dmitry Vyukov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Wed, Feb 12, 2020 at 11:25 PM Patricia Alfonso
> <trishalfonso@google.com> wrote:
> > > On Wed, Feb 12, 2020 at 1:19 AM Patricia Alfonso
> > > <trishalfonso@google.com> wrote:
> > > >
> > > > On Thu, Jan 16, 2020 at 12:53 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > >
> > > > > > +void kasan_init(void)
> > > > > > +{
> > > > > > +       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
> > > > > > +
> > > > > > +       // unpoison the kernel text which is form uml_physmem -> uml_reserved
> > > > > > +       kasan_unpoison_shadow((void *)uml_physmem, physmem_size);
> > > > > > +
> > > > > > +       // unpoison the vmalloc region, which is start_vm -> end_vm
> > > > > > +       kasan_unpoison_shadow((void *)start_vm, (end_vm - start_vm + 1));
> > > > > > +
> > > > > > +       init_task.kasan_depth = 0;
> > > > > > +       pr_info("KernelAddressSanitizer initialized\n");
> > > > > > +}
> > > > >
> > > > > Was this tested with stack instrumentation? Stack instrumentation
> > > > > changes what shadow is being read/written and when. We don't need to
> > > > > get it working right now, but if it does not work it would be nice to
> > > > > restrict the setting and leave some comment traces for future
> > > > > generations.
> > > > If you are referring to KASAN_STACK_ENABLE, I just tested it and it
> > > > seems to work fine.
> > >
> > >
> > > I mean stack instrumentation which is enabled with CONFIG_KASAN_STACK.
> >
> > I believe I was testing with CONFIG_KASAN_STACK set to 1 since that is
> > the default value when compiling with GCC.The syscall_stub_data error
> > disappears when the value of CONFIG_KASAN_STACK is 0, though.
>
>
> Then I would either disable it for now for UML, or try to unpoision
> stack or ignore accesses.
>
Okay, I'll probably disable it in UML for now.


-- 
Patricia Alfonso
