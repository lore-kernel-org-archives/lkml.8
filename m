Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC73C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB378207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="LoQsRabZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGKApC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 20:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgGKApB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 20:45:01 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D772C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:45:01 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dm19so5913708edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIfMfLrIcR4z15WKttA1evNrYOPo0JXT17THF0rBRHI=;
        b=LoQsRabZHG5ATQdm3coYlG1Zrqchdk/PP7xuyYfANxu+sMXaqUJ70hLILaaT+rFK1I
         YrRpC2IsCfR0psHUbklaxhyUrqA4T/aMv8efT1HSW24iFfeqvPtREByCPauaC4eQJBsp
         CSzC3S+gn9B+HJAjZamlWbVPgAE2OcD+aDlGKFEj5GU/93PRADu4wM/PP3bgi2bH7Z88
         bxe9A8orYs1/RI/p2OWaR4ASDRKh0/cnU2Lz9bv7TM+m2aZE0jzbCRX2lbAK8MtiUWn2
         UdfZcoI64G3Bip7FJcjfi/35SSQ/TUiCY4LaWcMr6a8hZ5UY7sZEL/qYXYNl4Dxn3Xeg
         0WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIfMfLrIcR4z15WKttA1evNrYOPo0JXT17THF0rBRHI=;
        b=QNO7L/efihkqLJk9D6hHHodHArY7lFK359o5BR8vmT+FYUD2uGFZ12bX3aeHpU4dZL
         oPufb5CENQwA7wrX0p8tj2lcdbWZYWZDMgYM+paJOJBqND9/zjNkU6eurcV59pcNKh8N
         JdBYAeuVIzYQHCZ/8e4h8WwOvSzlMeUWZg07+pQ7ysvBAlWYG5U923CnzZZlDihZFrSU
         CsD0ab8/DChg22PfZI/+ozDncLszLqSKPZ2ftSp/jcHevQq8ZXe//n9jjbJifBADzoFJ
         6qBCaVFQnVYrzPKeX2RrjoIM6aBO1zVgYfHN1WS/cBwidD0OxBTgJ+JmXZLz7t9NGakH
         bIDw==
X-Gm-Message-State: AOAM530TnBkH1fy1t3bEsfDpBUmwLfR5e4jcuyLVB7okK2ftqbOD9egh
        5ykf59YyD1fJmPg0w9KhTDNzi8dpPKH1CNnQpBsajQ==
X-Google-Smtp-Source: ABdhPJwpGJfvAKHE4idln3hDFMDRVKJAY4yZCP6ZY9+qFOXeHXc4+TgRZRKzVAwvSYFZvXtpNAWmNrHSO7iiYsqdtlI=
X-Received: by 2002:a05:6402:21c2:: with SMTP id bi2mr79476078edb.296.1594428299892;
 Fri, 10 Jul 2020 17:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
 <9a6ff83f-095c-0689-d6d1-693a6e9c07e6@oracle.com>
In-Reply-To: <9a6ff83f-095c-0689-d6d1-693a6e9c07e6@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Jul 2020 17:44:48 -0700
Message-ID: <CAPcyv4ijYVx0C3ocEaT+LB=qxAyy7t0g+yfkhXab5TXQ+s_owA@mail.gmail.com>
Subject: Re: [PATCH 11/12] device-dax: Add dis-contiguous resource support
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 9:12 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 3/23/20 11:55 PM, Dan Williams wrote:
> >  static ssize_t dev_dax_resize(struct dax_region *dax_region,
> >               struct dev_dax *dev_dax, resource_size_t size)
> >  {
> >       resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
> > -     resource_size_t dev_size = range_len(&dev_dax->range);
> > +     resource_size_t dev_size = dev_dax_size(dev_dax);
> >       struct resource *region_res = &dax_region->res;
> >       struct device *dev = &dev_dax->dev;
> > -     const char *name = dev_name(dev);
> >       struct resource *res, *first;
> > +     resource_size_t alloc = 0;
> > +     int rc;
> >
> >       if (dev->driver)
> >               return -EBUSY;
> > @@ -684,38 +766,47 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
> >        * allocating a new resource.
> >        */
> >       first = region_res->child;
> > -     if (!first)
> > -             return __alloc_dev_dax_range(dev_dax, dax_region->res.start,
> > -                             to_alloc);
>
> You probably want to retain the condition above?
>
> Otherwise it removes the ability to create new devices or resizing it , once we
> have zero-ed the last one.
>
> > -     for (res = first; to_alloc && res; res = res->sibling) {
> > +retry:
> > +     rc = -ENOSPC;
> > +     for (res = first; res; res = res->sibling) {
> >               struct resource *next = res->sibling;
> > -             resource_size_t free;
> >
> >               /* space at the beginning of the region */
> > -             free = 0;
> > -             if (res == first && res->start > dax_region->res.start)
> > -                     free = res->start - dax_region->res.start;
> > -             if (free >= to_alloc && dev_size == 0)
> > -                     return __alloc_dev_dax_range(dev_dax,
> > -                                     dax_region->res.start, to_alloc);
> > -
> > -             free = 0;
> > +             if (res == first && res->start > dax_region->res.start) {
> > +                     alloc = min(res->start - dax_region->res.start,
> > +                                     to_alloc);
> > +                     rc = __alloc_dev_dax_range(dev_dax,
> > +                                     dax_region->res.start, alloc);
> > +                     break;
> > +             }
> > +
> > +             alloc = 0;
> >               /* space between allocations */
> >               if (next && next->start > res->end + 1)
> > -                     free = next->start - res->end + 1;
> > +                     alloc = min(next->start - (res->end + 1), to_alloc);
> >
> >               /* space at the end of the region */
> > -             if (free < to_alloc && !next && res->end < region_res->end)
> > -                     free = region_res->end - res->end;
> > -
> > -             if (free >= to_alloc && strcmp(name, res->name) == 0)
> > -                     return __adjust_dev_dax_range(dev_dax, res,
> > -                                     resource_size(res) + to_alloc);
> > -             else if (free >= to_alloc && dev_size == 0)
> > -                     return __alloc_dev_dax_range(dev_dax, res->end + 1,
> > -                                     to_alloc);
> > +             if (!alloc && !next && res->end < region_res->end)
> > +                     alloc = min(region_res->end - res->end, to_alloc);
> > +
> > +             if (!alloc)
> > +                     continue;
> > +
> > +             if (adjust_ok(dev_dax, res)) {
> > +                     rc = __adjust_dev_dax_range(dev_dax, res,
> > +                                     resource_size(res) + alloc);
> > +                     break;
> > +             }
> > +             rc = __alloc_dev_dax_range(dev_dax, res->end + 1,
> > +                             alloc);
>
> I am wondering if we should switch to:
>
>         if (adjust_ok(...))
>                 rc = __adjust_dev_dax_range(...);
>         else
>                 rc = __alloc_dev_dax_range(...);
>
> And then a debug print at the end depicting whether and how did we grabbed
> space? Something like:
>
>         dev_dbg(&dev_dax->dev, "%s(%d) %d", action, location, rc);
>
> Assuming we set @location to its values when we allocate space at the end,
> beginning or middle; and @action to whether we adjusted up/down or allocated new
> range.
>
> Essentially, something similar to namespaces scan_allocate() just to help
> troubleshoot?

I went ahead and just added "alloc", "extend", "shrink", and "delete
debug prints in the right places.
