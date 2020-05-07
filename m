Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B070BC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801B720A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGpJucTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgEGLcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:32:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51505 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgEGLcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588851172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zKLGgGO4EC8bZEq/1EyPdX/1tzanL3uq/PXrZRZ5pUs=;
        b=IGpJucTIABgBnav3BI70wqeUq1cFaAvf1t3ss06MAY2NbdRVxpGowRLqDAF/gCVEbCEF79
        6Jr5WaPFz1cedUflGFr+TOLyALkvThDP4qWGew0dX0rLK/M4rHIGFKFHCKVQ25wvdLCCnz
        pmz8CRBuPInHImFnYSiVGpExDeT74Ew=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-qhdszV-WNZ6g3mRquQuBrw-1; Thu, 07 May 2020 07:32:50 -0400
X-MC-Unique: qhdszV-WNZ6g3mRquQuBrw-1
Received: by mail-wm1-f69.google.com with SMTP id o74so814804wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 04:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zKLGgGO4EC8bZEq/1EyPdX/1tzanL3uq/PXrZRZ5pUs=;
        b=aksqeryYfRVDnhji1lam9pweaeKGhVETHSPFvzy74haaZ0wqpdTNFnF5Rts/l8Bpsx
         Zql6EP3phob1rOahQ3hbWZYyxZeZI/QQbYCf7GKYKbpuxIZO5HmwIBWXIL06o9Q+h9gm
         Oh+1usoPtOp43PXSpCak+ee5RRuv3RZRhWKZDRkY5qmaxTXWh23mhkqgGW5rkVXKSn0M
         3i0WynrZvxGFR89kgkUFriVYYQJ/zaSdR6BVs154kI5mKTthzWyqNatQq/XQQoWcO7Zl
         67/YBOUgfPZRx7SBi/MGd2EIjGG5tAZyZDHJAafJsDJANKNE5fY4VdvUeS98sYcIS4/F
         8Y6Q==
X-Gm-Message-State: AGi0PuZu/uZKM+//xaerD3rnW3/MFmPq9Az5JIB9tjOJpHFr5a3silsi
        rk+iukxReFd8tj6uqmyB8a/zr9McRAElEVHTUU1egEdix7nVv3ZQ6NPuJ7i8YTHlQMFoK0/Rnb4
        AG0gGt/m2olmEqIX+0ZKgYUaS
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr1636656wmj.100.1588851168106;
        Thu, 07 May 2020 04:32:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypKMkK4Y96wvTf/c8NvxL5kFBl0MGlrC6lL6F0vzq4zAXwQPVzNdt6CSv6HKmQS/jT5SdzM0nA==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr1636629wmj.100.1588851167852;
        Thu, 07 May 2020 04:32:47 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id p8sm7547138wre.11.2020.05.07.04.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 04:32:47 -0700 (PDT)
Date:   Thu, 7 May 2020 07:32:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: Re: [EXT] Re: [PATCH v5] iommu/virtio: Use page size bitmap
 supported by endpoint
Message-ID: <20200507072619-mutt-send-email-mst@kernel.org>
References: <20200505093004.1935-1-bbhushan2@marvell.com>
 <20200505200659-mutt-send-email-mst@kernel.org>
 <MWHPR1801MB19669FA26D44E1C31DF89BDBE3A50@MWHPR1801MB1966.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB19669FA26D44E1C31DF89BDBE3A50@MWHPR1801MB1966.namprd18.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 11:24:29AM +0000, Bharat Bhushan wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, May 6, 2020 5:53 AM
