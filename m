Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5249DC33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1393F2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDObeLsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgANBuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 20:50:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34667 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgANBuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:50:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so2356692plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 17:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J30fqITUTDvnu3BqcfEBSuuwXGgTPGm8WpqWMqoJUnQ=;
        b=HDObeLsVJ1IPKVEq6uHS/0iWb/hQ2/4YvhVmLo8DG26WuaUfcQazBclVrvKGcXRKzW
         3HNoZpclk1UV0zpE3g7J/JeS3ldp8q4RjGNVUbHTnC1oIpPmog6+QoBKA4iNyWiR8Nyc
         CknqI2BOpsq1L/NcetnWjjTwIes3Qwl4jUXs5iJawbr2Qi3xkVrk6pJ3q1spNeXMt55g
         eabfnqoJaU9woFEJK0MbQwkIiciN+daATzfbhEmqwwFw7vOZSNvGsPNJMschbJzyxhex
         uPLpN21eqvmK6ipJiKF2UcNvaFgSPXSU7kmtSFJqHJuCAL1qxEaq9M8yHaT0U9+GivPx
         E1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J30fqITUTDvnu3BqcfEBSuuwXGgTPGm8WpqWMqoJUnQ=;
        b=ai4UrkXBIsBnbTaoZ3aK1+2b05mm9vxil/K2CjsgbNtyEvAvNnuH8R+B3nE/j/SHhW
         yNeDzh2AcC5xubBXywYSI1Ga3lo0hc6XCvUnMF0rMVretGCsPDV7hbG6ixipo0BgFeYi
         s4G0JQgd96ILTCM3WU2//NyQ+QQ0fg7MJ4UmNRLOowRbF5awWQORz8Mwnxk5gKKQgH9n
         MEgi7/4Hm7fRwjwAEvykh4Ymg7LgDPslKnIkzXbC0xkGRRcpwyCltEEXcBug3hVtIo3v
         xe8dyuALB6KpGtJnr4dWVqYO6Uer3jBWf1S+J0LhJ/LtJ2sJWPrkRXQ0hgxHX7RCr/LB
         AaZA==
X-Gm-Message-State: APjAAAWFUAKkgQTbE+PQhFs8R4j11zu3TbsRlPcWeLPugZEtXNCUmKOY
        e06VYdfeSOwM9OKQqzViP9hpP1Mvd0YW3qtGhb0VOQ==
X-Google-Smtp-Source: APXvYqwxKm9Il2KE3NehTvhxXgDjoX/7JhKbsceI/Mm3nAtLXSHi1w/4xVUKi/QWY8SozZ/ikfKnbjSksPmFEGO3jUs=
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr17543311plq.325.1578966636515;
 Mon, 13 Jan 2020 17:50:36 -0800 (PST)
MIME-Version: 1.0
References: <201912301716.xBUHGKTi016375@pmwg-server-01.pmwglab>
 <CAK8P3a1OsiUV5YuwzSJ4CsD8NHJHjedTA4K7xBKK6Q-4kA8t5g@mail.gmail.com>
 <CAFd5g46YYiC-aeAGumqOMiNZ71h2dGH==F_bdj+pwQ5YOHo3GA@mail.gmail.com>
 <CAK8P3a0cZQ-8sX=_2Oa_GQeHeMxsQpdJH=zUoeRXyM-7_MmE9g@mail.gmail.com>
 <20200110062747.1E6C92072E@mail.kernel.org> <CAK8P3a0ZvZR-rqYqrsx7h5zZBPKUqopipXyApoHNOa5VgiL7UA@mail.gmail.com>
