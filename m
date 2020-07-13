Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF095C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80672072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgGMNji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:39:38 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgGMNjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:39:37 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MQMm9-1kHCWV3S41-00MO5Z for <linux-kernel@vger.kernel.org>; Mon, 13 Jul
 2020 15:39:35 +0200
Received: by mail-qk1-f175.google.com with SMTP id j80so12157196qke.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:39:34 -0700 (PDT)
X-Gm-Message-State: AOAM533IcVcLNylWekDpVKohDpFN/QLijlpmoWjrIBpg5od6GqyCiCSs
        NaObZY9IS8VDs+N8zS8GkCPrvIVEdfJgQNrpQ9g=
X-Google-Smtp-Source: ABdhPJzfiwDCHgeYTkt5foitnFc860ymMpHNCokxIcJPPtYh0CrCPgy2bxPWy+GF+LiLIUCC1Q4dAKJhcUbnuERUk2o=
X-Received: by 2002:a37:9dd6:: with SMTP id g205mr83870943qke.352.1594647573631;
 Mon, 13 Jul 2020 06:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200711035544.2832154-1-palmer@dabbelt.com> <20200711035544.2832154-2-palmer@dabbelt.com>
 <20200713130632.GA29945@infradead.org>
In-Reply-To: <20200713130632.GA29945@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 13 Jul 2020 15:39:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0F4JSBAG5B=GRFF9Aw0kJaNd=cph86sHqjAtiONUA-Bw@mail.gmail.com>
Message-ID: <CAK8P3a0F4JSBAG5B=GRFF9Aw0kJaNd=cph86sHqjAtiONUA-Bw@mail.gmail.com>
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
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
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
X-Provags-ID: V03:K1:oxU1cV6FwqLVk2fXTkWLY2AfzLyy0LVrcqY5B2g8XUCXXLTKtVf
 XoQGKzhEGoEiKt0KDDm1Qvr9hymFY4LtmcYotJr+WXU7Sa+VLavWQpSpjARt5o0GjOiYC04
 gwSa0e9anfI7sXPqo0IrZpUN6U0I9MvHU6AEjQU9qNQbzjTmXN4foXg99TAjKeY0dU7yceD
 hxIAx7lZf4eOAwEwSSKqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9wCn35EnpVM=:2yVHzqxcr8AHjqFyJiMXFY
 S0Z68ewSeF5U3G+bOiALe/gUrW5s7CRTLbMfTBE8HOonUP4KY8pw5TSYta0vVttOUs4Jm7Yt/
 w8ghsrcYwFQBd7ZgPylQWOtv10rbxf62MIziEly36ekyph5fd9pwDJZ+0eBrILoStims4Lsc6
 W8NntnDkBNUobGgLmP7Bo2l9KzRt4/oLoC6am2BJ2qqfc0fe8zaYH3VMNZB2uWH+84mdFmhbB
 T/c2xGGv72YlxKERH8q6SQTHP8QOUmHKz0MZfktU8esvwLJvSkVP2yVC8p8kt4Ax5JYaogjOt
 +l64BaAs73dKz0PXGevpFXdMsYrCu+1P/Yv2c8cOQoPce8wj3tjsSDy8xQTGZhVtJJpBVhdHc
 4PbmXLaKLYjMFo8neGRJiaHVf/N17WNvOXyKaLCGGmjqRnFg3sgkJub74d+1kQ7Dhj3ipv9k5
 UfhvhfNWL1WgrkzKDVL2arV+fKuA8GfuRnxBYHr/654Im3Miaivj7hPO/Q5qP0zQTrVZOYCJP
 XafR++4Nu7YaqGjfIcTX4AWaKYSiH51qJG8u5MM06Lsa9nG/C/3gwBbZCzExkClNXj02dZ5Za
 1pzIZW5gEAoMiqBmIQ8oZVX+9P1d9Ntxf96fBeoiLs9D/Nahxcs1mhFj7hHG9dxEx+DkCKRKn
 p3UHAx4E3gDo6yHalwX0XI97MBS5O9JbkzePJpL1yoDM4EudddihJyC/VE+btQYDOW2xv/oGr
 ZqNeXjN570Cnr0degAODiTrtm+Hg/It7gamM6eZOdL64E1HWtfFR8oWivf4tKkEo5h7GmVlA9
 awXUiQ9j18dRh/Ljo2Raim3YrD3zAC75x5mDMEXz34dvAFU14c5vE5dDZ8nwroVPi/y/HGc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 3:07 PM Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Jul 10, 2020 at 08:55:42PM -0700, Palmer Dabbelt wrote:
> > +ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> > +                      size_t csize, unsigned long offset,
> > +                      int userbuf)
> > +{
> > +     void *vaddr;
> > +
> > +     if (!csize)
> > +             return 0;
> > +
> > +     vaddr = memremap(__pfn_to_phys(pfn), PAGE_SIZE, MEMREMAP_WB);
> > +     if (!vaddr)
> > +             return -ENOMEM;
>
> Doing a memremap for every page is very inefficient.  Also I don't see
> why you'd want to even do that.  All memory is in the direct mapping
> for RISC-V.  For other architecture that support highmem kmap_atomic_pfn
> would do the job, which is what I'd use in a generic version.

I would expect the 'oldmem' data to not have a 'struct page', which would
be a problem at least for the generic implementation of kmap_atomic_pfn()

include/linux/highmem.h:#define kmap_atomic_pfn(pfn)
kmap_atomic(pfn_to_page(pfn))

kmap_atomic() might still work with a bogus page pointer if it
only transforms it back into a pfn, but some implementations just
have this one that cannot work:
static inline void *page_address(const struct page *page)
{
        return page->virtual;
}

I have not checked how the crash dump code works though, maybe
it does work after all.

       Arnd
