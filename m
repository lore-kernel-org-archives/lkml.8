Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77F0C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2B32077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yzt4PGcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbgDANr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:47:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42387 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732289AbgDANr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:47:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so79836wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 06:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hWTKXsOIBcGEc6kXxJqNe/OurUmZ8Fi9q5gmK7Ykzbk=;
        b=Yzt4PGcTugsqsrDVm2wwnOdflaXj0EOYsps9dKGliRz8umqQMXhE+VebsJZv8hqjIM
         XbLvV0xCiTDK6VVDzqg2FygHEPvMfoXK+9UddvB+tNEmCGA1DmgdYkR78gr6gn9BLNFI
         ocp0AGc8zDiYs7DqjsmLmo9LrLsA3bJuagVcCTFKRGz/1/pVq4JVBuYVpHPBBu47PgHb
         iafoAyDlgEI4+GS8fEp6hfypaTLyR+LKS+7Hv69dk/z3ITIBs8xmPDsj0svsJpuKvKc4
         2kgKp0bp3BZMgMPa1Xpg4goSspgMfx/Y4I18V76Y/mBgPELhdQyDgqL8ykme5XElEgmH
         UyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hWTKXsOIBcGEc6kXxJqNe/OurUmZ8Fi9q5gmK7Ykzbk=;
        b=NfUOK7ihZ6SOJutqSYiQreH/EHfS+DVtXQuW1iO1e8sEhf/c5y7ksFchj+1vP3KoqO
         lnibSNHVERPVm8LiL4nnBSxHKoZ49Ti3Ltc1eemVoG2Tl/9QWjqJH/h97g63JiYzLRbL
         jAgCvSgVHDZ61OjyrDwFZqDTHkZXVi68M4BJsJVSyr72DS9F2G+GxoA7x5QlshzLdTMF
         OItZj2exmyeorZrwthWZD96bbHGU73SS/SrO5udLPUCOGhtfui5Mpa54B1t7v2+TA9pP
         W6jjRunKaaHYcO1SEPdTMDKPQ1XTwvdpRKj6h6q6QhsW11r9KqvjXJbM+9tZdoSqDo/u
         eaxg==
X-Gm-Message-State: ANhLgQ35avSMLyFM8pyFKCd29jQWR1Xk8jz5bx50Vc+QMXZJXzW/umoG
        gifaUPMoBnHlDOqLmaoMgd/4+A==
X-Google-Smtp-Source: ADFU+vtLBDtrQthnQoLxciFoJt3vXdCBxwjmgjXUlPGu5uL6h5v2lol0mgsvvJ1/YI/5YA2RJu4SRA==
X-Received: by 2002:adf:df8a:: with SMTP id z10mr24727794wrl.278.1585748873708;
        Wed, 01 Apr 2020 06:47:53 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
        by smtp.gmail.com with ESMTPSA id t11sm2938647wru.69.2020.04.01.06.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 06:47:53 -0700 (PDT)
