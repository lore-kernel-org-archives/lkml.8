Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B55C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D490D2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="J3TnySVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDIHR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:17:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32783 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgDIHR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:17:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so10693127wrd.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 00:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=XEywRyOXwpoRuTWlJ5j+LMEado440dnVx99CELnLolo=;
        b=J3TnySVG7X0SRfOQujg6yOG3DavP+JDN0lkGk+UlvIFcT6iYa5Q8C65gCTkCAtE2Mo
         kGmMZx6JLxF4erEc4I6K7rg8br6hzlz0f38KYmgt7Sh0IBzxOCuZ9JUe4h1rgeUm2VwD
         exythHc/jTstzJ2Fb1HjOoqzOI1cfvOyGgXMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XEywRyOXwpoRuTWlJ5j+LMEado440dnVx99CELnLolo=;
        b=R7rZhp+ZnNbcWSe4vuP9X0UONXH4KhYiYqh1UtJ0zzEnwc3q7IVppmLj8hPAp5efKq
         McmP3F2vsLb00kn1Mq71mOYqefbk4ddtZtzXlJG+P3U70ojZZGhchyTfzyX41/1p3NbA
         XzbN8hHc6zRyZrNq3u8EiQs6ynIkJ47Off/JsadSCzN0gtGlbQerXCI5WxlZk/797kXc
         aKh9O5VGMFW6H5xw+y2cP3laZucZVnXFEslUBekySEcuCcZQtRkMUbgVnb5h+9y+kimn
         HUf3ZmO3ZwJdwWwBrxOB0oWtBrDf1XTFCheRUMzrbdiUgEIa+BGTQvLd8HmbhCgnHUtK
         istA==
X-Gm-Message-State: AGi0Pua4w6Pl2sLtMhilIo9fSPcRz3TxOhOqOQcy83Frp+MfuQOyC7sN
        f8Tafh7A8DWHHrgKHodNhM/jeDES6uM=
X-Google-Smtp-Source: APiQypKS89n1ukOHevM/fA/En9CkkMkPx2aqkN1GaCwQI3yncisvGnWmhFn0YJmrjhmGia2Bk2TIOQ==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr13176684wrp.114.1586416672112;
        Thu, 09 Apr 2020 00:17:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v7sm2294539wmg.3.2020.04.09.00.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 00:17:51 -0700 (PDT)
Date:   Thu, 9 Apr 2020 09:17:49 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm: kirin: Revert change to add register connect helper
 functions
Message-ID: <20200409071749.GQ3456981@phenom.ffwll.local>
Mail-Followup-To: John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20200409004306.18541-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409004306.18541-1-john.stultz@linaro.org>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 12:43:06AM +0000, John Stultz wrote:
> Daniel noted[1] that commit d606dc9a6323 ("drm: kirin: Add
> register connect helper functions in drm init") was unnecessary
> and incorrect, as drm_dev_register does register connectors for
> us.
> 
> Thus, this patch reverts the change as suggested by Daniel.
> 
> [1]: https://lore.kernel.org/lkml/CAKMK7uHr5U-pPsxdQ4MpfK5v8iLjphDFug_3VTiUAf06nhS=yQ@mail.gmail.com/
> 
> Cc: Xu YiPing <xuyiping@hisilicon.com>
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Xinliang Liu <xinliang.liu@linaro.org>
> Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Chen Feng <puck.chen@hisilicon.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: dri-devel <dri-devel@lists.freedesktop.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks for the quick fix!

Cheers, Daniel

> ---
>  .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   |  1 -
>  .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 43 -------------------
>  .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  1 -
>  3 files changed, 45 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> index 86000127d4ee..c339e632522a 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> @@ -940,7 +940,6 @@ static struct drm_driver ade_driver = {
>  };
>  
>  struct kirin_drm_data ade_driver_data = {
> -	.register_connects = false,
>  	.num_planes = ADE_CH_NUM,
>  	.prim_plane = ADE_CH1,
>  	.channel_formats = channel_formats,
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> index d3145ae877d7..4349da3e2379 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> @@ -219,40 +219,6 @@ static int kirin_drm_kms_cleanup(struct drm_device *dev)
>  	return 0;
>  }
>  
> -static int kirin_drm_connectors_register(struct drm_device *dev)
> -{
> -	struct drm_connector *connector;
> -	struct drm_connector *failed_connector;
> -	struct drm_connector_list_iter conn_iter;
> -	int ret;
> -
> -	mutex_lock(&dev->mode_config.mutex);
> -	drm_connector_list_iter_begin(dev, &conn_iter);
> -	drm_for_each_connector_iter(connector, &conn_iter) {
> -		ret = drm_connector_register(connector);
> -		if (ret) {
> -			failed_connector = connector;
> -			goto err;
> -		}
> -	}
> -	drm_connector_list_iter_end(&conn_iter);
> -	mutex_unlock(&dev->mode_config.mutex);
> -
> -	return 0;
> -
> -err:
> -	drm_connector_list_iter_begin(dev, &conn_iter);
> -	drm_for_each_connector_iter(connector, &conn_iter) {
> -		if (failed_connector == connector)
> -			break;
> -		drm_connector_unregister(connector);
> -	}
> -	drm_connector_list_iter_end(&conn_iter);
> -	mutex_unlock(&dev->mode_config.mutex);
> -
> -	return ret;
> -}
> -
>  static int kirin_drm_bind(struct device *dev)
>  {
>  	struct kirin_drm_data *driver_data;
> @@ -279,17 +245,8 @@ static int kirin_drm_bind(struct device *dev)
>  
>  	drm_fbdev_generic_setup(drm_dev, 32);
>  
> -	/* connectors should be registered after drm device register */
> -	if (driver_data->register_connects) {
> -		ret = kirin_drm_connectors_register(drm_dev);
> -		if (ret)
> -			goto err_drm_dev_unregister;
> -	}
> -
>  	return 0;
>  
> -err_drm_dev_unregister:
> -	drm_dev_unregister(drm_dev);
>  err_kms_cleanup:
>  	kirin_drm_kms_cleanup(drm_dev);
>  err_drm_dev_put:
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
> index 4d5c05a24065..dee8ec2f7f2e 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
> @@ -37,7 +37,6 @@ struct kirin_drm_data {
>  	u32 channel_formats_cnt;
>  	int config_max_width;
>  	int config_max_height;
> -	bool register_connects;
>  	u32 num_planes;
>  	u32 prim_plane;
>  
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
