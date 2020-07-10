Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0275BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1BD52078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgGJIT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgGJIT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:19:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C2C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:19:58 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jtoGB-0008Kp-Uh; Fri, 10 Jul 2020 10:19:56 +0200
Message-ID: <6098f2549eb96348af0ba062d87a716f20d1af1c.camel@pengutronix.de>
Subject: Re: [PATCH 2/4] drm/etnaviv: add loadavg accounting
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     cphealy@gmail.com, Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Date:   Fri, 10 Jul 2020 10:19:54 +0200
In-Reply-To: <20200710074143.306787-3-christian.gmeiner@gmail.com>
References: <20200710074143.306787-1-christian.gmeiner@gmail.com>
         <20200710074143.306787-3-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Am Freitag, den 10.07.2020, 09:41 +0200 schrieb Christian Gmeiner:
> The GPU has an idle state register where each bit represents the idle
> state of a sub-GPU component like FE or TX. Sample this register
> every 10ms and calculate a simple moving average over the sub-GPU
> component idle states with a total observation time frame of 1s.
> 
> This provides us with a percentage based load of each sub-GPU
> component.
> 
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 14 ++++++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 32 +++++++++++++++++++++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.h | 29 ++++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index f9afe11c50f0..b31920241c86 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -46,6 +46,19 @@ static void load_gpu(struct drm_device *dev)
>  	}
>  }
>  
> +static void unload_gpu(struct drm_device *dev)
> +{
> +	struct etnaviv_drm_private *priv = dev->dev_private;
> +	unsigned int i;
> +
> +	for (i = 0; i < ETNA_MAX_PIPES; i++) {
> +		struct etnaviv_gpu *g = priv->gpu[i];
> +
> +		if (g)
> +			etnaviv_gpu_shutdown(g);
> +	}
> +}
> +
>  static int etnaviv_open(struct drm_device *dev, struct drm_file *file)
>  {
>  	struct etnaviv_drm_private *priv = dev->dev_private;
> @@ -581,6 +594,7 @@ static void etnaviv_unbind(struct device *dev)
>  	struct drm_device *drm = dev_get_drvdata(dev);
>  	struct etnaviv_drm_private *priv = drm->dev_private;
>  
> +	unload_gpu(drm);
>  	drm_dev_unregister(drm);
>  
>  	component_unbind_all(dev, drm);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index a31eeff2b297..1f0eb7e00657 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -714,6 +714,28 @@ static void etnaviv_gpu_hw_init(struct etnaviv_gpu *gpu)
>  	gpu_write(gpu, VIVS_HI_INTR_ENBL, ~0U);
>  }
>  
> +static void etnaviv_loadavg_function(struct timer_list *t)
> +{
> +	struct etnaviv_gpu *gpu = from_timer(gpu, t, loadavg_timer);
> +	const u32 idle = gpu_read(gpu, VIVS_HI_IDLE_STATE);

This isn't guaranteed to work on a clock/power gated GPU. Also we
surely don't want to wake a idle system every 10ms just to sample a "no
load" value, so this needs some integration with runtime PM, to disable
the sampling when the GPU is powered down and enable when powered up.
The loadavg must be able to adapt to jumps in the sampling interval
while idle.

> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(etna_idle_module_names); i++)
> +		if ((idle & etna_idle_module_names[i].bit))
> +			sma_loadavg_add(&gpu->loadavg_value[i], 0);
> +		else
> +			sma_loadavg_add(&gpu->loadavg_value[i], 100);
> +
> +	spin_lock_bh(&gpu->loadavg_spinlock);
> +
> +	for (i = 0; i < ARRAY_SIZE(etna_idle_module_names); i++)
> +		gpu->loadavg_percentage[i] = sma_loadavg_read(&gpu->loadavg_value[i]);
> +
> +	spin_unlock_bh(&gpu->loadavg_spinlock);
> +
> +	mod_timer(t, jiffies + msecs_to_jiffies(10));

A jiffies based timer is much too coarse for a regular 10ms sampling.
On a typical 100Hz system 10ms is a single jiffy, so your timer will
fire anywhere in the range of ~0ms...~20ms. This won't get us a usable
measurement.

Regards,
Lucas