> > To: Bharat Bhushan <bbhushan2@marvell.com>
> > Cc: jean-philippe@linaro.org; joro@8bytes.org; jasowang@redhat.com;
> > virtualization@lists.linux-foundation.org; iommu@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org; eric.auger.pro@gmail.com; eric.auger@redhat.com
> > Subject: [EXT] Re: [PATCH v5] iommu/virtio: Use page size bitmap supported by
> > endpoint
> > 
> > External Email
> > 
> > ----------------------------------------------------------------------
> > On Tue, May 05, 2020 at 03:00:04PM +0530, Bharat Bhushan wrote:
> > > Different endpoint can support different page size, probe endpoint if
> > > it supports specific page size otherwise use global page sizes.
> > >
> > > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > > ---
> > > v4->v5:
> > >  - Rebase to Linux v5.7-rc4
> > >
> > > v3->v4:
> > >  - Fix whitespace error
> > >
> > > v2->v3:
> > >  - Fixed error return for incompatible endpoint
> > >  - __u64 changed to __le64 in header file
> > >
> > >  drivers/iommu/virtio-iommu.c      | 48 ++++++++++++++++++++++++++++---
> > >  include/uapi/linux/virtio_iommu.h |  7 +++++
> > >  2 files changed, 51 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/iommu/virtio-iommu.c
> > > b/drivers/iommu/virtio-iommu.c index d5cac4f46ca5..9513d2ab819e 100644
> > > --- a/drivers/iommu/virtio-iommu.c
> > > +++ b/drivers/iommu/virtio-iommu.c
> > > @@ -78,6 +78,7 @@ struct viommu_endpoint {
> > >  	struct viommu_dev		*viommu;
> > >  	struct viommu_domain		*vdomain;
> > >  	struct list_head		resv_regions;
> > > +	u64				pgsize_bitmap;
> > >  };
> > >
> > >  struct viommu_request {
> > > @@ -415,6 +416,19 @@ static int viommu_replay_mappings(struct
> > viommu_domain *vdomain)
> > >  	return ret;
> > >  }
> > >
> > > +static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
> > > +				    struct virtio_iommu_probe_pgsize_mask *mask,
> > > +				    size_t len)
> > > +{
> > > +	u64 pgsize_bitmap = le64_to_cpu(mask->pgsize_bitmap);
> > > +
> > > +	if (len < sizeof(*mask))
> > 
> > This is too late to validate length, you have dereferenced it already.
> > do it before the read pls.
> 
> Yes, Will change here and other places as well
> 
> > 
> > > +		return -EINVAL;
> > 
> > OK but note that guest will then just proceed to ignore the property. Is that really
> > OK? Wouldn't host want to know?
> 
> 
> Guest need to be in sync with device, so yes seems like guest need to tell device which page-size-mask it is using.
> 
> Corresponding spec change patch (https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg06214.html)
> 
> Would like Jean/Eric to comment here as well.
> 
> > 
> > 
> > > +
> > > +	vdev->pgsize_bitmap = pgsize_bitmap;
> > 
> > what if bitmap is 0? Is that a valid size? I see a bunch of BUG_ON with that value ...
> 
> As per spec proposed device is supposed to set at-least one bit.
> Will add a bug_on her.

Or better fail probe ...

> Should we add bug_on or switch to global config page-size mask if this is zero (notify device which page-size-mask it is using).

It's a spec violation, I wouldn't try to use the device.

> > 
> > I also see a bunch of code like e.g. this:
> > 
> >         pg_size = 1UL << __ffs(pgsize_bitmap);
> > 
> > which probably won't DTRT on a 32 bit guest if the bitmap has bits set in the high
> > word.
> > 
> 
> My thought is that in that case viommu_domain_finalise() will fail, do not proceed.

That's undefined behaviour in C. You need to make sure this condition
is never reached. And spec does not make this illegal at all
so it looks like we actually need to handle this gracefully.


> > 
> > 
> > > +	return 0;
> > > +}
> > > +
> > >  static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
> > >  			       struct virtio_iommu_probe_resv_mem *mem,
> > >  			       size_t len)
> > > @@ -499,6 +513,9 @@ static int viommu_probe_endpoint(struct viommu_dev
> > *viommu, struct device *dev)
> > >  		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
> > >  			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
> > >  			break;
> > > +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> > > +			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
> > > +			break;
> > >  		default:
> > >  			dev_err(dev, "unknown viommu prop 0x%x\n", type);
> > >  		}
> > > @@ -630,7 +647,7 @@ static int viommu_domain_finalise(struct
> > > viommu_endpoint *vdev,
> > >
> > >  	vdomain->id		= (unsigned int)ret;
> > >
> > > -	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> > > +	domain->pgsize_bitmap	= vdev->pgsize_bitmap;
> > >  	domain->geometry	= viommu->geometry;
> > >
> > >  	vdomain->map_flags	= viommu->map_flags;
> > > @@ -654,6 +671,29 @@ static void viommu_domain_free(struct iommu_domain
> > *domain)
> > >  	kfree(vdomain);
> > >  }
> > >
> > > +/*
> > > + * Check whether the endpoint's capabilities are compatible with
> > > +other
> > > + * endpoints in the domain. Report any inconsistency.
> > > + */
> > > +static bool viommu_endpoint_is_compatible(struct viommu_endpoint *vdev,
> > > +					  struct viommu_domain *vdomain) {
> > > +	struct device *dev = vdev->dev;
> > > +
> > > +	if (vdomain->viommu != vdev->viommu) {
> > > +		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> > > +		return false;
> > > +	}
> > > +
> > > +	if (vdomain->domain.pgsize_bitmap != vdev->pgsize_bitmap) {
> > > +		dev_err(dev, "incompatible domain bitmap 0x%lx != 0x%llx\n",
> > > +			vdomain->domain.pgsize_bitmap, vdev->pgsize_bitmap);
> > > +		return false;
> > > +	}
> > 
> > I'm confused by this. So let's assume host supports pages sizes of 4k, 2M, 1G. It
> > signals this in the properties. Nice.
> > Now domain supports 4k, 2M and that's all. Why is that a problem?
> > Just don't use 1G ...
> 
> Is not it too to change the existing domain properties, for devices already attached to domain? New devices must match to domain page-size.

Again if IOMMU supports more page sizes than domain uses, why is
that a problem? Just don't utilize the bits domain does not use.


> > 
> > 
> > > +
> > > +	return true;
> > > +}
> > > +
> > >  static int viommu_attach_dev(struct iommu_domain *domain, struct
> > > device *dev)  {
> > >  	int i;
> > > @@ -670,9 +710,8 @@ static int viommu_attach_dev(struct iommu_domain
> > *domain, struct device *dev)
> > >  		 * owns it.
> > >  		 */
> > >  		ret = viommu_domain_finalise(vdev, domain);
> > > -	} else if (vdomain->viommu != vdev->viommu) {
> > > -		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> > > -		ret = -EXDEV;
> > > +	} else if (!viommu_endpoint_is_compatible(vdev, vdomain)) {
> > > +		ret = -EINVAL;
> > >  	}
> > >  	mutex_unlock(&vdomain->mutex);
> > >
> > > @@ -886,6 +925,7 @@ static int viommu_add_device(struct device *dev)
> > >
> > >  	vdev->dev = dev;
> > >  	vdev->viommu = viommu;
> > > +	vdev->pgsize_bitmap = viommu->pgsize_bitmap;
> > >  	INIT_LIST_HEAD(&vdev->resv_regions);
> > >  	dev_iommu_priv_set(dev, vdev);
> > >
> > > diff --git a/include/uapi/linux/virtio_iommu.h
> > > b/include/uapi/linux/virtio_iommu.h
> > > index 48e3c29223b5..2cced7accc99 100644
> > > --- a/include/uapi/linux/virtio_iommu.h
> > > +++ b/include/uapi/linux/virtio_iommu.h
> > 
> > As any virtio UAPI change, you need to copy virtio TC at some point before this is
> > merged ...
> 
> Jean already send patch for same
> https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg06214.html
> 
> Do we need to do anything additional?


Yes, that is spec patch. you need to see the UAPI patch to virtio-dev.

> > 
> > > @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
> > >
> > >  #define VIRTIO_IOMMU_PROBE_T_NONE		0
> > >  #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> > > +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
> > >
> > >  #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
> > >
> > 
> > Does host need to know that guest will ignore the page size mask?
> > Maybe we need a feature bit.
> > 
> > > @@ -119,6 +120,12 @@ struct virtio_iommu_probe_property {
> > >  	__le16					length;
> > >  };
> > >
> > > +struct virtio_iommu_probe_pgsize_mask {
> > > +	struct virtio_iommu_probe_property	head;
> > > +	__u8					reserved[4];
> > > +	__le64					pgsize_bitmap;
> > > +};
> > > +
> > 
> > This is UAPI. Document the format of pgsize_bitmap please.
> 
> Ok,
> 
> Thanks
> -Bharat
> 
> > 
> > 
> > >  #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
> > >  #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
> > >
> > > --
> > > 2.17.1

