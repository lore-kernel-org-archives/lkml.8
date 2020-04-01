Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2A7C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98ED20658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1X71f5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbgDAPto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:49:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37057 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732683AbgDAPto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:49:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so653709wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C/6o2vAlNYHnEoJMtN8wwi/oRzeStDRZUTB/Nd2Hv7M=;
        b=V1X71f5rZiDGmnBfh3sBWCp7T9Jp+5xgMJtds1xfZSu8D+O/hvzseXEbwd0hbE/ic5
         x2TkT+43IaifgxbqN3WD5qF0jkxiEJn/vxu7PJRb8DLrWPo6nyc2sc0xJTT/Dgr5U/Ks
         I+dljP0laNt/dwhmWSN9NgnGnsQ5TIJIRWzDiczColatMsLZ4AxN0FV2nGqCjw0hr5vA
         Zoy0T/CjYuH6DlYK8xB91i5btiy69jf9MTCkULGVja5Tvk+K0iLwEzJSa0OqQVJ5Ulf2
         xfg3KFSYDoo0qFQSaOx3myBfeqcG6DhAd2eTiiX5P4BHoNaXawbCHD7VO9oOVywNrhMn
         kYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C/6o2vAlNYHnEoJMtN8wwi/oRzeStDRZUTB/Nd2Hv7M=;
        b=Ccovi9ArqJL2KgUyTb/XHqZljoAQcVwazEEJyRattmDWsoiRLcpa9vir6hhUBvNRUW
         dmD1l8stVBJfzqaTaaJG0hHq+C5V1ev8xfj1zpYCpVsz6ati4ymdaWvnUjNj3qnhAXnl
         fgGdSm3QCyd5v2eCfn+ha/KJPBwoVzJVXclbwc02zf21YBysxYR+aJtqaLUEpaTS/6s8
         8NFEBA4CE/571mJEiXdFGGeBYIJrOqCVe595v/88vsMSMqL2CzyNbDqdMOH0KSddO6mG
         UhukZzQVRZVwqj5ERdBdyY6kwP6PhywKEVVmRyWNDJt/07336eY6BAQ5weeuupurdkmu
         BZxw==
X-Gm-Message-State: ANhLgQ1uLOuEm0LLmHu+ulcAOBGkrAPB3CW/Eh7L0Eq7sUpSqVuQNfXw
        psVmfD/FzhNvKruDai0pX7h3zg==
X-Google-Smtp-Source: ADFU+vsj+IPnTlTnW8cEeiZkmxOp3zrZSNdsM6O5dJ55cTv7aer2xndG3sAVVLsjPUulI2AMAH/7/g==
X-Received: by 2002:adf:84a3:: with SMTP id 32mr25563249wrg.378.1585756181494;
        Wed, 01 Apr 2020 08:49:41 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
        by smtp.gmail.com with ESMTPSA id s131sm3258684wmf.35.2020.04.01.08.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 08:49:40 -0700 (PDT)
Date:   Wed, 1 Apr 2020 17:49:32 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Bharat Bhushan <bbhushan2@marvell.com>, joro@8bytes.org,
        mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        eric.auger.pro@gmail.com, eric.auger@redhat.com
Subject: Re: [RFC PATCH v2] iommu/virtio: Use page size bitmap supported by
 endpoint
Message-ID: <20200401154932.GA1124215@myrica>
References: <20200401113804.21616-1-bbhushan2@marvell.com>
 <b75beb74-89ce-fd6a-6207-3c0d7f479215@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b75beb74-89ce-fd6a-6207-3c0d7f479215@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 02:00:13PM +0100, Robin Murphy wrote:
