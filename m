Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B507C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9604214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVpoLgWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgA3W5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:57:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42862 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgA3W47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:56:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id p9so1911255plk.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0OASKqvkAbKhPJi+8BLbJXf7NsJuVGG2F01NRx4uXs=;
        b=uVpoLgWjGXuzd5yfcWM9lhJIpdK7H/ed03v0i4oe6ecKcTEcyUagDQonSnpspNqBrg
         vzRW3ikS7UJQyY4Dj4PvpzbOlFmWNIQh30F18QIPfzj4FV1GaUcHqdOzZ3waSZX28dFR
         owP1VctM6Zpi+bhXbngtnNxU5Npm2UP3BFLONGvIskBJ+Hso+Gm7uzXKWMzhnG1Wu8Zr
         3raQdUvOYsYH0Sw1qO1QgwRs+xaKfx7EYur5a3+Wfbi0ZwyEdL1Yu5dOLhbV7Pnmq3Wo
         HmdITpnr8Myjlm7LxKgu2hN0B/4IlgJdB1tejGrAsObwA/gpPvKq22x5TFLXzj7T6OSa
         Nmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0OASKqvkAbKhPJi+8BLbJXf7NsJuVGG2F01NRx4uXs=;
        b=ABKtTrPUd5I53KQUD2RkNn9XrKrwYK4CMCgzShCJne7KjHnif7Eh9x1dwmGIae9kL0
         pGY3x7Zo+B63r8zN1Vy2pr39jFyiEmWEP3J4Ijo+UFnuaxTie/w2tEC34JYdjBnlsviH
         iXcFu82q+uAfHHu79Ip97Ozex1Mz/KHW9GodVHvU8JJH1Mbc9pBoL0tg3XyKfGnAe/8D
         nG4wsdEZimTceU2y2RVQuKd/X1FuypKZEzNOcmFkJ4eMc1F46MRuHKgUDFeF4dfG5HuI
         lr1HfW7QhRYjhz01m4ZFmnneZyIqu3iMxIbw2iZpUqrHppCH/BAQJqqof6CsI7LQO05C
         MmUQ==
X-Gm-Message-State: APjAAAXiGmEi3Go2ZZowPoFi35JEfZyKIifA85eD4nFfMVFTz6yQwuH5
        OoPqUKpI16qx2l22/QyMnJqZbK6Fa4l1sCprvW/Mlg==
X-Google-Smtp-Source: APXvYqx06rRfdAGESGvFlaOpt4QDt5bLwuCNfe3+zYpcszJFW6Zuk8yX4mjZtgIJVufRQ/Br8R02iQzC8Gfj3f2ErLY=
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr6694919plv.297.1580425018923;
 Thu, 30 Jan 2020 14:56:58 -0800 (PST)
MIME-Version: 1.0
References: <20200128072002.79250-1-brendanhiggins@google.com>
 <20200128072002.79250-7-brendanhiggins@google.com> <20200129063307.19CB4206F0@mail.kernel.org>
In-Reply-To: <20200129063307.19CB4206F0@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 30 Jan 2020 14:56:47 -0800
Message-ID: <CAFd5g44OO7Lany3U9dn-Axbsf2YBQ4fynvRpkqYYf-N1AhNMQQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] kunit: Add 'kunit_shutdown' option
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Knut Omang <knut.omang@oracle.com>,
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

On Tue, Jan 28, 2020 at 10:33 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2020-01-27 23:20:01)
> > From: David Gow <davidgow@google.com>
> >
> > Add a new kernel command-line option, 'kunit_shutdown', which allows the
> > user to specify that the kernel poweroff, halt, or reboot after
> > completing all KUnit tests; this is very handy for running KUnit tests
> > on UML or a VM so that the UML/VM process exits cleanly immediately
> > after running all tests without needing a special initramfs.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
>
> Two nitpicks below
>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 7fd16feff157e..d3ec1265a72fd 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >
> >  #include <kunit/test.h>
> > +#include <linux/reboot.h>
>
> Should this include come before kunit/test.h? I imagine the order of
> includes would be linux, kunit, local?

I think some reviewers/maintainers want them all to be alphabetical.
So I have probably done it both ways in the past. Will fix.

> >
> >  /*
> >   * These symbols point to the .kunit_test_suites section and are defined in
> > @@ -11,6 +12,23 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
> >
> >  #if IS_BUILTIN(CONFIG_KUNIT)
> >
> > +static char *kunit_shutdown;
> > +core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> > +
> > +static void kunit_handle_shutdown(void)
> > +{
> > +       if (!kunit_shutdown)
> > +               return;
> > +
> > +       if (!strcmp(kunit_shutdown, "poweroff")) {
> > +               kernel_power_off();
> > +       } else if (!strcmp(kunit_shutdown, "halt")) {
> > +               kernel_halt();
> > +       } else if (!strcmp(kunit_shutdown, "reboot")) {
> > +               kernel_restart(NULL);
> > +       }
>
> Kernel style would be to not have braces on single line if statements.

Whoops. Sometimes I forget :-)

> > +}
> > +
> >  static void kunit_print_tap_header(void)
> >  {
> >         struct kunit_suite * const * const *suites, * const *subsuite;

Thanks!
