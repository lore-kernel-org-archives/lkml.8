Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B252C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB3520671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgEOS0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:26:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:46810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEOS0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:26:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C0E6FAD93;
        Fri, 15 May 2020 18:26:04 +0000 (UTC)
Date:   Fri, 15 May 2020 20:26:00 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
        jsnitsel@redhat.com
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
Message-ID: <20200515182600.GJ8135@suse.de>
References: <20200515094519.20338-1-joro@8bytes.org>
 <d4e1cd9e-fc83-d41a-49c0-8f14f44b2701@arm.com>
 <20200515161400.GZ18353@8bytes.org>
 <e7bdcbf1-a713-618d-3e02-037f509a17e9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7bdcbf1-a713-618d-3e02-037f509a17e9@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 05:28:53PM +0100, Robin Murphy wrote:
> On 2020-05-15 17:14, Joerg Roedel wrote:
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index ba128d1cdaee..403fda04ea98 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -362,8 +362,8 @@ static int iommu_dma_deferred_attach(struct device *dev,
> >   		return 0;
> >   	if (unlikely(ops->is_attach_deferred &&
> > -			ops->is_attach_deferred(domain, dev)))
> > -		return iommu_attach_device(domain, dev);
> > +		     ops->is_attach_deferred(domain, dev)))
> > +		return iommu_attach_device_no_defer(domain, dev);
> 
> Wouldn't it be simpler to just invoke ops->attach_dev directly and avoid
> having to formalise a public interface that nobody else should ever use
> anyway?

That would omit the ops->attach_dev != NULL check and the trace-point on
device attach. Besides that, it would be a layering violation. But the
function is of course entirely internal to the iommu subsytem and is a
good canditate to be moved to a header file in drivers/iommu.

> @@ -746,8 +747,11 @@ int iommu_group_add_device(struct iommu_group *group,
> struct device *dev)
> 
>         mutex_lock(&group->mutex);
>         list_add_tail(&device->list, &group->devices);
> -       if (group->domain)
> -               ret = __iommu_attach_device(group->domain, dev);
> +       domain = group->domain;
> +       if (domain && (!domain->ops->is_attach_deferred ||
> +                      !domain->ops->is_attach_deferred(domain, dev)))
> +               ret = __iommu_attach_device(domain, dev);
> +       }
>         mutex_unlock(&group->mutex);
>         if (ret)
>                 goto err_put_group;

No, doing this in iommu_group_add_device() doesn't solve the problem.
The attach must not happen before a device driver took control of the
device and silenced any DMA initiated by the old kernel. At probe time
this isn't guaranteed.


	Joerg

