Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB88C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B6A207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wq9KLpLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgHYKT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbgHYKT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:19:56 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC93C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 03:19:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a26so15839073ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 03:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g18an+DnGAA2/tAmNxTP2/NMhw8KAjHBuuMiMwzqHUs=;
        b=Wq9KLpLV7gS2hZMsyl2+UIAW9Sr/bOA3Pgi3h1lsSFHVBCle6Ln0BwaIXMkWrNbb82
         PsbJ36Vd3j7UkVMV1Aih/kPt7HDZ9d33Xg6KquakrieGFJI7OZP+gzIfb8klpTgUTa95
         EvgiOeAZnO9Qm9683tKZelPpeYVY6D2Lizp8cpZDd4y72gZGUEvXfL+3UysI8taIwEbK
         CyhaXu3VgdSDbsKiDywKAFN6v7MGkCWpsYUF2eoQZcY1Xcj5rlk3jYedsfFc0bB1bhsh
         A0VpkWQpvzIsAfvAjT359ThTa69X800czoFouF9izDHGR4usfHggB7SU+7xKJyKTqkPR
         Bofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g18an+DnGAA2/tAmNxTP2/NMhw8KAjHBuuMiMwzqHUs=;
        b=VsHTUrBArTuPJyHfhC9IG/l1t7RS308rrD0cMQZWVYrU+Z+Fnn9FqJTSlxlr12vKjj
         0y9LcyXZj1L5/1NUHDtAxRLE8igp45XecbcENdG3LqO3O1fbCkhDXVJlBEzHfpQT1UNY
         CXoRUM0CGjY2xs46BnqG+a+MW79ZQg3GwQ+bEHUswI1vhQ7FSuHGX+l8dhyId4KXHJwB
         DkvUVMbk4DOHpU3dnzTObvyr7RfO74D/NatdfngqiPUsma9L+DqHvhb6sGUvi4atIbvW
         QMjMwRkL7GzoQC+DBBedeZLjpWR97M1eXmRt9KXFJHjYmov3l/M+NKgFugd1xYY58kp2
         1JmQ==
X-Gm-Message-State: AOAM5326NzJBwF+ubyEWq4orllPr2c8Y8kNQHWBWWHHFU9X4ta7CPqf6
        R/43+7C6R4Ixpbjr3Dq8NKgAhQ==
