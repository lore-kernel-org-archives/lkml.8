Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8DFC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D886A21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="M0PjjdgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgBGNoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:44:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43928 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGNoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:44:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id z9so2719894wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 05:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=m9Hn1RaUXFooKHwmRZTfAKZ274VjztClE8pDRYYGw2c=;
        b=M0PjjdgYCPa6DgxGqO3xxPQ3OX262TSN0UqM6Kqiq8/lumJMhLG+2HPA3bnZvyhpwc
         CVSO/cXMEAMr+UUk3ef8vaeTxw3+qSrjyvfJWj/sLyvEzrHr1LqWAjHi8Ap3jRrWzagR
         fWYlOeYeXN31g0NzMnTA5QYYX6ZfrRyNtdkGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=m9Hn1RaUXFooKHwmRZTfAKZ274VjztClE8pDRYYGw2c=;
        b=lHtpejGyJKk1YCdJJtCieink4f7B5Aqk3qr40j52a7oSjCwvp9VMNO1EFjI8/UXYAy
         XgfQ5wUqVlvLsqYDYMMZP1qGb9Qy9An8GOoRWnG9nutadjyk2QgB0XZfOTbsfyhHhxwt
         3KjeewjRnEoRFqjTbiFszdb/IKITmwe6i1+o+DlsCjzxP+uqa9GZnG8Ywr0D+rodw9ex
         UU7ODPL5/KpVUZf7IoIGwpGhfUnXnjEJ3BUxiJoIoRgJvKD+GaU/SYRxsx07yqxVtC/Q
         l/dQYlzT1VvMsLayzM9BVDYM8a7DWIi0ZcLCesy/t7m1uq1t6E2+3Y6gZjhl04fqphPi
         M4tQ==
X-Gm-Message-State: APjAAAXcsGzWowgvZsPvg1aklEf0Zj7vwXwWm4ZAnT1D/nXRDUw907/C
        QVs6GnpLhoAGQHT3Gpk1KnUqCCgwhKLqEQ==
X-Google-Smtp-Source: APXvYqwJ37XAlNKHJ3NdiUGsMdK5N0tuoJlJ5hgMTD925OdVra68xNS96qXdlwiN2Ssrdy6rDTdM8Q==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr5065348wrk.53.1581083054017;
        Fri, 07 Feb 2020 05:44:14 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g25sm16762868wmh.3.2020.02.07.05.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 05:44:13 -0800 (PST)
Date:   Fri, 7 Feb 2020 14:44:11 +0100
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
Subject: Re: [PATCH] drm/qxl: add drm_driver.release callback.
Message-ID: <20200207134411.GB43062@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200207121405.25895-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207121405.25895-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 01:14:05PM +0100, Gerd Hoffmann wrote:
> Move final cleanups to qxl_drm_release() callback.
> Add drm_atomic_helper_shutdown() call to qxl_pci_remove().
> 
> Reorder calls in qxl_device_fini().  Cleaning up gem & ttm
> might trigger qxl commands, so we should do that before
> releaseing command rings.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 21 ++++++++++++++-------
>  drivers/gpu/drm/qxl/qxl_kms.c |  8 ++++----
>  2 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 1d601f57a6ba..8044363ba0f2 100644
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
> @@ -132,21 +133,25 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	return ret;
>  }
>  
> +static void qxl_drm_release(struct drm_device *dev)
> +{
> +	struct qxl_device *qdev = dev->dev_private;
> +
> +	qxl_modeset_fini(qdev);
> +	qxl_device_fini(qdev);

Same here, there's a few iounmap and io_mapping_free which I think should
be in the pci_remove hook.
-Daniel

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
> @@ -279,6 +284,8 @@ static struct drm_driver qxl_driver = {
>  	.major = 0,
>  	.minor = 1,
>  	.patchlevel = 0,
> +
> +	.release = qxl_drm_release,
>  };
>  
>  static int __init qxl_init(void)
> diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
> index bfc1631093e9..70b20ee4741a 100644
> --- a/drivers/gpu/drm/qxl/qxl_kms.c
> +++ b/drivers/gpu/drm/qxl/qxl_kms.c
> @@ -299,12 +299,12 @@ void qxl_device_fini(struct qxl_device *qdev)
>  {
>  	qxl_bo_unref(&qdev->current_release_bo[0]);
>  	qxl_bo_unref(&qdev->current_release_bo[1]);
> -	flush_work(&qdev->gc_work);
> -	qxl_ring_free(qdev->command_ring);
> -	qxl_ring_free(qdev->cursor_ring);
> -	qxl_ring_free(qdev->release_ring);
>  	qxl_gem_fini(qdev);
>  	qxl_bo_fini(qdev);
> +	flush_work(&qdev->gc_work);
> +	qxl_ring_free(qdev->command_ring);
> +	qxl_ring_free(qdev->cursor_ring);
> +	qxl_ring_free(qdev->release_ring);
>  	io_mapping_free(qdev->surface_mapping);
>  	io_mapping_free(qdev->vram_mapping);
>  	iounmap(qdev->ram_header);
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
