Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59085C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 09:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386EE20725
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 09:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FQWoRHd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgHAJ2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 05:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgHAJ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 05:28:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4AAC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 02:28:04 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so10344852wmi.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 02:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=B1mN8564CaEdT6pvNLdTQVULf9KDq5pz1XDgMNRT910=;
        b=FQWoRHd0BcdiPCnL0D1+eDAcsOwi/+aB/kW6re4TQ9GEE/gFZM5ydnGpwRDSrDlrAA
         vE0Wb+vjJ9Qa6Tjt6BO4Zc05tLLyCzxh84eji37m0Taf1AdZ3BO14tjJY2ee7RsDgFDs
         GJekNUCfYRMTgVsh3myjZM5euGCL5c+nSJHuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=B1mN8564CaEdT6pvNLdTQVULf9KDq5pz1XDgMNRT910=;
        b=iLg+2si4gGARusutoIs2Opd3PY8Gp8GJ3N+f317u/0z+mDhl2mf4i9M+C1WNg/Pvza
         VGTwOacpEIKGeEycJT9Db8L9KeK8kS1MpYCIUiKymFc0lPl20lN4cvPlkEYGfq0CSJ+d
         PlRZSTvm2pr3Zs4ZgtRqiwfvnoWgm403HGJeWo4BkzZikNIgee9noz4P+9+s+kM/gThy
         F1neCkzeFlrRDxRzwE2VB9zmneOIhzimBp1ZULybMzBKTVfhdxNyzGw3PXeUwKZRXKuC
         Ibxnbxu3gUa4gtKAmeLOHqJxu+QMDOTuG/Wt4Bswh2JdEc6N/PKCzMvrvW7l1xPn8/C2
         DzXg==
X-Gm-Message-State: AOAM5323e40FIlhQjjFdPwygSUbaxeQmRbi/kA8unw/AuMhJtG9FpYTq
        QdPGWcExxTPJptZyy2ULBkWXtoXtQQA=
X-Google-Smtp-Source: ABdhPJzqoZg7QECsMjE4NgtabggJaa5B2EruQyl1cEAXPJlRrt1l/dIdNlAH17f9MEC0un6QR2wXyw==
X-Received: by 2002:a1c:81c7:: with SMTP id c190mr7918789wmd.129.1596274082956;
        Sat, 01 Aug 2020 02:28:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a10sm15857494wrx.15.2020.08.01.02.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 02:28:02 -0700 (PDT)
Date:   Sat, 1 Aug 2020 11:28:00 +0200
From:   daniel@ffwll.ch
Cc:     airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgaarb: mark vga_tryget static
Message-ID: <20200801092800.GE6419@phenom.ffwll.local>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200801061713.307434-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801061713.307434-1-hch@lst.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 01, 2020 at 08:17:13AM +0200, Christoph Hellwig wrote:
> This symbols isn't used anywhere outside of vgaarb.c.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice catch, patch queued up for 5.9.

Thanks, Daniel

> ---
>  drivers/gpu/vga/vgaarb.c | 3 +--
>  include/linux/vgaarb.h   | 6 ------
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> index f2f3ef8af2710f..5180c5687ee530 100644
> --- a/drivers/gpu/vga/vgaarb.c
> +++ b/drivers/gpu/vga/vgaarb.c
> @@ -529,7 +529,7 @@ EXPORT_SYMBOL(vga_get);
>   *
>   * 0 on success, negative error code on failure.
>   */
> -int vga_tryget(struct pci_dev *pdev, unsigned int rsrc)
> +static int vga_tryget(struct pci_dev *pdev, unsigned int rsrc)
>  {
>  	struct vga_device *vgadev;
>  	unsigned long flags;
> @@ -554,7 +554,6 @@ int vga_tryget(struct pci_dev *pdev, unsigned int rsrc)
>  	spin_unlock_irqrestore(&vga_lock, flags);
>  	return rc;
>  }
> -EXPORT_SYMBOL(vga_tryget);
>  
>  /**
>   * vga_put - release lock on legacy VGA resources
> diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
> index 553b34c8b5f700..977caf96c8d2a3 100644
> --- a/include/linux/vgaarb.h
> +++ b/include/linux/vgaarb.h
> @@ -109,12 +109,6 @@ static inline int vga_get_uninterruptible(struct pci_dev *pdev,
>         return vga_get(pdev, rsrc, 0);
>  }
>  
> -#if defined(CONFIG_VGA_ARB)
> -extern int vga_tryget(struct pci_dev *pdev, unsigned int rsrc);
> -#else
> -static inline int vga_tryget(struct pci_dev *pdev, unsigned int rsrc) { return 0; }
> -#endif
> -
>  #if defined(CONFIG_VGA_ARB)
>  extern void vga_put(struct pci_dev *pdev, unsigned int rsrc);
>  #else
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