X-Google-Smtp-Source: ABdhPJwxPOml6Gv5fBtKomLGI/+jo8vwNZePq0KfoSrMCm6JvGRloclftRCgdC9/se1yRCOMLoKxVg==
X-Received: by 2002:a17:906:2998:: with SMTP id x24mr7058914eje.131.1598350794888;
        Tue, 25 Aug 2020 03:19:54 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id j5sm10266638edy.29.2020.08.25.03.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 03:19:54 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:19:37 +0200
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
Subject: Re: [PATCH v2 4/9] iommu/ioasid: Add reference couting functions
Message-ID: <20200825101937.GA3252704@myrica>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-5-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598070918-21321-5-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:35:13PM -0700, Jacob Pan wrote:
> There can be multiple users of an IOASID, each user could have hardware
> contexts associated with the IOASID. In order to align lifecycles,
> reference counting is introduced in this patch. It is expected that when
> an IOASID is being freed, each user will drop a reference only after its
> context is cleared.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/ioasid.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h |   4 ++
>  2 files changed, 117 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index f73b3dbfc37a..5f31d63c75b1 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -717,6 +717,119 @@ int ioasid_set_for_each_ioasid(struct ioasid_set *set,
>  EXPORT_SYMBOL_GPL(ioasid_set_for_each_ioasid);
>  
>  /**
> + * IOASID refcounting rules
> + * - ioasid_alloc() set initial refcount to 1
> + *
> + * - ioasid_free() decrement and test refcount.
> + *     If refcount is 0, ioasid will be freed. Deleted from the system-wide
> + *     xarray as well as per set xarray. The IOASID will be returned to the
> + *     pool and available for new allocations.
> + *
> + *     If recount is non-zero, mark IOASID as IOASID_STATE_FREE_PENDING.
> + *     No new reference can be added. The IOASID is not returned to the pool
> + *     for reuse.
> + *     After free, ioasid_get() will return error but ioasid_find() and other
> + *     non refcount adding APIs will continue to work until the last reference
> + *     is dropped
> + *
> + * - ioasid_get() get a reference on an active IOASID
> + *
> + * - ioasid_put() decrement and test refcount of the IOASID.
> + *     If refcount is 0, ioasid will be freed. Deleted from the system-wide
> + *     xarray as well as per set xarray. The IOASID will be returned to the
> + *     pool and available for new allocations.
> + *     Do nothing if refcount is non-zero.
> + *
> + * - ioasid_find() does not take reference, caller must hold reference
> + *
> + * ioasid_free() can be called multiple times without error until all refs are
> + * dropped.
> + */

Since you already document this in ioasid.rst, I'm not sure the comment
is necessary. Maybe the doc for _free/_put would be better in the
function's documentation.

> +
> +int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
> +{
> +	struct ioasid_data *data;
> +
> +	data = xa_load(&active_allocator->xa, ioasid);
> +	if (!data) {
> +		pr_err("Trying to get unknown IOASID %u\n", ioasid);
> +		return -EINVAL;
> +	}
> +	if (data->state == IOASID_STATE_FREE_PENDING) {
> +		pr_err("Trying to get IOASID being freed%u\n", ioasid);
> +		return -EBUSY;
> +	}
> +
> +	if (set && data->set != set) {
> +		pr_err("Trying to get IOASID not in set%u\n", ioasid);
> +		/* data found but does not belong to the set */
> +		return -EACCES;
> +	}
> +	refcount_inc(&data->users);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_get_locked);

Is it necessary to export the *_locked variant?  Who'd call them and how
would they acquire the lock?

> +
> +/**
> + * ioasid_get - Obtain a reference of an ioasid
> + * @set
> + * @ioasid

Can be dropped. The doc checker will throw a warning, though.

> + *
> + * Check set ownership if @set is non-null.
> + */
> +int ioasid_get(struct ioasid_set *set, ioasid_t ioasid)
> +{
> +	int ret = 0;

No need to initialize ret

> +
> +	spin_lock(&ioasid_allocator_lock);
> +	ret = ioasid_get_locked(set, ioasid);
> +	spin_unlock(&ioasid_allocator_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_get);
> +
> +void ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid)
> +{
> +	struct ioasid_data *data;
> +
> +	data = xa_load(&active_allocator->xa, ioasid);
> +	if (!data) {
> +		pr_err("Trying to put unknown IOASID %u\n", ioasid);
> +		return;
> +	}
> +
> +	if (set && data->set != set) {
> +		pr_err("Trying to drop IOASID not in the set %u\n", ioasid);
> +		return;
> +	}
> +
> +	if (!refcount_dec_and_test(&data->users)) {
> +		pr_debug("%s: IOASID %d has %d remainning users\n",
> +			__func__, ioasid, refcount_read(&data->users));
> +		return;
> +	}
> +	ioasid_do_free(data);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_put_locked);
> +
> +/**
> + * ioasid_put - Drop a reference of an ioasid
> + * @set
> + * @ioasid
> + *
> + * Check set ownership if @set is non-null.
> + */
> +void ioasid_put(struct ioasid_set *set, ioasid_t ioasid)
> +{
> +	spin_lock(&ioasid_allocator_lock);
> +	ioasid_put_locked(set, ioasid);
> +	spin_unlock(&ioasid_allocator_lock);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_put);
> +
> +/**
>   * ioasid_find - Find IOASID data
>   * @set: the IOASID set
>   * @ioasid: the IOASID to find
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 412d025d440e..310abe4187a3 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -76,6 +76,10 @@ int ioasid_attach_data(ioasid_t ioasid, void *data);
>  int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_is_in_set(struct ioasid_set *set, ioasid_t ioasid);
> +int ioasid_get(struct ioasid_set *set, ioasid_t ioasid);
> +int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
> +void ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
> +void ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);

Please also add the stubs for !CONFIG_IOASID.

Thanks,
Jean

>  int ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
>  			       void (*fn)(ioasid_t id, void *data),
>  			       void *data);
> -- 
> 2.7.4
> 
