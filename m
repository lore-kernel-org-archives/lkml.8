Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A01FC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7839522201
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgGNLi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:38:58 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56845 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgGNLiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:38:54 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MiagR-1kXvwq33Zf-00fi3t for <linux-kernel@vger.kernel.org>; Tue, 14 Jul
 2020 13:38:51 +0200
Received: by mail-qt1-f170.google.com with SMTP id e12so12449305qtr.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:38:51 -0700 (PDT)
X-Gm-Message-State: AOAM530DEuxulI3a9zzNeLwgdaKv+dHaUObPQ/oSTTO7QqGdE7fCOllU
        XIdJFAtaVRIZMGT2rLJxZn6u2ZxQdi1QDC3V+ko=
X-Google-Smtp-Source: ABdhPJyFjloVdWL5jLo3wyeFmexBh1mXWt1AZPEWS1RiOfnRkATYWBbKic8D8zZyvKZOoNe2ZbcLezwA1um2pe10fnA=
X-Received: by 2002:ac8:4ccb:: with SMTP id l11mr4063189qtv.18.1594726730621;
 Tue, 14 Jul 2020 04:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200711035544.2832154-1-palmer@dabbelt.com> <20200711035544.2832154-2-palmer@dabbelt.com>
 <20200713130632.GA29945@infradead.org> <CAK8P3a0F4JSBAG5B=GRFF9Aw0kJaNd=cph86sHqjAtiONUA-Bw@mail.gmail.com>
 <20200714110549.GA22613@infradead.org>
In-Reply-To: <20200714110549.GA22613@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Jul 2020 13:38:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0VEsshmF0d9AhRurME8Jca5MxG3eAsvXYmwfexMrutLg@mail.gmail.com>
Message-ID: <CAK8P3a0VEsshmF0d9AhRurME8Jca5MxG3eAsvXYmwfexMrutLg@mail.gmail.com>
Subject: Re: [PATCH 1/3] lib: Add a generic copy_oldmem_page()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Mark Rutland <mark.rutland@arm.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Uwe Kleine-K??nig" <uwe@kleine-koenig.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>,
        Petr Mladek <pmladek@suse.com>, zaslonko@linux.ibm.com,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        David Gow <davidgow@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xTSe9ZnQH+hN5QBL1xtuZR/mvbjHEgz1GcNtYWBs0BJ7uGndA/0
 jk4BDkb4H4OR3xc7y4itgU7TB/hHVN+nhITZ5BY3271w36JKrxWnhcEW4cWlcM4VC1lxkz+
 lwFc3t9YKzTt1FyOJBWc+CqQGYVNHLl80y2hvdWRqlfi9/wKiDpcdMuNSjqhL1yLkxYb0ut
 M8uwZsQ9U/U027xzQf3BA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YVeQ19yVhMU=:VP0j4YRuvsGfc4uFIXX6pY
 EAQ6HosxpPft81Gg4D2QxCQkfj162rwmWFKFAqTZbpGIUIR89eqE4rMY2tRrXdIJ2SdChdWKp
 zY7VUA+moJ2U0BjQmYdbLW4TcDPKtDmBrTv0a5LaOHBO2ErDjSrByeduUMD152mqgRTnk1VSZ
 H6VTEAVCLq5ctqjz8uyyXqZWTJEyDYxbzaTae2khRa+3dSGgFSbxAQdAsUOOwGYiuG1+yYLRm
 n+JFbsvqWMEYXx446dhK2M/vFGyNXS7trzVHOHM+yKmzY8tjt2CQ6DAi67IW9lT4zMhPPjEfp
 O0s/y6OJ01SRztS7RxGH2NC2EzBjnFmDsI9JYV/PhVJo+PjURrM4AeSQW4F+tnyT2fftUhMgq
 RqPQIheOwCjXvMNMz1ttrqjnK2vikcXUKrug5O6SnebctlfthHzsaJuE9/WfjUjRCUdg5k3j3
 DUUMyz0EciFTE2jKpqv94tM9EljVw3scZJ6TVqH3eDJqLKHQY3DrWbgXxR8gdKATYmsRER1sK
 y0AijqFozUW81bwg1LVyZ3pThsB8xHnxbj0FfjNWB/3lLAfNxoJBjehGGBUQXStwnS9GrXJsT
 E6ygE+xXxsqKcEuLqyaVh6OPUdk8al+BIoT1AJ1E/5Kb36smObaJAueXI+MWtLHEDWdFYDLHc
 VCfEnyDnLnvh27ObjH3nF1eLwrU/1RHucBXMCLLwHv08JkqfqqygaQhgdSHX2QLVCn34sG+j6
 ZWPRkq8PpI7Ws0AEcJCgR9eXaD6CLFQpp+ScFS6nl9Xg4TYDxCHYMSYKEYm3N8stTZJJU68xl
 Z7XHRvsVMr2yoh23fLb9feNOB4ZdlBf9ax8/j9PqWYkIWvLvNkjrPOxWMB6+XZooxK+iW49+/
 8StSi/cLwh6+XPo9wDHD3o1JuP2Fetj6t0/uPCrQYBdempplJNOjotUdRdmwNawCe+XUwzA54
 uhzovxkQyw34VPaH9CtUxPmUKr+dv5OtNf6WIelcsQw5sqLPZxjik
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 1:06 PM Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jul 13, 2020 at 03:39:17PM +0200, Arnd Bergmann wrote:
> > On Mon, Jul 13, 2020 at 3:07 PM Christoph Hellwig <hch@infradead.org> wrote:
> > > On Fri, Jul 10, 2020 at 08:55:42PM -0700, Palmer Dabbelt wrote:
> > > > +ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> > > > +                      size_t csize, unsigned long offset,
> > > > +                      int userbuf)
> > > > +{
> > > > +     void *vaddr;
> > > > +
> > > > +     if (!csize)
> > > > +             return 0;
> > > > +
> > > > +     vaddr = memremap(__pfn_to_phys(pfn), PAGE_SIZE, MEMREMAP_WB);
> > > > +     if (!vaddr)
> > > > +             return -ENOMEM;
> > >
> > > Doing a memremap for every page is very inefficient.  Also I don't see
> > > why you'd want to even do that.  All memory is in the direct mapping
> > > for RISC-V.  For other architecture that support highmem kmap_atomic_pfn
> > > would do the job, which is what I'd use in a generic version.
> >
> > I would expect the 'oldmem' data to not have a 'struct page', which would
> > be a problem at least for the generic implementation of kmap_atomic_pfn()
>
> Why do you expect it to not have a struct page?

I was under the impression that the kdump kernel only accesses a small
amount of memory itself and would allocate its mem_map to fit that but
not pages of that were used by the kernel it is dumping.

       Arnd
