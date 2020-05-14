Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19C9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D6420728
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgENPdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:33:02 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:32861 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgENPdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:33:02 -0400
Received: from mail-qv1-f53.google.com ([209.85.219.53]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MILru-1jKvyZ0hhU-00ELvP for <linux-kernel@vger.kernel.org>; Thu, 14 May
 2020 17:32:59 +0200
Received: by mail-qv1-f53.google.com with SMTP id x13so1884352qvr.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:32:59 -0700 (PDT)
X-Gm-Message-State: AOAM530oMiWovw/zG2dnGRGj5umOOubwUiv7uWSyl1Gtww5Ic8Jx1eBq
        IbTpuUklU7ERh6MM+/j4uSqRiYzyQE+olBA0Gew=
X-Google-Smtp-Source: ABdhPJzFhU3uR60qV+NCsNONeIzKaCGCy5L57CVbEj8kxjwZrZF3EKTRXtmeZ6RSyPcjRbe5um5gPB2eFj40u3fiQBo=
X-Received: by 2002:a0c:a90f:: with SMTP id y15mr4980431qva.211.1589470378043;
 Thu, 14 May 2020 08:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200503145017.GA5074@afzalpc> <CAK8P3a3OC5UO72rTDWi6+XgmExJmkATEjscq8hns8Bng06OpcQ@mail.gmail.com>
 <20200504091018.GA24897@afzalpc> <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc> <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc> <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc> <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc>
In-Reply-To: <20200514133545.GA5020@afzalpc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 May 2020 17:32:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
Message-ID: <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
Subject: Re: ARM: static kernel in vmalloc space
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:4fxc/UVpnaKBQJBpwHk/bflybyubC2cfteXp6NhQtFwwSPlb3o0
 jR0RdF6DXSh9I8/MPT59BH0yvM9Np7bY4Far/gZu3jpVaXh8QizVzC59LgCkVTALKsGux9I
 sLhPYBB83+e8sb3EVd3u/lcSWhIZAINv8OEbYhUswL24qwfCN5o5N/28ScD3yd/SA0tgsoK
 CLEMqNtIHHh+LBnqqr/XA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Pd7Gi3bvu4=:j3GymoGjwRuLRHiLNLMHrt
 42xoIK1b8pk/8JADgsGA594GcwFlNzbUbdxbL5VwnSEbCLaxVTu0FWQZLCuBq6vJU88eC1JFT
 wz55ShIWp2GTpQWq/98ipoQ5NBNcXOydOYVk2R6gac3kY7wnNTEx+kQ8j2mMuqHkDlXCrTEwt
 c9kSgdz3DhieyVGR2pCS9MUJILm+CuoXthBuXikZirN2SvnyOfgpBkLpTfgV+/G1UV5nny15L
 duejdm/YOqtK2mGWaYz8IZHNUbc0LH6E/3Qq9txp2qp8Z4DzjRgGAj/TnxRx2cHuP+OLkuRLs
 XVqT0We+dbxbkyenvS6DNMKXrC9YoqpnecX2lfixdTxtifOfcSc6sSJ25PwbDZwmVjko6HU3c
 ZOWEYpJ/zj7GE8gic6zU5ammOMbyMXI/qErRv+h9SqhAzXStpy9qQ4lTRx1QYXwGEuIAcjh5l
 OCVkPN8LvuD+/986p/06WjcVVrpAzgueGazBBqu/vVlAnCKhC/3rHgS8YswlEjOW8y1tBoKQy
 74BSvmTh+k+zf4lFwfvI7CXBMakXBfZWXrD5Bl2bgLopZvJFeVJzOzpVrnu7Zt61Fkv56/uAs
 FWuKvBhHQjnd5A3/ct8TK3ng1knCPC1XBlNjU98FdietvyYoCSRUU82UIEAWWUVrzKsEu642Y
 0e2OL0AzQF8soOpERMj+1nAhTxCSUHs0vSfKciPIfPwPFdkGky3TYTYARS/AR4EBybRe7hOS2
 a/z43CBPEFZtPion2Vx7w9cJ6lkRM0HYe2NSpbZuTNXFJVfVxy9sB72kkJzMIMaXuRiYtXFPB
 qSMN8m5hMfzd9UmIif29sI/95vJjN2hj+cVir/qC9tcvY4bTKY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 3:35 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> On Thu, May 14, 2020 at 02:41:11PM +0200, Arnd Bergmann wrote:
> > On Thu, May 14, 2020 at 1:18 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> > > 4. for user space to/from copy
> > >  a. pin user pages
> > >  b. kmap user page (can't corresponding lowmem be used instead ?)
>
> > - In the long run, there is no need for kmap()/kmap_atomic() after
> >   highmem gets removed from the kernel, but for the next few years
> >   we should still assume that highmem can be used, in order to support
> >   systems like the 8GB highbank, armadaxp, keystone2 or virtual
> >   machines. For lowmem pages (i.e. all pages when highmem is
> >   disabled), kmap_atomic() falls back to page_address() anyway,
> >   so there is no much overhead.
>
> Here i have some confusion - iiuc, VMSPLIT_4G_4G is meant to help
> platforms having RAM > 768M and <= 4GB disable high memory and still
> be able to access full RAM, so high memory shouldn't come into picture,
> right ?. And for the above platforms it can continue current VMPSLIT
> option (the default 3G/1G), no ?, as VMSPLIT_4G_4G can't help complete
> 8G to be accessible from lowmem.
>
> So if we make VMSPLIT_4G_4G, depends on !HIGH_MEMORY (w/ mention of
> caveat in Kconfig help that this is meant for platforms w/ <=4GB), then
> we can do copy_{from,to}_user the same way currently do, and no need to
> do the user page pinning & kmap, right ?

No, that doesn't work: the current copy_from_user() relies on the user
address space being a subset of the kernel address space, so it doesn't
have to walk the page tables but just access the pointer and use
the .text.fixup/__ex_table trick to trap any accesses to pages with the
wrong permission or no backing.

> ...
> i think user page pinning is still required, but kmap can be avoided
> by using lowmem corresponding to that page, right ?, or am i
> completely wrong ?

As long as one does not actually use highmem on a particular
machine, kmap_atomic() is much cheaper than the get_user_pages()
that is needed anyway:

static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
{
        preempt_disable();
        pagefault_disable();
        if (!PageHighMem(page))
                return page_address(page);
        return kmap_atomic_high_prot(page, prot);
}
#define kmap_atomic(page)       kmap_atomic_prot(page, kmap_prot)

The preempt_disable()/pagefault_disable() are just adding to
variables that are usually on the local L1 cache, and the
page_address() is another multiply+add that you need in any
case. In kernels that disable highmem, the expensive code path
(kmap_atomic_high_prot) goes away entirely.

As a micro-optimization, one could use page_address() directly
instead of kmap_atomic() when highmem is disabled, but
I doubt it makes much of a difference.

> Only problem i see is Kernel compiled w/ VMSPLIT_4G_4G not suitable
> for >4GB machines, but anyway iiuc, it is was not meant for those
> machines. And it is not going to affect our current multiplatform
> setup as LPAE is not defined in multi_v7.

That was what I original thought as well, but I'd now prefer to
allow highmem to coexist with vmsplit-4g-4g:

Typical distros currently offer two kernels, with and without LPAE,
and they probably don't want to add a third one for LPAE with
either highmem or vmsplit-4g-4g. Having extra user address
space and more lowmem is both going to help users that
still have 8GB configurations.

If we want to limit the number of combinations, I'd prefer making
vmsplit-4g-4g mandatory for all LPAE kernels and it is stable
enough.

       Arnd
