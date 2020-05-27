Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FB5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD4C20DD4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590564177;
	bh=1aq3yZzokjVj+RoQhhhzUgjY0nXbOLSSfK8XA7fR4Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1PnjU26iWjPFJSlsvQXF0jTcxcAgZZ6rO5D9M5X/XO9ceQW6FmfUwmvD5Pxu/0Rt1
	 +blFEG4co+R2eJ3mO0ruTfT+4Fk/AMjM/+69f6qMhxEu6yqDVUZxWqs+Vqj50F/Fir
	 ApGS96L2xcduJKpQcZeaV2YYoynKykAa3lSEYYew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgE0HW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbgE0HW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:22:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F96B20C56;
        Wed, 27 May 2020 07:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590564175;
        bh=1aq3yZzokjVj+RoQhhhzUgjY0nXbOLSSfK8XA7fR4Do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjMYLITu4AH/Co3BABCLGX1qgQBoQdNzHH36mQeMM6h79+RSteQzen2+qpGHf+rXr
         Qpn8iIKkzrId+/F1cUN1RdeBjuqFB/mEDB98+afZLXWFAybb/SGvcx6dt0nqsxbsp8
         8TTzh3dX8FNL9lfvsJB9dXUGijtMCz9CUTs2bKEo=
Date:   Wed, 27 May 2020 08:22:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH -tip v3 09/11] data_race: Avoid nested statement
 expression
Message-ID: <20200527072248.GA9887@willie-the-truck>
References: <20200521142047.169334-1-elver@google.com>
 <20200521142047.169334-10-elver@google.com>
 <CAKwvOdnR7BXw_jYS5PFTuUamcwprEnZ358qhOxSu6wSSSJhxOA@mail.gmail.com>
 <CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com>
 <20200526120245.GB27166@willie-the-truck>
 <CAK8P3a29BNwvdN1YNzoN966BF4z1QiSxdRXTP+BzhM9H07LoYQ@mail.gmail.com>
 <CANpmjNOUdr2UG3F45=JaDa0zLwJ5ukPc1MMKujQtmYSmQnjcXg@mail.gmail.com>
 <20200526173312.GA30240@google.com>
 <CAK8P3a3ZawPnzmzx4q58--M1h=v4X-1GtQLiwL1=G6rDK8=Wpg@mail.gmail.com>
 <CAK8P3a3UYQeXhiufUevz=rwe09WM_vSTCd9W+KvJHJcOeQyWVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3UYQeXhiufUevz=rwe09WM_vSTCd9W+KvJHJcOeQyWVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 01:10:00AM +0200, Arnd Bergmann wrote:
> On Tue, May 26, 2020 at 9:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, May 26, 2020 at 7:33 PM 'Marco Elver' via Clang Built Linux
> > <clang-built-linux@googlegroups.com> wrote:
> > > On Tue, 26 May 2020, Marco Elver wrote:
> > > > On Tue, 26 May 2020 at 14:19, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > Note that an 'allyesconfig' selects KASAN and not KCSAN by default.
> > > > But I think that's not relevant, since KCSAN-specific code was removed
> > > > from ONCEs. In general though, it is entirely expected that we have a
> > > > bit longer compile times when we have the instrumentation passes
> > > > enabled.
> > > >
> > > > But as you pointed out, that's irrelevant, and the significant
> > > > overhead is from parsing and pre-processing. FWIW, we can probably
> > > > optimize Clang itself a bit:
> > > > https://github.com/ClangBuiltLinux/linux/issues/1032#issuecomment-633712667
> > >
> > > Found that optimizing __unqual_scalar_typeof makes a noticeable
> > > difference. We could use C11's _Generic if the compiler supports it (and
> > > all supported versions of Clang certainly do).
> > >
> > > Could you verify if the below patch improves compile-times for you? E.g.
> > > on fs/ocfs2/journal.c I was able to get ~40% compile-time speedup.
> >
> > Yes, that brings both the preprocessed size and the time to preprocess it
> > with clang-11 back to where it is in mainline, and close to the speed with
> > gcc-10 for this particular file.
> >
> > I also cross-checked with gcc-4.9 and gcc-10 and found that they do see
> > the same increase in the preprocessor output, but it makes little difference
> > for preprocessing performance on gcc.
> 
> Just for reference, I've tested this against a patch I made that completely
> shortcuts READ_ONCE() on anything but alpha (which needs the
> read_barrier_depends()):
> 
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -224,18 +224,21 @@ void ftrace_likely_update(struct
> ftrace_likely_data *f, int val,
>   * atomicity or dependency ordering guarantees. Note that this may result
>   * in tears!
>   */
> -#define __READ_ONCE(x) (*(const volatile __unqual_scalar_typeof(x) *)&(x))
> +#define __READ_ONCE(x) (*(const volatile typeof(x) *)&(x))
> 
> +#ifdef CONFIG_ALPHA /* smp_read_barrier_depends is a NOP otherwise */
>  #define __READ_ONCE_SCALAR(x)                                          \
>  ({                                                                     \
>         __unqual_scalar_typeof(x) __x = __READ_ONCE(x);                 \
>         smp_read_barrier_depends();                                     \
> -       (typeof(x))__x;                                                 \
> +       __x;                                                            \
>  })
> +#else
> +#define __READ_ONCE_SCALAR(x) __READ_ONCE(x)
> +#endif

Nice! FWIW, I'm planning to have Alpha override __READ_ONCE_SCALAR()
eventually, so that smp_read_barrier_depends() can disappear forever. I
just bit off more than I can chew for 5.8 :(

However, '__unqual_scalar_typeof()' is still useful for
load-acquire/store-release on arm64, so we still need a better solution to
the build-time regression imo. I'm not fond of picking random C11 features
to accomplish that, but I also don't have any better ideas...

Is there any mileage in the clever trick from Rasmus?

https://lore.kernel.org/r/6cbc8ae1-8eb1-a5a0-a584-2081fca1c4aa@rasmusvillemoes.dk

Will
