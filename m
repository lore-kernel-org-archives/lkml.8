Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF68C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7100205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XsbFwoIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgCXUp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:45:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51464 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgCXUp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:45:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id c187so29070wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=IXTMQkJ5+rGIRXyFRn2dpDyKMm30Z0L9/Y4UKQodmuM=;
        b=XsbFwoILxMKcZdz37dHEuosq733I4y/GkVUwE3Ks/oGgxQIuhMcgJQ+j1AHHMx00qa
         iBGiBj1V0+Yb2+bP8VryBHadvf3LASdLt9ZlUGU16dLFqszLw4MX1jpy+BeXp85NfjJy
         H4L4vIc73H/yZQ3d6vVRr3Ch/zGJ+bCoUqIqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=IXTMQkJ5+rGIRXyFRn2dpDyKMm30Z0L9/Y4UKQodmuM=;
        b=EKeVvXb7J+E4782JNtXBkmvovhz9cnHfR81UG+fsfxcz6ieYsKSBppaRCzrqswV5QS
         5891O1LBqteIdbRLYwA2aw3a2etJcHkShPy7GsBzW3Nq0Kdnu9Jcv9gabVEAK0wRVFKW
         zF8SjX17p3Qb92lbJx2j1fhrqDGMT8t6dCHPpQDs8Okh7mqt6MOM/lFqXc3dzDnruA4a
         4AfV6MKejUwzJzGVjrc8jLGuPOS2HfYdoZBodfzaqB6k8B0YE4D10WJD8UtmMnVCyaKY
         nAu2RGAp+W3vzUq0QaPoq1zAhNNVCtwxgaFk71Sp8WXjNmSWt8AYi5hsa0j1AWhg8j3h
         61gQ==
X-Gm-Message-State: ANhLgQ247sGmzlghFd82ji+ilAwB2U4Ig/cY9aHtk7WZCDDo9Qv8p2hk
        ljOJ8ssyBsQjqF4Swb3OnfYAgg==
X-Google-Smtp-Source: ADFU+vszfqEuuH6nexMj7L+36UtUSlCzZQx/S5+rMyLLsVooforcJdZKmTiZefaW7LZ9e0eRD4QV/Q==
X-Received: by 2002:a05:600c:2051:: with SMTP id p17mr7516494wmg.153.1585082724489;
        Tue, 24 Mar 2020 13:45:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z188sm5992134wme.46.2020.03.24.13.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 13:45:23 -0700 (PDT)
Date:   Tue, 24 Mar 2020 21:45:21 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 1/6] video: fbdev: controlfb: fix sparse warning about
 using incorrect type
Message-ID: <20200324204521.GL2363188@phenom.ffwll.local>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20200324134508.25120-1-b.zolnierkie@samsung.com>
 <CGME20200324134518eucas1p16e1a39c14dfd101f5a6d86218a9e19af@eucas1p1.samsung.com>
 <20200324134508.25120-2-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324134508.25120-2-b.zolnierkie@samsung.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 02:45:03PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Use in_le32() instead of le32_to_cpup() to fix sparse warning about
> improper type of the argument.
> 
> Also add missing inline keyword to control_par_to_var() definition
> (to match function prototype).
> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/video/fbdev/controlfb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
> index 38b61cdb5ca4..9625792f4413 100644
> --- a/drivers/video/fbdev/controlfb.c
> +++ b/drivers/video/fbdev/controlfb.c
> @@ -313,7 +313,7 @@ static int controlfb_blank(int blank_mode, struct fb_info *info)
>  		container_of(info, struct fb_info_control, info);
>  	unsigned ctrl;
>  
> -	ctrl = le32_to_cpup(CNTRL_REG(p,ctrl));
> +	ctrl = in_le32(CNTRL_REG(p, ctrl));
>  	if (blank_mode > 0)
>  		switch (blank_mode) {
>  		case FB_BLANK_VSYNC_SUSPEND:
> @@ -952,7 +952,8 @@ static int control_var_to_par(struct fb_var_screeninfo *var,
>   * Convert hardware data in par to an fb_var_screeninfo
>   */
>  
> -static void control_par_to_var(struct fb_par_control *par, struct fb_var_screeninfo *var)
> +static inline void control_par_to_var(struct fb_par_control *par,

Just quick drive-by bikeshed, feel free to ignore: static inline within a
.c file imo doesn't make sense anymore, compilers are smart enough
nowadays. I'd just drop this.
-Daniel

> +	struct fb_var_screeninfo *var)
>  {
>  	struct control_regints *rv;
>  	
> -- 
> 2.24.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
