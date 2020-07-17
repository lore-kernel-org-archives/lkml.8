Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B614EC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AFF220775
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1f5WJb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGQNoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:44:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47933 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726734AbgGQNog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594993474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mac458cRY7ETrZPwqvMBuN29OK7W50bpGzDOlGwzN9M=;
        b=F1f5WJb0x6fZOCbwQLp80TkCzsBd8zLEQYaT5dPIEeDgS5nzArr7GCeohoN348+CBB4BG6
        OSNtWpXCA8RboRhUi85jqEO0l/WeFGfS4480InjXGXhOrSb5jBsEIh/z+KHKmO0YTlroVm
        c9aRRSMrq/vpvCKnH1cfJnANpBntulk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-tz2RhTTGOl6eWUyXu-DDbQ-1; Fri, 17 Jul 2020 09:44:32 -0400
X-MC-Unique: tz2RhTTGOl6eWUyXu-DDbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D4868064AA;
        Fri, 17 Jul 2020 13:44:31 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 627D072AC7;
        Fri, 17 Jul 2020 13:44:25 +0000 (UTC)
Subject: Re: [PATCH v5 2/5] iommu/uapi: Add argsz for user filled data
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <1594925117-64892-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1594925117-64892-3-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <1538ec69-62a2-ea04-0870-a583fc63a2bf@redhat.com>
Date:   Fri, 17 Jul 2020 15:44:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1594925117-64892-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 7/16/20 8:45 PM, Jacob Pan wrote:
> As IOMMU UAPI gets extended, user data size may increase. To support
> backward compatibiliy, this patch introduces a size field to each UAPI
> data structures. It is *always* the responsibility for the user to fill in
> the correct size. Padding fields are adjusted to ensure 8 byte alignment.
> 
> Specific scenarios for user data handling are documented in:
> Documentation/userspace-api/iommu.rst
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/uapi/linux/iommu.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index e907b7091a46..d5e9014f690e 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -135,6 +135,7 @@ enum iommu_page_response_code {
>  
>  /**
>   * struct iommu_page_response - Generic page response information
> + * @argsz: User filled size of this data
>   * @version: API version of this structure
>   * @flags: encodes whether the corresponding fields are valid
>   *         (IOMMU_FAULT_PAGE_RESPONSE_* values)
> @@ -143,6 +144,7 @@ enum iommu_page_response_code {
>   * @code: response code from &enum iommu_page_response_code
>   */
>  struct iommu_page_response {
> +	__u32	argsz;
>  #define IOMMU_PAGE_RESP_VERSION_1	1
Don't you need to incr the version for all the modified structs?
>  	__u32	version;
>  #define IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)
> @@ -218,6 +220,7 @@ struct iommu_inv_pasid_info {
>  /**
>   * struct iommu_cache_invalidate_info - First level/stage invalidation
>   *     information
> + * @argsz: User filled size of this data
>   * @version: API version of this structure
>   * @cache: bitfield that allows to select which caches to invalidate
>   * @granularity: defines the lowest granularity used for the invalidation:
> @@ -246,6 +249,7 @@ struct iommu_inv_pasid_info {
>   * must support the used granularity.
>   */
>  struct iommu_cache_invalidate_info {
> +	__u32	argsz;
>  #define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
>  	__u32	version;
so there is no "flags" field in this struct. Is it OK?
>  /* IOMMU paging structure cache */
> @@ -255,7 +259,7 @@ struct iommu_cache_invalidate_info {
>  #define IOMMU_CACHE_INV_TYPE_NR		(3)
>  	__u8	cache;
>  	__u8	granularity;
> -	__u8	padding[2];
> +	__u8	padding[6];
>  	union {
>  		struct iommu_inv_pasid_info pasid_info;
>  		struct iommu_inv_addr_info addr_info;
> @@ -292,6 +296,7 @@ struct iommu_gpasid_bind_data_vtd {
>  
>  /**
>   * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
> + * @argsz:	User filled size of this data
>   * @version:	Version of this data structure
>   * @format:	PASID table entry format
>   * @flags:	Additional information on guest bind request
> @@ -309,17 +314,18 @@ struct iommu_gpasid_bind_data_vtd {
>   * PASID to host PASID based on this bind data.
>   */
>  struct iommu_gpasid_bind_data {
> +	__u32 argsz;
>  #define IOMMU_GPASID_BIND_VERSION_1	1
>  	__u32 version;
>  #define IOMMU_PASID_FORMAT_INTEL_VTD	1
>  	__u32 format;
> +	__u32 addr_width;
>  #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
>  	__u64 flags;
>  	__u64 gpgd;
>  	__u64 hpasid;
>  	__u64 gpasid;
> -	__u32 addr_width;
> -	__u8  padding[12];
> +	__u8  padding[8];
>  	/* Vendor specific data */
>  	union {
>  		struct iommu_gpasid_bind_data_vtd vtd;
> 
Thanks

Eric

