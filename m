Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98ABC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FB32078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="A1PSXXHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390911AbgEYOec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEYOec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:34:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BA2C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 07:34:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f5so209473wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=uF/4fHZuH4O2kAyZbFgHJMIKMxQSq2SpjuNJFiGzN3c=;
        b=A1PSXXHPnm4Ueqyin/tvwZ7Rw+EyRVcQ72yjHH2tOIZWkZdm260BiD248y5u2VThdf
         esrRZqJYtt1Cc02PGRWeL0C7PcY4OwdjR9P8MVyQ+1pKNR8zkcA4uAq15zikLHkmz6bO
         S+MSQa8dGaDGRX3CRZlQZ66t6bAtkDLjOvX2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=uF/4fHZuH4O2kAyZbFgHJMIKMxQSq2SpjuNJFiGzN3c=;
        b=pVUjrlLR52OG1+JqGtPE+p17t+16XrgkA26m+Wf0Udchs/fl7ezwsSPj/J55Qdaqag
         jEz4MxCGo9zLzaRC8xl6IP2TFc+fP1lzXslKisbAD1H5VkeWWAKV9V/c6XoDQSxLj9nx
         d0p3AGPDJXqvatf8yRUAmSb/U4XcQeD1pSq0PwLMwDQakt/sQX+vojBdZjRaOPS3WxGq
         Q8IpNgK0Ro0V1Aj97nuHW783vbhipqsdynM9KLA+ZscTwTq1Nqf1ZdQNrV98sh/af6Ix
         PbtOjZllwXXYQRBgLuHE9CUHiuohIqdP+XdtvVOhZmHUqR/RIjtf3H6rNeToA3EkwET8
         vU+Q==
X-Gm-Message-State: AOAM5328IBth1LvOMsD5bqlvVBZqRo7GX0mMfrwP3psbfEWoldlGS8pG
        JBSvvEuSmJvEJjMB8FPYmWo4WI3Srvg=
X-Google-Smtp-Source: ABdhPJz6GW+J1xSrZI8dXuAtuxH1sDs6MqBa5pe6rLiXeB5g2ICOVcpjJLrHZ29PpphGyfBsHzuRgA==
X-Received: by 2002:a1c:9654:: with SMTP id y81mr24769147wmd.46.1590417270737;
        Mon, 25 May 2020 07:34:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n1sm4595258wrp.10.2020.05.25.07.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 07:34:30 -0700 (PDT)
Date:   Mon, 25 May 2020 16:34:28 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     chenxb_99091@126.com
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: fix setting of plane_mask in pan_display_atomic()
 function for linux-4.4
Message-ID: <20200525143428.GG206103@phenom.ffwll.local>
Mail-Followup-To: chenxb_99091@126.com, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <1590205747-19599-1-git-send-email-chenxb_99091@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590205747-19599-1-git-send-email-chenxb_99091@126.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 11:49:07AM +0800, chenxb_99091@126.com wrote:
> From: Xuebing Chen <chenxb_99091@126.com>
> 
> The <include/drm/drm_crtc.h> provides drm_for_each_plane_mask macro and
> plane_mask is defined as bitmask of plane indices, such as
> 1<<drm_plane_index(plane). This patch fixes error setting of plane_mask
> in pan_display_atomic() function.
> 
> Signed-off-by: Xuebing Chen <chenxb_99091@126.com>

What kernel is this patch against? Latest upstream doesn't have any such
code anymore ... I'm assuming that Ville fixed this in one of his patches,
but I can't find the right one just now.
-Daniel

> ---
>  drivers/gpu/drm/drm_fb_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index e449f22..6a9f7ee 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1256,7 +1256,7 @@ retry:
>  			goto fail;
>  
>  		plane = mode_set->crtc->primary;
> -		plane_mask |= drm_plane_index(plane);
> +		plane_mask |= 1 << drm_plane_index(plane);
>  		plane->old_fb = plane->fb;
>  	}
>  
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
