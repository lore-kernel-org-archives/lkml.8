Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EAFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349B62080C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sts5HjeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391376AbgFXUUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391054AbgFXUUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:20:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C21CC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:20:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z63so1733367pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6VX8l56o/9phg5oRAnfBhOhnSRSgx40667vVlnrgP1c=;
        b=Sts5HjeXaRIsjaUUSOulF2b0QJW/rtbjE50f2+QWQIT17OrFkVY+Z2bpYbafSTBuhE
         jxvDPfNLBtSH2Ou4l6yD3zA3bSURrtxiM0TzakQ0Cyg+LVoz4iXNXXrN/3Pk6/icJOul
         Z16sTB6L0/w6Dq6u/vlp+QWuyJg235QG/tvM1E3K4IedKvz3c0z9c6NfrN/bbHZ5G8fY
         wgIDX2Wo3ZlTsNzOZMWvutvhS1YdbOeKKZVcOA3R3ompjsm/GmA4l7JPIX1erW80E4Xe
         f7WqejKmK1rE7yp57rosd315QgC4GDBxxpJty94hEmaRpg571BdsL0lc7su+QmaUVxdz
         A0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6VX8l56o/9phg5oRAnfBhOhnSRSgx40667vVlnrgP1c=;
        b=CaadN9Z2I8tSeiMMWjdI/y+kQjuCNUcfvCCB4ogQZhxz6OePt5Dr0VqBmcNcuDyQT3
         t5vbMnpUtKEZov9UTljVBzqbskjun+TEC1tudczy3Vppp6XrX+o2MFyfxE/16ixS32a1
         uvy/AmWKnWlD3E0LzWvd5wXua8rpjFSqO6Y6LAsAbqsjWd0bTleRhyBoCcNBX/MRU5H3
         9Etpg79jkfkw1gvw8jjwHLAeDu6iyf645Ml3jW6RPOHJDjbkzbiqrU52Yx6wkxBNaScl
         Ggc3nqpfCuYY9e/mcs1K1xDjHnoi6PYCq7vbdkgtsG7ssmUECjfsZicGXt1XZazbm748
         dnfw==
X-Gm-Message-State: AOAM531n6LY2i6cfy9o5nkJP3O7EYJWzYa/SsmImGWWXECrkhMbAQugI
        CQLsn/2XBvqFLbZG1D0pl7WxLMhktwxWaIevdS1Qsg==
X-Google-Smtp-Source: ABdhPJyrliHHssGy3danayvmx9aPSjdbjHWaiTrvgu7jCsDLKzKm48Geyd4LzOvmXoNzU9YMecGFnsoNN/nEaFMMSFU=
X-Received: by 2002:aa7:979b:: with SMTP id o27mr29432985pfp.284.1593030046391;
 Wed, 24 Jun 2020 13:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200228012036.15682-5-brendanhiggins@google.com> <202003021439.A6B6FD8@keescook>
In-Reply-To: <202003021439.A6B6FD8@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 24 Jun 2020 13:20:35 -0700
Message-ID: <CAFd5g45Jz-5wtO-YNuqPN2Zc_rJtoA1qbPLVs2wrJFQyZpd5QQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] init: main: add KUnit to kernel init
To:     Kees Cook <keescook@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 2:45 PM Kees Cook <keescook@chromium.org> wrote:

Sorry it took so long to respond. I am reviving this patchset now,
about to send out a new revision and I just saw this comment.

> On 2/27/20 7:20 PM, Brendan Higgins wrote:
> > Remove KUnit from init calls entirely, instead call directly from
> > kernel_init().
> >
> > Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > [...]
> > diff --git a/init/main.c b/init/main.c
> > index ee4947af823f3..7875a5c486dc4 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -104,6 +104,8 @@
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/initcall.h>
> >
> > +#include <kunit/test.h>
> > +
> >  static int kernel_init(void *);
> >
> >  extern void init_IRQ(void);
> > @@ -1444,6 +1446,8 @@ static noinline void __init kernel_init_freeable(void)
> >
> >       do_basic_setup();
> >
> > +     kunit_run_all_tests();
> > +
> >       console_on_rootfs();
> >
> >       /*
>
> I'm nervous about this happening before two key pieces of the kernel
> setup, which might lead to weird timing-sensitive bugs or false
> positives:
>         async_synchronize_full()
>         mark_readonly()
>
> Now, I realize kunit tests _should_ be self-contained, but this seems
> like a possible robustness problem. Is there any reason this can't be
> moved after rcu_end_inkernel_boot() in kernel_init() instead?

I tried that, but it doesn't work without an initramfs. We could add
an initramfs for KUnit at some point if highly desired, but I think
that is outside the scope of this patchset. Additionally, this patch
actually moves running tests to later in the init process, which is
still an improvement over the way KUnit works today.

There are some other reasons I wouldn't want to make that change right
now, which will become apparent in a patch that I will send out in
short order.

Cheers