In-Reply-To: <CAK8P3a0ZvZR-rqYqrsx7h5zZBPKUqopipXyApoHNOa5VgiL7UA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 13 Jan 2020 17:50:25 -0800
Message-ID: <CAFd5g47-3kM7NscbjXMOMnL3kHt2zURM+7K4ex4T454xNaL2Yw@mail.gmail.com>
Subject: Re: kunit stack usage, was: pmwg-ci report v5.5-rc4-147-gc62d43442481
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Boyd <sboyd@kernel.org>, PMWG CI <pmwg-ci@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Private Kernel Alias <private-kwg@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 12:05 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jan 10, 2020 at 7:27 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > Quoting Arnd Bergmann (2020-01-08 07:13:46)
> > > On Wed, Jan 8, 2020 at 3:41 PM Brendan Higgins <brendanhiggins@google.com> wrote:
> > > > On Tue, Jan 7, 2020 at 4:37 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > test function, which allocates the object, and then calls the unit
> > > > test function with a reference to the object allocation; then we could
> > > > just reuse that allocation and we can avoid making a bunch of
> > > > piecemeal heap allocations.
> > > >
> > > > What do people think? Any other ideas?
> >
> > How about forcing inlining of kunit_do_assertion()? That may allow the
> > compiler to remove all the assertion structs and inline the arguments
> > from the struct to whatever functions the assertion functions call? It
> > may bloat the text size.
>
> I haven't tried it, but I'm fairly sure that would not reliably fix it. The
> problem is that the local 'struct kunit_assert' structure escapes to
> an extern function call it is passed to by reference. If we inline
> kunit_do_assertion(), nothing really changes in that regard as
> the compiler still has to construct and initialize that structure on
> the stack.
>
> However, the reverse would be possible. Turning
> KUNIT_BASE_BINARY_ASSERTION() into an extern
> function that takes all the arguments without passing a
> structure would solve it. I've prototyped this by changing
> KUNIT_BINARY_EQ_ASSERTION() and
> KUNIT_BINARY_NE_ASSERTION() like
>
> @@ -651,13 +649,19 @@ do {
>                                 \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_NE_ASSERTION(test, assert_type, left, right)             \
> +#define __KUNIT_BINARY_NE_ASSERTION(test, assert_type, left, right)           \
>         KUNIT_BINARY_NE_MSG_ASSERTION(test,                                    \
>                                       assert_type,                             \
>                                       left,                                    \
>                                       right,                                   \
>                                       NULL)
>
> +static __maybe_unused noinline void KUNIT_BINARY_NE_ASSERTION(struct
> kunit *test, int assert_type,
> +                                       long long left, long long right)
> +{
> +       __KUNIT_BINARY_NE_ASSERTION(test, assert_type, left, right);
> +}
> +
>  #define KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,
>                 \
>                                           assert_type,                         \
>                                           left,                                \
>
>
> A little more work is needed to make the varargs and
> code location passing all work correctly.
>
> > > The idea of annotating it got me thinking about what could be
> > > done to improve the structleak plugin, and that in turn got me on
> > > the right track to a silly but trivial fix for the issue: The only thing
> > > that structleak does here is to initialize the implied padding in
> > > the kunit_binary_assert structure. If there is no padding, it all
> > > works out find and the structures don't get pinned to the stack
> > > because the plugin can simply ignore them.
> > >
> > > I tried out this patch and it works:
> > >
> > > diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> > > index db6a0fca09b4..5b09439fa8ae 100644
> > > --- a/include/kunit/assert.h
> > > +++ b/include/kunit/assert.h
> > > @@ -200,8 +200,9 @@ struct kunit_binary_assert {
> > >         struct kunit_assert assert;
> > >         const char *operation;
> > >         const char *left_text;
> > > -       long long left_value;
> > >         const char *right_text;
> > > +       long __pad;
> > > +       long long left_value;
> > >         long long right_value;
> > >  };
> > >
> > > There may also be a problem in 'struct kunit_assert' depending on the
> > > architecture, if there are any on which the 'enum kunit_assert_type'
> > > type is 64 bit wide (which I think is allowed in C, but may not happen
> > > on any toolchain that builds kernels).
> > >
> >
> > What does the padding do? This is all magical!
>
> It turned out to not work after all, The change above fixed some of the
> cases I saw, but not others.
>
> I'm still struggling to fully understand why the structleak gcc plugin
> sometimes forces the structures on the stack and sometimes doesn't.
> The idea for the patch above was to avoid implicit padding by making
> the padding explicit. What happens with the implicit padding is that
> the expanded macro containing code like
>
> struct { const char *left_text; long long left_value; } assert =
>     { .left_text  = # _left, .left_value =  _left };
> func(&assert);
>
> produces a partially initialized object on a 32-bit architecture, with the
> padding between left_text and left_value being old stack data. The
> structleak plugin forces this to be initialized to zero, which in turn
> forces the structure to be allocated on the stack during the execution
> of the function, not just within the surrounding basic block (this
> is a known deficiency in structleak).
>
> The theory so far made sense to me, except that as I said above the
> padding alone did not fix the problem. :(

The padding idea makes sense to me; however, it isn't going to address
the problem with using too much stack space, right? I think the
union/single copy idea would address that, no? (Not that I am excited
by the prospect of making these macros any more magical than they
already are.)
