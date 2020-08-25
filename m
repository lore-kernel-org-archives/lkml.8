Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A934C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732832068F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ao1qF1KY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgHYKWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbgHYKWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:22:31 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9F3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 03:22:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l63so7690443edl.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 03:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=orjn/VuUmFAKu7SvmsNFkE/hoRSrEyeiukqJjo9MKuA=;
        b=ao1qF1KYWbLmB8Rvob7GVVtTIKVV5d6PFFqIHS9ydk3k+eRpYe7cioZwJgj1wdwvGN
         zhVKELt8vhbVDUCm2Hk2+KrSmb+RdQswCx1p8t7Qgl1MZJtG1cYZtfPNHtr1YFICMY4V
         ECoDQLEDXGwAL8e6aAurywWHwC3Q+K+X+1EiJGUHgJC+GE4Xu3S6BSNFY4ILv35UOtsB
         i0UY+g7rPqMJ+JHkyPYpINjy+lT7OD1Z39m0SJaLkeiZ/Ivn1rK0gPrly/omtL5Wua9V
         6KiMMBzL5OlvEK9hWENUzJWRFgBqnvMsOfLJXYytvU4KK3VT/woJR9mOwEuuH5H/sjIk
         77cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=orjn/VuUmFAKu7SvmsNFkE/hoRSrEyeiukqJjo9MKuA=;
        b=gDzSv03Rw/p7HQFl+QnnqebvNKPCPzvnCTvQPW1RY9qnH+XLUrOtRnZLbbkH4AzL+t
         zqx5ZJG0sZdap4J8+kAwW1rSpukUKl+9Dzh5FgCo2f6mW7HfSZpHWskVckkQ0ub7xDi+
         4q//QBzH25ZMpwra/1FRwlTKV4aY3iyb3wzyxo34EDxYSEAgCtHKz02I7QTvgYE1T5RZ
         rzTjnvTjviGSUy4G35SSOWWNps/sWNNHyaMjQDe8VVAM1QsRyc34wKHb7JK8ndbuptyJ
         Fs7kji0Qa/57HjOizMvKVv7jOZYHEhUhOlhx/07z/PvKKkPPpj6WGlJZ7rMFBrsLrlvz
         vX5w==
X-Gm-Message-State: AOAM533SHOByyFnXLQg4GZwu7pxDO+CVX1ZdVqN1U+/2BRrQOm7p616j
        uFdeJ8HNwXbn29g3RJbGOMETrA==
X-Google-Smtp-Source: ABdhPJwADXHBjgMYgFOWzT5HTr50X6O0YIi/ax3qATZjnb7cxoJoh1npIkB1GHYvWPSJH1FVA5mkag==
X-Received: by 2002:a50:ee92:: with SMTP id f18mr9021140edr.191.1598350946357;
        Tue, 25 Aug 2020 03:22:26 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id df22sm12730912edb.93.2020.08.25.03.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 03:22:25 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:22:09 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.pan.linux@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v2 5/9] iommu/ioasid: Introduce ioasid_set private ID
Message-ID: <20200825102209.GC3252704@myrica>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-6-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598070918-21321-6-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:35:14PM -0700, Jacob Pan wrote:
> When an IOASID set is used for guest SVA, each VM will acquire its
> ioasid_set for IOASID allocations. IOASIDs within the VM must have a
> host/physical IOASID backing, mapping between guest and host IOASIDs can
> be non-identical. IOASID set private ID (SPID) is introduced in this
> patch to be used as guest IOASID. However, the concept of ioasid_set
> specific namespace is generic, thus named SPID.
> 
> As SPID namespace is within the IOASID set, the IOASID core can provide
> lookup services at both directions. SPIDs may not be allocated when its
> IOASID is allocated, the mapping between SPID and IOASID is usually
> established when a guest page table is bound to a host PASID.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/ioasid.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h | 12 +++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 5f31d63c75b1..c0aef38a4fde 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -21,6 +21,7 @@ enum ioasid_state {
>   * struct ioasid_data - Meta data about ioasid
>   *
>   * @id:		Unique ID
> + * @spid:	Private ID unique within a set
>   * @users	Number of active users
>   * @state	Track state of the IOASID
>   * @set		Meta data of the set this IOASID belongs to
> @@ -29,6 +30,7 @@ enum ioasid_state {
>   */
>  struct ioasid_data {
>  	ioasid_t id;
> +	ioasid_t spid;
>  	struct ioasid_set *set;
>  	refcount_t users;
>  	enum ioasid_state state;
> @@ -326,6 +328,58 @@ int ioasid_attach_data(ioasid_t ioasid, void *data)
>  EXPORT_SYMBOL_GPL(ioasid_attach_data);
>  
>  /**
> + * ioasid_attach_spid - Attach ioasid_set private ID to an IOASID
> + *
> + * @ioasid: the ID to attach
> + * @spid:   the ioasid_set private ID of @ioasid
> + *
> + * For IOASID that is already allocated, private ID within the set can be
> + * attached via this API. Future lookup can be done via ioasid_find.

via ioasid_find_by_spid()?

> + */
> +int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
> +{
> +	struct ioasid_data *ioasid_data;
> +	int ret = 0;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> +
> +	if (!ioasid_data) {
> +		pr_err("No IOASID entry %d to attach SPID %d\n",
> +			ioasid, spid);
> +		ret = -ENOENT;
> +		goto done_unlock;
> +	}
> +	ioasid_data->spid = spid;
> +
> +done_unlock:
> +	spin_unlock(&ioasid_allocator_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_attach_spid);
> +
> +ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid)

Maybe add a bit of documentation as this is public-facing.

> +{
> +	struct ioasid_data *entry;
> +	unsigned long index;
> +
> +	if (!xa_load(&ioasid_sets, set->sid)) {
> +		pr_warn("Invalid set\n");
> +		return INVALID_IOASID;
> +	}
> +
> +	xa_for_each(&set->xa, index, entry) {
> +		if (spid == entry->spid) {
> +			pr_debug("Found ioasid %lu by spid %u\n", index, spid);
> +			refcount_inc(&entry->users);

Nothing prevents ioasid_free() from concurrently dropping the refcount to
zero and calling ioasid_do_free(). The caller will later call ioasid_put()
on a stale/reallocated index.

> +			return index;
> +		}
> +	}
> +	return INVALID_IOASID;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_find_by_spid);
> +
> +/**
>   * ioasid_alloc - Allocate an IOASID
>   * @set: the IOASID set
>   * @min: the minimum ID (inclusive)
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 310abe4187a3..d4b3e83672f6 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -73,6 +73,8 @@ bool ioasid_is_active(ioasid_t ioasid);
>  
>  void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid, bool (*getter)(void *));
>  int ioasid_attach_data(ioasid_t ioasid, void *data);
> +int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid);
> +ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid);
>  int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_is_in_set(struct ioasid_set *set, ioasid_t ioasid);
> @@ -136,5 +138,15 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
>  	return -ENOTSUPP;
>  }
>  
> +staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid)
> +{
> +	return -ENOTSUPP;

INVALID_IOASID

Thanks,
Jean

> +}
> +
>  #endif /* CONFIG_IOASID */
>  #endif /* __LINUX_IOASID_H */
> -- 
> 2.7.4
> 
