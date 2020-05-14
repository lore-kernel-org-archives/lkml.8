Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55881C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 368F12065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgENMla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:41:30 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:36289 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgENMl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:41:29 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M8QFi-1jUnKC0hE0-004Q2e for <linux-kernel@vger.kernel.org>; Thu, 14 May
 2020 14:41:28 +0200
Received: by mail-qv1-f52.google.com with SMTP id p4so681937qvr.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:41:27 -0700 (PDT)
X-Gm-Message-State: AOAM532U6SskE86F21vLNtiAOMuJlMMeummTGQLlYU4zjC1BsC9Zepdv
        /zegRq+UGp5f7dDy4s8IRuWMgVz4C7QNnWoNxoU=
X-Google-Smtp-Source: ABdhPJyJLN74A7lfT/QVAu4V7wp3auPjIATgvDUXKW2U6GfQBe3NIdRtROls/MudNYNcGImA8MxrKcbv83h7QK20dFQ=
X-Received: by 2002:a05:6214:3f0:: with SMTP id cf16mr4728066qvb.4.1589460087044;
 Thu, 14 May 2020 05:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0JW9x-Wk9Ec3+zLjPHbWAvPQx8MF-xe-PnWUgEjRAuTg@mail.gmail.com>
 <20200415135407.GA6553@afzalpc> <20200503145017.GA5074@afzalpc>
 <CAK8P3a3OC5UO72rTDWi6+XgmExJmkATEjscq8hns8Bng06OpcQ@mail.gmail.com>
 <20200504091018.GA24897@afzalpc> <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc> <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc> <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc>
In-Reply-To: <20200514111755.GA4997@afzalpc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 May 2020 14:41:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
Message-ID: <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
Subject: Re: ARM: static kernel in vmalloc space
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5PAYyNPTDoJsJjFT2lWzq1NWr00oVsU1aiCUVWap0SfaPLypCBL
 QF30qR1iV3ZAQ5085odIY4ScuVeuSsg22OBvhJvToEszyID6Fd9k6m1UP1eCI2ldn297Eju
 TG//k0sT4x3bJpYcDmbCgt885ys9UoTmlqrRu9NOKnv+CjdnKgwSz0T4+vFFZRfd8+GTkAI
 jcNmSnSav0soIFgcN4MAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cs+jF2DoH94=:2C/RdE9bb73YWYd8ICRObJ
 Okjw3nkfNL7+eCo3ibS2ZP6l1/Umsm6Jl41oxPlCs0b/pZ7JK4Lwa02MR3ihbbducJEtuZZNm
 n14CUUns3J3GSzLWsYNWrEeIlRJXpFOQTasRq47608r4knr5KKw53Tl/B7mlWGaCLC9zZbc5Q
 WyKNpfJbTLl9FcgEix5fNDZKU86XnpNcO8d9vTIxFp/OKsbq4f3VxrPCXCaYMBkjo+sOf2jrb
 ldeMoTDQXlL2iMmMi/PmnsBSi4eo1udnfaHJlCp9ZbtLqT2pAdet/dPUtRsPr7V+XBcUvpulK
 hghaVNsZt3KDzmqa81Lx9aQdJKE/aylso4xeprb0atcHEkjeRHV8R8r57TvITcZDXFtk3enY0
 jb5fA+FZuBCEFT6yx8jjJyMKpNzXiBtHARWZqvHLVApxc0B1BBglzU7cxqML0Aa9JZU9e08mF
 zOoZsJLY0A40vkPL7r4pJ7iVzHcJeLKNFoXgxBlxwyV0QuSbYEUXp5bgOJl1zy351rmf2P7Bo
 xv67J1vRZVgWxvzwmZBmoH+Q2B5UkR/a8pwwHu19eCCKbYZMEzcr/HV45O7C6LWBXISyT2zje
 7dMHFc4mrGNv+tsodD9ma4H01l1vZA0quJLMhQyy8p0rsIlbFM4sASLiMQVvzdgx+fhzZFinm
 xS4fjVFItuskFsa6IKCeQ+8bY/CAulUmrD8DyiKMGPx/kScy1B2cLmXVMh2qjMHedhRbQQcd1
 D0oRcMyqsRKudzVck2eodTok+mo0OT1wiPAu1Foo8R41jul7Fep0sDfnum1rjBRQWKSzfV9bu
 naAZ6EUkxPvRbbc728nu3Zs8lPm2dJ8NtlwtFdlaoEyCnZ34Nk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 1:18 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> On Tue, May 12, 2020 at 09:49:59PM +0200, Arnd Bergmann wrote:
>
> > Any idea which bit you want to try next?
>
> My plan has been to next post patches for the static kernel migration
> to vmalloc space (currently the code is rigid, taking easy route
> wherever possible & not of high quality) as that feature has an
> independent existence & adds value by itself.  And then start working
> on other steps towards VMSPLIT_4G_4G.
>
> Now that you mentioned about other things, i will slowly start those
> as well.

Sounds good.

> > Creating a raw_copy_{from,to}_user()
> > based on get_user_pages()/kmap_atomic()/memcpy() is probably a good
> > next thing to do. I think it can be done one page at a time with only
> > checking for
> > get_fs(), access_ok(), and page permissions, while get_user()/put_user()
> > need to handle a few more corner cases.
>
> Before starting w/ other things, i would like to align on the high
> level design,
>
> My understanding (mostly based on your comments) as follows,
> (i currently do not have a firm grip over these things, hope to have
> it once started w/ the implementation)
>
> 1. SoC w/ LPAE
> 2. TTBR1 (top 256MB) for static kernel, modules, io mappings, vmalloc,
>         kmap, fixmap & vectors

Right, these kind of go together because pre-LPAE cannot do the
same TTBR1 split, and they more frequently have conflicting
static mappings.

It's clearly possible to do something very similar for older chips
(v6 or v7 without LPAE, possibly even v5), it just gets harder
while providing less benefit.

> 3. TTBR0 (low 3768MB) for user space & lowmem (kernel lowmem to have
>         separate ASID)

Right. This could in theory become a boot-time decision, using
a larger TTBR1 on machines that want more vmalloc space, but a
hardcoded 3840/256 split is likely the best compromise of all the
constraints.

> 4. for user space to/from copy
>  a. pin user pages
>  b. kmap user page (can't corresponding lowmem be used instead ?)
>  c. copy

Right, this is probably the simplest and most generic implementation,
it can even be in an architecture-independent lib/uaccess-generic
file.

These are the trade-offs I see:

- we can have optimizations for get_user/put_user or small copy_from_user
  based on ttbr0 switching, but large copies should probably use the pinned
  page approach anyway, and it's easier to only have one method to
  start with, and then measure the overhead before starting to optimize.

- In the long run, there is no need for kmap()/kmap_atomic() after
  highmem gets removed from the kernel, but for the next few years
  we should still assume that highmem can be used, in order to support
  systems like the 8GB highbank, armadaxp, keystone2 or virtual
  machines. For lowmem pages (i.e. all pages when highmem is
  disabled), kmap_atomic() falls back to page_address() anyway,
  so there is no much overhead.

      Arnd
