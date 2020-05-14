Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F66DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 644FF20722
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="g4NrS6Cm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgENMhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgENMhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:37:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2EFC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:36:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h17so3832601wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ifRD49o1LZImX+UuQT8Fu8icSNPBuzwAgca/8KAC1VQ=;
        b=g4NrS6CmKdjIA9u0pd/FCfKYjI0Z9XIkumKsx1shIlbQFRExMucRX1rpw0LOxfj8rr
         hXllo/f0mA8e1ExqLxmjA+7sXtQwWDq9EVT99apo/NJ3H0me8eGS4kzvi32ZMPw+wZ3N
         Biqqn0plYWKex9E+QKH98mq0oYJt6HtNxZSAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ifRD49o1LZImX+UuQT8Fu8icSNPBuzwAgca/8KAC1VQ=;
        b=uXUWV7hAWpa2ZUyC1fVe25H+Qf/E1vFKeu9aCohj6xuR88D9muZ+Gv0L2v5Fk/GOa6
         izfTYT8auo01EkelLvYlU3+TuSwKiD1QU3gD+Q+Kf1y/JscoCx+k1iF72JzSVIAnLK6k
         GbvyDBxFaiyjMicPHhcom13z3X3rsp23APshUaw/rdFFRZ7fJtzYRnIO7p2XngKDGRI7
         go/xxerzKCT4xPXW+6d/IuHzS5OggY1sONGuln/hEPNk6DVEvdrNo0vKOX9RH/ELpwZJ
         n2sw8LmdRPVKhg/xYT7RlbRGxrH7WKYDmOl+YBUv1D5egTPl/uecZgQm3f1+rtxP141e
         Vlgg==
X-Gm-Message-State: AOAM5300TIY6iF5USLLcZHjisq0aOcUuHSIO4zmOF1H469w7O3Horw2s
        z+VBFfGIM+LhM0dmAcYTrT9lug==
X-Google-Smtp-Source: ABdhPJyI/apxDuOLoOJU4jQNgnMw2wloGWznn0DlMO1xwK2hzM6OwLzIDSPZS9HCfxsSgkD8GvupQQ==
X-Received: by 2002:adf:f102:: with SMTP id r2mr5021205wro.376.1589459817152;
        Thu, 14 May 2020 05:36:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k17sm38882843wmi.10.2020.05.14.05.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 05:36:56 -0700 (PDT)
Date:   Thu, 14 May 2020 14:36:54 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 08/11] drm: constify sysrq_key_op
Message-ID: <20200514123654.GT206103@phenom.ffwll.local>
Mail-Followup-To: Emil Velikov <emil.l.velikov@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jiri Slaby <jslaby@suse.com>
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
 <20200513214351.2138580-8-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513214351.2138580-8-emil.l.velikov@gmail.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:43:48PM +0100, Emil Velikov wrote:
> With earlier commits, the API no longer discards the const-ness of the
> sysrq_key_op. As such we can add the notation.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> ---
> Please keep me in the CC list, as I'm not subscribed to the list.
> 
> IMHO it would be better if this gets merged this via the tty tree.

Shouldn't conflict, looks all reasonable for merging through tty as one
series.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_fb_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index a9771de4d17e..533767100efe 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -307,13 +307,13 @@ static void drm_fb_helper_sysrq(int dummy1)
>  	schedule_work(&drm_fb_helper_restore_work);
>  }
>  
> -static struct sysrq_key_op sysrq_drm_fb_helper_restore_op = {
> +static const struct sysrq_key_op sysrq_drm_fb_helper_restore_op = {
>  	.handler = drm_fb_helper_sysrq,
>  	.help_msg = "force-fb(V)",
>  	.action_msg = "Restore framebuffer console",
>  };
>  #else
> -static struct sysrq_key_op sysrq_drm_fb_helper_restore_op = { };
> +static const struct sysrq_key_op sysrq_drm_fb_helper_restore_op = { };
>  #endif
>  
>  static void drm_fb_helper_dpms(struct fb_info *info, int dpms_mode)
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
