Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F510C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4923A20842
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MW2G1dbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgG3LQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 07:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgG3LQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:16:31 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF10C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 04:16:31 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k22so23436072oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LDbiiFfKtuBxFd870k3GH23jKEqkoS40hdkLsm0b4u0=;
        b=MW2G1dbCbGNqMXJdESeyof+5APizl5+rWERSLL6laNDtD5a7Lo3BA/8sv4bJo1LFny
         7tIJlRj8Z95VnTTJUHI9YPYqCrylfi1RoJj0bTTTcPkS/2ubCkmYTYpbKzNxrWQGzCrG
         v/CiqvlxWTUixqyk/bRhLbkJXAIYOBC9ABju8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LDbiiFfKtuBxFd870k3GH23jKEqkoS40hdkLsm0b4u0=;
        b=ic3l5J8S3qWNaVgX78aYK9cr20WNU8LFPg+/oYIT4nL8RrPxQWiG/X6PCnlB3n9/sY
         XSbGTGi2+XxMYdagnkwEvxg+Fo4Db/npu2VzoiMgFHleXQmuu7M/c2a/AMrOYn0NELoB
         dhk7nGoHcQennw+t/v/pD1YjfRjV/UhKs7ev/iKetqlFaAQw/nw0kx/bHn6z0m5tiVzE
         RBRimP5ihCPM6qz3ASXvp2Qy8Ey699QxG16iXeUvf0ZHzjdbP/QMUQ1NKDvb2aQ3EI6X
         NQu88juvfJR2M9k+dSq5Jqb8je9RCvyNTL3qJCtCgZTV0/HUswfDmJUJsHLrQldVwSII
         gsdQ==
X-Gm-Message-State: AOAM531V/IY+qI9RKEfit145qPYkt9lUvru9yGICU317UItBy+vsS7T4
        pL6pu5UPWPpRXt1AcUI7Fuw63COPexvEpmH+GVtnLg==
X-Google-Smtp-Source: ABdhPJzfUiKobckCicQnGet8s1h12wCwGvx9XhS5QDydDKtM5O91UJihBhm6xQH2moRfPRJfpZDnoglFGhUO6YhtxLU=
X-Received: by 2002:a05:6808:9b6:: with SMTP id e22mr425598oig.101.1596107790721;
 Thu, 30 Jul 2020 04:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <1596000620-4075-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAKMK7uHeteS2+rKrZKrAM+zQO==hAX0XaVc9JfHPsdLTCtzKOw@mail.gmail.com> <a3bb6544-064d-54a1-1215-d92188cb4209@i-love.sakura.ne.jp>
In-Reply-To: <a3bb6544-064d-54a1-1215-d92188cb4209@i-love.sakura.ne.jp>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 30 Jul 2020 13:16:19 +0200
Message-ID: <CAKMK7uGTL02SHbEazu5YEnEncO6c-+P6DXt1GWSVQ28enqLx2g@mail.gmail.com>
Subject: Re: [PATCH] fbmem: pull fbcon_update_vcs() out of fb_set_var()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 12:47 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
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
> ---
>  drivers/video/fbdev/core/fbmem.c   | 8 ++------
>  drivers/video/fbdev/core/fbsysfs.c | 4 ++--
>  drivers/video/fbdev/ps3fb.c        | 4 ++--
>  include/linux/fb.h                 | 2 --
>  4 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 30e73ec..da7c88f 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -957,7 +957,6 @@ static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
>  int
>  fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>  {
> -       int flags = info->flags;
>         int ret = 0;
>         u32 activate;
>         struct fb_var_screeninfo old_var;
> @@ -1052,9 +1051,6 @@ static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
>         event.data = &mode;
>         fb_notifier_call_chain(FB_EVENT_MODE_CHANGE, &event);
>
> -       if (flags & FBINFO_MISC_USEREVENT)
> -               fbcon_update_vcs(info, activate & FB_ACTIVATE_ALL);
> -
>         return 0;
>  }
>  EXPORT_SYMBOL(fb_set_var);
> @@ -1105,9 +1101,9 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>                         return -EFAULT;
>                 console_lock();
>                 lock_fb_info(info);
> -               info->flags |= FBINFO_MISC_USEREVENT;
>                 ret = fb_set_var(info, &var);
> -               info->flags &= ~FBINFO_MISC_USEREVENT;
> +               if (!ret)
> +                       fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
>                 unlock_fb_info(info);
>                 console_unlock();
>                 if (!ret && copy_to_user(argp, &var, sizeof(var)))
> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
> index d54c88f..65dae05 100644
> --- a/drivers/video/fbdev/core/fbsysfs.c
> +++ b/drivers/video/fbdev/core/fbsysfs.c
> @@ -91,9 +91,9 @@ static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
>
>         var->activate |= FB_ACTIVATE_FORCE;
>         console_lock();
> -       fb_info->flags |= FBINFO_MISC_USEREVENT;
>         err = fb_set_var(fb_info, var);
> -       fb_info->flags &= ~FBINFO_MISC_USEREVENT;
> +       if (!err)
> +               fbcon_update_vcs(fb_info, var->activate & FB_ACTIVATE_ALL);
>         console_unlock();
>         if (err)
>                 return err;
> diff --git a/drivers/video/fbdev/ps3fb.c b/drivers/video/fbdev/ps3fb.c
> index 9df78fb..4b4a99f 100644
> --- a/drivers/video/fbdev/ps3fb.c
> +++ b/drivers/video/fbdev/ps3fb.c
> @@ -824,12 +824,12 @@ static int ps3fb_ioctl(struct fb_info *info, unsigned int cmd,
>                                 var = info->var;
>                                 fb_videomode_to_var(&var, vmode);
>                                 console_lock();
> -                               info->flags |= FBINFO_MISC_USEREVENT;
>                                 /* Force, in case only special bits changed */
>                                 var.activate |= FB_ACTIVATE_FORCE;
>                                 par->new_mode_id = val;
>                                 retval = fb_set_var(info, &var);
> -                               info->flags &= ~FBINFO_MISC_USEREVENT;
> +                               if (!retval)
> +                                       fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);

Patch looks good, except ... does this compile? fbcon_update_vcs is
defined in fbcon.h, and that doesn't seem to be included here ...
Maybe what we want is an fb_set_var_ioctl in fbmem.c so that the fbcon
interaction is a bit better hidden (but that's a bikeshed, feel free
to ignore). Also I have no idea what trickery you need to compile-test
ps3fb, that's why I'm asking :-)
-Daniel

>                                 console_unlock();
>                         }
>                         break;
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 3b4b2f0..b11eb02 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -400,8 +400,6 @@ struct fb_tile_ops {
>  #define FBINFO_HWACCEL_YPAN            0x2000 /* optional */
>  #define FBINFO_HWACCEL_YWRAP           0x4000 /* optional */
>
> -#define FBINFO_MISC_USEREVENT          0x10000 /* event request
> -                                                 from userspace */
>  #define FBINFO_MISC_TILEBLITTING       0x20000 /* use tile blitting */
>
>  /* A driver may set this flag to indicate that it does want a set_par to be
> --
> 1.8.3.1
>
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
