Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BD8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 21:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4822087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 21:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GglQyMIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgIDVb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 17:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgIDVb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 17:31:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AA9C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 14:31:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so8620793wrl.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 14:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lWsIwGs4zwf7QsRg59AIdeA858uxoHmiYKmGxLCL+jc=;
        b=GglQyMIzcy1VPhXaMWU6sAazP11ZlGD+g1QkZErVQWsYcmle+PPc32oWvxEAfkyFTd
         Ev/w1OcjerBUY0wPe1XLn+bdaF/xi6AMmdhe5vefEex1oo837qgSi2Hf561OlFMgqOCq
         44GZLjptKmZENqtHfEMaze/MDnKS7U7Fb7wc2oIn/WHR795UAnOJsko8SH/WcoNvYf8R
         wa8fsjD/8w2CDkS+0cjmUIFkDe+GS43tqw0McxBbyeMkqH6eaHQEOGs56qYWpNEhYqFA
         J63Q8YgnHb4+KS/Ks8AKhs0cMjDj/rlW8mnuD+W//Uz7f7O8/2k8Wj8S1h6S010ZDB1H
         YVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lWsIwGs4zwf7QsRg59AIdeA858uxoHmiYKmGxLCL+jc=;
        b=YcjStO7DpDxmPfI7rYDDgpgpkmHgRygd81DiZKtGKiFW0XAIzCrYNPceqNDz704EKX
         qo3iuWpmnEP1Xg2vIrp52Rv4fL+dipkcSCTkZE/CSsnGChVeUIZ9nbAS/E2dKDdmoSg2
         dbMWX3SKNQlKZ3E7Hn5qnUp2hMGwcMOyCDZdF1WR64pXmu88XaQ+BtXkvqpmwK30zRhW
         kq30c9SbcOJUHwCQxeFqGUHA+p0azoyXfSaM7QyBvkj8VSFXaHRNy1Z2QoTRyDiYtJob
         +9tdm9tnzCnzKUWF50eK/l75cZ+FSuC8ALYLDA4B6R7s44UCzv5ZUcZ2UASL8yqh0yHh
         JLDQ==
X-Gm-Message-State: AOAM533w5lFgWDPClQziWXNfA8L15qgun9zHyJrhxvbCcE0hhl4AlxQ0
        sIewq3PE4WJFVob9WpKd6FUM+oAmi0K17A==
X-Google-Smtp-Source: ABdhPJyqdhi45rsVT/UWBQjiHBIO8qTSndTo8Zfrs7+fjXtA1RBnU2WKYmSGeZpinN9WxcdA8lo7GA==
X-Received: by 2002:a05:6000:1ce:: with SMTP id t14mr8840909wrx.195.1599255085099;
        Fri, 04 Sep 2020 14:31:25 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id z203sm14989819wmc.31.2020.09.04.14.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 14:31:24 -0700 (PDT)
Date:   Fri, 4 Sep 2020 18:31:18 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Leandro Ribeiro <leandro.ribeiro@collabora.com>,
        daniels@collabora.com, Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v6 2/3] drm/vkms: Compute CRC without change input data
Message-ID: <20200904213118.7bpdhokijilb6np3@smtp.gmail.com>
References: <20200830142000.146706-1-rodrigosiqueiramelo@gmail.com>
 <20200830142000.146706-3-rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830142000.146706-3-rodrigosiqueiramelo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30, Rodrigo Siqueira wrote:
> The compute_crc() function is responsible for calculating the
> framebuffer CRC value; due to the XRGB format, this function has to
> ignore the alpha channel during the CRC computation. Therefore,
> compute_crc() set zero to the alpha channel directly in the input
> framebuffer, which is not a problem since this function receives a copy
> of the original buffer. However, if we want to use this function in a
> context without a buffer copy, it will change the initial value. This
> patch makes compute_crc() calculate the CRC value without modifying the
> input framebuffer.
Hi Rodrigo,

This commit message no longer reflects the current state of crc
computation on vkms, since the alpha channel is no longer ignored (not
zeroed) there. I think the point here is to improve readability, which I
agree, is it? If so, update this msg.
> 
> Change in V5 (Melissa):
> - Rebase and drop bitmap for alpha
> Change in V4 (Emil):
> - Move bitmap_clear operation and comments to get_pixel function
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 34 ++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index f67d1baf1942..c5b32fe5870f 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -9,31 +9,41 @@
>  
>  #include "vkms_drv.h"
>  
> +static u32 get_pixel_from_buffer(int x, int y, const u8 *buffer,
> +				 const struct vkms_composer *composer)
> +{
> +	u32 pixel;
> +	int src_offset = composer->offset + (y * composer->pitch)
> +				      + (x * composer->cpp);
> +
> +	pixel = *(u32 *)&buffer[src_offset];
> +
> +	return pixel;
> +}
> +
>  /**
>   * compute_crc - Compute CRC value on output frame
>   *
> - * @vaddr_out: address to final framebuffer
> + * @vaddr: address to final framebuffer
>   * @composer: framebuffer's metadata
>   *
>   * returns CRC value computed using crc32 on the visible portion of
>   * the final framebuffer at vaddr_out
>   */
> -static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
> +static uint32_t compute_crc(const u8 *vaddr,
> +			    const struct vkms_composer *composer)
>  {
> -	int i, j, src_offset;
> +	int x, y;
> +	u32 crc = 0, pixel = 0;
>  	int x_src = composer->src.x1 >> 16;
>  	int y_src = composer->src.y1 >> 16;
>  	int h_src = drm_rect_height(&composer->src) >> 16;
>  	int w_src = drm_rect_width(&composer->src) >> 16;
> -	u32 crc = 0;
> -
> -	for (i = y_src; i < y_src + h_src; ++i) {
> -		for (j = x_src; j < x_src + w_src; ++j) {
> -			src_offset = composer->offset
> -				     + (i * composer->pitch)
> -				     + (j * composer->cpp);
> -			crc = crc32_le(crc, vaddr_out + src_offset,
> -				       sizeof(u32));
> +
> +	for (y = y_src; y < y_src + h_src; ++y) {
> +		for (x = x_src; x < x_src + w_src; ++x) {
> +			pixel = get_pixel_from_buffer(x, y, vaddr, composer);
> +			crc = crc32_le(crc, (void *)&pixel, sizeof(u32));
>  		}
>  	}
>  
> -- 
> 2.28.0
> 
Please, update the commit msg.
The code improvement look good to me. So:

Reviewed-by: Melissa Wen <melissa.srw@gmail.com>
