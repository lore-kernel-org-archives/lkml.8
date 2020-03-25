Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18824C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2FD2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="CArd9H+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgCYRtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:49:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45998 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYRtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:49:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id u59so3579843edc.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 10:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQLg73f4A6IdCvlkz6AAgidHZXBVbjJUTIhnj9QMJq0=;
        b=CArd9H+nUYQo86GgTO34kcf8M/qaGTtxoUap7Zv3rckjuMdaZYN1F6JjgfnWPrmmQD
         STLiZXfm9tTL4tzLvCBpRJ7We2yFE5YuaVYOVylxRmNv+lJGiiAUSyUkCZ2JU2MdAdtK
         /mehUtAxrA6Npr8A1L1muHfUvFvs2COnFJy1ZnrkPpjoNS8yFICdQt3s0xwQfjnwCpbU
         iX04wAD3h9RPqTOKiG6KbgGQ4OF9ezvrMsfHGyNb7m92ahBGPMbYr0/XbX7m2hj1Pebn
         xuQdsVlIEt+LULaBWLDhOZkiim1Sh7F259hWZF0OdyJeF8VkU9WQLChRU/rMYvagJ8Gg
         Gcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQLg73f4A6IdCvlkz6AAgidHZXBVbjJUTIhnj9QMJq0=;
        b=MiP7dDLeGBBV+7L81+zxo0JZxHe2plp9sUUliX90/yKlEfLAdPEX4xuq15ksN+wduq
         yJeOfvXBJ4G131rTIPHejZ82GznFvbifR30giYbjFpiqgXRrf9JExNBQjg0Rp2cLsRj3
         CE8UV5kmLztv8O8hW1GYJbFGT1ukVWJYHObijbDk0+A5y0f2mNgvf1+N8EI6vnFGL0Cy
         aJzWux3kqe8X/4FngKlCpR7PaUgV83NNbrOOgO9zlbuusIZa7o1miWtJtc/EjR9ZK+Ti
         UoDb96J//XZYlQ6leygGz4/uh7zKGTLAdbE4noBX63jXE4uTMER1wph7uLl77veHv8oj
         2XcA==
X-Gm-Message-State: ANhLgQ1TW+Qy8HKpA09W/GHbuB2dS12o0UcqFg4+1jUfZhDDxYytF8MX
        Z2gSXpcidYhcCegp4RORJkVCK1I4lSDWe6VbNOIgQQ==
X-Google-Smtp-Source: ADFU+vvboEnhuKsKIQb1Icp0tf2ZKIBZhzX0zsyDsXuxXz0SOdiPzd+VaI3b61+gj6WVPFLBvXBLoqtuW6eHq2rVeAE=
X-Received: by 2002:aa7:c609:: with SMTP id h9mr4043188edq.93.1585158550697;
 Wed, 25 Mar 2020 10:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
 <9a6ff83f-095c-0689-d6d1-693a6e9c07e6@oracle.com> <c673cba2-8749-d63e-f0b2-592ed753481d@oracle.com>
In-Reply-To: <c673cba2-8749-d63e-f0b2-592ed753481d@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 25 Mar 2020 10:48:58 -0700
Message-ID: <CAPcyv4gBQOh9sba+Zbpo6yw3sh9JCKC7Cd10qdNc7d1TvTFfYQ@mail.gmail.com>
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

On Wed, Mar 25, 2020 at 3:35 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 3/24/20 4:12 PM, Joao Martins wrote:
> > On 3/23/20 11:55 PM, Dan Williams wrote:
> >>  static ssize_t dev_dax_resize(struct dax_region *dax_region,
> >>              struct dev_dax *dev_dax, resource_size_t size)
> >>  {
> >>      resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
> >> -    resource_size_t dev_size = range_len(&dev_dax->range);
> >> +    resource_size_t dev_size = dev_dax_size(dev_dax);
> >>      struct resource *region_res = &dax_region->res;
> >>      struct device *dev = &dev_dax->dev;
> >> -    const char *name = dev_name(dev);
> >>      struct resource *res, *first;
> >> +    resource_size_t alloc = 0;
> >> +    int rc;
> >>
> >>      if (dev->driver)
> >>              return -EBUSY;
> >> @@ -684,38 +766,47 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
> >>       * allocating a new resource.
> >>       */
> >>      first = region_res->child;
> >> -    if (!first)
> >> -            return __alloc_dev_dax_range(dev_dax, dax_region->res.start,
> >> -                            to_alloc);
> >
> > You probably want to retain the condition above?
> >
> > Otherwise it removes the ability to create new devices or resizing it , once we
> > have zero-ed the last one.
> >
>
> A quick unit test that I had stashed here to help explain what I mean:
>
>         cd /sys/bus/dax/devices
>         # dax0.0 is the only dax device in the corresponding dax_region
>         echo dax0.0 > dax0.0/driver/unbind
>         echo 0 > dax0.0/size
>         # Shouldn't fail but returns -ENOSPC despite having
>         # the full region available
>         cat $(readlink -f dax0.0/../dax_region/available_size) > dax0.0/size

Thanks! Will incorporate that test before resending the series.
