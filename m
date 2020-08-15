Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB755C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982E22311C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LMUYZSyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgHOVqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgHOVpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:45:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C97BC03D1CF
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 14:28:58 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i10so641460pgk.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDB2cu8uvw5o4FJBQyga65heRe+0KnSxhoCkr4blEbk=;
        b=LMUYZSyi+6Ij3c4IGwpY9C3syOogfNop3DuOh5j4l3mEUI0iD5lnQTNegoHqPJbDwi
         k4Hu60HVmy/WjAS9njUGjZ2BRBWRDlAh6wLOuo5fKx/Uy0xd4IAUVx2t3LvlBG/UAAfJ
         T8fPzNqKy0WDJ+39RxYjx79SLJGdG9ZRxXB8qxUl67GNMAujG4oQgXfbf6m5+tlVCV7j
         yFDHJSk75k9zrc9O9bmHkTNETm5ql/1rN1V2LxRJzp+GlQs1BnQcM1BQf1Py5gZ71rW+
         78uQEQv3doEuu4pBNdzgCl8oSl1sHt5o1I0xIMEaA76DlTrJo3pQrRwc2S4Jfo7T05Ud
         BuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDB2cu8uvw5o4FJBQyga65heRe+0KnSxhoCkr4blEbk=;
        b=AlQL7IpYXk5FlooDvf3hCOGE+AWp4Rc8w9Y/CiX69vbiT/FKRwkyREQgsRI/ChQtzo
         6gIpLDb+Ie5cICH7adgHk12f5mQMO3Y2c5SdTv4LS5yhcZ3eEk9dNfWgrrS9LPiea1Qx
         8z06XOM9JooFAvfp6iSZjsjNTKGXuCD8jk7vu6jQKaUfGN8knQTBb2uRG8LC5c4KBTPB
         pxCBCm7LFMfaZQzLpk/8OxXPwryzsYaTuTUKI4wXFj4CTC8uIXTxzXkwfSy2wcc7P0AA
         NBDAdb+7PQNCg/v7g+e5tL2svhLyNRH+pRwTfCET1vNeAESHjbNrz9fE0+b/s81oKkrL
         qRVg==
X-Gm-Message-State: AOAM530NhvG0YzLvsRuTZXol+MEyiOyqtoICms12I1Vxy0PuTtSs5+IN
        Ev7Vn1Lh1dIpbE8Sj0qebtBEGeqBze6LK6B5a1+TIQ==
X-Google-Smtp-Source: ABdhPJwGiLda6VueXOHB1PGNMKpexOYerFArFSN25ggacJ5cSHMqAlXCj+LSomXWh3kxgUb+FFN6EOTnhGBqohq/8Dk=
X-Received: by 2002:a63:7d8:: with SMTP id 207mr5780004pgh.263.1597526937591;
 Sat, 15 Aug 2020 14:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200815014006.GB99152@rani.riverdale.lan> <20200815020946.1538085-1-ndesaulniers@google.com>
 <202008150921.B70721A359@keescook> <CAKwvOdnyHfx6ayqEoOr3pb_ibKBAG9vj31LuKE+f712W=7LFKA@mail.gmail.com>
 <457a91183581509abfa00575d0392be543acbe07.camel@perches.com>
In-Reply-To: <457a91183581509abfa00575d0392be543acbe07.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sat, 15 Aug 2020 14:28:46 -0700
Message-ID: <CAKwvOdk4PRi45MXCtg4kmeN6c1AK5w9EJ1XFBJ5GyUjwEtRj1g@mail.gmail.com>
Subject: Re: [PATCH v2] lib/string.c: implement stpcpy
To:     Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>, Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 2:24 PM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2020-08-15 at 13:47 -0700, Nick Desaulniers wrote:
> > On Sat, Aug 15, 2020 at 9:34 AM Kees Cook <keescook@chromium.org> wrote:
> > > On Fri, Aug 14, 2020 at 07:09:44PM -0700, Nick Desaulniers wrote:
> > > > LLVM implemented a recent "libcall optimization" that lowers calls to
> > > > `sprintf(dest, "%s", str)` where the return value is used to
> > > > `stpcpy(dest, str) - dest`. This generally avoids the machinery involved
> > > > in parsing format strings.  Calling `sprintf` with overlapping arguments
> > > > was clarified in ISO C99 and POSIX.1-2001 to be undefined behavior.
> > > >
> > > > `stpcpy` is just like `strcpy` except it returns the pointer to the new
> > > > tail of `dest`. This allows you to chain multiple calls to `stpcpy` in
> > > > one statement.
> > >
> > > O_O What?
> > >
> > > No; this is a _terrible_ API: there is no bounds checking, there are no
> > > buffer sizes. Anything using the example sprintf() pattern is _already_
> > > wrong and must be removed from the kernel. (Yes, I realize that the
> > > kernel is *filled* with this bad assumption that "I'll never write more
> > > than PAGE_SIZE bytes to this buffer", but that's both theoretically
> > > wrong ("640k is enough for anybody") and has been known to be wrong in
> > > practice too (e.g. when suddenly your writing routine is reachable by
> > > splice(2) and you may not have a PAGE_SIZE buffer).
> > >
> > > But we cannot _add_ another dangerous string API. We're already in a
> > > terrible mess trying to remove strcpy[1], strlcpy[2], and strncpy[3]. This
> > > needs to be addressed up by removing the unbounded sprintf() uses. (And
> > > to do so without introducing bugs related to using snprintf() when
> > > scnprintf() is expected[4].)
> >
> > Well, everything (-next, mainline, stable) is broken right now (with
> > ToT Clang) without providing this symbol.  I'm not going to go clean
> > the entire kernel's use of sprintf to get our CI back to being green.
>
> Maybe this should get place in compiler-clang.h so it isn't
> generic and public.

https://bugs.llvm.org/show_bug.cgi?id=47162#c7 and
https://bugs.llvm.org/show_bug.cgi?id=47144
Seem to imply that Clang is not the only compiler that can lower a
sequence of libcalls to stpcpy.  Do we want to wait until we have a
fire drill w/ GCC to move such an implementation from
include/linux/compiler-clang.h back in to lib/string.c?

>
> Something like:
>
> ---
>  include/linux/compiler-clang.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index cee0c728d39a..6279f1904e39 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -61,3 +61,30 @@
>  #if __has_feature(shadow_call_stack)
>  # define __noscs       __attribute__((__no_sanitize__("shadow-call-stack")))
>  #endif
> +
> +#ifndef __HAVE_ARCH_STPCPY
> +/**
> + * stpcpy - copy a string from src to dest returning a pointer to the new end
> + *          of dest, including src's NULL terminator. May overrun dest.
> + * @dest: pointer to buffer being copied into.
> + *        Must be large enough to receive copy.
> + * @src: pointer to the beginning of string being copied from.
> + *       Must not overlap dest.
> + *
> + * This function exists _only_ to support clang's possible conversion of
> + * sprintf calls to stpcpy.
> + *
> + * stpcpy differs from strcpy in two key ways:
> + * 1. inputs must not overlap.
> + * 2. return value is dest's NUL termination character after copy.
> + *    (for strcpy, the return value is a pointer to src)
> + */
> +
> +static inline char *stpcpy(char __restrict *dest, const char __restrict *src)
> +{
> +       while ((*dest++ = *src++) != '\0') {
> +               ;       /* nothing */
> +       }
> +       return --dest;
> +}
> +#endif
>
>


-- 
Thanks,
~Nick Desaulniers
