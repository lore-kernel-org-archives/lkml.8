Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4B2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6541A20723
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SV7JaaRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgE2TNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2TNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:13:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E8CC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:13:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k2so1913647pjs.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oaFnjUA4dY+z1OHe26Jg20HjGUXEg7dL6NAWsqRKEyg=;
        b=SV7JaaRYNYenoJaDIipJhEAoLQG6IXkyOEfZg5vhA9CdIAgkh80aEx48FdnSD+xb0u
         sZojVzgEitVYnOi28MIy/qWtXexVx0c954swi+d1FV4LKLu9RbL2XqWSsEFejPGcq+IT
         8l26NXBdFqVCRTAmkAcnYNJndFLPOux5GapAYeuLePPNF1xAJ73uEC6erI4oTwIvaAwh
         FTn80jqj74uIMvKpjszsIqTZkg4YXeV601sOwArRNCG5Av8P40FjLs+8BCopVxah/TR5
         1ZFWCVZnS0HCje3NGBICSm5VbiB7VPUgJWztTatu6zIAugSsqX5Wmq3rIYruCp0ZaNOu
         6P+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oaFnjUA4dY+z1OHe26Jg20HjGUXEg7dL6NAWsqRKEyg=;
        b=n9m7FmiiN3um4Aj+x9ynXWSeKS7FZkJWKkjm4VOKO0DbnBQC1btvKd5o1i2RhTyYGi
         GVA/fBDr6Ug1QnzuRpej+1fVdNI9Pez3lxRy+yDmPpEviPqIhiQg67ybCZJe2I49S2IP
         ftbYfi8Lwa2jtxSg04oaG8luI1gfm/V8vyQ8tIUncYRjUsv1juRqBZ3GJYXJ/u/nT/SN
         //NeIkHuIxGz5dgM8oxZ3u21FRPhB698ptqWgOPye/7YNoqgP8wlfiMsdr4v+KKNATzi
         rotUK7nvhPHoWlRCloTuUjGPItBfAdDbty6A9IolB9ngu9hqmv/1ud1KIYphnluQQs7g
         H7vA==
X-Gm-Message-State: AOAM5329J9CR/L3aekZo5gX2RSzz+xu0CejXRNNDxvAoap1JnkgHPbH0
        l1ThJ6UZGmQLbj4J0qpE9kqm4WW2xZ0EInIr7ndhKd5JMMM=
X-Google-Smtp-Source: ABdhPJxM1af5vMs+j6j9U6LtukVH5C12f/WIPpriOWLUdLaaM2iK0hRts3/WmQ+NStv/xsSPalR/eRloaZ1kt3RZCVU=
X-Received: by 2002:a17:90a:2a8e:: with SMTP id j14mr10688817pjd.136.1590779614972;
 Fri, 29 May 2020 12:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <ced83584eec86a1a9ce264013cf6c0da5e0add6a.1590686292.git.andreyknvl@google.com>
 <CANpmjNPr5MrwPFOW10pRkUgxwktXNiUweNj+pGJMunoZKi7Cdw@mail.gmail.com>
In-Reply-To: <CANpmjNPr5MrwPFOW10pRkUgxwktXNiUweNj+pGJMunoZKi7Cdw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 29 May 2020 21:13:23 +0200
Message-ID: <CAAeHK+z_b+EEX+raj_WQ9xVG11HrQDb5nMGJpyvFS1t=x1MFKg@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix clang compilation warning due to stack protector
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 4:56 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, 28 May 2020 at 19:20, 'Andrey Konovalov' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > KASAN uses a single cc-option invocation to disable both conserve-stack
> > and stack-protector flags. The former flag is not present in Clang, which
> > causes cc-option to fail, and results in stack-protector being enabled.
> >
> > Fix by using separate cc-option calls for each flag. Also collect all
> > flags in a variable to avoid calling cc-option multiple times for
> > different files.
> >
> > Reported-by: Qian Cai <cai@lca.pw>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
>
> Thank you! I was about to send an almost identical patch, as I
> encountered this when using clang.
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> >  mm/kasan/Makefile | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> > index de3121848ddf..bf6f7b1f6b18 100644
> > --- a/mm/kasan/Makefile
> > +++ b/mm/kasan/Makefile
> > @@ -15,14 +15,19 @@ CFLAGS_REMOVE_tags_report.o = $(CC_FLAGS_FTRACE)
> >
> >  # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
> >  # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
> > -CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> > -CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> > -CFLAGS_generic_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> > -CFLAGS_init.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> > -CFLAGS_quarantine.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> > -CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> > -CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> > -CFLAGS_tags_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
> > +CC_FLAGS_KASAN_CONFLICT := $(call cc-option, -fno-conserve-stack)
> > +CC_FLAGS_KASAN_CONFLICT += $(call cc-option, -fno-stack-protector)
> > +# Disable branch tracing to avoid recursion.
> > +CC_FLAGS_KASAN_CONFLICT += -DDISABLE_BRANCH_PROFILING
>
> Note that maybe CC_FLAGS_KASAN_RUNTIME could be a better name, because
> other flags added in future might not be conflict-related. But until
> that future, it doesn't really matter.

CC_FLAGS_KASAN_RUNTIME is a better name, sent v2, thanks!

>
> > +CFLAGS_common.o := $(CC_FLAGS_KASAN_CONFLICT)
> > +CFLAGS_generic.o := $(CC_FLAGS_KASAN_CONFLICT)
> > +CFLAGS_generic_report.o := $(CC_FLAGS_KASAN_CONFLICT)
> > +CFLAGS_init.o := $(CC_FLAGS_KASAN_CONFLICT)
> > +CFLAGS_quarantine.o := $(CC_FLAGS_KASAN_CONFLICT)
> > +CFLAGS_report.o := $(CC_FLAGS_KASAN_CONFLICT)
> > +CFLAGS_tags.o := $(CC_FLAGS_KASAN_CONFLICT)
> > +CFLAGS_tags_report.o := $(CC_FLAGS_KASAN_CONFLICT)
> >
> >  obj-$(CONFIG_KASAN) := common.o init.o report.o
> >  obj-$(CONFIG_KASAN_GENERIC) += generic.o generic_report.o quarantine.o
> > --
> > 2.27.0.rc0.183.gde8f92d652-goog
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/ced83584eec86a1a9ce264013cf6c0da5e0add6a.1590686292.git.andreyknvl%40google.com.