> On 2020-04-01 12:38 pm, Bharat Bhushan wrote:
> > Different endpoint can support different page size, probe
> > endpoint if it supports specific page size otherwise use
> > global page sizes.
> > 
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> >   drivers/iommu/virtio-iommu.c      | 33 +++++++++++++++++++++++++++----
> >   include/uapi/linux/virtio_iommu.h |  7 +++++++
> >   2 files changed, 36 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index cce329d71fba..c794cb5b7b3e 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -78,6 +78,7 @@ struct viommu_endpoint {
> >   	struct viommu_dev		*viommu;
> >   	struct viommu_domain		*vdomain;
> >   	struct list_head		resv_regions;
> > +	u64				pgsize_bitmap;
> >   };
> >   struct viommu_request {
> > @@ -415,6 +416,20 @@ static int viommu_replay_mappings(struct viommu_domain *vdomain)
> >   	return ret;
> >   }
> > +static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
> > +				    struct virtio_iommu_probe_pgsize_mask *mask,
> > +				    size_t len)
> > +
> > +{
> > +	u64 pgsize_bitmap = le64_to_cpu(mask->pgsize_bitmap);
> > +
> > +	if (len < sizeof(*mask))
> > +		return -EINVAL;
> > +
> > +	vdev->pgsize_bitmap = pgsize_bitmap;
> > +	return 0;
> > +}
> > +
> >   static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
> >   			       struct virtio_iommu_probe_resv_mem *mem,
> >   			       size_t len)
> > @@ -494,11 +509,13 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
> >   	while (type != VIRTIO_IOMMU_PROBE_T_NONE &&
> >   	       cur < viommu->probe_size) {
> >   		len = le16_to_cpu(prop->length) + sizeof(*prop);
> > -

Whitespace change

> >   		switch (type) {
> >   		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
> >   			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
> >   			break;
> > +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> > +			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
> > +			break;
> >   		default:
> >   			dev_err(dev, "unknown viommu prop 0x%x\n", type);
> >   		}
> > @@ -607,16 +624,23 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
> >   	return &vdomain->domain;
> >   }
> > -static int viommu_domain_finalise(struct viommu_dev *viommu,
> > +static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> >   				  struct iommu_domain *domain)
> >   {
> >   	int ret;
> >   	struct viommu_domain *vdomain = to_viommu_domain(domain);
> > +	struct viommu_dev *viommu = vdev->viommu;
> >   	vdomain->viommu		= viommu;
> >   	vdomain->map_flags	= viommu->map_flags;
> > -	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> > +	/* Devices in same domain must support same size pages */
> 
> AFAICS what the code appears to do is enforce that the first endpoint
> attached to any domain has the same pgsize_bitmap as the most recently
> probed viommu_dev instance, then ignore any subsequent endpoints attached to
> the same domain. Thus I'm not sure that comment is accurate.
> 

Yes viommu_domain_finalise() is only called once. What I had in mind is
something like:

---- 8< ----
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 750f69c49b95..8303b7b513ff 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -639,6 +639,29 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 	return 0;
 }
 
+/*
+ * Check whether the endpoint's capabilities are compatible with other endpoints
+ * in the domain. Report any inconsistency.
+ */
+static bool viommu_endpoint_is_compatible(struct viommu_endpoint *vdev,
+					  struct viommu_domain *vdomain)
+{
+	struct device *dev = vdev->dev;
+
+	if (vdomain->viommu != vdev->viommu) {
+		dev_err(dev, "cannot attach to foreign vIOMMU\n");
+		return false;
+	}
+
+	if (vdomain->domain.pgsize_bitmap != vdev->pgsize_bitmap) {
+		dev_err(dev, "incompatible domain bitmap 0x%lx != 0x%lx\n",
+			vdomain->domain.pgsize_bitmap, vdev->pgsize_bitmap);
+		return false;
+	}
+
+	return true;
+}
+
 static void viommu_domain_free(struct iommu_domain *domain)
 {
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
@@ -670,9 +693,8 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		 * owns it.
 		 */
 		ret = viommu_domain_finalise(vdev, domain);
-	} else if (vdomain->viommu != vdev->viommu) {
-		dev_err(dev, "cannot attach to foreign vIOMMU\n");
-		ret = -EXDEV;
+	} else if (!viommu_endpoint_is_compatible(vdev, vdomain)) {
+		ret = -EINVAL;
 	}
 	mutex_unlock(&vdomain->mutex);
---- >8 ----

> 
> > +	if ((domain->pgsize_bitmap != viommu->pgsize_bitmap) &&
> > +	    (domain->pgsize_bitmap != vdev->pgsize_bitmap))
> > +		return -EINVAL;
> > +
> > +	domain->pgsize_bitmap = vdev->pgsize_bitmap;
> > +
> >   	domain->geometry	= viommu->geometry;
> >   	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
> > @@ -657,7 +681,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >   		 * Properly initialize the domain now that we know which viommu
> >   		 * owns it.
> >   		 */
> > -		ret = viommu_domain_finalise(vdev->viommu, domain);
> > +		ret = viommu_domain_finalise(vdev, domain);
> >   	} else if (vdomain->viommu != vdev->viommu) {
> >   		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> >   		ret = -EXDEV;
> > @@ -875,6 +899,7 @@ static int viommu_add_device(struct device *dev)
> >   	vdev->dev = dev;
> >   	vdev->viommu = viommu;
> > +	vdev->pgsize_bitmap = viommu->pgsize_bitmap;
> >   	INIT_LIST_HEAD(&vdev->resv_regions);
> >   	fwspec->iommu_priv = vdev;
> > diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> > index 237e36a280cb..dc9d3f40bcd8 100644
> > --- a/include/uapi/linux/virtio_iommu.h
> > +++ b/include/uapi/linux/virtio_iommu.h
> > @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
> >   #define VIRTIO_IOMMU_PROBE_T_NONE		0
> >   #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> > +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
> >   #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
> > @@ -119,6 +120,12 @@ struct virtio_iommu_probe_property {
> >   	__le16					length;
> >   };
> > +struct virtio_iommu_probe_pgsize_mask {
> > +	struct virtio_iommu_probe_property	head;
> > +	__u8					reserved[4];
> > +	__u64					pgsize_bitmap;

Should be __le64

Thanks,
Jean

> > +};
> > +
> >   #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
> >   #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
> > 
