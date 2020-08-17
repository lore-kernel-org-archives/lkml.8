Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871EFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631E62072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HlS+DhuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgHQVpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHQVpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:45:39 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84714C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 14:45:39 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 74so8878691pfx.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 14:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5NX3Q1GYp48OUvJZQHx5AOAR0W2M3qE4XWtOJ4Fmf4=;
        b=HlS+DhuF53gJlvJjmZwoSWeJywwWrbP2J0o6+lnOf2amORdoowBNfu/IO4Cv8mkKaf
         938OP6GPK4aAGksebv44/DUxsozDxt9zhcS/5zZyF9y1f1Qq7jJfRokWHnoGpdiWRBK4
         MLgvTQZpojbRQ7EMIjwOyDdvq6yym1jfoibP1ALDQDuqhKZ0z2ZEH2oLmx4+/oAhnXkr
         Fh3XJZNmkckaTTGmloFQ2nryxSCa9cprNSRp7Hv9AOCVyzcn432/lwWV86+hNL5ETYP2
         mlSy8xx8Ztf4+YdzJ3lgjyiBCRSLXQ8Z4nuMkR0/NR00SM8nnitb4AXUOVTm9LJNloDA
         Ywyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5NX3Q1GYp48OUvJZQHx5AOAR0W2M3qE4XWtOJ4Fmf4=;
        b=Lz33Hmd/12gh8+/UJ6DMBudJQUzBnG2eA/3IhTbhelCNuR9M544dokjjBXzDptDlOH
         SKe57tfrCi7hpcxQVjVhLP+8LqrMJ/DbKsgDw9LX8Zh/daT44SqlbryxZhLy0y8AS6Aa
         DBbY4Hsa6JcvFj7mOXN/zwx3UOqVbyQBdOs5OR2BYDjZ161h+cqShvU9zkoiM4HHGFtK
         OOSakr6qX/nBSv5Y1+mu4J0m56vlSOzPWv/uZzJ2UlCc/xkWNXuCWWSRkh6PNae5UTWh
         uFp3bbNcN5nPcxxCBOPR/Kp0G63gMckKV2FBmtvudCjzrx60H4kzan5ogeRvOdqpqloX
         Vbkw==
X-Gm-Message-State: AOAM532tHV2QULZG6M8ZtxE2YzazOqh5cVvxq2TP3tEO/XLrwPJH+iY/
        Fut3ljTYEDZLpCDAcpeyhPd9+ch5iJBzlVWLUcfwAQ==
X-Google-Smtp-Source: ABdhPJzQtM0WgyIzaD6jqd80KqMJ+foDWc+kVqOWoecUhCR/LnSPxtj2Zb6aUss/SJr5hyl0bh6zqWx8BMSGNpoVy5w=
X-Received: by 2002:a63:a119:: with SMTP id b25mr11094694pgf.10.1597700738307;
 Mon, 17 Aug 2020 14:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnyHfx6ayqEoOr3pb_ibKBAG9vj31LuKE+f712W=7LFKA@mail.gmail.com>
 <457a91183581509abfa00575d0392be543acbe07.camel@perches.com>
 <CAKwvOdk4PRi45MXCtg4kmeN6c1AK5w9EJ1XFBJ5GyUjwEtRj1g@mail.gmail.com>
 <ccacb2a860151fdd6ce95371f1e0cd7658a308d1.camel@perches.com>
 <CAKwvOd=QkpmdWHAvWVFtogsDom2z_fA4XmDF6aLqz1czjSgZbQ@mail.gmail.com>
 <20200816001917.4krsnrik7hxxfqfm@google.com> <CA+icZUW=rQ-e=mmYWsgVns8jDoQ=FJ7kdem1fWnW_i5jx-6JzQ@mail.gmail.com>
 <20200816150217.GA1306483@rani.riverdale.lan> <CABCJKucsXufD6rmv7qQZ=9kLC7XrngCJkKA_WzGOAn-KfcObeA@mail.gmail.com>
 <CAKwvOd=Ns4_+amT8P-7yQ56xUdDmL=1zDUThF-OmFKhexhJPdg@mail.gmail.com> <20200817201351.GA2246446@rani.riverdale.lan>
In-Reply-To: <20200817201351.GA2246446@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Aug 2020 14:45:26 -0700
Message-ID: <CAKwvOdnUydcU_LpEjXS+M-EUVztoiMNsVpvZ9eK+_+yoCen6ZQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib/string.c: implement stpcpy
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>, Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 1:13 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Aug 17, 2020 at 11:36:49AM -0700, Nick Desaulniers wrote:
> > > > Though I don't understand the original issue, with -ffreestanding,
> > > > sprintf shouldn't have been turned into strcpy in the first place.
> >
> > Huh? The original issue for this thread is because `-ffreestanding`
> > *isn't* being used for most targets (oh boy, actually mixed usage by
> > ARCH. Looks like MIPS, m68k, superH, xtensa, and 32b x86 use it?); and
> > I'm not suggesting it be used.
> >
>
> Sorry, I meant the issue mentioned in the commit that removed
> -ffreestanding, not the stpcpy one you're solving now. It says that
> sprintf got converted into strcpy, which caused failures because back
> then, strcpy was #define'd to __builtin_strcpy, and the default
> implementation was actually of a function called __builtin_strcpy o_O,
> not strcpy.
>
> Anyway, that's water under the bridge now.
>
> 6edfba1b33c7 ("x86_64: Don't define string functions to builtin")
>   gcc should handle this anyways, and it causes problems when
>   sprintf is turned into strcpy by gcc behind our backs and
>   the C fallback version of strcpy is actually defining __builtin_strcpy

For fun, I tried removing `-ffreestanding` from arch/x86/Makefile;
both gcc and clang can compile+boot the i386 defconfig just fine.  Why
don't I send a patch removing it with your suggested by in a series of
fixes for stpcpy and bcmp?

-- 
Thanks,
~Nick Desaulniers
