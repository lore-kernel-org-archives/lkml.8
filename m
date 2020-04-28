Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132CCC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2AF0206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dt9JvUZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgD1POQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727108AbgD1POP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:14:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7F1C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:14:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d17so25096187wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=gPj1O/jOW1qBAm9wItVCoQg+/JQBV9DNAyjrAa3CJ1s=;
        b=dt9JvUZu3Yez0wBMSlGnIr5B7uhLVVv3xwgu+ys50HNnfNjJK9xsLpXf2bo0UZ1oym
         ecWCqYvougpWP61bBgvZZAZn43EYIJgizSjuwvDRtGA34DKbLCNt331p+fseG19QtbW0
         hLAenfbNLivynA523s4fRjSgUtRCZxbl616Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=gPj1O/jOW1qBAm9wItVCoQg+/JQBV9DNAyjrAa3CJ1s=;
        b=q/rAmU/2TRMV2QLgJFMglByzJrQevA7i9GPt79Drv4i3QUENyorBrPv3Nfdv17NL3t
         L3UubJcwnscsL0IUTj2TtGD/1sDyjgE1XB9adpd6nD3pwztyiF5bAlMRxUEPg0j/2f6k
         wOC9kctrkfu4wGZGoyyNIJJ+rUaZLC9rbExIxJQz7bJR9HUBtBZdG833znM5WRxVl3YB
         Z3JRhu5Qe6u/UD+EgLO6P9DRMvbxSfF4XHkssKsBDftOc78Tc3rrkStYjb0r4IsZMjR3
         QD68ItOc5BOpAHg/+T8fPj8Vwt0XuVueUGwxwaJs4bOFyhklCngAGh5V4qk0CJcpVmbU
         qF5g==
X-Gm-Message-State: AGi0PubXnhQjNs0J2IvkFYtb5YSiACwxVGGWT6S214Whmk84LeOA2SGJ
        7yU/JYQzYq0TrHHUvfk3di/Ueg==
X-Google-Smtp-Source: APiQypJnyMpVG5cmlGZH+PfTwmm3Qs/qc4+yVZMCFB9zhwRRInfXVOfPO1+oV4/KwUW3P+P7liGvaA==
X-Received: by 2002:adf:e986:: with SMTP id h6mr33315188wrm.256.1588086852682;
        Tue, 28 Apr 2020 08:14:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q8sm3611203wmg.22.2020.04.28.08.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 08:14:11 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:14:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Levinsen <kl@kl.wtf>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: make drm_file use keyed wakeups
Message-ID: <20200428151410.GU3456981@phenom.ffwll.local>
Mail-Followup-To: Kenny Levinsen <kl@kl.wtf>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, tzimmermann@suse.de, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, linux-kernel@vger.kernel.org
References: <20200424162615.10461-1-kl@kl.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424162615.10461-1-kl@kl.wtf>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 06:26:15PM +0200, Kenny Levinsen wrote:
> Some processes, such as systemd, are only polling for EPOLLERR|EPOLLHUP.
> As drm_file uses unkeyed wakeups, such a poll can receive many spurious
> wakeups from uninteresting events if, for example, the file description
> is subscribed to vblank events. This is the case with systemd, as it
> polls a file description from logind that is shared with the users'
> compositor.
> 
> Use keyed wakeups to allow the wakeup target to more efficiently discard
> these uninteresting events.
> 
> Signed-off-by: Kenny Levinsen <kl@kl.wtf>

Hm I applied v1 and I'm not spotting what's different here, and there's no
changelog explaining what changed ...

Please send a fixup if there's anything important missing.
-Daniel

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