> +}
> +
>  int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
>  {
>  	struct etnaviv_drm_private *priv = gpu->drm->dev_private;
> @@ -804,6 +826,10 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
>  	for (i = 0; i < ARRAY_SIZE(gpu->event); i++)
>  		complete(&gpu->event_free);
>  
> +	/* Setup loadavg timer */
> +	timer_setup(&gpu->loadavg_timer, etnaviv_loadavg_function, 0);
> +	mod_timer(&gpu->loadavg_timer, jiffies + msecs_to_jiffies(10));
> +
>  	/* Now program the hardware */
>  	mutex_lock(&gpu->lock);
>  	etnaviv_gpu_hw_init(gpu);
> @@ -824,6 +850,11 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
>  	return ret;
>  }
>  
> +void etnaviv_gpu_shutdown(struct etnaviv_gpu *gpu)
> +{
> +	del_timer(&gpu->loadavg_timer);
> +}
> +
>  #ifdef CONFIG_DEBUG_FS
>  struct dma_debug {
>  	u32 address[2];
> @@ -1762,6 +1793,7 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>  	gpu->dev = &pdev->dev;
>  	mutex_init(&gpu->lock);
>  	mutex_init(&gpu->fence_lock);
> +	spin_lock_init(&gpu->loadavg_spinlock);
>  
>  	/* Map registers: */
>  	gpu->mmio = devm_platform_ioremap_resource(pdev, 0);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> index 8ea48697d132..a5b9c89c6744 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> @@ -10,6 +10,8 @@
>  #include "etnaviv_gem.h"
>  #include "etnaviv_mmu.h"
>  #include "etnaviv_drv.h"
> +#include "etnaviv_sma.h"
> +#include "state_hi.xml.h"
>  
>  struct etnaviv_gem_submit;
>  struct etnaviv_vram_mapping;
> @@ -91,6 +93,26 @@ struct clk;
>  
>  #define ETNA_NR_EVENTS 30
>  
> +DECLARE_SMA(loadavg, 100)
> +
> +static const struct {
> +    const char *name;
> +    u32 bit;
> +} etna_idle_module_names[] = {
> +    { "FE", VIVS_HI_IDLE_STATE_FE },
> +    { "DE", VIVS_HI_IDLE_STATE_DE },
> +    { "PE", VIVS_HI_IDLE_STATE_PE },
> +    { "SH", VIVS_HI_IDLE_STATE_SH },
> +    { "PA", VIVS_HI_IDLE_STATE_PA },
> +    { "SE", VIVS_HI_IDLE_STATE_SE },
> +    { "RA", VIVS_HI_IDLE_STATE_RA },
> +    { "TX", VIVS_HI_IDLE_STATE_TX },
> +    { "VG", VIVS_HI_IDLE_STATE_VG },
> +    { "IM", VIVS_HI_IDLE_STATE_IM },
> +    { "FP", VIVS_HI_IDLE_STATE_FP },
> +    { "TS", VIVS_HI_IDLE_STATE_TS },
> +};
> +
>  struct etnaviv_gpu {
>  	struct drm_device *drm;
>  	struct thermal_cooling_device *cooling;
> @@ -145,6 +167,12 @@ struct etnaviv_gpu {
>  	unsigned int freq_scale;
>  	unsigned long base_rate_core;
>  	unsigned long base_rate_shader;
> +
> +	/* Loadavg: */
> +	struct timer_list loadavg_timer;
> +	spinlock_t loadavg_spinlock;
> +	struct sma_loadavg loadavg_value[ARRAY_SIZE(etna_idle_module_names)];
> +	unsigned int loadavg_percentage[ARRAY_SIZE(etna_idle_module_names)];
>  };
>  
>  static inline void gpu_write(struct etnaviv_gpu *gpu, u32 reg, u32 data)
> @@ -160,6 +188,7 @@ static inline u32 gpu_read(struct etnaviv_gpu *gpu, u32 reg)
>  int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value);
>  
>  int etnaviv_gpu_init(struct etnaviv_gpu *gpu);
> +void etnaviv_gpu_shutdown(struct etnaviv_gpu *gpu);
>  bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu);
>  
>  #ifdef CONFIG_DEBUG_FS

