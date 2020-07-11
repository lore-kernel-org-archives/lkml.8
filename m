Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F46C433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F8520786
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="kf/GijOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgGKAra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 20:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgGKAr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 20:47:29 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B896C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:47:29 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so7854460ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=st0YQO+9N+wj1Bpy5FgTMDvwfrDYYhxnz84DaeIYHvE=;
        b=kf/GijOp8+5lWxfksRaWtI/aKDLLu2C+Ep5A8Zd+Wwap17OxVtPlB7kKxMuBYdHZ56
         1vq9LulHSmENIqlaXFPDdeH3UxCrk9JfnP1zJseaq4tgF0iV2i6jHck+Oee77DpfLhhz
         uZ0ZXokKtNSLsjNyx7s6Ry4SbImB82FRvLQyPfU19WFTXKXoLn7Eie/0jEOrSJDsTrFt
         JnXSoWvT2Kr6IRlk63GWt7W3tLbbsto2BkLE/yDmuKjWIPgJ70M6DQWmLafIsc26e/1c
         VcSMX3uadaPJpPekovYYiousunCLedzS6bZB65zkyg2Sc6aaWdrgHMiIlLhv81TdM7bL
         oW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=st0YQO+9N+wj1Bpy5FgTMDvwfrDYYhxnz84DaeIYHvE=;
        b=B2KZ1AzjAft2CHTA9ikk8FM8Kjd6g1AtjtDKt2zKRbFUzTawZ1lWTH83BWPDkC+G3p
         B3K42Eb6Q2NRXgyPSriTimVOoEj4zKaTTfEDbPN/jwedNOaR8AfgiWNGRIU8gg3PHUsX
         KtuqT2s8ACDWL+O9z9iAAXjSmG/MT6PnCYnOtgYYja6uL1p4tsmTXfdS5UZjmsgHx2Fo
         2mZ1kwm58F7MyMB4rhTWfgxjgml81J+kPL/YbAYqI1ZL8b9H88KNAtkqx83ilkdIanGj
         ZgF7rTErZvYwd8+FuEfGolMh0zyhmsXj5558JLf3Q3TWt8XacdU4YfdUh3qZN9lSLpao
         Vutw==
X-Gm-Message-State: AOAM530XQjVsnkBxZ5Yr6ebome/ijpZ4gdv8DLuERlCXQy3dbIwLLtZ0
        lt4qotCM+bwunflWliC7ruOBe7MVs3oXfu1rKg6GQHIi
X-Google-Smtp-Source: ABdhPJxKT8AjTlortJSpv1MwycxURB5wVgMFtwFPFUW2XppCLIraO4Bs/8ibaYUjNpKiTvsmpR6qSMA5TwM2NTNsvFQ=
X-Received: by 2002:a17:907:20af:: with SMTP id pw15mr66148379ejb.204.1594428447936;
 Fri, 10 Jul 2020 17:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
 <23742bb8-831f-29ff-1463-75427eec57c7@oracle.com> <CAPcyv4jvsBSD3SELYn=oj_nvLZ_VgM2YbyswbSEeq5DmkcbXcw@mail.gmail.com>
In-Reply-To: <CAPcyv4jvsBSD3SELYn=oj_nvLZ_VgM2YbyswbSEeq5DmkcbXcw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Jul 2020 17:47:17 -0700
Message-ID: <CAPcyv4joMJDjaTLSw=HiU_sesWrHoVt07fOuWM44726TpjWCCA@mail.gmail.com>
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

On Mon, Apr 6, 2020 at 1:22 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Apr 6, 2020 at 3:46 AM Joao Martins <joao.m.martins@oracle.com> wrote:
> >
> > On 3/23/20 11:55 PM, Dan Williams wrote:
> >
> > [...]
> >
> > >  static ssize_t dev_dax_resize(struct dax_region *dax_region,
> > >               struct dev_dax *dev_dax, resource_size_t size)
> > >  {
> > >       resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
> > > -     resource_size_t dev_size = range_len(&dev_dax->range);
> > > +     resource_size_t dev_size = dev_dax_size(dev_dax);
> > >       struct resource *region_res = &dax_region->res;
> > >       struct device *dev = &dev_dax->dev;
> > > -     const char *name = dev_name(dev);
> > >       struct resource *res, *first;
> > > +     resource_size_t alloc = 0;
> > > +     int rc;
> > >
> > >       if (dev->driver)
> > >               return -EBUSY;
> > > @@ -684,38 +766,47 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
> > >        * allocating a new resource.
> > >        */
> > >       first = region_res->child;
> > > -     if (!first)
> > > -             return __alloc_dev_dax_range(dev_dax, dax_region->res.start,
> > > -                             to_alloc);
> > > -     for (res = first; to_alloc && res; res = res->sibling) {
> > > +retry:
> > > +     rc = -ENOSPC;
> > > +     for (res = first; res; res = res->sibling) {
> > >               struct resource *next = res->sibling;
> > > -             resource_size_t free;
> > >
> > >               /* space at the beginning of the region */
> > > -             free = 0;
> > > -             if (res == first && res->start > dax_region->res.start)
> > > -                     free = res->start - dax_region->res.start;
> > > -             if (free >= to_alloc && dev_size == 0)
> > > -                     return __alloc_dev_dax_range(dev_dax,
> > > -                                     dax_region->res.start, to_alloc);
> > > -
> > > -             free = 0;
> > > +             if (res == first && res->start > dax_region->res.start) {
> > > +                     alloc = min(res->start - dax_region->res.start,
> > > +                                     to_alloc);
> > > +                     rc = __alloc_dev_dax_range(dev_dax,
> > > +                                     dax_region->res.start, alloc);
> >
> > You might be missing:
> >
> >         first = region_res->child;
> >
> > (...) right after returning from __alloc_dev_dax_range(). Alternatively, perhaps
> > even moving the 'retry' label to right before the @first initialization.
> >
> > In the case that you pick space from the beginning, the child resource of the
> > dax region will point to first occupied region, and that changes after you pick
> > this space. So, IIUC, you want to adjust where you start searching free space
> > otherwise you end up wrongly picking that same space twice.
> >
> > If it helps, the bug can be reproduced in this unit test below, see
> > daxctl_test3() test:
>
> It definitely will, thanks. I'll be circling back to this now that
> I've settled my tree for the v5.7 window.

s/v5.7/v5.9/ whats a couple of kernel release cycles between friends?
I went ahead and moved the retry loop above the assignment of first as
you suggested.
