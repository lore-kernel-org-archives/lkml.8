Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233F6C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E783520678
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgAJIFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:05:02 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:36117 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgAJIFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:05:01 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MoOMq-1jRJpK42zA-00ok88 for <linux-kernel@vger.kernel.org>; Fri, 10 Jan
 2020 09:04:59 +0100
Received: by mail-qk1-f178.google.com with SMTP id z76so1089661qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 00:04:58 -0800 (PST)
X-Gm-Message-State: APjAAAXwt+csoUvfYm3Dy+QyODmJLrJmlyXdbRtKZLdu9L8UfKxizJY9
        Cd1uMrpWK1RBcsAuV2HiZVZ+gUzELNHmOQZVQN4=
X-Google-Smtp-Source: APXvYqwwZLLjT42PUOjjsXFh9hC3exwElFruUPll4PUUvQBJVmyOfKZMOqwBtEx2qro4SVhTjvJyxFVbdCz6BdCCee4=
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr1907267qka.286.1578643497797;
 Fri, 10 Jan 2020 00:04:57 -0800 (PST)
MIME-Version: 1.0
References: <201912301716.xBUHGKTi016375@pmwg-server-01.pmwglab>
 <CAK8P3a1OsiUV5YuwzSJ4CsD8NHJHjedTA4K7xBKK6Q-4kA8t5g@mail.gmail.com>
 <CAFd5g46YYiC-aeAGumqOMiNZ71h2dGH==F_bdj+pwQ5YOHo3GA@mail.gmail.com>
 <CAK8P3a0cZQ-8sX=_2Oa_GQeHeMxsQpdJH=zUoeRXyM-7_MmE9g@mail.gmail.com> <20200110062747.1E6C92072E@mail.kernel.org>
In-Reply-To: <20200110062747.1E6C92072E@mail.kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Jan 2020 09:04:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0ZvZR-rqYqrsx7h5zZBPKUqopipXyApoHNOa5VgiL7UA@mail.gmail.com>
Message-ID: <CAK8P3a0ZvZR-rqYqrsx7h5zZBPKUqopipXyApoHNOa5VgiL7UA@mail.gmail.com>
Subject: Re: kunit stack usage, was: pmwg-ci report v5.5-rc4-147-gc62d43442481
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        PMWG CI <pmwg-ci@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Private Kernel Alias <private-kwg@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hVmseLO8md2lM8nLzvgnKzDI2+R80sx8DCBOHs/NOexbnuVC9md
 wSu5jXw1FFlQY852ny/iNaWy2M/gSq2qKxgLHibu0QUI50wy/SCAy/j/KiMkjFt1mmLH2sX
 A/R3QA1AGNawHRH7SJwO2bWwDynK6PxXgCB5cUNxVylxWL7NZhIlRpa4iCw/rORIBcaYAcM
 8mEPoWw9Aoq1WgDGOAAiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sSNufhcq9tM=:6JwIuX1ONri4UdkS3JKiuZ
 TEmrBi1ZRbiP6zCBJHAg9v0ea6VhJ2ob9F62qNSQ3gmGIwplGI0WlGO+pEZuQRD/FnZwBVvHG
 pYkK8dfljtYSHzORXBghu7aSbaQHngwuSI7ylbPGHP/RWcuouV3ICjVqz9xhWFBtWxJJeUCLV
 qeJDNQ4+KfNKMSoVvBl9wMU0uwNzyQ1E/2IPy3k8Wmu6q2vumMbEbB1VBzp0tqahx8E94EHU3
 vFlGuOW+3lWgTNAzgvN3RxO1RIOHbkpxZxwBtTW8smK2EBHcd3pYqajGMrRtUbHVJJvcplps/
 pG8zwnYybqLgcPAja53UnsUVN0SjEv1zxfNfCI2BSzSaMWx2KajHn/46BZXprddD833Pwl7AP
 1jLe3UJLP0/k0gXjBlNg6PMHFhwv3gdArfAgVLPXEs2YhQ06lBgKar3SCa8lllEwRgbwGgP9P
 1cw0vprZwlfRjcT7tgqAUlk2zeAzm3JKHK2VVl7J6cTYgmcYJp1mINkC2nOmLEINsJn7mq1Kg
 YP9ZPhKOcnt36/CnvNkYKa45whWceFUC+sEcFoH0mFQ3R3HvZXtE/rCIRMGwlxYHymDcBVS0C
 dkIm0TtHTHfC3ijQ+Qvqq/cwpgetPltc+2cQHiNNECvrzsObV2lcB/AeDpN1/9H7k02om662e
 6vpWu7+fj0gcodqIl7zrNXLsR54pYz+KSfp8pSw32spXfX7fbOqu07dKCNMggGNLSijSdS4D9
 0ioycfYonCCwwXWPVFjkDRapOpzD/2Ovs3wucj/J7hT+xXIVnEsC+dMLNGx1mYI9rsQ5bsVj2
 KnhgeU7adDnyzBOxjBMwW7wfUfqvGVYORJU0OC1nfQveWtq8sdY0JBB3xoCnrh9xKR3GjK0c6
 qmw8Rfg5aF9ChHMUA4rg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 7:27 AM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Arnd Bergmann (2020-01-08 07:13:46)
