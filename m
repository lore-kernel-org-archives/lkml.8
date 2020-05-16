Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD4EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 23:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393B420786
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 23:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1Hw8S8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgEPXxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 19:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726670AbgEPXxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 19:53:04 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6198FC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 16:53:04 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id e125so4104557lfd.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 16:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTOjg3LRKrOjZRaH+MBDwrWQ5QHycpS6ns5xrDhIPQU=;
        b=U1Hw8S8Ez1s26H+C7pGO1kjxeK+sPTVI/z5nX39rct4L2PiislzUljGXwNawxrIVc1
         CAerMm7TVyp+RbCU7OUnur9kefVzVsdlo0TouI8ATDIG0vk+6K+t1N1cZ7IUoVlOUALN
         sUKapGdU8n+9LV7zek6BnrmwjdtQGTHfbcpdt33B14UNMGDo8pwPim+6coFHxhNmJ6UK
         azckhOkGBYnfTGNpVTASqLiqCf23MUkWeNI8Hn6WBFnH7p305/ZNH1wlkZuGejL8fEBi
         U7yFY9xUoIgP/ywCN1FIfVvYe/MICTHZh1sJKEjF4GC/QZvbBdeG9gGgnBpOp0dbuB+n
         RchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTOjg3LRKrOjZRaH+MBDwrWQ5QHycpS6ns5xrDhIPQU=;
        b=sqdnvEhXm+Au1Ink0VdgXoJKGRlJGZ+OdYYiAn7FaL4PPXw79fhNmBn2ranB/145LJ
         tQjjm0H/htkVIlWXAuH80E2TYPsKkRaNUjQrmrbLz9EHJa830VMNqL0K6qNpGMZ5seVi
         ATCGolqwu48XzEzOmg2lQB4Nar8FlKCeZR34NjkeY5Cc0jk0OguDRf8iEgK1lbcM+2/y
         JWxkKL2t/WV/fP9mIZbQpjCBiAdTYDiWfqids40kMXtLBhPb1dKYT8IzJCIyIIf48yj6
         RZa09sSWqANDcoM3uY3xG5b56NtD/I9Fn9p81ny0uwdKeJP2qPRDTzVBLZ22AZJwOUrP
         pBsQ==
X-Gm-Message-State: AOAM5321uEiOwu7deZYAEPYlMCy/6SqzNmkna/uQbk1TnfasgshbU6WN
        jaFyOFe+3qivPbRme9XtygAszkV+L9w/kgVGxarJmg==
X-Google-Smtp-Source: ABdhPJxFg6Br+F3mfeEIVbPQPPWU4BQ1MiaAuBlHfXbkGVPTd6FVFzu+L7aXuGKZs0dkcczJTNgLtD1Ii7hmk99pxHw=
X-Received: by 2002:a19:d52:: with SMTP id 79mr5914680lfn.125.1589673182415;
 Sat, 16 May 2020 16:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200516021736.226222-1-shakeelb@google.com> <20200516.134018.1760282800329273820.davem@davemloft.net>
 <CALvZod7euq10j6k9Z_dej4BvGXDjqbND05oM-u6tQrLjosX31A@mail.gmail.com> <CANn89iJ9BYNi__DhLp_QE5JU7=RxkzknOSxD+P+qiHg2=Ho6Ow@mail.gmail.com>
In-Reply-To: <CANn89iJ9BYNi__DhLp_QE5JU7=RxkzknOSxD+P+qiHg2=Ho6Ow@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 16 May 2020 16:52:51 -0700
Message-ID: <CALvZod6b2tHDGGzkspxT1r7c4So95BpUagPcwgUVf+++5eX5Hw@mail.gmail.com>
Subject: Re: [PATCH] net/packet: simply allocations in alloc_one_pg_vec_page
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Miller <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 3:45 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Sat, May 16, 2020 at 3:35 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Sat, May 16, 2020 at 1:40 PM David Miller <davem@davemloft.net> wrote:
> > >
> > > From: Shakeel Butt <shakeelb@google.com>
> > > Date: Fri, 15 May 2020 19:17:36 -0700
> > >
> > > > and thus there is no need to have any fallback after vzalloc.
> > >
> > > This statement is false.
> > >
> > > The virtual mapping allocation or the page table allocations can fail.
> > >
> > > A fallback is therefore indeed necessary.
> >
> > I am assuming that you at least agree that vzalloc should only be
> > called for non-zero order allocations. So, my argument is if non-zero
> > order vzalloc has failed (allocations internal to vzalloc, including
> > virtual mapping allocation and page table allocations, are order 0 and
> > use GFP_KERNEL i.e. triggering reclaim and oom-killer) then the next
> > non-zero order page allocation has very low chance of succeeding.
>
>
> 32bit kernels might have exhausted their vmalloc space, yet they can
> still allocate order-0 pages.

Oh ok it makes sense.
