Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F1DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFEE221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="N78Hjx0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgHGNML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHGNMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:12:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5DAC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 06:12:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so1809476wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=EEI1Q+fppn24GUPwdHUe/rrjbN2XPprAGHaCmC9qOCk=;
        b=N78Hjx0pAcuP2VQLKJkukTxDF+52k9EvIjw1q3rhWkg1C+u2aeSRZYWPwPKisJXP8Q
         Dbx7yoJIM1L5p+lScZJ5ji9JdlO60MwT7urL//OWbV4LZewRq5sblDIb7zYNecfVdw7+
         j2I7l6qqQeMtKspM19SnVntRgx2QpvKM/9eAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EEI1Q+fppn24GUPwdHUe/rrjbN2XPprAGHaCmC9qOCk=;
        b=g+OaMRTDAUS1f5ZBBMQaZyVuw89JJ2MI8R8DcvJivJE9rfDv3XgHdxjMXSyVArqJ2l
         BN2fozQHpjPDZ7TF8CqmqP9rlztKg3KXHTxHUGBQpcjCjWOILyCQdwES1lbw0m9sL1y4
         hUONdS7Ew1g8vQRRJhelAEZCxh6kgNecrrediptbvtsYWX7JkBdMxdqf9q9ZPsfRslLr
         AdRUuMCdW1cCEKHXZwFyLnobsYB1dZ5Y3rBcKvmng+AG+AQjvwWPmDn3CrkNZz9jY7Rq
         Qg3iNonIPUXOhY+xASpHKVtj0E/UN5GBk7p+nIapdNvUKIUcQDcR7RfEOgFTGvWdMpwF
         Cz2w==
X-Gm-Message-State: AOAM5311ErdGUBfvAh/kYUK7rQ1Csg0FrdgIyf5uUm0Fu+MewWw2botO
        HmoWlrmvB+rwsuav92bsOW+Bkw==
X-Google-Smtp-Source: ABdhPJyD5OPGKoTthEZngYIDRYz+e6OwbxqKcFkbXwnJNTrU9Di7izRE54UTv2wtNjkvOJXMA2srGQ==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr12470414wmj.122.1596805924546;
        Fri, 07 Aug 2020 06:12:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l11sm9904436wme.11.2020.08.07.06.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 06:12:03 -0700 (PDT)
Date:   Fri, 7 Aug 2020 15:12:01 +0200
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
Subject: Re: [PATCH v2] drm/qxl: don't take vga ports on rev5+
Message-ID: <20200807131201.GF2352366@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200807105501.24599-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807105501.24599-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 12:55:01PM +0200, Gerd Hoffmann wrote:
> qemu 5.0 introduces a new qxl hardware revision 5.  Unlike revision 4
> (and below) the device doesn't switch back into vga compatibility mode
> when someone touches the vga ports.  So we don't have to reserve the
> vga ports any more to avoid that happening.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Does what it says on the label.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 13872b882775..6e7f16f4cec7 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -96,7 +96,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (ret)
>  		goto disable_pci;
>  
> -	if (is_vga(pdev)) {
> +	if (is_vga(pdev) && pdev->revision < 5) {
>  		ret = vga_get_interruptible(pdev, VGA_RSRC_LEGACY_IO);
>  		if (ret) {
>  			DRM_ERROR("can't get legacy vga ioports\n");
> @@ -127,7 +127,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  unload:
>  	qxl_device_fini(qdev);
>  put_vga:
> -	if (is_vga(pdev))
> +	if (is_vga(pdev) && pdev->revision < 5)
>  		vga_put(pdev, VGA_RSRC_LEGACY_IO);
>  disable_pci:
>  	pci_disable_device(pdev);
> @@ -155,7 +155,7 @@ qxl_pci_remove(struct pci_dev *pdev)
>  
>  	drm_dev_unregister(dev);
>  	drm_atomic_helper_shutdown(dev);
> -	if (is_vga(pdev))
> +	if (is_vga(pdev) && pdev->revision < 5)
>  		vga_put(pdev, VGA_RSRC_LEGACY_IO);
>  }
>  
> -- 
> 2.18.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
