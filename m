Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F8AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54080206B8
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgDLOS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 10:18:56 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:57146 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgDLOS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 10:18:56 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 835BC804A3;
        Sun, 12 Apr 2020 16:18:49 +0200 (CEST)
Date:   Sun, 12 Apr 2020 16:18:42 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     puck.chen@hisilicon.com, airlied@linux.ie, daniel@ffwll.ch,
        tzimmermann@suse.de, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] drm/hisilicon: Add the shutdown for hibmc_pci_driver
Message-ID: <20200412141842.GA12313@ravnborg.org>
References: <1586573370-41945-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586573370-41945-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=BTeA3XvPAAAA:8
        a=e5mUnYsNAAAA:8 a=AGzG8Xd3EExtzCPMGWIA:9 a=CjuIK1q_8ugA:10
        a=tafbbOV3vt1XuEhzTjGK:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tian.

On Sat, Apr 11, 2020 at 10:49:30AM +0800, Tian Tao wrote:
> add the shutdown function to release the resource.
> 

Why it the release of the memory required in the shutdown method?
The memory is allocated using devm_ioremap() which
will let device management handle the release of the resources when
he driver is released.

The patch also introduces a pci_disable_device()
The better approch would be to use pcim_enable_device()
so you let the device management about releasing the
resources.

	Sam

> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index a6fd0c2..126d4f4 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -232,6 +232,21 @@ static int hibmc_hw_map(struct hibmc_drm_private *priv)
>  	return 0;
>  }
>  
> +static void hibmc_hw_unmap(struct hibmc_drm_private *priv)
> +{
> +	struct drm_device *dev = priv->dev;
> +
> +	if (priv->mmio)	{
> +		devm_iounmap(dev->dev, priv->mmio);
> +		priv->mmio = NULL;
> +	}
> +
> +	if (priv->fb_map) {
> +		devm_iounmap(dev->dev, priv->fb_map);
> +		priv->fb_map = NULL;
> +	}
> +}
> +
>  static int hibmc_hw_init(struct hibmc_drm_private *priv)
>  {
>  	int ret;
> @@ -258,6 +273,7 @@ static int hibmc_unload(struct drm_device *dev)
>  
>  	hibmc_kms_fini(priv);
>  	hibmc_mm_fini(priv);
> +	hibmc_hw_unmap(priv);
>  	dev->dev_private = NULL;
>  	return 0;
>  }
> @@ -374,6 +390,12 @@ static void hibmc_pci_remove(struct pci_dev *pdev)
>  	drm_dev_unregister(dev);
>  	hibmc_unload(dev);
>  	drm_dev_put(dev);
> +	pci_disable_device(pdev);
> +}
> +
> +static void hibmc_pci_shutdown(struct pci_dev *pdev)
> +{
> +	hibmc_pci_remove(pdev);
>  }
>  
>  static struct pci_device_id hibmc_pci_table[] = {
> @@ -386,6 +408,7 @@ static struct pci_driver hibmc_pci_driver = {
>  	.id_table =	hibmc_pci_table,
>  	.probe =	hibmc_pci_probe,
>  	.remove =	hibmc_pci_remove,
> +	.shutdown = hibmc_pci_shutdown,
>  	.driver.pm =    &hibmc_pm_ops,
>  };
>  
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
