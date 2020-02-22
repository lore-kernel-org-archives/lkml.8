Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721D0C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 09:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF8A208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 09:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgBVJbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 04:31:31 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42183 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgBVJbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 04:31:31 -0500
Received: by mail-oi1-f196.google.com with SMTP id j132so4196666oih.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 01:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3xnrjDb6hgTNnX7mGgWoeVfbuM9GGgQ7NTSprECVdM=;
        b=OCBu+Qv6XPbzH2ka79QWLMXfRYUxe2HMTBMiKvFMizRR6Pfae90Lg95MFcELShMH4w
         /4ou0lmQSIskQilngCvTR+PQ3JkwZApCxET7jl4/BuEh8QsSLM6DRHkhMReKvFNFVykN
         HScqMK50FtOnRAeh/gstyuolwO5cL4TuzxSxi9Qq2k6Eu1QG1h+vc21XivTea9QGXW5f
         lRAPRh+Br5w4j0rs7+6xfgyxI5acE2T9VWqZnCpm9tZlhVjXgwt4ofED8RdL/1QEqEQc
         wgzwgWjhomteYdjXvWJocxdqR4DB7+vTWj8FrM12gax0cXr0pAzs0KaTFjmaKKKvf2U3
         bxWQ==
X-Gm-Message-State: APjAAAXdtv4hx3um29HHcDQlZ9WmYKc1recVxUbBJ8A6aPfuCqgdEA7G
        uahIz/FbD+TIzCeDeimDyj++O4HvW7DtMmEVcRA=
X-Google-Smtp-Source: APXvYqzkPHlUNRY0rLyWjHxG0GFr6uttOCebAMEHPBf3nCnrkCitisQfp9v2RpWvOd3pAJiZhyrOQ03BBYt0TcQIWa8=
X-Received: by 2002:aca:1a06:: with SMTP id a6mr5320808oia.148.1582363889243;
 Sat, 22 Feb 2020 01:31:29 -0800 (PST)
MIME-Version: 1.0
References: <158227281198.12842.8478910651170568606.stgit@devnote2>
 <158227282199.12842.10110929876059658601.stgit@devnote2> <536c681d-a546-bb51-a6cb-2d39ed726716@infradead.org>
In-Reply-To: <536c681d-a546-bb51-a6cb-2d39ed726716@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 22 Feb 2020 10:31:17 +0100
Message-ID: <CAMuHMdURcRPXo7Q-2E7bS7X9w73NvYP8ffdJeNk37wdQgVxThw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bootconfig: Prohibit re-defining value on same key
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Sat, Feb 22, 2020 at 5:30 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 2/21/20 12:13 AM, Masami Hiramatsu wrote:
> > --- a/Documentation/admin-guide/bootconfig.rst
> > +++ b/Documentation/admin-guide/bootconfig.rst
> > @@ -62,7 +62,16 @@ Or more shorter, written as following::
> >  In both styles, same key words are automatically merged when parsing it
> >  at boot time. So you can append similar trees or key-values.
> >
> > -Note that a sub-key and a value can not co-exist under a parent key.
> > +Same-key Values
> > +---------------
> > +
> > +It is prohibited that two or more values or arraies share a same-key.
>
> I think (?):                                   arrays
>
> > +For example,::
> > +
> > + foo = bar, baz
> > + foo = qux  # !ERROR! we can not re-define same key
> > +
> > +Also, a sub-key and a value can not co-exist under a parent key.
> >  For example, following config is NOT allowed.::
> >
> >   foo = value1
>
>
> I'm pretty sure that the kernel command line allows someone to use
>   key=value1 ... key=value2
> and the first setting is just overwritten with value2 (for most "key"s).
>
> Am I wrong?  and is this patch saying that bootconfig won't operate like that?

I think so. Both are retained.
A typical example is "console=ttyS0 console=tty", to have the kernel output
on both the serial and the graphical console.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
