Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BE2C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1162080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="W0V0l0jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgBJPGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:06:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37765 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgBJPGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:06:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id a6so740344wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 07:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=SZWw5BNnqsxO+B1PSnFYos2X0WTIUEc5MmcB9KkYh80=;
        b=W0V0l0jrXQHgBSOItUTUJwRpOtkv/Q/smtmpPUJS47OOLZBD9qbyJ8CY7KClmjxKxE
         OFc5xuUJTNI4H//VPHEy4UoWZp7QD8sRKpumXKABiIZpcpZIkyHN4QhqxByZ2lH+sKZu
         XV3LNb2Q4Jr9z+7WNawVmGuKpSgkkjfr0VcRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=SZWw5BNnqsxO+B1PSnFYos2X0WTIUEc5MmcB9KkYh80=;
        b=sus6dr4menGuCnMJUJA2Iv/dRT4a+AeL5AxtDcsfM70NDjosPmRknFiTAlp2W/fZZU
         okr7XFF/aCPYuqJsxjyddpckLpCvxIZWlXsOztCjhhQdzhu+MGm0i13CP6BaIel/dT2t
         r5YXbFEHDo4U1CRg3JbFYaRVNHygD3B+bOF5USh6TLLS0jc/d90Peds8caMVmtb/OweF
         ftReNjfksN1qqEI7roMpeq/2KuGWvwnXRcDcxI064dTP8T/7B/HRUkbs3NAKG+ukDHqp
         CiLtl2Ycw/nQiNbpDVLDdXPo4w1tns0U8iet8xCvet7HkCk4WYAPcQkPwILcEobcsB3/
         eVmw==
X-Gm-Message-State: APjAAAWvrCypJrEnU7lQhaCffRPEu1DcLSnKCIw8/LKzCSYw4lyvSqjs
        dsaUMvIwCztEJa7YySu0er0+Ag==
X-Google-Smtp-Source: APXvYqzYMP69IToA5/mmhtOboZyOY6hCkleSPGfnRYobetT8q7zeS4pAYMffcDEcpwKzvUZc8Wsx2Q==
X-Received: by 2002:a1c:44d:: with SMTP id 74mr16475365wme.53.1581347195749;
        Mon, 10 Feb 2020 07:06:35 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t13sm935403wrw.19.2020.02.10.07.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 07:06:35 -0800 (PST)
Date:   Mon, 10 Feb 2020 16:06:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] drm/qxl: add drm_driver.release callback.
Message-ID: <20200210150633.GS43062@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200210113753.5614-1-kraxel@redhat.com>
 <20200210113753.5614-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210113753.5614-3-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 12:37:52PM +0100, Gerd Hoffmann wrote:
> Move final cleanups to qxl_drm_release() callback.
> Add drm_atomic_helper_shutdown() call to qxl_pci_remove().
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 1d601f57a6ba..4fda3f9b29f4 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -34,6 +34,7 @@
>  #include <linux/pci.h>
>  
>  #include <drm/drm.h>
> +#include <drm/drm_atomic_helper.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_modeset_helper.h>
> @@ -132,21 +133,30 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	return ret;
>  }
>  
> +static void qxl_drm_release(struct drm_device *dev)
> +{
> +	struct qxl_device *qdev = dev->dev_private;
> +
> +	/*
> +	 * TODO: qxl_device_fini() call should be in qxl_pci_remove(),
> +	 * reodering qxl_modeset_fini() + qxl_device_fini() calls is
> +	 * non-trivial though.
> +	 */
> +	qxl_modeset_fini(qdev);

So the drm_mode_config_cleanup call in here belongs in ->release, but the
qxl_destroy_monitors_object feels like should be perfectly fine in the
remove hook. You might need to sprinkle a few drm_dev_enter/exit around to
protect code paths thought.

Aside from this lgtm, for the series

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

And up to you whether you want to fix this or not really.

Btw for testing all these patches that add a ->release hook I think it'd
be good if the drm core checks that drm_device->dev is set to NULL, and
that we do this in the remove hook. Since that's guaranteed to be gone at
that point, so anything in ->release that still needs the device is
broken. Ofc maybe do that check only for drivers which have a ->release
hook, and we might need a few fixups.

Cheers, Daniel

> +	qxl_device_fini(qdev);
> +	dev->dev_private = NULL;
> +	kfree(qdev);
> +}
> +
>  static void
>  qxl_pci_remove(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev = pci_get_drvdata(pdev);
> -	struct qxl_device *qdev = dev->dev_private;
>  
>  	drm_dev_unregister(dev);
> -
> -	qxl_modeset_fini(qdev);
> -	qxl_device_fini(qdev);
> +	drm_atomic_helper_shutdown(dev);
>  	if (is_vga(pdev))
>  		vga_put(pdev, VGA_RSRC_LEGACY_IO);
> -
> -	dev->dev_private = NULL;
> -	kfree(qdev);
>  	drm_dev_put(dev);
>  }
>  
> @@ -279,6 +289,8 @@ static struct drm_driver qxl_driver = {
>  	.major = 0,
>  	.minor = 1,
>  	.patchlevel = 0,
> +
> +	.release = qxl_drm_release,
>  };
>  
>  static int __init qxl_init(void)
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
