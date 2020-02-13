Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B3BC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6443520873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtBoid64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgBMFkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 00:40:05 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38537 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgBMFkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 00:40:03 -0500
Received: by mail-qk1-f196.google.com with SMTP id z19so4574085qkj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 21:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFvB3dUHqlfWY0xdzQLpqooj9O1A8mgi9rJRJWCXmFQ=;
        b=vtBoid64kdWQODNZsUHlienhgxFYDOHEaJzpP6h14MdSty1RTBtrn1TQxj+u1qfYhr
         bRRlbvtlBlLfY6K0aFTZBm7MO3YcfKZ/bqP7MQLeM7MIH8UycmVZrN+cf0+TgFjMEvvt
         iD8NyrSZBWQ6ZQkN7WFDRZqKVYDHPaLejY7ZgT2CJjZp8d1Mr6eAifbIAFiBzOJMAr/P
         oV+4pks29Rczjh9mxbujVW8ohd0jGVH5hmMmJMFl4AyNfAVw6S9LzGTjuM6+X2widnnB
         3LelD14XVVCJpK8f+45SAFsWZMXt8VE6oLODNh56dWAGAHPyZmIdzO1C/nVFjESghItf
         AdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFvB3dUHqlfWY0xdzQLpqooj9O1A8mgi9rJRJWCXmFQ=;
        b=NhDeu7yDefQoAqx1EqhB3shDlGNT98aE6QoFZ/YYdQEBHX/hvjtGtuzkhRGBUeQ9hS
         pxuKS/+BAjb1YxfhMHDmW93bK7uQ+NW40kPEwJU2FXkBvldw4BvMpLZVEE/1Xa3mtZOB
         U1ypOmqZk0sKcUOAGC+HN+HuMgGeqKb5qCwA4LTNwqyZ5imEwk0uDkPJZM7jcuPeqAQ7
         LmQeagq5UkIeDOrfgA8gmXqjlUlitPSP+OkDfc/uZX0T6fl/f/kjmiqOaCKNdKMeo+yO
         VXaPsWOPTKzk/iro+xf8/5cOTGl/h4b+Mnl+1IWxUNtnRz4TNNge2ExCtpUzCBtEhjDv
         8XBg==
X-Gm-Message-State: APjAAAUS3vYlNOI5/mcEd6rjodK8ET6jd3BZzKgedSUQTCSB2suOICL1
        WcOrWAxr49LuPixf47EPM3H8VFX6awSP+FwNIy49Pg==
X-Google-Smtp-Source: APXvYqzaDFUay/tiN8A69YthVrVrEWVEDha05NgK4STp1bXgm/zLYLJTkCUvxRYlnfDoyj2J8GDWh2dpSA3hoJCgWSQ=
X-Received: by 2002:a37:4755:: with SMTP id u82mr13737500qka.43.1581572402214;
 Wed, 12 Feb 2020 21:40:02 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <CACT4Y+b4+5PQvUeeHi=3g0my0WbaRaNEWY3P-MOVJXYSO7U5aA@mail.gmail.com>
 <CAKFsvU+zaY6B_+g=UTpOddKXXgVaKWxH3c8nw6GSLceb1Mg2qA@mail.gmail.com>
 <CACT4Y+aHRiR_7hiRE0DmaCQV2NzaqL0-kbMoVPJU=5-pcOBxJA@mail.gmail.com> <CAKFsvUJ2w=re_-q5PTV8c30aVwot8zMOipRvhD9cCx-9cc-Ksw@mail.gmail.com>
In-Reply-To: <CAKFsvUJ2w=re_-q5PTV8c30aVwot8zMOipRvhD9cCx-9cc-Ksw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Feb 2020 06:39:50 +0100
Message-ID: <CACT4Y+ZJeABriqRZkThVa-MNDBwe7cH=Hmq1vonNmyCTMZOu6w@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Patricia Alfonso <trishalfonso@google.com>
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

On Wed, Feb 12, 2020 at 11:25 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
> > On Wed, Feb 12, 2020 at 1:19 AM Patricia Alfonso
> > <trishalfonso@google.com> wrote:
> > >
> > > On Thu, Jan 16, 2020 at 12:53 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > >
> > > > > +void kasan_init(void)
> > > > > +{
> > > > > +       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
> > > > > +
> > > > > +       // unpoison the kernel text which is form uml_physmem -> uml_reserved
> > > > > +       kasan_unpoison_shadow((void *)uml_physmem, physmem_size);
> > > > > +
> > > > > +       // unpoison the vmalloc region, which is start_vm -> end_vm
> > > > > +       kasan_unpoison_shadow((void *)start_vm, (end_vm - start_vm + 1));
> > > > > +
> > > > > +       init_task.kasan_depth = 0;
> > > > > +       pr_info("KernelAddressSanitizer initialized\n");
> > > > > +}
> > > >
> > > > Was this tested with stack instrumentation? Stack instrumentation
> > > > changes what shadow is being read/written and when. We don't need to
> > > > get it working right now, but if it does not work it would be nice to
> > > > restrict the setting and leave some comment traces for future
> > > > generations.
> > > If you are referring to KASAN_STACK_ENABLE, I just tested it and it
> > > seems to work fine.
> >
> >
> > I mean stack instrumentation which is enabled with CONFIG_KASAN_STACK.
>
> I believe I was testing with CONFIG_KASAN_STACK set to 1 since that is
> the default value when compiling with GCC.The syscall_stub_data error
> disappears when the value of CONFIG_KASAN_STACK is 0, though.


Then I would either disable it for now for UML, or try to unpoision
stack or ignore accesses.
