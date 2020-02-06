Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58EEC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79935214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLSDRmcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgBFIge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:36:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27578 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727947AbgBFIge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580978193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=74n076s+3DHQh3T3bcXdZPPlzGYWoamkk1gc54HiO/8=;
        b=aLSDRmcZ2y9lV/rDRAVk0cTg0MNu+jbzh1YtuTvY7E+NMWSaMmNCzvK6s6vi+aY/3qKAzf
        DsX0Ne5fT2vcrmLog2+rB53ECslAXdueLgPpBZX49MCZz+cT9PeLohScVCov8PXi6bONZ4
        vDiH2XqHWHObmHzKF5fExVvpXU93I34=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-_L4Io6mqPRCix_yZrxR5qg-1; Thu, 06 Feb 2020 03:36:31 -0500
X-MC-Unique: _L4Io6mqPRCix_yZrxR5qg-1
Received: by mail-qk1-f200.google.com with SMTP id a132so3105660qkg.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=74n076s+3DHQh3T3bcXdZPPlzGYWoamkk1gc54HiO/8=;
        b=Aoz9QiNYbbjoDEpHaoQXU/ErddXSyl9bLqqEvyu82jInh3FXgkQRUY5L9j5Qx/6WP9
         Yg8pUcJ3lNB2DRuzG8+Koe1VLg/u1xNu+5SlZXOIcNkFYvmfRewefdDa8napW9Xt5b9s
         XbvGTWm2pmmB+R1KHaZji5UuqQtcu5ZgGnz2Zhc/lr6MbklhvlILaHnnVVx6LCKC628M
         nrCp5QLuZi3UZ5kDiCteLA+LDDDX0dblCC3lQD9bVW127nXyCRGR09L9aYK3qo/MiXhE
         Et4koXAnSerS6ehSUW99PLSdT/+i4RKY2gyETs6PUutPBsH+ezg3DJ9t09Wt8zoMrOsJ
         XPGQ==
X-Gm-Message-State: APjAAAXA5HePEOrW3FKBl25cOAxKugyLEgGyqxZGAsRxYzisR6/TAipf
        fP3X0dyesSbHJB1iHjPtRbQTkfkZqLG2fDsGLMi3wtgd90Eh4KVYPRQqqn4kz2NkdYu5waWBw1M
        vTfboeYd16xceRXIfV7DNQGCA
X-Received: by 2002:aed:204d:: with SMTP id 71mr1650672qta.116.1580978191351;
        Thu, 06 Feb 2020 00:36:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqwOjwDIx6ECH63BTSKTS7qQDsEkSPH49BMWkAwLbEf63JTlbiX87dRDwKUJa0Z97Qca2pYdzw==
X-Received: by 2002:aed:204d:: with SMTP id 71mr1650665qta.116.1580978191144;
        Thu, 06 Feb 2020 00:36:31 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id x126sm1099710qkc.42.2020.02.06.00.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:36:30 -0800 (PST)
Date:   Thu, 6 Feb 2020 03:36:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Liang Li <liang.z.li@intel.com>
Subject: Re: [PATCH v1 1/3] virtio-balloon: Fix memory leak when unloading
 while hinting is in progress
Message-ID: <20200206033617-mutt-send-email-mst@kernel.org>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205163402.42627-2-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 05:34:00PM +0100, David Hildenbrand wrote:
> When unloading the driver while hinting is in progress, we will not
> release the free page blocks back to MM, resulting in a memory leak.
> 
> Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Liang Li <liang.z.li@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Applied, thanks!

> ---
>  drivers/virtio/virtio_balloon.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 8e400ece9273..abef2306c899 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -968,6 +968,10 @@ static void remove_common(struct virtio_balloon *vb)
>  		leak_balloon(vb, vb->num_pages);
>  	update_balloon_size(vb);
>  
> +	/* There might be free pages that are being reported: release them. */
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> +		return_free_pages_to_mm(vb, ULONG_MAX);
> +
>  	/* Now we reset the device so we can clean up the queues. */
>  	vb->vdev->config->reset(vb->vdev);
>  
> -- 
> 2.24.1