Date:   Wed, 1 Apr 2020 15:47:45 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 03/10] iommu/ioasid: Introduce per set allocation APIs
Message-ID: <20200401134745.GE882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585158931-1825-4-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 10:55:24AM -0700, Jacob Pan wrote:
> IOASID set defines a group of IDs that share the same token. The
> ioasid_set concept helps to do permission checking among users as in the
> current code.
> 
> With guest SVA usage, each VM has its own IOASID set. More
> functionalities are needed:
> 1. Enforce quota, each guest may be assigned limited quota such that one
> guest cannot abuse all the system resource.
> 2. Stores IOASID mapping between guest and host IOASIDs
> 3. Per set operations, e.g. free the entire set
> 
> For each ioasid_set token, a unique set ID is assigned. This makes
> reference of the set and data lookup much easier to implement.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/ioasid.c | 147 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h |  13 +++++
>  2 files changed, 160 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 4026e52855b9..27ee57f7079b 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -10,6 +10,25 @@
>  #include <linux/spinlock.h>
>  #include <linux/xarray.h>
>  
> +static DEFINE_XARRAY_ALLOC(ioasid_sets);
> +/**
> + * struct ioasid_set_data - Meta data about ioasid_set
> + *
> + * @token:	Unique to identify an IOASID set
> + * @xa:		XArray to store subset ID and IOASID mapping
> + * @size:	Max number of IOASIDs can be allocated within the set
> + * @nr_ioasids	Number of IOASIDs allocated in the set
> + * @sid		ID of the set
> + */
> +struct ioasid_set_data {
> +	struct ioasid_set *token;
> +	struct xarray xa;
> +	int size;
> +	int nr_ioasids;
> +	int sid;
> +	struct rcu_head rcu;
> +};
> +
>  struct ioasid_data {
>  	ioasid_t id;
>  	struct ioasid_set *set;
> @@ -388,6 +407,111 @@ void ioasid_free(ioasid_t ioasid)
>  EXPORT_SYMBOL_GPL(ioasid_free);
>  
>  /**
> + * ioasid_alloc_set - Allocate a set of IOASIDs
> + * @token:	Unique token of the IOASID set
> + * @quota:	Quota allowed in this set
> + * @sid:	IOASID set ID to be assigned
> + *
> + * Return 0 upon success. Token will be stored internally for lookup,
> + * IOASID allocation within the set and other per set operations will use
> + * the @sid assigned.
> + *
> + */
> +int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid)
> +{
> +	struct ioasid_set_data *sdata;
> +	ioasid_t id;
> +	int ret = 0;
> +
> +	if (quota > ioasid_capacity_avail) {
> +		pr_warn("Out of IOASID capacity! ask %d, avail %d\n",
> +			quota, ioasid_capacity_avail);
> +		return -ENOSPC;
> +	}

This check should be in the same critical section as the quota
substraction

> +
> +	sdata = kzalloc(sizeof(*sdata), GFP_KERNEL);
> +	if (!sdata)
> +		return -ENOMEM;

I don't understand why we need this structure at all, nor why we need the
SID. Users have already allocated an ioasid_set, so why not just stick the
content of ioasid_set_data in there, and pass the ioasid_set pointer to
ioasid_alloc()?

> +
> +	spin_lock(&ioasid_allocator_lock);
> +
> +	ret = xa_alloc(&ioasid_sets, &id, sdata,
> +		       XA_LIMIT(0, ioasid_capacity_avail - quota),
> +		       GFP_KERNEL);

Same as Kevin, I think the limit should be the static ioasid_capacity. And
perhaps a comment explaining the worst case of one PASID per set. I found
a little confusing using the same type ioasid_t for IOASIDs and IOASID
sets, it may be clearer to use an int for IOASID set IDs.

Thanks,
Jean

> +	if (ret) {
> +		kfree(sdata);
> +		goto error;
> +	}
> +
> +	sdata->token = token;
> +	sdata->size = quota;
> +	sdata->sid = id;
> +
> +	/*
> +	 * Set Xarray is used to store IDs within the set, get ready for
> +	 * sub-set ID and system-wide IOASID allocation results.
> +	 */
> +	xa_init_flags(&sdata->xa, XA_FLAGS_ALLOC);
> +
> +	ioasid_capacity_avail -= quota;
> +	*sid = id;
> +
> +error:
> +	spin_unlock(&ioasid_allocator_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_alloc_set);
> +
> +/**
> + * ioasid_free_set - Free all IOASIDs within the set
> + *
> + * @sid:		The IOASID set ID to be freed
> + * @destroy_set:	Whether to keep the set for further allocation.
> + *			If true, the set will be destroyed.
> + *
> + * All IOASIDs allocated within the set will be freed upon return.
> + */
> +void ioasid_free_set(int sid, bool destroy_set)
> +{
> +	struct ioasid_set_data *sdata;
> +	struct ioasid_data *entry;
> +	unsigned long index;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	sdata = xa_load(&ioasid_sets, sid);
> +	if (!sdata) {
> +		pr_err("No IOASID set found to free %d\n", sid);
> +		goto done_unlock;
> +	}
> +
> +	if (xa_empty(&sdata->xa)) {
> +		pr_warn("No IOASIDs in the set %d\n", sdata->sid);
> +		goto done_destroy;
> +	}
> +
> +	/* Just a place holder for now */
> +	xa_for_each(&sdata->xa, index, entry) {
> +		/* Free from per sub-set pool */
> +		xa_erase(&sdata->xa, index);
> +	}
> +
> +done_destroy:
> +	if (destroy_set) {
> +		xa_erase(&ioasid_sets, sid);
> +
> +		/* Return the quota back to system pool */
> +		ioasid_capacity_avail += sdata->size;
> +		kfree_rcu(sdata, rcu);
> +	}
> +
> +done_unlock:
> +	spin_unlock(&ioasid_allocator_lock);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_free_set);
> +
> +
> +/**
>   * ioasid_find - Find IOASID data
>   * @set: the IOASID set
>   * @ioasid: the IOASID to find
> @@ -431,6 +555,29 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  }
>  EXPORT_SYMBOL_GPL(ioasid_find);
>  
> +/**
> + * ioasid_find_sid - Retrieve IOASID set ID from an ioasid
> + *                   Caller must hold a reference to the set.
> + *
> + * @ioasid: IOASID associated with the set
> + *
> + * Return IOASID set ID or error
> + */
> +int ioasid_find_sid(ioasid_t ioasid)
> +{
> +	struct ioasid_data *ioasid_data;
> +	int ret = 0;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> +	ret = (ioasid_data) ? ioasid_data->sdata->sid : -ENOENT;
> +
> +	spin_unlock(&ioasid_allocator_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_find_sid);
> +
>  MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
>  MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
>  MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 9711fa0dc357..be158e03c034 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -41,6 +41,9 @@ int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  int ioasid_set_data(ioasid_t ioasid, void *data);
>  void ioasid_install_capacity(ioasid_t total);
> +int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid);
> +void ioasid_free_set(int sid, bool destroy_set);
> +int ioasid_find_sid(ioasid_t ioasid);
>  #else /* !CONFIG_IOASID */
>  static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
>  				    ioasid_t max, void *private)
> @@ -52,6 +55,15 @@ static inline void ioasid_free(ioasid_t ioasid)
>  {
>  }
>  
> +static inline int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline void ioasid_free_set(int sid, bool destroy_set)
> +{
> +}
> +
>  static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  				bool (*getter)(void *))
>  {
> @@ -75,5 +87,6 @@ static inline int ioasid_set_data(ioasid_t ioasid, void *data)
>  static inline void ioasid_install_capacity(ioasid_t total)
>  {
>  }
> +
>  #endif /* CONFIG_IOASID */
>  #endif /* __LINUX_IOASID_H */
> -- 
> 2.7.4
> 
