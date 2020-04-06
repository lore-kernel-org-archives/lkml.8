Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE9EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945672078C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUr0f/B6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDFJMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:12:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39205 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgDFJMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:12:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so16476230wrt.6;
        Mon, 06 Apr 2020 02:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=glkaDM5M1FoM2GQRJ0fDDMF/MejHXymIl6X4UtEi45w=;
        b=hUr0f/B6PpAktI3a6eoaU1zTcfOcHxV89tvP0kcd8jZBbI7WT++ehVaWsh9HeIrZtG
         xuu1c3/b6aKj7y4S7ruK7DQjOBZcGxwIgUJkDaydRCD4JgcMvW7pfjXw4s3Oz2Eq68vi
         D+4DwMwsW86NI/dHuQZd5+25ZWJZ+ixQhGqrxnoHHCe1f50CodifbOg5k/bRpOry19D+
         UD54aw4U8pfdtQ9v+19UqvUIuiwE/k9t9yJf+y1TCqQ9raRJdYvMS8YLvj/yGs6K0ATk
         OUbnPJUY3mkDGNK0zDUt1BEQfxs5pFBDHSN553zkHXpVfbgg8WuxYWP3DL4Q0sCfiNbo
         LfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=glkaDM5M1FoM2GQRJ0fDDMF/MejHXymIl6X4UtEi45w=;
        b=fEPDOkpH585NibyKzLkQsQMM79nWQSLMvou6xqkcrtULgpgPqBkRWcp15ACi7g+W+P
         Qklbv+BvfY62XdBY+pDWfRV/gbX/diU9LpsCh/K5dmnMnGrV4POKcuKHVd7APqAWC7+4
         GtbioIomSl99vXGnSQ4nhefMTrwrNEY18FGcR0H8taonLRXBC+J+J3vX8mk6UdM2ud5m
         gg3AlaqzLW2h4fFhjmZRPxa4gKjWpOV7qr5Ry46LVN5tNzfsUJoT2hqjFtGxD4DZkH0e
         ryUwZjB8R8hi5e1wR/WM5Z0P1K25LZm6dqZA8rSgrzmIafz1baOMK8+3ov54XYND+30M
         IMuQ==
X-Gm-Message-State: AGi0PuZMXfmCWAPQ75I85tVflTsQvBI/K9p7P09wyq8vK3AfzHJ3c+ed
        5cBni40z5OzEPi3HXdzEbRKyckXvmEf59DNoECU=
X-Google-Smtp-Source: APiQypL24y4fJaGtGW9gRNAz9pUa7fkp7hOrxC5pazn4QZ+0m+JtSdUti/oau1CdKKN+mr2AASvDWC3HNFJREEErwpM=
X-Received: by 2002:adf:b64f:: with SMTP id i15mr3772042wre.351.1586164339736;
 Mon, 06 Apr 2020 02:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200403051709.22407-1-masahiroy@kernel.org> <CAKwvOdnaZ6qDVxaPY-GEH8pdUkzH6eqm16ok9_wzRSVRG-1kiQ@mail.gmail.com>
 <CAK7LNAQybfcYiosNU+ybd-Q7-Y2dbLqBVN2XA00wCRnFAoqdew@mail.gmail.com>
 <20200405235507.psjjhqa3cxw57xra@google.com> <CAK7LNAS_SQg2nhJ8HKBTq3+dziGpaJZ87fOBRS-ZMdUpKGhX9Q@mail.gmail.com>
In-Reply-To: <CAK7LNAS_SQg2nhJ8HKBTq3+dziGpaJZ87fOBRS-ZMdUpKGhX9Q@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 6 Apr 2020 11:12:39 +0200
Message-ID: <CA+icZUU5YmFJispXy8Ax7gzxv__LfFMwUX-cGO_kaNXv_RHO7w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: support 'LLVM' to switch the default tools to Clang/LLVM
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        Sandeep Patil <sspatil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 3:34 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Mon, Apr 6, 2020 at 8:55 AM 'Fangrui Song' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > On 2020-04-06, Masahiro Yamada wrote:
> > >On Sat, Apr 4, 2020 at 3:24 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >>
> > >> On Thu, Apr 2, 2020 at 10:17 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >> >
> > >> > As Documentation/kbuild/llvm.rst implies, building the kernel with a
> > >> > full set of LLVM tools gets very verbose and unwieldy.
> > >> >
> > >> > Provide a single switch 'LLVM' to use Clang and LLVM tools instead of
> > >> > GCC and Binutils. You can pass LLVM=1 from the command line or as an
> > >> > environment variable. Then, Kbuild will use LLVM toolchains in your
> > >> > PATH environment.
> > >> >
> > >> > Please note LLVM=1 does not turn on the LLVM integrated assembler.
> > >> > You need to explicitly pass AS=clang to use it. When the upstream
> > >> > kernel is ready for the integrated assembler, I think we can make
> > >> > it default.
> > >>
> > >> Having this behavior change over time may be surprising.  I'd rather
> > >> that if you want to not use the integrated assembler, you explicitly
> > >> negate it, or just don't use the LLVM=1 syntax, ie. `make CC=clang
> > >> LD=ld.lld ...`.
> > >>
> > >> We could modify how `-no-integrated-as` is chosen when LLVM=1.
> > >>
> > >> make LLVM=1 LLVMIA=0 ... # add `-no-integrated-as`
> > >> # what the flag is doesn't really matter to me, something shorter might be nice.
> > >> make LLVM=1 # use all LLVM tools
> > >>
> > >> Since we got rid of $(AS), it would be appropriate to remove/change it
> > >> there, since no one really relies on AS=clang right now. (We do have 1
> > >> of our 60+ CI targets using it, but we can also change that trivially.
> > >> So I think we have a lot of freedom to change how `-no-integrated-as`
> > >> is set.
> > >>
> > >> This could even be independent of this patch.
> > >
> > >
> > >I also thought a boolean flag is preferred.
> > >
> > >AS=clang will not live long anyway, and
> > >I hesitated to break the compatibility
> > >for the short-term workaround.
> > >
> > >But, if this is not a big deal, I can
> > >replace AS=clang with LLVMIA=1.
> >
> > My mere complaint is that it may be difficult to infer the intention (integrated
> > assembler) from the abbreviation "IA" in "LLVMIA" :/
> >
> > Something with "AS" in the name may be easier for a user to understand,
> > e.g. CLANG_AS or LLVM_AS.
>
>
>
>
> I see 'llvm-as' in my PATH,
> but it is a different kind of tool, right?
> (converter from LLVM assembler *.ll to LLVM bit code *.bc)
>
> So, I thought "LLVM_AS" might be confusing.
>

Indeed LLVM_AS is confusing as llvm-as is different to Clang's
integrated assembler.
So CLANG_AS might be a better choice.

- sed@ -
