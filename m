Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97F6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C97A2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQ+9HJwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgATPJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:09:59 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42062 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgATPJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:09:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id z14so30367053qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 07:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RILlv2/4lxhYaS+kKGTocXUc7rBZNj6liYWIdFAYLvQ=;
        b=PQ+9HJwkpHh6UGSfmbZj1yoVjU3WBfmMRoDHyXZg8Xym+mrPVA2I5Y8KrzBd7kel+T
         reuDWjyQ6GYnF7/woKV1/RXpvtxtb5X9gzk/wuzN63SKNFmHBKPzErKfOCOmlY1mhVkF
         z0qBOG92IaACs+MeaUYSvpBvqF+7knmED3PJy3HVF85s9z4Fk2ZIImGAtZVtjlE+N8Ya
         O2MtOz6Ir/FH3qqZvKcO4Qp071b7MH2gMhcrV4Pa6bSMeX0gnIB3fwL7cQDrOfQdiIqa
         eTdm3s5r4FVsJNQ9hXC7Twh9dImfDJfTB09QSPsfErWOHsOMYzoyDvkGaWfKCbRGg8/r
         +iVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RILlv2/4lxhYaS+kKGTocXUc7rBZNj6liYWIdFAYLvQ=;
        b=Z/9MB7iWRBn4jTWbpWCySSKDrup0FW4r1DsLl5jrPPqah8hKQ2z2ob1LaJjmAv8C8+
         EmuFB4qG49smW8GK0WCYLEaJzk5dex9K8UpyU5Egdrk4z9BbkS7cCgiQJfSy7dlQeu6S
         bhM3TxwTlGUO9IWEIbT/8RPt9UY+j5TD94mFgZMutwxxdCyeSfJgtnnL3ERqqIKyq80O
         7OvtszqL1wqBrKVFfTFd4FoDP6YBKrBRHarvw2hTacL/nD/AwCkdNqJYsR3XbGXB22+6
         UTWaiCFoeBLKwGf4P1474EaMem/LnyzTb4gc6sgX4Jf3KdQLQ7Ng+ns6tW5tb1pHv+xl
         uYZw==
X-Gm-Message-State: APjAAAWyuRBfjbR6ADu+oXTXH6Mt0/hnnVWXjX+EG3o4AC7aUaHuXIYC
        2WkX2aZNYMpzNo4sMca4nA46qKdqPjbCcDccq1RWtg==
X-Google-Smtp-Source: APXvYqxIiGtso33+ZGjACAQiFbsYtbOxc4Shn8h2vPNcQORsrLV8LawWPsHl9Potnj3q87J+zgQ9995P7S/CcUG9p6g=
X-Received: by 2002:a05:620a:1136:: with SMTP id p22mr52522165qkk.8.1579532997947;
 Mon, 20 Jan 2020 07:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com> <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
 <CACT4Y+YuTT6kZ-AkgU0c1o09qmQdFWr4_Sds4jaDg-Va6g6jkA@mail.gmail.com>
In-Reply-To: <CACT4Y+YuTT6kZ-AkgU0c1o09qmQdFWr4_Sds4jaDg-Va6g6jkA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Jan 2020 16:09:46 +0100
Message-ID: <CACT4Y+acrXkA-ixjQXqNf1EC=fpgTWf3Rcevxxon0DfrPdD-UQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] include/linux: Add instrumented.h infrastructure
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>, cyphar@cyphar.com,
        Kees Cook <keescook@chromium.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 3:58 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Jan 20, 2020 at 3:45 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
> > >
> > > This adds instrumented.h, which provides generic wrappers for memory
> > > access instrumentation that the compiler cannot emit for various
> > > sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> > > future this will also include KMSAN instrumentation.
> > >
> > > Note that, copy_{to,from}_user require special instrumentation,
> > > providing hooks before and after the access, since we may need to know
> > > the actual bytes accessed (currently this is relevant for KCSAN, and is
> > > also relevant in future for KMSAN).
> > >
> > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 153 insertions(+)
> > >  create mode 100644 include/linux/instrumented.h
> > >
> > > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > > new file mode 100644
> > > index 000000000000..9f83c8520223
> > > --- /dev/null
> > > +++ b/include/linux/instrumented.h
> > > @@ -0,0 +1,153 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +/*
> > > + * This header provides generic wrappers for memory access instrumentation that
> > > + * the compiler cannot emit for: KASAN, KCSAN.
> > > + */
> > > +#ifndef _LINUX_INSTRUMENTED_H
> > > +#define _LINUX_INSTRUMENTED_H
> > > +
> > > +#include <linux/compiler.h>
> > > +#include <linux/kasan-checks.h>
> > > +#include <linux/kcsan-checks.h>
> > > +#include <linux/types.h>
> > > +
> > > +/**
> > > + * instrument_read - instrument regular read access
> > > + *
> > > + * Instrument a regular read access. The instrumentation should be inserted
> > > + * before the actual read happens.
> > > + *
> > > + * @ptr address of access
> > > + * @size size of access
> > > + */
> >
> > Based on offline discussion, that's what we add for KMSAN:
> >
> > > +static __always_inline void instrument_read(const volatile void *v, size_t size)
> > > +{
> > > +       kasan_check_read(v, size);
> > > +       kcsan_check_read(v, size);
> >
> > KMSAN: nothing
>
> KMSAN also has instrumentation in
> copy_to_user_page/copy_from_user_page. Do we need to do anything for
> KASAN/KCSAN for these functions?


There is also copy_user_highpage.

And ioread/write8/16/32_rep: do we need any instrumentation there. It
seems we want both KSAN and KCSAN too. One may argue that KCSAN
instrumentation there is to super critical at this point, but KASAN
instrumentation is important, if anything to prevent silent memory
corruptions. How do we instrument there? I don't see how it maps to
any of the existing instrumentation functions.

There is also kmsan_check_skb/kmsan_handle_dma/kmsan_handle_urb that
does not seem to map to any of the instrumentation functions.
