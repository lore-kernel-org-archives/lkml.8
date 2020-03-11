Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,SPOOFED_FREEMAIL_NO_RDNS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mout.gmx.net ([212.227.15.15]:52563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729989AbgCKQKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:10:32 -0400
Subject: Re: [PATCH] device core: fix dma_mask handling in
 platform_device_register_full
To: Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20200311160710.376090-1-hch@lst.de>
From: "Artem S. Tashkinov" <aros@gmx.com>
Message-ID: <1183e2c5-f29d-96a1-580d-64fbc0d40f89@gmx.com>
Date: Wed, 11 Mar 2020 16:10:28 +0000
MIME-Version: 1.0
In-Reply-To: <20200311160710.376090-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/11/20 4:07 PM, Christoph Hellwig wrote:
> Ever since the generic platform device code started allocating DMA masks
> itself the code to allocate and leak a private DMA mask in
> platform_device_register_full has been superflous.  More so the fact tha=
t
> it unconditionally frees the DMA mask allocation in the failure path
> can lead to slab corruption if the function fails later on for a device
> where it didn't allocate the mask.  Just remove the offending code.
>
> Fixes: cdfee5623290 ("driver core: initialize a default DMA mask for pla=
tform device")
> Reported-by: Artem S. Tashkinov <aros@gmx.com>
> Tested-by: Artem S. Tashkinov <aros@gmx.com>
> ---
>   drivers/base/platform.c | 14 --------------
>   1 file changed, 14 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 7fa654f1288b..47d3e6187a1c 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -662,19 +662,6 @@ struct platform_device *platform_device_register_fu=
ll(
>   	pdev->dev.of_node_reused =3D pdevinfo->of_node_reused;
>
>   	if (pdevinfo->dma_mask) {
> -		/*
> -		 * This memory isn't freed when the device is put,
> -		 * I don't have a nice idea for that though.  Conceptually
> -		 * dma_mask in struct device should not be a pointer.
> -		 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
> -		 */
> -		pdev->dev.dma_mask =3D
> -			kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
> -		if (!pdev->dev.dma_mask)
> -			goto err;
> -
> -		kmemleak_ignore(pdev->dev.dma_mask);
> -
>   		*pdev->dev.dma_mask =3D pdevinfo->dma_mask;
>   		pdev->dev.coherent_dma_mask =3D pdevinfo->dma_mask;
>   	}
> @@ -700,7 +687,6 @@ struct platform_device *platform_device_register_ful=
l(
>   	if (ret) {
>   err:
>   		ACPI_COMPANION_SET(&pdev->dev, NULL);
> -		kfree(pdev->dev.dma_mask);
>   		platform_device_put(pdev);
>   		return ERR_PTR(ret);
>   	}
>

I'd love to see this patch applied to the next round of stable kernels
(at the very least 5.5.x) ASAP because I've been stuck with kernel 5.3
on Fedora for quite some time already.

Thank you!

