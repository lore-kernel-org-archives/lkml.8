Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A956CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8159C206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fe5vKm8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgIAMpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:45:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54197 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728067AbgIAMN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598962389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rdmHH/b1jYUmUDSGEjwkqQ1FjyPV/N1Xn4edTd1na+o=;
        b=Fe5vKm8nVBInMf1hV7rb3lVDRl9O/ZUBZwxBx4H/07LN42Xo72SUjDatb72DFbicdkDzhp
        hQ6LMlekbp1G4RmVHC45274JIpY9JS2OiwSPyxqnGEt6vl82AAEY3ldWm/CKGBy1OGG69+
        RhrwTx/ZjY+Oh6eoRXPCM6d+lPGU9fs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-taBQ7Gf-Ooq5NVTApcU-Uw-1; Tue, 01 Sep 2020 08:13:07 -0400
X-MC-Unique: taBQ7Gf-Ooq5NVTApcU-Uw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EF9D1888A3E;
        Tue,  1 Sep 2020 12:13:05 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1077747B0;
        Tue,  1 Sep 2020 12:13:01 +0000 (UTC)
Subject: Re: [PATCH v2 4/9] iommu/ioasid: Add reference couting functions
To:     Jacob Pan <jacob.pan.linux@gmail.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Wu Hao <hao.wu@intel.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-5-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <fed6c93b-8538-662c-2273-19ae2f2f7464@redhat.com>
Date:   Tue, 1 Sep 2020 14:13:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1598070918-21321-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 8/22/20 6:35 AM, Jacob Pan wrote:
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
s/recount/refcount
> + *     No new reference can be added. The IOASID is not returned to the pool
can be taken
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
I would drop this last sentence
> + *
> + * - ioasid_find() does not take reference, caller must hold reference
So can you use ioasid_find() once the state is
IOASID_STATE_FREE_PENDING? According to Jean's reply, the "IOASID may be
freed once ioasid_find() returns but not the returned data." So holding
a ref is not mandated right?
> + *
> + * ioasid_free() can be called multiple times without error until all refs are
> + * dropped.
> + */
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
maybe try to normalize your traces using always the same formatting for
ioasids and ioasid sets. Also we can understand %u is the id of the set.
> +		/* data found but does not belong to the set */
you can get rid of this comment
> +		return -EACCES;
> +	}
> +	refcount_inc(&data->users);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_get_locked);
> +
> +/**
> + * ioasid_get - Obtain a reference of an ioasid
> + * @set
> + * @ioasid
> + *
> + * Check set ownership if @set is non-null.
> + */
> +int ioasid_get(struct ioasid_set *set, ioasid_t ioasid)
> +{
> +	int ret = 0;
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
was set%u above
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
>  int ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
>  			       void (*fn)(ioasid_t id, void *data),
>  			       void *data);
> 
Thanks

Eric

