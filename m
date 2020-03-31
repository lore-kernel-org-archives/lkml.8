Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EE6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E246E214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbgCaQyS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:54:18 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:39116 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgCaQyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:54:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1FE5E60A073D;
        Tue, 31 Mar 2020 18:54:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bCAazVMZJRqh; Tue, 31 Mar 2020 18:54:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0280B609D2F6;
        Tue, 31 Mar 2020 18:54:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 82ywUB7fjkiv; Tue, 31 Mar 2020 18:54:12 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D47F7609D2E2;
        Tue, 31 Mar 2020 18:54:12 +0200 (CEST)
Date:   Tue, 31 Mar 2020 18:54:12 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        davidgow <davidgow@google.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <418158403.63080.1585673652800.JavaMail.zimbra@nod.at>
In-Reply-To: <CAKFsvULjkQ7T6QhspHg87nnDpo-VW1qg2M3jJGB+NcwTQNeXGQ@mail.gmail.com>
References: <20200226004608.8128-1-trishalfonso@google.com> <CACT4Y+bdxmRmr57JO_k0whhnT2BqcSA=Jwa5M6=9wdyOryv6Ug@mail.gmail.com> <ded22d68e623d2663c96a0e1c81d660b9da747bc.camel@sipsolutions.net> <CACT4Y+YzM5bwvJ=yryrz1_y=uh=NX+2PNu4pLFaqQ2BMS39Fdg@mail.gmail.com> <2cee72779294550a3ad143146283745b5cccb5fc.camel@sipsolutions.net> <CACT4Y+YhwJK+F7Y7NaNpAwwWR-yZMfNevNp_gcBoZ+uMJRgsSA@mail.gmail.com> <a51643dbff58e16cc91f33273dbc95dded57d3e6.camel@sipsolutions.net> <CAKFsvULjkQ7T6QhspHg87nnDpo-VW1qg2M3jJGB+NcwTQNeXGQ@mail.gmail.com>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: add support for KASAN under x86_64
Thread-Index: PKJWQW+CVN2ItfoQyPENtJL8H3bmwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patricia,

----- Ursprüngliche Mail -----
> Von: "Patricia Alfonso" <trishalfonso@google.com>
> An: "Johannes Berg" <johannes@sipsolutions.net>
> CC: "Dmitry Vyukov" <dvyukov@google.com>, "Jeff Dike" <jdike@addtoit.com>, "richard" <richard@nod.at>, "anton ivanov"
> <anton.ivanov@cambridgegreys.com>, "Andrey Ryabinin" <aryabinin@virtuozzo.com>, "Brendan Higgins"
> <brendanhiggins@google.com>, "davidgow" <davidgow@google.com>, "linux-um" <linux-um@lists.infradead.org>,
> "linux-kernel" <linux-kernel@vger.kernel.org>, "kasan-dev" <kasan-dev@googlegroups.com>
> Gesendet: Dienstag, 31. März 2020 18:39:21
> Betreff: Re: [PATCH] UML: add support for KASAN under x86_64

> On Mon, Mar 30, 2020 at 1:41 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>>
>> On Mon, 2020-03-30 at 10:38 +0200, Dmitry Vyukov wrote:
>> > On Mon, Mar 30, 2020 at 9:44 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>> > > On Fri, 2020-03-20 at 16:18 +0100, Dmitry Vyukov wrote:
>> > > > > Wait ... Now you say 0x7fbfffc000, but that is almost fine? I think you
>> > > > > confused the values - because I see, on userspace, the following:
>> > > >
>> > > > Oh, sorry, I copy-pasted wrong number. I meant 0x7fff8000.
>> > >
>> > > Right, ok.
>> > >
>> > > > Then I would expect 0x1000 0000 0000 to work, but you say it doesn't...
>> > >
>> > > So it just occurred to me - as I was mentioning this whole thing to
>> > > Richard - that there's probably somewhere some check about whether some
>> > > space is userspace or not.
>> > >
> 
> Yeah, it seems the "Kernel panic - not syncing: Segfault with no mm",
> "Kernel mode fault at addr...", and "Kernel tried to access user
> memory at addr..." errors all come from segv() in
> arch/um/kernel/trap.c due to what I think is this type of check
> whether the address is
> in userspace or not.

Segfault with no mm means that a (not fixable) pagefault happened while
kernel code ran.

>> > > I'm beginning to think that we shouldn't just map this outside of the
>> > > kernel memory system, but properly treat it as part of the memory that's
>> > > inside. And also use KASAN_VMALLOC.
>> > >
>> > > We can probably still have it at 0x7fff8000, just need to make sure we
>> > > actually map it? I tried with vm_area_add_early() but it didn't really
>> > > work once you have vmalloc() stuff...
>> >
> 
> What x86 does when KASAN_VMALLOC is disabled is make all vmalloc
> region accesses succeed by default
> by using the early shadow memory to have completely unpoisoned and
> unpoisonable read-only pages for all of vmalloc (which includes
> modules). When KASAN_VMALLOC is enabled in x86, the shadow memory is not
> allocated for the vmalloc region at startup. New chunks of shadow
> memory are allocated and unpoisoned every time there's a vmalloc()
> call. A similar thing might have to be done here by mprotect()ing
> the vmalloc space as read only, unpoisoned without KASAN_VMALLOC. This
> issue here is that
> kasan_init runs so early in the process that the vmalloc region for
> uml is not setup yet.
> 
> 
>> > But we do mmap it, no? See kasan_init() -> kasan_map_memory() -> mmap.
>>
>> Of course. But I meant inside the UML PTE system. We end up *unmapping*
>> it when loading modules, because it overlaps vmalloc space, and then we
>> vfree() something again, and unmap it ... because of the overlap.
>>
>> And if it's *not* in the vmalloc area, then the kernel doesn't consider
>> it valid, and we seem to often just fault when trying to determine
>> whether it's valid kernel memory or not ... Though I'm not really sure I
>> understand the failure part of this case well yet.
>>
> 
> I have been testing this issue in a multitude of ways and have only
> been getting more confused. It's still very unclear where exactly the
> problem occurs, mostly because the errors I found most frequently were
> reported in segv(), but the stack traces never contained segv.
> 
> Does anyone know if/how UML determines if memory being accessed is
> kernel or user memory?

In contrast to classic x86, without KPTI and SMAP/SMEP, UML has a strong
separation between user- and kernel-memory. This is also why copy_from/to_user()
is so expensive.

In arch/um/kernel/trap.c segv() you can see the logic.
Also see UPT_IS_USER().

Thanks,
//richard
