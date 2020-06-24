Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F2DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CBF20768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQox80nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406241AbgFXTvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406233AbgFXTvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:51:09 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE685C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 12:51:08 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m26so1907695lfo.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J73i3rz/I64LqKUej6oP6f1NYtvUf3NYSVwbC7dTX5w=;
        b=IQox80nqkvYl2V203YIzkDNaBu47Vj2YXveFlws6lJoadByZi6gvf5Ak74zL+CwinF
         gejQxBplLk+uJcb4s/uPTi4HYS+WpgF/OGhmUup1auCMtHdoP9zp9hexdeW26j0wc19+
         edg+/lK8Vf6l1KTLPZ0aBQ6jnUM9BREFEDitSxhLaBrxGYlxL5coDuLDm4AEbdE+siqF
         7Yp5c7NLPBs/orjJ0yiP3jy/O5ic6EW6S0FIT3vU3JIV4QqayWnwCZUSrd6QDX8UrAti
         cjV4OYYz/Zb3mK1GhFCbUxbSswm0Xo88qV9d7USbMn8jTNFSiWjV/m6ccO7XPPvObEEo
         XlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J73i3rz/I64LqKUej6oP6f1NYtvUf3NYSVwbC7dTX5w=;
        b=qqTcm6j2mhTJxungMlvl4ICc6KAR63AYR4ggVpVTjWpjzS3WEArpslmpBiN7uh0FnX
         o+TG3HQXy7adfcbqUddlTK7K8nXKtz1If+sP5ycXGf6prNGN8NTn3E0IuN2gmo1rfJiD
         aX4tCxRSQEcvUqy3t0Kf/Fff2RE7YbMpMDK2GSz6KFYpHYTfNfCYY763ETPeMJXf2zBl
         112DFzyAJoBDGVUsNhe0DG8p8RDfqgiGr0TW3d3ZmQmDybkK68CS+4rq2vzLQI2du/0s
         sjh3/PG/E/aW43uWdeYa0INUrb/pRmOY3diM/n/XReXAnNNVjM1Bw2lE65aXIZp46yPc
         Nx5g==
X-Gm-Message-State: AOAM532ydFjuoEMFyhdXfcafrhiGM6a9fYuHQ1R9FH/Dz4nDY8GEmIWl
        d1PEK2W5CZAjyoqnbWJsGF90VLKObr+6rLIaI2HCUw==
X-Google-Smtp-Source: ABdhPJwN+9jJvyPQZbs5Vt0yJCm7O1mbDa7eNA87UsIDrPWLGFu8X2N2J+GCp0bygrkuHWixHoY5PExoMMWqb7rDVGc=
X-Received: by 2002:ac2:4557:: with SMTP id j23mr10988476lfm.124.1593028266755;
 Wed, 24 Jun 2020 12:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <1593020612-13051-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200624115317.792d8fc6369d421d2898ab2f@linux-foundation.org> <b1959a9b-d660-3a99-df37-fea141eda44d@linux.alibaba.com>
In-Reply-To: <b1959a9b-d660-3a99-df37-fea141eda44d@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 24 Jun 2020 12:50:55 -0700
Message-ID: <CALvZod6BEw-1=XgwN6RDohnEp1uwmDQwPPvgbtC2H4q-X=Nsig@mail.gmail.com>
Subject: Re: [PATCH] mm: filemap: clear idle flag for writes
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>, gavin.dg@linux.alibaba.com,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:18 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>
>
> On 6/24/20 11:53 AM, Andrew Morton wrote:
> > On Thu, 25 Jun 2020 01:43:32 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
> >
> >> Since commit bbddabe2e436aa7869b3ac5248df5c14ddde0cbf ("mm: filemap:
> >> only do access activations on reads"), mark_page_accessed() is called
> >> for reads only.  But the idle flag is cleared by mark_page_accessed() so
> >> the idle flag won't get cleared if the page is write accessed only.
> >>
> >> Basically idle page tracking is used to estimate workingset size of
> >> workload, noticeable size of workingset might be missed if the idle flag
> >> is not maintained correctly.
> >>
> >> It seems good enough to just clear idle flag for write operations.
> >>
> >> ...
> >>
> >> --- a/mm/filemap.c
> >> +++ b/mm/filemap.c
> >> @@ -41,6 +41,7 @@
> >>   #include <linux/delayacct.h>
> >>   #include <linux/psi.h>
> >>   #include <linux/ramfs.h>
> >> +#include <linux/page_idle.h>
> >>   #include "internal.h"
> >>
> >>   #define CREATE_TRACE_POINTS
> >> @@ -1630,6 +1631,11 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
> >>
> >>      if (fgp_flags & FGP_ACCESSED)
> >>              mark_page_accessed(page);
> >> +    else if (fgp_flags & FGP_WRITE) {
> >> +            /* Clear idle flag for buffer write */
> >> +            if (page_is_idle(page))
> >> +                    clear_page_idle(page);
> >> +    }
> >>
> >>   no_page:
> >>      if (!page && (fgp_flags & FGP_CREAT)) {
> > The kerneldoc comment for pagecache_get_page() could do with some
> > updating - it fails to mention FGP_WRITE, FGP_NOFS and FGP_NOWAIT.
>
> Yes, will propose a separate patch later on.
>
> >
> > This change seems correct but also will have runtime effects.  What are
> > they?
>
> Other than a couple of extra cycles when idle page tracking is enabled,
> I didn't think of other effects. It should be negligible. The idle flag
> doesn't play a role in page reclaim algorithm, so it won't have impact
> on that.
>
>

The only user visible impact will be on idle page tracking users. They
will get more accurate data.
