Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9D6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C51D20772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j179t90F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgGCGel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCGek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:34:40 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6666AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 23:34:40 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g13so23172976qtv.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u3qUOwsLsxiI6rED0QEYL5qR8wzRy0UEcKjWHFa8UvI=;
        b=j179t90FJYaHQ8HrtSupONgPsJoyTJ/0hYShVlyk5GgeN4gfTvp0PrqUpIGefV6oDd
         RmvOZIjjs5Kmax3U05y02v290UF7xB3UhruS01xuLJMEDTMomlsgJo3epZsHwwf8JBEG
         W535mzODdv7E0+RPlUcNGU6VnY5Wkl0xgbZ6/aTtP5LagZt4veLnACzgg3gJZnxHlPYM
         66BLAfjbv68vHAazNY+f10Q7sbsiscMIAtGIvy4VIXJGDJ3wMT/EvajAdXMeFZeYP6FE
         yl0dvptsEmOYuGHG/nX3SRE/wW4aPIlSJ3OTAeabW1hVvrjGKwnvXRVfx+Z+LOLjbo4h
         ZUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3qUOwsLsxiI6rED0QEYL5qR8wzRy0UEcKjWHFa8UvI=;
        b=pNl36TJN5fYdYwklPXc96OdojPINJUZC1/59kxVaAvKVekeSOtl0pk0EJH4BlvCYov
         /21ZsQPGEmiE3mjHAA94e8lvBb2yrJn5HR2S0Ud/tisOXPpGSlhz3B84f/zrTwDLpU20
         T/NFafld417jPpz0O5soE27eXeIB7mJvtNwtZd/YQyi+9gH/1hOGoBzHAZHD1Am36gqm
         E/UQTY0LGwSmolNLvN1RwYyL1XmRqa7kJCWwCFdGiJ2leGsHziFi96uVC5NO4H08WYM1
         Nm92SUIKUgpao2tjlGw364lvRz5n8S8e1oeQactLR5OaDAqWJj4w4XrcVPnC+KR4NbEa
         u11g==
X-Gm-Message-State: AOAM530sHbYBgL49tZ/OrM/1214glsiRXDYQGbyF/FIy2MMX7VYRffEm
        /nhNCRkPAGkPb8OVC1ZhW/h566n8t269hTHRRRg=
X-Google-Smtp-Source: ABdhPJxp99OgQObzPF0as7boQdLWlTQnTQqoQluZE28e6gu3A2d44LTgDPnGhHIijm2s/ty9DSHmsis/xk6UUCzE/C8=
X-Received: by 2002:ac8:18b2:: with SMTP id s47mr21636760qtj.114.1593758079511;
 Thu, 02 Jul 2020 23:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200703061350.94474-1-songmuchun@bytedance.com>
In-Reply-To: <20200703061350.94474-1-songmuchun@bytedance.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Fri, 3 Jul 2020 09:34:24 +0300
Message-ID: <CAOJsxLGc-o1Os7HAoQmhd1DNxGWVrfbw2R8NroTQg0wHNyWX1w@mail.gmail.com>
Subject: Re: [PATCH RESEND] mm/page_alloc: skip setting nodemask when we are
 in interrupt
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 9:14 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> When we are in the interrupt context, it is irrelevant to the
> current task context. If we use current task's mems_allowed, we
> can fair to alloc pages in the fast path and fall back to slow
> path memory allocation when the current node(which is the current
> task mems_allowed) does not have enough memory to allocate. In
> this case, it slows down the memory allocation speed of interrupt
> context. So we can skip setting the nodemask to allow any node
> to allocate memory, so that fast path allocation can success.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/page_alloc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b48336e20bdcd..a6c36cd557d1d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4726,10 +4726,12 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
>
>         if (cpusets_enabled()) {
>                 *alloc_mask |= __GFP_HARDWALL;
> -               if (!ac->nodemask)
> -                       ac->nodemask = &cpuset_current_mems_allowed;
> -               else
> +               if (!ac->nodemask) {
> +                       if (!in_interrupt())
> +                               ac->nodemask = &cpuset_current_mems_allowed;

If !ac->nodemask and in_interrupt() the ALLOC_CPUSET flag is not set,
which by-passes the __cpuset_zone_allowed() check for allocations.
This works fine because in the case if in_interrupt() the function
allows allocation on any zone/node.

> +               } else {
>                         *alloc_flags |= ALLOC_CPUSET;
> +               }
>         }

However, if you write the condition as follows:

        if (cpusets_enabled()) {
                *alloc_mask |= __GFP_HARDWALL;
                if (!in_interrupt() && !ac->nodemask)
                        ac->nodemask = &cpuset_current_mems_allowed;
                else
                        *alloc_flags |= ALLOC_CPUSET;
        }

then the code is future-proof in case of __cpuset_zone_allowed() is
one day extended to support IRQ context too (it probably should
eventually respect IRQ SMP affinity).

>
>         fs_reclaim_acquire(gfp_mask);
> --
> 2.11.0
>
>
