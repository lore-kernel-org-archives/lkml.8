Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CFFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A38AD205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DENV1wyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgHKVHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbgHKVHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597180066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=VthFkyGCFIh85pRmVSVaEBHjQustoj147EebE/56Eiw=;
        b=DENV1wygMlwh0HGD8eZyWolJ9y/4r8v6akmXTrkZLLvRME7zpJuFgpaiAsgnG/fK6hE0tQ
        JQBR8NTgnqTbxwHZcphgjuP7UC8KKPClwwIwHe2arYas4awjVLqHxDo7JUvTvznLNnVsAz
        tp81W+QliFdap1L3wpQfkhGL4a8sC/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-FYjZlXzsPp2LNMKyiGvItQ-1; Tue, 11 Aug 2020 17:07:42 -0400
X-MC-Unique: FYjZlXzsPp2LNMKyiGvItQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C10B8015F4;
        Tue, 11 Aug 2020 21:07:40 +0000 (UTC)
Received: from [10.36.112.12] (ovpn-112-12.ams2.redhat.com [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1456C5F9DF;
        Tue, 11 Aug 2020 21:07:36 +0000 (UTC)
Subject: Re: [PATCH v4 1/2] memremap: rename MEMORY_DEVICE_DEVDAX to
 MEMORY_DEVICE_GENERIC
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-nvdimm@lists.01.org, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org
References: <20200811094447.31208-1-roger.pau@citrix.com>
 <20200811094447.31208-2-roger.pau@citrix.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <96e34f77-8f55-d8a2-4d1f-4f4b667b0472@redhat.com>
Date:   Tue, 11 Aug 2020 23:07:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811094447.31208-2-roger.pau@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.20 11:44, Roger Pau Monne wrote:
> This is in preparation for the logic behind MEMORY_DEVICE_DEVDAX also
> being used by non DAX devices.
> 
> No functional change intended.
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: xen-devel@lists.xenproject.org
> Cc: linux-mm@kvack.org
> ---
>  drivers/dax/device.c     | 2 +-
>  include/linux/memremap.h | 9 ++++-----
>  mm/memremap.c            | 2 +-
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index 4c0af2eb7e19..1e89513f3c59 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -429,7 +429,7 @@ int dev_dax_probe(struct device *dev)
>  		return -EBUSY;
>  	}
>  
> -	dev_dax->pgmap.type = MEMORY_DEVICE_DEVDAX;
> +	dev_dax->pgmap.type = MEMORY_DEVICE_GENERIC;
>  	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
>  	if (IS_ERR(addr))
>  		return PTR_ERR(addr);
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 5f5b2df06e61..e5862746751b 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -46,11 +46,10 @@ struct vmem_altmap {
>   * wakeup is used to coordinate physical address space management (ex:
>   * fs truncate/hole punch) vs pinned pages (ex: device dma).
>   *
> - * MEMORY_DEVICE_DEVDAX:
> + * MEMORY_DEVICE_GENERIC:
>   * Host memory that has similar access semantics as System RAM i.e. DMA
> - * coherent and supports page pinning. In contrast to
> - * MEMORY_DEVICE_FS_DAX, this memory is access via a device-dax
> - * character device.
> + * coherent and supports page pinning. This is for example used by DAX devices
> + * that expose memory using a character device.
>   *
>   * MEMORY_DEVICE_PCI_P2PDMA:
>   * Device memory residing in a PCI BAR intended for use with Peer-to-Peer
> @@ -60,7 +59,7 @@ enum memory_type {
>  	/* 0 is reserved to catch uninitialized type fields */
>  	MEMORY_DEVICE_PRIVATE = 1,
>  	MEMORY_DEVICE_FS_DAX,
> -	MEMORY_DEVICE_DEVDAX,
> +	MEMORY_DEVICE_GENERIC,
>  	MEMORY_DEVICE_PCI_P2PDMA,
>  };
>  
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 03e38b7a38f1..006dace60b1a 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -216,7 +216,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>  			return ERR_PTR(-EINVAL);
>  		}
>  		break;
> -	case MEMORY_DEVICE_DEVDAX:
> +	case MEMORY_DEVICE_GENERIC:
>  		need_devmap_managed = false;
>  		break;
>  	case MEMORY_DEVICE_PCI_P2PDMA:
> 

No strong opinion (@Dan?), I do wonder if a separate type would make sense.

-- 
Thanks,

David / dhildenb

