Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8585AC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604EB205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JzzSWV6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgD1PLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727860AbgD1PLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:11:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B99C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:11:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so25023450wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=BUERjUN4IDwttfkbYfdMTF6BA4dlrEJqnocFSu4n2pw=;
        b=JzzSWV6VeXNXKWNoqHG6ooCaqTZW64eXYAKVM24LcSgC60DV4OyDEwlp5Gpu3yn7qJ
         XeHO9wsxTPOt1SUYnlHf4ezYuRGS3fa4JiT0J4xJmAM2YGWpBYxKwm9UZyE/M/RxmamI
         eCokY40xIDTAPjO+k9R2cTPexnqYLiMC0btwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=BUERjUN4IDwttfkbYfdMTF6BA4dlrEJqnocFSu4n2pw=;
        b=gMh64nuUX9b/nuLRIVgv2v93Ce0Nfohu+WcTDe7j700ufbKPktl67Lge0wFkP9iO3n
         6Om0aNiYScZ5H4ieuaVXkhKUinxV8cA2IcqA8IUkUvnYvOvK5qd3Bn+Bn2kwLzZ9wea7
         dNKeP1k7KsykvCqXyGrICxLiVLD9jl2/7n/YeCAPOucqUmnoA4TkA1P93WQ2UkBCLWzh
         NTLwmM+QSw4oDqvCcpDtg1QDN03CfIV57wQ/SCO0ZL7llS7pBwm6HPB9mlEq3wNXV6R8
         nn9gZ++n4DmX30Q/eGsg4rVPaEC+jyt/7WC6ar2KB7olMF0aWR8q63qWuBhWnp5KhOs6
         Oc9w==
X-Gm-Message-State: AGi0PuZTfJRmn+ZDP+LyUYr8+xqA/zSRZBiGbUwVxL4WoGWsnuNdxasy
        EokoXFlORLylEEDlnovCzRevMQ==
X-Google-Smtp-Source: APiQypJbpnbX/zV+1pglD3REQ+BWeE31qH1Yj5A39N7xBFb9oSVIctQznEArleZrlUwA5DdyVa44WQ==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr33557684wrs.391.1588086707255;
        Tue, 28 Apr 2020 08:11:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u7sm3869726wmg.41.2020.04.28.08.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 08:11:46 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:11:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Levinsen <kl@kl.wtf>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: make drm_file use keyed wakeups
Message-ID: <20200428151144.GT3456981@phenom.ffwll.local>
Mail-Followup-To: Kenny Levinsen <kl@kl.wtf>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, tzimmermann@suse.de, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, linux-kernel@vger.kernel.org
References: <20200424145103.3048-1-kl@kl.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424145103.3048-1-kl@kl.wtf>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 04:51:03PM +0200, Kenny Levinsen wrote:
> Some processes, such as systemd, are only polling for EPOLLERR|EPOLLHUP.
> As drm_file uses unkeyed wakeups, such a poll receives many spurious
> wakeups from uninteresting events.
> 
> Use keyed wakeups to allow the wakeup target to more efficiently discard
> these uninteresting events.
> 
> Signed-off-by: Kenny Levinsen <kl@kl.wtf>

intel-gfx CI is happy, I'm living with the illusion that this seems to
loook correct (linux kernel poll code is too much magic for me). Thanks
for your patch, queued up in drm-misc-next for 5.8.

Cheers, Daniel

> ---
>  drivers/gpu/drm/drm_file.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index c4c704e01961..ec25b3d979d9 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -608,7 +608,8 @@ ssize_t drm_read(struct file *filp, char __user *buffer,
>  				file_priv->event_space -= length;
>  				list_add(&e->link, &file_priv->event_list);
>  				spin_unlock_irq(&dev->event_lock);
> -				wake_up_interruptible(&file_priv->event_wait);
> +				wake_up_interruptible_poll(&file_priv->event_wait,
> +					EPOLLIN | EPOLLRDNORM);
>  				break;
>  			}
>  
> @@ -804,7 +805,8 @@ void drm_send_event_locked(struct drm_device *dev, struct drm_pending_event *e)
>  	list_del(&e->pending_link);
>  	list_add_tail(&e->link,
>  		      &e->file_priv->event_list);
> -	wake_up_interruptible(&e->file_priv->event_wait);
> +	wake_up_interruptible_poll(&e->file_priv->event_wait,
> +		EPOLLIN | EPOLLRDNORM);
>  }
>  EXPORT_SYMBOL(drm_send_event_locked);
>  
> -- 
> 2.26.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
