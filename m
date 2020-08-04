Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678F1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003EA206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hid86rnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgHDFiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 01:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgHDFiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 01:38:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7D4C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 22:38:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c80so1503051wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 22:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cv9dwVi/Wv30ZWHkdUpxmHaYyxiCbxozjhCWMQldsSA=;
        b=hid86rnu5RdeUriBzIBEf2/tA0fNBYdk6DhoKMlhiCAMpSXUwfxj3XLOQYGYor+YKh
         obVBT6XDDh/nIOP/LLJHUDkolrw4gukhJtqws5Ae8PJmgsBp4SXJvioc/neeKpv+QxUx
         OCjfoxlE59A4ZzmPaytbEqYfW9PwqrL1k/rk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Cv9dwVi/Wv30ZWHkdUpxmHaYyxiCbxozjhCWMQldsSA=;
        b=jf5Q3qEudH7x53Q/fuTmUjLqPk6q0EZ58Ni6iTUyGtK+Mcobrt7aGNEMLHos2a0Alo
         ykh9tl5DfJJ466NuXh/9l8rxUkcsra905e3LXFRfLZO4YEq/+RK/8FB7sBlv5Ez9EiXE
         M5+VeYmg7n2lNdVL5IQavPit14sOwi2+zLJYHRpIbs/5bnWkJuAWU7QZzMEgOUOtrgJ1
         5RlPr1eaESk/y+w03PNy3DSykvKBxmKcvhR/L7yg/xnKRiA5s5n4PhT2BfZ31O4Yxu1d
         Riv5TFSAyAyb6GGwBZYqEV9d+jjhQ01T2GNbxRO0f5VsOURa2PcJUenyAPYa00Z08NlT
         P3og==
X-Gm-Message-State: AOAM531eO1jHHGrbFCVfH4rkNAXMXy5bv7NOlXodzxt3Vedi1HQgympM
        A+OkY+pjGg/nqXC4/OOl5jojoA==
X-Google-Smtp-Source: ABdhPJwNiZT+/GhP9T5Q5Ir4jlWN4SHDiYp7jXO8IwDtD5pgMdueTFiD3HJLFoEgCPNyMnmX+I4egQ==
X-Received: by 2002:a7b:c257:: with SMTP id b23mr2251985wmj.164.1596519497267;
        Mon, 03 Aug 2020 22:38:17 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f63sm3156762wmf.9.2020.08.03.22.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 22:38:16 -0700 (PDT)
Date:   Tue, 4 Aug 2020 07:38:14 +0200
From:   daniel@ffwll.ch
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] fbmem: pull fbcon_update_vcs() out of fb_set_var()
Message-ID: <20200804053814.GG6419@phenom.ffwll.local>
Mail-Followup-To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>
References: <1596000620-4075-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAKMK7uHeteS2+rKrZKrAM+zQO==hAX0XaVc9JfHPsdLTCtzKOw@mail.gmail.com>
 <a3bb6544-064d-54a1-1215-d92188cb4209@i-love.sakura.ne.jp>
 <075b7e37-3278-cd7d-31ab-c5073cfa8e92@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <075b7e37-3278-cd7d-31ab-c5073cfa8e92@i-love.sakura.ne.jp>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 07:47:14PM +0900, Tetsuo Handa wrote:
> syzbot is reporting OOB read bug in vc_do_resize() [1] caused by memcpy()
> based on outdated old_{rows,row_size} values, for resize_screen() can
> recurse into vc_do_resize() which changes vc->vc_{cols,rows} that outdates
> old_{rows,row_size} values which were saved before calling resize_screen().
> 
> Daniel Vetter explained that resize_screen() should not recurse into
> fbcon_update_vcs() path due to FBINFO_MISC_USEREVENT being still set
> when calling resize_screen().
> 
> Instead of masking FBINFO_MISC_USEREVENT before calling fbcon_update_vcs(),
> we can remove FBINFO_MISC_USEREVENT by calling fbcon_update_vcs() only if
> fb_set_var() returned 0. This change assumes that it is harmless to call
> fbcon_update_vcs() when fb_set_var() returned 0 without reaching
> fb_notifier_call_chain().
> 
> [1] https://syzkaller.appspot.com/bug?id=c70c88cfd16dcf6e1d3c7f0ab8648b3144b5b25e
> 
> Reported-and-tested-by: syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: kernel test robot <lkp@intel.com> for missing #include

