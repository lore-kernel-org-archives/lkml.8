Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0972FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C0C20678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="diAPk9Nz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgFCIYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgFCIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:24:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB50C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 01:24:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f5so1041309wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=qRRViGgr/XMXuK899gyJpd+glkMI9g3TUAqhc5bIdms=;
        b=diAPk9NzqmTTMCUpwWl/9I43wRC0s9YisBeaJ3i/Ao27NvMQV2tq0o/amb5EsgN5Dc
         m7UOzOkQ1IcJFbc/rP+zbfrn4e78xzB8fxvBTJwqpUCIS+KXHxZzWv0fJ8aqglCSFuUF
         PsgSO47gzy0i41trTDnIz8ohkR0xLziwSCsy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=qRRViGgr/XMXuK899gyJpd+glkMI9g3TUAqhc5bIdms=;
        b=azicj/RUidtys10FpCIWmF0qrzDurus3e70Pe9T45W0QU6B2mM5431X1wCW1zZuGQG
         d/VP2/ou0Cpw5I+d7axXkJUjXDAUAvI+SjTpqeKeC8+Na8BPAXz7i0Un7PDNKpG0Ujax
         MOlAHbqkiuEgkOCBHjFXKIgBq2aCEgc1Noz6sRGsNX/ayIPpBwAbd3Br/OQBU0+ddhEb
         zW8nlOps1wwHnW7WjEi0Zmetv0C9iCXXisjN6z29xwmAr1vR6RBynX7j1PT4v0azOO/F
         UmhW4bgey+59VZ1u8YyKElmgFsOu5lwpXAkFdkvkX1y2NT8EtIkBmIEQC2yUOxfmhRr2
         BSVQ==
X-Gm-Message-State: AOAM530WyzrexH8uwkcH+Gi0bYs9LmizmmehIROGBzKMM4RGC9hjcYdE
        8A9v4pEla+5LA24CofoXG44hHg==
X-Google-Smtp-Source: ABdhPJwF05tJg2U8YAuUBqkP69xy0KO/yd1uPSYB+TFlsp2LQxAA+L8XZMe3ryw0UOWY+kevnffgNw==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr7447279wmc.142.1591172653407;
        Wed, 03 Jun 2020 01:24:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p10sm2318468wra.78.2020.06.03.01.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 01:24:12 -0700 (PDT)
Date:   Wed, 3 Jun 2020 10:24:11 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jeykumar Sankaran <jsanka@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Steve Cohen <cohens@codeaurora.org>, seanpaul@chromium.org
Subject: Re: [PATCH] drm/connector: notify userspace on hotplug after
 register complete
Message-ID: <20200603082411.GI20149@phenom.ffwll.local>
Mail-Followup-To: Jeykumar Sankaran <jsanka@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Steve Cohen <cohens@codeaurora.org>, seanpaul@chromium.org
References: <1591155451-10393-1-git-send-email-jsanka@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591155451-10393-1-git-send-email-jsanka@codeaurora.org>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 08:37:31PM -0700, Jeykumar Sankaran wrote:
> drm connector notifies userspace on hotplug event prematurely before
> late_register and mode_object register completes. This leads to a race
> between userspace and kernel on updating the IDR list. So, move the
> notification to end of connector register.
> 
> Signed-off-by: Jeykumar Sankaran <jsanka@codeaurora.org>
> Signed-off-by: Steve Cohen <cohens@codeaurora.org>

Hm on the unregister side we don't have the race, there we remove
everything and then send out the uevent. But there the uevent is also
generated in a separate step, so I wonder whether we shouldn't do the same
for register for symmetry ...

Anyway this looks good, nice catch, I'll add cc: stable and merge.
-Daniel

> ---
>  drivers/gpu/drm/drm_connector.c | 5 +++++
>  drivers/gpu/drm/drm_sysfs.c     | 3 ---
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index b1099e1..d877ddc 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -27,6 +27,7 @@
>  #include <drm/drm_print.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
> +#include <drm/drm_sysfs.h>
>  
>  #include <linux/uaccess.h>
>  
> @@ -523,6 +524,10 @@ int drm_connector_register(struct drm_connector *connector)
>  	drm_mode_object_register(connector->dev, &connector->base);
>  
>  	connector->registration_state = DRM_CONNECTOR_REGISTERED;
> +
> +	/* Let userspace know we have a new connector */
> +	drm_sysfs_hotplug_event(connector->dev);
> +
>  	goto unlock;
>  
>  err_debugfs:
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 939f003..f0336c8 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -291,9 +291,6 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
>  		return PTR_ERR(connector->kdev);
>  	}
>  
> -	/* Let userspace know we have a new connector */
> -	drm_sysfs_hotplug_event(dev);
> -
>  	if (connector->ddc)
>  		return sysfs_create_link(&connector->kdev->kobj,
>  				 &connector->ddc->dev.kobj, "ddc");
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
