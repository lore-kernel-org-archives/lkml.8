Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACB4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4DC3207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dt6uptbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHJODc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:03:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46562 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727000AbgHJOD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597068208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0IyuaY9t2vA/B12pZXPt0Wm8+ZAqAc40MFsIlLkmWgc=;
        b=Dt6uptbjnTzrssBzon3gFqXcO2ZluNu6wqbMoDT5CeXz6qBtmz/cfie8PI/NVcd4lYpZLi
        5Ef74+1PiehCetRxnVcre5ObekX7iKxDX/guATyDSpMEc1875KwYc2Bykosw1tPrGxfLAv
        QmvqJ7qyxfljexLqqvLnD3WS3NF5i0s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-0-GZ4yaoMz-8lxtIvfUpcg-1; Mon, 10 Aug 2020 10:03:25 -0400
X-MC-Unique: 0-GZ4yaoMz-8lxtIvfUpcg-1
Received: by mail-wm1-f69.google.com with SMTP id d22so2914699wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0IyuaY9t2vA/B12pZXPt0Wm8+ZAqAc40MFsIlLkmWgc=;
        b=PsjeDwO9hnJ3bRF6dI+tKp7SsAjCwSyGItbdQhJBLZT8fNxvG+WO2ha1wTXMQME6BS
         3ySMp+f2iZbza5iIoiViyht65DddZPU8NMyPYYsmsaFZHqFpndr+7N5mVaDv3Cumo9gP
         HEgq/5RsrQ9Nt33KbPBPCIdWHSpBEgrteqe6qGszTI6LXeeXSYa9W2YugIBXKAbJN032
         JGXr5jmZ6t61+jsnzvrA/dQBTF8usIqKhSqzXifcbxBc4i68CsEQNcnjNlk2Ld6aIAGo
         sWdxZB7UGqHzRKpXhZxuXNSszekAumk4e8Jl3edPgYn450fWpquBsvJiyL8RD/rdHDTi
         xNEA==
X-Gm-Message-State: AOAM532pkdY1M5wToPG1APVOR3qQHUhVPi0zDkaHySez4vILzVUwaDgl
        EZQFEdyHouDtP+RiaL45Ho1ITM1NgZUz/MFBvoJJi16kZ0Q2nt61YxqOs267K8OBwRvlDpPtKhj
        fIucGHxvEN6IvTAXVT6NOj0uf
X-Received: by 2002:a7b:c1c2:: with SMTP id a2mr24858795wmj.74.1597068204361;
        Mon, 10 Aug 2020 07:03:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjNtR3OArq0V+wemZ+ZAqdL/eGbHMLXToEAuqW5w/uHw7UhkAdm+a8gtIMsDr6mATcbBH4jA==
X-Received: by 2002:a7b:c1c2:: with SMTP id a2mr24858780wmj.74.1597068204153;
        Mon, 10 Aug 2020 07:03:24 -0700 (PDT)
Received: from redhat.com (bzq-109-67-41-16.red.bezeqint.net. [109.67.41.16])
        by smtp.gmail.com with ESMTPSA id r11sm21350307wrw.78.2020.08.10.07.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:03:23 -0700 (PDT)
Date:   Mon, 10 Aug 2020 10:03:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2 05/20] virtio: Implement get_shm_region for MMIO
 transport
Message-ID: <20200810100240-mutt-send-email-mst@kernel.org>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-6-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807195526.426056-6-vgoyal@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 03:55:11PM -0400, Vivek Goyal wrote:
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> 
> On MMIO a new set of registers is defined for finding SHM
> regions.  Add their definitions and use them to find the region.
> 
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Cc: kvm@vger.kernel.org
> Cc: "Michael S. Tsirkin" <mst@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/virtio/virtio_mmio.c     | 32 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_mmio.h | 11 +++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 627ac0487494..2697c492cf78 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -498,6 +498,37 @@ static const char *vm_bus_name(struct virtio_device *vdev)
>  	return vm_dev->pdev->name;
>  }
>  
> +static bool vm_get_shm_region(struct virtio_device *vdev,
> +			      struct virtio_shm_region *region, u8 id)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	u64 len, addr;
> +
> +	/* Select the region we're interested in */
> +	writel(id, vm_dev->base + VIRTIO_MMIO_SHM_SEL);
> +
> +	/* Read the region size */
> +	len = (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_LOW);
> +	len |= (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_HIGH) << 32;
> +
> +	region->len = len;
> +
> +	/* Check if region length is -1. If that's the case, the shared memory
> +	 * region does not exist and there is no need to proceed further.
> +	 */
> +	if (len == ~(u64)0) {
> +		return false;
> +	}
> +

It might make sense to validate that addr/len do not overlap.
Will be useful for PCI too.
Can be a patch on top.

> +	/* Read the region base address */
> +	addr = (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_LOW);
> +	addr |= (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_HIGH) << 32;
> +
> +	region->addr = addr;
> +
> +	return true;
> +}
> +
>  static const struct virtio_config_ops virtio_mmio_config_ops = {
>  	.get		= vm_get,
>  	.set		= vm_set,
> @@ -510,6 +541,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
>  	.get_features	= vm_get_features,
>  	.finalize_features = vm_finalize_features,
>  	.bus_name	= vm_bus_name,
> +	.get_shm_region = vm_get_shm_region,
>  };
>  
>  
> diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio_mmio.h
> index c4b09689ab64..0650f91bea6c 100644
> --- a/include/uapi/linux/virtio_mmio.h
> +++ b/include/uapi/linux/virtio_mmio.h
> @@ -122,6 +122,17 @@
>  #define VIRTIO_MMIO_QUEUE_USED_LOW	0x0a0
>  #define VIRTIO_MMIO_QUEUE_USED_HIGH	0x0a4
>  
> +/* Shared memory region id */
> +#define VIRTIO_MMIO_SHM_SEL             0x0ac
> +
> +/* Shared memory region length, 64 bits in two halves */
> +#define VIRTIO_MMIO_SHM_LEN_LOW         0x0b0
> +#define VIRTIO_MMIO_SHM_LEN_HIGH        0x0b4
> +
> +/* Shared memory region base address, 64 bits in two halves */
> +#define VIRTIO_MMIO_SHM_BASE_LOW        0x0b8
> +#define VIRTIO_MMIO_SHM_BASE_HIGH       0x0bc
> +
>  /* Configuration atomicity value */
>  #define VIRTIO_MMIO_CONFIG_GENERATION	0x0fc
>  
> -- 
> 2.25.4
> 