> > On Wed, Jan 8, 2020 at 3:41 PM Brendan Higgins <brendanhiggins@google.com> wrote:
> > > On Tue, Jan 7, 2020 at 4:37 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > test function, which allocates the object, and then calls the unit
> > > test function with a reference to the object allocation; then we could
> > > just reuse that allocation and we can avoid making a bunch of
> > > piecemeal heap allocations.
> > >
> > > What do people think? Any other ideas?
>
> How about forcing inlining of kunit_do_assertion()? That may allow the
> compiler to remove all the assertion structs and inline the arguments
> from the struct to whatever functions the assertion functions call? It
> may bloat the text size.

I haven't tried it, but I'm fairly sure that would not reliably fix it. The
problem is that the local 'struct kunit_assert' structure escapes to
an extern function call it is passed to by reference. If we inline
kunit_do_assertion(), nothing really changes in that regard as
the compiler still has to construct and initialize that structure on
the stack.

However, the reverse would be possible. Turning
KUNIT_BASE_BINARY_ASSERTION() into an extern
function that takes all the arguments without passing a
structure would solve it. I've prototyped this by changing
KUNIT_BINARY_EQ_ASSERTION() and
KUNIT_BINARY_NE_ASSERTION() like

@@ -651,13 +649,19 @@ do {
                                \
                                    fmt,                                       \
                                    ##__VA_ARGS__)

-#define KUNIT_BINARY_NE_ASSERTION(test, assert_type, left, right)             \
+#define __KUNIT_BINARY_NE_ASSERTION(test, assert_type, left, right)           \
        KUNIT_BINARY_NE_MSG_ASSERTION(test,                                    \
                                      assert_type,                             \
                                      left,                                    \
                                      right,                                   \
                                      NULL)

+static __maybe_unused noinline void KUNIT_BINARY_NE_ASSERTION(struct
kunit *test, int assert_type,
+                                       long long left, long long right)
+{
+       __KUNIT_BINARY_NE_ASSERTION(test, assert_type, left, right);
+}
+
 #define KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,
                \
                                          assert_type,                         \
                                          left,                                \


A little more work is needed to make the varargs and
code location passing all work correctly.

> > The idea of annotating it got me thinking about what could be
> > done to improve the structleak plugin, and that in turn got me on
> > the right track to a silly but trivial fix for the issue: The only thing
> > that structleak does here is to initialize the implied padding in
> > the kunit_binary_assert structure. If there is no padding, it all
> > works out find and the structures don't get pinned to the stack
> > because the plugin can simply ignore them.
> >
> > I tried out this patch and it works:
> >
> > diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> > index db6a0fca09b4..5b09439fa8ae 100644
> > --- a/include/kunit/assert.h
> > +++ b/include/kunit/assert.h
> > @@ -200,8 +200,9 @@ struct kunit_binary_assert {
> >         struct kunit_assert assert;
> >         const char *operation;
> >         const char *left_text;
> > -       long long left_value;
> >         const char *right_text;
> > +       long __pad;
> > +       long long left_value;
> >         long long right_value;
> >  };
> >
> > There may also be a problem in 'struct kunit_assert' depending on the
> > architecture, if there are any on which the 'enum kunit_assert_type'
> > type is 64 bit wide (which I think is allowed in C, but may not happen
> > on any toolchain that builds kernels).
> >
>
> What does the padding do? This is all magical!

It turned out to not work after all, The change above fixed some of the
cases I saw, but not others.

I'm still struggling to fully understand why the structleak gcc plugin
sometimes forces the structures on the stack and sometimes doesn't.
The idea for the patch above was to avoid implicit padding by making
the padding explicit. What happens with the implicit padding is that
the expanded macro containing code like

struct { const char *left_text; long long left_value; } assert =
    { .left_text  = # _left, .left_value =  _left };
func(&assert);

produces a partially initialized object on a 32-bit architecture, with the
padding between left_text and left_value being old stack data. The
structleak plugin forces this to be initialized to zero, which in turn
forces the structure to be allocated on the stack during the execution
of the function, not just within the surrounding basic block (this
is a known deficiency in structleak).

The theory so far made sense to me, except that as I said above the
padding alone did not fix the problem. :(

        Arnd
