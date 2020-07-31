Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E57C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFDC22BF3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="R4eDvdiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732922AbgGaJ2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732339AbgGaJ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:28:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AFAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:28:16 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l2so16797514wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=z+0/zjHSuK4YpkaJOtgZNG0mGoncCgYB5r2C7+VJ3D4=;
        b=R4eDvdiyjZiAS2M0ScI5ZgcMF2tJ0yokw3apO8UqhsoNlAdBSFkzqPNOIw8Dvrr2Yc
         wkKkHQFTK73G30dhhTnlZmx5u0RV5cVW6DSgBvmw6PTYQLyxf2dGVEyPKsehu4QW0ifI
         QQkcZ0RtsuPJQ70TR3ADt+mbAAgIDlzU2ytSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=z+0/zjHSuK4YpkaJOtgZNG0mGoncCgYB5r2C7+VJ3D4=;
        b=syjTg7BVBjjyoWxYRKIyuHTTUMIaAnEtapDH4QCJfTZZMU6RT2GVnfw2Di0fDKk8I4
         DTOYuhpCElGHNf1grp3ZUZK68c2kOeToDAHugUoYJ0OyhDSfocxkikRSQTICJayI9kXu
         wwjfl2tE1uHqJqbzkIrPRD8OkBDHwkICuVCYFKK7O0Yn1S4IEp6gRiQKW/c7znU+Dvwh
         x/C7kYOSnvQxRwqXFIIJx2WIDs1AIHNcz3NFLtt/Ca2WEvMJZ3c5RHPnhKmNGfZSMR1J
         Xn8gYtta5QEa/48jXVg4j+EOGoO8+oZAXALSzdrkDdRTZysI4lIsnHJ0Zf3DCgcI92Uq
         OVBA==
X-Gm-Message-State: AOAM532WHdllXOTvB9srlS3bXlnTDhjf9zCaIoOk7Nn5QaGnRIXMDxfR
        RfXs1lk1WvTpd8FN8GX9QnE38w==
X-Google-Smtp-Source: ABdhPJwT64W6SQNoeOQa1Euw8GGqxxmHPhkx0/MtFqznd2l1BYwFVsr8TCLtYQNzfpRxEdkGA4k+IA==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr2890544wrq.166.1596187695348;
        Fri, 31 Jul 2020 02:28:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z8sm11660814wmf.42.2020.07.31.02.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 02:28:14 -0700 (PDT)
Date:   Fri, 31 Jul 2020 11:28:12 +0200
From:   daniel@ffwll.ch
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        twoerner@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] drm/vkms: fix xrgb on compute crc
Message-ID: <20200731092812.GY6419@phenom.ffwll.local>
Mail-Followup-To: Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, twoerner@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
References: <20200730202524.5upzuh4irboru7my@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730202524.5upzuh4irboru7my@smtp.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 05:25:24PM -0300, Melissa Wen wrote:
> The previous memset operation was not correctly zeroing the alpha
> channel to compute the crc, and as a result, the IGT subtest
> kms_cursor_crc/pipe-A-cursor-alpha-transparent fails.
> 
> Fixes: db7f419c06d7c ("drm/vkms: Compute CRC with Cursor Plane")
> 
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>

Applied to drm-misc-next, thanks for your patch.

> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 4af2f19480f4..b8b060354667 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -33,7 +33,7 @@ static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
>  				     + (i * composer->pitch)
>  				     + (j * composer->cpp);
>  			/* XRGB format ignores Alpha channel */
> -			memset(vaddr_out + src_offset + 24, 0,  8);
> +			bitmap_clear(vaddr_out + src_offset, 24, 8);

Yeah that's a pretty good "oops" oversight on review, nice catch!

Cheers, Daniel
>  			crc = crc32_le(crc, vaddr_out + src_offset,
>  				       sizeof(u32));
>  		}
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
