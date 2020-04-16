Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14147C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2942064A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke1sn34k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgDPBMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgDPBMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:12:31 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ED3C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:12:29 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 198so4286537lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLXrMgkzQHFW3b+SlhNpB17QVhD+CtFuaz/Wf6gaH7c=;
        b=ke1sn34kqduIn0oSGOMF+iZfjQmztWauKOCFQwXQ0qkWqpAsrha6m/GTacRa+j57Qm
         KA2lis8YwY3gQgktu/UWLGnGPrChWiqtUVgpHeLLPYDvKWr0aLiDarPNq9KBpFbf+cKr
         HFyyai3aoq9ZvmNn2/S5XzQKLu/dBQmw6OEs0VZED+M8qVHELkH4T7VFhUWEYCgXkt5I
         savcJgWrG9AaJGwuIvG9g3Ut/hHs5fzOq1PH0dfrHNEVXEoh7I7L655uGnf4ZU+uwVT+
         +UGyZYxiqubMmWy5GMGb01V5SdS2rmw8E9Xw+V4HBtrBMnETN3CzgwVHe5+5huFM85b6
         zk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLXrMgkzQHFW3b+SlhNpB17QVhD+CtFuaz/Wf6gaH7c=;
        b=CqVsI+ywCVX70wljLPppJp864IV8GpiTEB/6AmhHeYceVtj6MmJ6tmiB1wjTXXXt1Z
         o4ctVZdsB5U2ziGXMZ1j434AhyY2s3dfoD6ZdiR/N3dgOYzF9ak2hjcIe4udB0v8dX1M
         qNZGj1/UZbZYK3dxaZP5VpDmSAyHZaJcq2lEkcl9HNmLFk5rPBXTnMfhdWa8MQkeFrDN
         rYgPBF0b3JsfvB8IAeDqJEU9XvHrEq5CMTHPYnn69dARWsks5OCpDZV+ZVMxklsw3pFl
         esLhArgvb8vclkL8hqWc6gxBAKVoCNVfVdpsebe66RamwQRwa3eysyEYF8Bm07APDN50
         DtBA==
X-Gm-Message-State: AGi0PubFf2XDedxqyv+0gdx8aU/Q1vW/Pf6ROecVrxfUhQrmDWjhEHMu
        PiJnEwDY4QkhdmbW4XUGlkREliqyAnplcFornKM=
X-Google-Smtp-Source: APiQypLGkYKWGZqyAluteVjPen7uPL4oZlK0q6N+kDdKMce2t++tPRm7fj5pNTgzFPtxwzSsqDgVkjAthCr0Su7oW18=
X-Received: by 2002:a19:48c3:: with SMTP id v186mr4451137lfa.194.1586999548275;
 Wed, 15 Apr 2020 18:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200412090756.GA19574@open-light-1.localdomain> <c0bd9b1b-a0e7-5c88-ab99-e867ef25c935@linux.intel.com>
In-Reply-To: <c0bd9b1b-a0e7-5c88-ab99-e867ef25c935@linux.intel.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Thu, 16 Apr 2020 09:12:16 +0800
Message-ID: <CA+2MQi-u-Kd=iqoYt+Mg0Ts-wZogo3K5fSMWHGdnfCrYvt=2Yw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] mm: reduce the impaction of page reporing worker
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        liliang.opensource@gmail.com, liliang324@gmail.com
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 10:59 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On 4/12/2020 2:08 AM, liliangleo wrote:
> > When scaning the free list, 'page_reporting_cycle' may hold the
> > zone->lock for a long time when there are no reported page in the
> > free list. Setting PAGE_REPORTING_MIN_ORDER to a lower oder will
> > make this issue worse.
> >
> > Two ways were used to reduce the impact:
> >     1. Release zone lock periodicly
> >     2. Yield cpu voluntarily if needed.
> >
> > Signed-off-by: liliangleo <liliangleo@didiglobal.com>
>
> One of the reasons why I had limited this to no lower than pageblock
> order was in order to keep number of pages we would have to walk in each
> list on the smaller side.
>
> Also the lock ends up being released every time we report a batch of
> pages. It might make more sense to look at calling cond_resched after a
> batch as been submitted rather than try to introduce a new loop around
> page_reporting_cycle.
>

Hi Alexander,

My original intention is to prevent 'page_reporting_cycle' hold the
zone lock for too long
when scanning free list but there is very few pages need to report.
For PG_zero use case, it's better for users to decide the page order,
if the order is set to
a low order, the impaction will be much more serious.
Just call cond_resched after batch submission is not enough, that's
the reason why I add
cond_resched.

> >   static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
> >
> >   enum {
> > @@ -115,7 +118,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
> >       unsigned int page_len = PAGE_SIZE << order;
> >       struct page *page, *next;
> >       long budget;
> > -     int err = 0;
> > +     int err = 0, scan_cnt = 0;
> >
> >       /*
> >        * Perform early check, if free area is empty there is
> > @@ -145,8 +148,14 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
> >       /* loop through free list adding unreported pages to sg list */
> >       list_for_each_entry_safe(page, next, list, lru) {
> >               /* We are going to skip over the reported pages. */
> > -             if (PageReported(page))
> > +             if (PageReported(page)) {
> > +                     if (++scan_cnt >= MAX_SCAN_NUM) {
> > +                             err = scan_cnt;
> > +                             break;
> > +                     }
> >                       continue;
> > +             }
> > +
> >
> >               /*
> >                * If we fully consumed our budget then update our
>
> Why add yet another loopvariable, why not just move our budget test to
> before the PageReported check and then increase the value?
>

The code can be refined, I just don't want to break the budget stuff.

Thanks for your feedback your work.

Liang

> > @@ -219,6 +228,26 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
> >       return err;
> >   }
> >
> > +static int
> > +reporting_order_type(struct page_reporting_dev_info *prdev, struct zone *zone,
> > +                  unsigned int order, unsigned int mt,
> > +                  struct scatterlist *sgl, unsigned int *offset)
> > +{
> > +     int ret = 0;
> > +     unsigned long total = 0;
> > +
> > +     might_sleep();
> > +     do {
> > +             cond_resched();
> > +             ret = page_reporting_cycle(prdev, zone, order, mt,
> > +                                        sgl, offset);
> > +             if (ret > 0)
> > +                     total += ret;
> > +     } while (ret > 0 && total < zone->free_area[order].nr_free);
> > +
> > +     return ret;
> > +}
> > +
>
> The idea behind page reporting is it is supposed to happen while the
> system is idle. As such we don't need to be in a hurry. I would get rid
> of the loop and just let the natural placing take over so that we are
> only processing something like 1/8 of the nr_free with each pass.
