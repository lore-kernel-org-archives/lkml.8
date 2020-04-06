Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5275AC2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B8A20768
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="re0wkM9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDFUXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:23:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37044 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFUXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 16:23:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id de14so1167715edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 13:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39PH+pwpIycTi0BsfN3QezNcOPRNhfwqmeD1bO42FHI=;
        b=re0wkM9Y8K0FkjQlOYTtllVGDKo96zzEV9ijGYRTSuOy69i+w+YnLmP5o40GJpt35d
         id1hpQ7x/EK/kFALbsL9tNzD+6SkS/Vk7I8UkLLjA6NHyxmzdfU0k6F9dHb3Eiyy+jok
         E18GAbSDHu0DAsBxHQd0paCz6sqrKShssxJf9In36mDsiTd1aw+w+YOkQcTzQqwKkpSd
         og/4qTJ341EkMIRECzta+agUB7EVJK0c/mFmjYoRMgxHoP+ySEESE37xSNcO1R2BgqbL
         Fbf4XVj2ywZ2YkHUG6xzQnnc3PHFsmGWn2zp1TMpAQpcERcFithJvKtO7PePdYzBw4ab
         d7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39PH+pwpIycTi0BsfN3QezNcOPRNhfwqmeD1bO42FHI=;
        b=BiRCqOzYS+quwrUWvPHThf0xdL3PUf6PYuQ/6iX8BP4pawV+WqyzlS313Ee7fQbI/M
         YUF8yP6eKV8BmwJOnuMdTOvwUv+Q+6j9/8WO0LayoyvpkTS7WBq9QueR3jhlP1YyGXSf
         3lCL64KxKIYBHTXqqOZjfqlEzlWSrvfROihAM1vjz3Ec73E5QZGk7IIbiYliBWKMxtbR
         Cn5iJuTn92V7DYywsBtaCJAgwy8EATF19YLlKzcuJu8wtkNleMGGODvGnZjTCcysegma
         1yFkmaJeXdB2MfvEirwWk+p0++OixIMYHVp6dFADAtyctnmKSRmsyOJmUPyxaTxTmn35
         ZfVA==
X-Gm-Message-State: AGi0PuYkGf+q0i0iKx0hHkeON5BYRpEZopI0dzKWFmDS7oR8QvqhPU1O
        gqHn6uso8sfrYfZkP88QZLEmhcouhI+3ShKxW/3Y1g==
X-Google-Smtp-Source: APiQypLKe5k4sPIdyDlAdrXh1qMjrKzUsMm7i1sTvxIVG8cUt7zm4WnRhiU6r3Bysf7eOs3J7AGGIYYvkaNPjCfcQMI=
X-Received: by 2002:a17:906:6d8e:: with SMTP id h14mr1160830ejt.123.1586204586068;
 Mon, 06 Apr 2020 13:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
 <23742bb8-831f-29ff-1463-75427eec57c7@oracle.com>
In-Reply-To: <23742bb8-831f-29ff-1463-75427eec57c7@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 6 Apr 2020 13:22:54 -0700
Message-ID: <CAPcyv4jvsBSD3SELYn=oj_nvLZ_VgM2YbyswbSEeq5DmkcbXcw@mail.gmail.com>
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

On Mon, Apr 6, 2020 at 3:46 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 3/23/20 11:55 PM, Dan Williams wrote:
>
> [...]
>
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
>
> You might be missing:
>
>         first = region_res->child;
>
> (...) right after returning from __alloc_dev_dax_range(). Alternatively, perhaps
> even moving the 'retry' label to right before the @first initialization.
>
> In the case that you pick space from the beginning, the child resource of the
> dax region will point to first occupied region, and that changes after you pick
> this space. So, IIUC, you want to adjust where you start searching free space
> otherwise you end up wrongly picking that same space twice.
>
> If it helps, the bug can be reproduced in this unit test below, see
> daxctl_test3() test:

It definitely will, thanks. I'll be circling back to this now that
I've settled my tree for the v5.7 window.
