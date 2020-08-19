Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED256C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5EDD2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFlJFEgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgHSLvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgHSLuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:50:25 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A1FC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 04:50:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g15so6802182plj.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 04:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4uE3mQjF3izpWntHgMP6vzXZ5cqjVe0Hyv9OEz2QLD4=;
        b=aFlJFEgS4xeWJD2USnflfp80bmbUTDHEtmHnXCE947VXz5EyeTPV3QRVW+wjvGX6+p
         kJLcrMAvMhUpUU+ZRaC8s9Wc2BZGiahUizFe2oLRs1AwIZPC7A0h+t37Hu652e/FOP69
         JI4I590AKuX/6ss/T8ym6gH/NVb/ylkC+OAahzpaqsCOw12mXVToJMelIvNUhBnYLXl5
         UGsyMqvu0UZoG7TXh0dSzrWV/CIHux1nnvnVTKZYIXlR/sFY1ATdG7yI+cmEXpmS2fZV
         S8mmFmUvevdy4RnkJVX+DwX7vyli5AS1X3mW3K4TPdITZf5uk3wrXtEFuJB0ECay34/5
         06AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4uE3mQjF3izpWntHgMP6vzXZ5cqjVe0Hyv9OEz2QLD4=;
        b=pn98FSqKH+kMrnaDE/b3hs+PLpcOUDjb+Tgdw+cSHCmIZ/68kOJ7NcKw0QG3JoUhlB
         XxuZkWhgzCr/ImMt7A5fFTzsAU3ML6KHtTa+7GtmK7HdrZebXj9v++2D9ATcd6cWDFOd
         CzKgvE3Pa6J1dpM7YuemaGjzwfh+cX3G7FJ+A0b+9OJByBq06CfOH+/Oq35EmTkgwbBQ
         pF2CuP+Z+bv3UP2VdDhf1IaPY6BTistMxyFjg/l5hCmerNiAxcwhzG/vLiPzhpPjHQJd
         P8pSgHWH0Sxscn4v/oM7xb7vU4n/25PYbLqhW3msLf6ZQatn9HWKZ4PC2mxZ6eWq2698
         FJnA==
X-Gm-Message-State: AOAM530kfouer8yqU3wBVd88hyhsgdUP4of25U2d7lwxTPh/CYh7sBBx
        vWCtjstKnOY5jg2i8w/NdHYMn9GTu4a5kbd9KRo=
X-Google-Smtp-Source: ABdhPJzay2TOShI6HEwUhVOocphRC+IKNraciZWhP6ouM49rNg5cerikDFqaFPjF2IkmYdWbcII3EWNJ7Qoe5sxEfeA=
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr19229334pla.18.1597837823309;
 Wed, 19 Aug 2020 04:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200819094437.GE1891694@smile.fi.intel.com> <CAK7LNATQ1oAQm19-mzCKdMQsiQsYT9BRH5H7zukpFSzJw5WZZQ@mail.gmail.com>
In-Reply-To: <CAK7LNATQ1oAQm19-mzCKdMQsiQsYT9BRH5H7zukpFSzJw5WZZQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Aug 2020 14:50:07 +0300
Message-ID: <CAHp75VcKpkZQ78xygzWTQhNsy8aLBzKzqVJTtzygzTYnWeqmyQ@mail.gmail.com>
Subject: Re: -Werror for `make W=0`
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, X86 ML <x86@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 1:48 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> On Wed, Aug 19, 2020 at 6:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Hi!
> >
> > Maybe silly idea, but would it make sense to enable -Werror for default warning
> > level, let's say W=0, at some point?
> >
>
> Every GCC release adds new warning options.
>
> Enabling -Werror by default means
> the kernel build is suddenly broken
> with new compilers, correct?

Probably, and at the same time we keep our hand on the pulse of the
changes, right?
Adding those warnings to W=1, 2, ... block might be not the bad idea after all.

Maybe some flag CONFIG_DEBUG_WERROR ? Then CIs or other early stage
users can enable by default and be informed.

-- 
With Best Regards,
Andy Shevchenko
