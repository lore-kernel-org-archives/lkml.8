Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FF7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A53FE22BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhTBCzgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgH0HTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgH0HTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:19:22 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E525C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:19:21 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id h3so3807381oie.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=0wRVxxRBrrXGuGqR4AB9DKE0dYwS8RlpkKHyA8lloZg=;
        b=vhTBCzgbGDUV3mcqoV5yagn+6W0CBogPAlqKt5dQ+UYjP1Tr5ETBTBkFGIeKqJIvef
         1Arr7FjVtctVCuLgq2F15jLrVKlC1L77ApDkP6ZVLN8Dp3dRFAtn8mEXbPrO8D6xSBCa
         JDwVTpANVwzYdOlO+Ih+l+NgW/R2FUK0b2b6US1yJCpjb2hJiRHq2s+umHXqCM8BCeQ9
         hIrIhUBBI/HUdx9xGvh1pIJfwpPAIBKGeOpq8E4At4O/UATb9UjTK1W34UW/TgOim8Hl
         eDXjKfMvBCMwzCnVmO9pJ5Pu6APfegpggPngKJf1gTKe78Jht/h8WG8aLwtL/9czSAdY
         jXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=0wRVxxRBrrXGuGqR4AB9DKE0dYwS8RlpkKHyA8lloZg=;
        b=Dpe977ivpGuW5URqQ2tsyV2g9eseEK8rDbi6PI++ScYdPTa20NIM9FjHJKVkMWYbMf
         uuKUzUVvPhdG/4Bb9X+nL1AA5ELCujmXxWdqC/eK10YGFfBx+eI18x5qq0+wi8ebHyf0
         2KOHHEBtgFWt2IF2YCt1PYAqM2GSVRhYNjmZezpRFZVoQMzJ2e/5N9LqWKHoqHqIQLSB
         dZGcGjiLF/OrGARdfvYNzTovUevQYCWV0drLiwb0LlBBw523M2goxNmW8VL5eYgQzyjw
         914WUlMNW9TaayMXtarwV13GvQRLf+RkHiD1aW5JhiSjD1nAtYZv8nuSR7rc+pjF6yul
         qChQ==
X-Gm-Message-State: AOAM533syyemUeVojrLBwh0CaepiJ/np3h0Pd2Mm02eOuqH+0wsD4WyM
        PkLQhwiTa2JuXuKoTce5nW5B8OnxwW3lfLR7ELs=
X-Google-Smtp-Source: ABdhPJx9kpBlueuJXaWzTH8db0dluRAlapnjSs1ROR7mrrr5hhRaso1vEsWLFJDslzR1/jl6tpsCn3mvhfrxrKY2Ax8=
X-Received: by 2002:aca:acd5:: with SMTP id v204mr5974706oie.35.1598512759141;
 Thu, 27 Aug 2020 00:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200826201420.3414123-1-ndesaulniers@google.com>
 <CANiq72no2qO3BBTU3MhVCp4mDLqzMg7NhWGObHV3wtFCRjaziw@mail.gmail.com> <20200826212648.GA1005132@ubuntu-n2-xlarge-x86>
In-Reply-To: <20200826212648.GA1005132@ubuntu-n2-xlarge-x86>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 27 Aug 2020 09:19:08 +0200
Message-ID: <CA+icZUX_mR6E+tO+qR4xML78qBZe2Rs4Ck7BgerwtgGaGJ9hgA@mail.gmail.com>
Subject: Re: [PATCH] compiler-clang: add build check for clang 10.0.1
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 11:26 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Aug 26, 2020 at 11:17:34PM +0200, Miguel Ojeda wrote:
> > On Wed, Aug 26, 2020 at 10:14 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > During Plumbers 2020, we voted to just support the latest release of
> > > Clang for now.  Add a compile time check for this.
> >
> > Since this effectively enforces a minimum version for Clang, I'd
> > also update `Documentation/process/changes.rst` and
> > `Documentation/admin-guide/README.rst` to mention this, and perhaps
> > use that as a commit title ("implement minimum version for Clang")
> > since that is the important change, not the implementation so much!
>
> I was actually going to comment on this separately but you beat me to it
> :) this patch probably should have been sent as a series with the
> Documentation update to avoid confusion for the reviewers:
>

Agreed... This patch should be combined with the other one and sent as
a patch-series.

- Sedat -

> https://lore.kernel.org/lkml/20200826191555.3350406-1-ndesaulniers@google.com/
>
> Cheers,
> Nathan
>
> > [Actually, I'd remove the particular GCC version from the
> > `admin-guide/README.rst` to avoid having the version in 2 places (that
> > doc already links to the other one), but that should be another
> > patch.]
> >
> > Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> >
> > Cheers,
> > Miguel
