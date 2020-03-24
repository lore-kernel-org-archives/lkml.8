Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2508CC54FCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDE12073C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="jgx9CVgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgCXXvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:51:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:47055 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgCXXvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 19:51:41 -0400
Received: by mail-oi1-f193.google.com with SMTP id q204so388970oia.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 16:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KsuHRbkrRa7b9vqtRFx6ZxGV0C6hEgdYMQeOpNoVJ0E=;
        b=jgx9CVgZcBzRzaEGKFLv/1JOTUMrhNkGkLTdNTBN5CFC7PlSIeE0hcCdBrTvaw578G
         8YxLzN0nM6iNf3wKE7zw8apBgYHyE5jU7LNswbWwXwWHfUTQJO9vm1PFErePmhUQPlBP
         Vt6nqyYE7EcDffVVOCJ4DFUufko+Zog9ruk7Gg0dJk5SQBgWGC7BBV5pr1mRIq5755yO
         YVHd++wVXkAmTw/lET38pgHh8M72HZAwVGgO4Du+2ufb81Jltpo4VrKzt0/QsPNJMRgr
         2Tq6BGao3x7tbcGZIExPuDBLWO3boKoqOsO8A/UijwTYnjICttMS266PGrxtNmAjMR3G
         rsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KsuHRbkrRa7b9vqtRFx6ZxGV0C6hEgdYMQeOpNoVJ0E=;
        b=TvpmlHBOUxXz2XHLca/tMq7HTKKtzNvWq9uwA4Zuoh8bhu1fBGCC6LW6EESus8p1xs
         D0GJ8NxIcOb6aSv1BFA4AW06v+ialhm2Bcr2inlXArHgktFST2Mdj2pitdhap1X6LE4Z
         ba5uAazQ1Riah6GVY9qBuGg75LukEfTTnFqtzoiYDbvQY3ZeU4MjW8JfTI25tfOj8TZW
         ERsYbwyAN4vvvtemRU7gdbQJxH0uSDwfUjSCzp68+jbN9NwzopABG2wdHcLcEHmNqooY
         rfWFnwAFDcGDETYUAz+S0bfJjSHz0JMSElkLq2BKZaz2kWhV8wlNqHbYxzzJ/WjpXoeO
         0b8w==
X-Gm-Message-State: ANhLgQ3Orxz8UX/JcFvERegHFo4Ttvetyl5vPicHwrEtD1pTE2RdNpME
        46pR/H60GthWFi+5aViqh1CiWo96HzfaJSs+0bsV9w==
X-Google-Smtp-Source: ADFU+vvEot3loXp3xfdzaa8/BtiMFgInDf2505MhIro1JIu7WSMtVgkejuDT5W3XzYDu/BNtqWzlHCFs5LvpT08hY6c=
X-Received: by 2002:aca:ef82:: with SMTP id n124mr562802oih.73.1585093900545;
 Tue, 24 Mar 2020 16:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500774067.2088294.1260962550701501447.stgit@dwillia2-desk3.amr.corp.intel.com>
 <27ba42ac-ec08-fd9c-dee2-53414eb0bc58@oracle.com>
In-Reply-To: <27ba42ac-ec08-fd9c-dee2-53414eb0bc58@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 24 Mar 2020 16:51:29 -0700
Message-ID: <CAPcyv4isr2cRXQ2nJtOBaru7ir-GnCdqz=wXH4bytrZpDUpe0Q@mail.gmail.com>
Subject: Re: [PATCH 12/12] device-dax: Introduce 'mapping' devices
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

On Tue, Mar 24, 2020 at 9:28 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 3/23/20 11:55 PM, Dan Williams wrote:
> > In support of interrogating the physical address layout of a device with
> > dis-contiguous ranges, introduce a sysfs directory with 'start', 'end',
> > and 'page_offset' attributes. The alternative is trying to parse
> > /proc/iomem, and that file will not reflect the extent layout until the
> > device is enabled.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/dax/bus.c         |  190 +++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/dax/dax-private.h |   14 +++
> >  2 files changed, 202 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index 07aeb8fa9ee8..645449a079bd 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -558,6 +558,167 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
> >  }
> >  EXPORT_SYMBOL_GPL(alloc_dax_region);
> >
> > +static void dax_mapping_release(struct device *dev)
> > +{
> > +     struct dax_mapping *mapping = to_dax_mapping(dev);
> > +     struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> > +
> > +     ida_free(&dev_dax->ida, mapping->id);
> > +     kfree(mapping);
> > +}
> > +
> > +static void unregister_dax_mapping(void *data)
> > +{
> > +     struct device *dev = data;
> > +     struct dax_mapping *mapping = to_dax_mapping(dev);
> > +     struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> > +     struct dax_region *dax_region = dev_dax->region;
> > +
> > +     dev_dbg(dev, "%s\n", __func__);
> > +
> > +     device_lock_assert(dax_region->dev);
> > +
> > +     dev_dax->ranges[mapping->range_id].mapping = NULL;
> > +     mapping->range_id = -1;
> > +
> > +     device_del(dev);
> > +     put_device(dev);
> > +}
> > +
> > +static struct dev_dax_range *get_dax_range(struct device *dev)
> > +{
> > +     struct dax_mapping *mapping = to_dax_mapping(dev);
> > +     struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> > +     struct dax_region *dax_region = dev_dax->region;
> > +
> > +     device_lock(dax_region->dev);
> > +     if (mapping->range_id < 1) {
>             ^^^^^^^^^^^^^^^^^^^^^ perhaps "mapping->range_id < 0" ?
>
> AFAICT, invalid/disabled ranges have id to -1.
>
> Otherwise we can't use mapping0 entry fields.
>

Yes, a gaping hole in the unit test.