Thanks a lot for your patch, queued up to hopefully still make it for
5.9-rc1.

Cheers, Daniel

> ---
>  drivers/video/fbdev/core/fbmem.c   | 8 ++------
>  drivers/video/fbdev/core/fbsysfs.c | 4 ++--
>  drivers/video/fbdev/ps3fb.c        | 5 +++--
>  include/linux/fb.h                 | 2 --
>  4 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 30e73ec..da7c88f 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -957,7 +957,6 @@ static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
>  int
>  fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>  {
> -	int flags = info->flags;
>  	int ret = 0;
>  	u32 activate;
>  	struct fb_var_screeninfo old_var;
> @@ -1052,9 +1051,6 @@ static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
>  	event.data = &mode;
>  	fb_notifier_call_chain(FB_EVENT_MODE_CHANGE, &event);
>  
> -	if (flags & FBINFO_MISC_USEREVENT)
> -		fbcon_update_vcs(info, activate & FB_ACTIVATE_ALL);
> -
>  	return 0;
>  }
>  EXPORT_SYMBOL(fb_set_var);
> @@ -1105,9 +1101,9 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  			return -EFAULT;
>  		console_lock();
>  		lock_fb_info(info);
> -		info->flags |= FBINFO_MISC_USEREVENT;
>  		ret = fb_set_var(info, &var);
> -		info->flags &= ~FBINFO_MISC_USEREVENT;
> +		if (!ret)
> +			fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
>  		unlock_fb_info(info);
>  		console_unlock();
>  		if (!ret && copy_to_user(argp, &var, sizeof(var)))
> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
> index d54c88f..65dae05 100644
> --- a/drivers/video/fbdev/core/fbsysfs.c
> +++ b/drivers/video/fbdev/core/fbsysfs.c
> @@ -91,9 +91,9 @@ static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
>  
>  	var->activate |= FB_ACTIVATE_FORCE;
>  	console_lock();
> -	fb_info->flags |= FBINFO_MISC_USEREVENT;
>  	err = fb_set_var(fb_info, var);
> -	fb_info->flags &= ~FBINFO_MISC_USEREVENT;
> +	if (!err)
> +		fbcon_update_vcs(fb_info, var->activate & FB_ACTIVATE_ALL);
>  	console_unlock();
>  	if (err)
>  		return err;
> diff --git a/drivers/video/fbdev/ps3fb.c b/drivers/video/fbdev/ps3fb.c
> index 9df78fb..203c254 100644
> --- a/drivers/video/fbdev/ps3fb.c
> +++ b/drivers/video/fbdev/ps3fb.c
> @@ -29,6 +29,7 @@
>  #include <linux/freezer.h>
>  #include <linux/uaccess.h>
>  #include <linux/fb.h>
> +#include <linux/fbcon.h>
>  #include <linux/init.h>
>  
>  #include <asm/cell-regs.h>
> @@ -824,12 +825,12 @@ static int ps3fb_ioctl(struct fb_info *info, unsigned int cmd,
>  				var = info->var;
>  				fb_videomode_to_var(&var, vmode);
>  				console_lock();
> -				info->flags |= FBINFO_MISC_USEREVENT;
>  				/* Force, in case only special bits changed */
>  				var.activate |= FB_ACTIVATE_FORCE;
>  				par->new_mode_id = val;
>  				retval = fb_set_var(info, &var);
> -				info->flags &= ~FBINFO_MISC_USEREVENT;
> +				if (!retval)
> +					fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
>  				console_unlock();
>  			}
>  			break;
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 3b4b2f0..b11eb02 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -400,8 +400,6 @@ struct fb_tile_ops {
>  #define FBINFO_HWACCEL_YPAN		0x2000 /* optional */
>  #define FBINFO_HWACCEL_YWRAP		0x4000 /* optional */
>  
> -#define FBINFO_MISC_USEREVENT          0x10000 /* event request
> -						  from userspace */
>  #define FBINFO_MISC_TILEBLITTING       0x20000 /* use tile blitting */
>  
>  /* A driver may set this flag to indicate that it does want a set_par to be
> -- 
> 1.8.3.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
