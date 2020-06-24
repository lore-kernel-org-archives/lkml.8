Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26779C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC0420823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGhN7dyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbgFXJG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:06:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32831 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728463AbgFXJG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592989615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BWweQzpvz5qRvsYocQLFZ/CEELAJfUtNzgc7NW2oHMc=;
        b=CGhN7dyV+qMddUF4oBDwNhIkVao2HbnxaoePCr1VSfgO7bHrW/RfIy1dolC+IMQoYJpN/F
        xTj/RKsjY1TxQiMhxaj8IoJZ1zmGBJ4RwuOdkshKlKvtM5M3Qc5cxCTEUTPWUbMeHiJcDk
        ptgr8/KgF45U0nr2HI0tuFwQDy/wLFA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-qlgsM7iXMgKv59FCCcEBAA-1; Wed, 24 Jun 2020 05:06:54 -0400
X-MC-Unique: qlgsM7iXMgKv59FCCcEBAA-1
Received: by mail-wm1-f72.google.com with SMTP id g187so2098932wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 02:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BWweQzpvz5qRvsYocQLFZ/CEELAJfUtNzgc7NW2oHMc=;
        b=Nh/iBRe5LRNHbvm5Ui140vR52LHAk7jNtRlwqsQPMzuBinyf2i3FqV8RQtktD3SXGI
         O+CYiPLMuoOZ+V20rXVMmV9qvMYVKYe/lUG6Mx0TZY3TxlQTvUNNRiGgZQZY2aZFE+yV
         M+vbl1jkq5riilKVl0KW1aKKtLRnjrkEqo3Eq/egx9q+pcwxsGxlulSHILT6t+An2DV5
         uwUgksG/rROkvCOFtx7jgSI3dgwtiG2AVOrXRTZY4DBmNhJdaWpen9OA/U+Kz3Sg+5RT
         xUJtm35CPyHLxHIaqmitz6gHq/Cqf+ymxw0me4CM4n+NDkuu1RlxL8YZF6NRAZwBwjzU
         01KA==
X-Gm-Message-State: AOAM532d45XJP+CHIi6Brpml/FNdVqEGDyMRCM32hYGqcKL71IdN87f2
        2bre6utwSoMDTNXVfHA75B1TjBmEGW3XbTdDZ/1V4ILK7nZ2iIH0n6rSnO2m7FEu/CD9ngrgVql
        8Mke+mrC8MjtMGZsK8cMLrSsE
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr276001wmk.170.1592989612933;
        Wed, 24 Jun 2020 02:06:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCjnIRq0GLGlJ0yYJ0oEVhHQJi+H1TnyLeWn06GTYZrPy1eSbfHNnWW2xTl+/KbPsMMBv1Rw==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr275986wmk.170.1592989612754;
        Wed, 24 Jun 2020 02:06:52 -0700 (PDT)
Received: from redhat.com ([82.166.20.53])
        by smtp.gmail.com with ESMTPSA id n189sm7181712wmb.43.2020.06.24.02.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 02:06:51 -0700 (PDT)
Date:   Wed, 24 Jun 2020 05:06:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, konrad.wilk@oracle.com, jasowang@redhat.com,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, linux-imx@nxp.com
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Message-ID: <20200624050355-mutt-send-email-mst@kernel.org>
References: <20200624091732.23944-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624091732.23944-1-peng.fan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> Export xen_swiotlb for all platforms using xen swiotlb
> 
> Use xen_swiotlb to determine when vring should use dma APIs to map the
> ring: when xen_swiotlb is enabled the dma API is required. When it is
> disabled, it is not required.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for this?
Xen was there first, but everyone else is using that now.


> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a2de775801af..768afd79f67a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -252,7 +252,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	 * the DMA API if we're a Xen guest, which at least allows
>  	 * all of the sensible Xen configurations to work correctly.
>  	 */
> -	if (xen_domain())
> +	if (xen_vring_use_dma())
>  		return true;
>  
>  	return false;


The comment above this should probably be fixed.

-- 
MST

