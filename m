Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C819C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F232076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="e+s6DHmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgG2ISZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2ISZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:18:25 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8049C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:18:24 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id o72so11326597ota.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGI4csuNiLS6fTAVR1vQNcVBEWSJTSk1oAgwrrB5NsI=;
        b=e+s6DHmgRnUm69dvY6m2+wPD1X7mXvPZP0fswGknSPRvoHeYYGhzmpEn1hRP36juI+
         V7TLksSzFpiPGZ8iBtvuXY677+7945nVOo6cGw3h1DxW9Egpg1lITwCjHofkkZSgWJco
         0eO2GF3rPRG9tVA7CqAt0TGLANGNbH2HvhkYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGI4csuNiLS6fTAVR1vQNcVBEWSJTSk1oAgwrrB5NsI=;
        b=lkJ4ux5ngcP5UAn2FZe/5dCytRArPO9o5S2UatQPomxmgOhxxMVpzg/lDeD/M9Q+mo
         3dO6rEW1nJ31w8Wmu4po5Vn01cpOGc8vOgwswFi205C/mMYF8pxCwywXC/pmBN7JiicY
         5faM0hXuyzpVbb8L1UQ6grAPnkfk/Sju9eZaQS0IKWE9kC4qctRX9KFiLgZqBaSWwOdQ
         wwKB+Hbe/PvB6dIROvGYWcTqPsEEmJEpF/sOJWU2DjZto2p73aXKjGp/lk/5OysCaBA7
         JAfkTQyLrbdpHWuZnAXuae1Gwc2pz0s/CIEVOU/YuEg5wceAAJfuHyzazeJywaRQrbbV
         zFnA==
X-Gm-Message-State: AOAM530RFX6gU9gZb4c7wZ/dTifLD8JqsQxFXjV+tya2pii56KQpmyhc
        u8RTR1hGQ4cAQn3y0sKr09J8gWM//423Siuo9yoZIA==
X-Google-Smtp-Source: ABdhPJzBH+27x3ZujuEpHEVy6Gcb6DYFt6r/ynfQcsmDo5vW4q292PZiJ8/qFIUa5jgMuBmctGSCddAR2m3AVK8RCQA=
X-Received: by 2002:a9d:6052:: with SMTP id v18mr2509589otj.303.1596010704124;
 Wed, 29 Jul 2020 01:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <1596000620-4075-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1596000620-4075-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 29 Jul 2020 10:18:12 +0200
Message-ID: <CAKMK7uHeteS2+rKrZKrAM+zQO==hAX0XaVc9JfHPsdLTCtzKOw@mail.gmail.com>
Subject: Re: [PATCH] vt: Handle recursion in vc_do_resize().
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

On Wed, Jul 29, 2020 at 8:58 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is reporting OOB read bug in vc_do_resize() [1] caused by memcpy()
> based on outdated old_{rows,row_size} values, for resize_screen() can
> recurse into vc_do_resize() which changes vc->vc_{cols,rows} that outdates
> old_{rows,row_size} values which were read before calling resize_screen().
>
> Minimal fix might be to read vc->vc_{rows,size_row} after resize_screen().
> A different fix might be to forbid recursive vc_do_resize() request.
> I can't tell which fix is the better.
>
> But since I guess that new_cols == vc->vc_cols && new_rows == vc->vc_rows
> check could become true after returning from resize_screen(), and I assume
> that not calling clear_selection() when resize_screen() will return error
> is harmless, let's redo the check by moving resize_screen() earlier.
>
> [1] https://syzkaller.appspot.com/bug?id=c70c88cfd16dcf6e1d3c7f0ab8648b3144b5b25e
>
> Reported-by: syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Ok, I have actual insight on this one here, and I'm pretty sure this
isn't the fix. Looking at the syzkaller splat we have a recursion of
the form

fb_ioctl -> fb_set_var -> fbcon_update_vcs -> fbcon_resize -> fb_set_var

Which isn't supposed to be happening. I've dug around recently in
fbcon code, and this is a fairly common issue: You can update fbcon
state both from fb_ioctl, but also from the vc side. To avoid the
above recursion problems the code is using FBINFO_MISC_USEREVENT, and
should only set that from fb_ioctl entry points. That's all fairly
fragile, so I've done a bit of reworking, e.g.

commit de29ae5c092bd9a5360cfabf174b0f783248d278
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue May 28 11:02:56 2019 +0200

    fbmem: pull fbcon_fb_blanked out of fb_blank

as an example.

I think doing the same for fb_set_var, i.e. only calling
fbcon_update_vcs for the 3 callers that want it, should fix this
recursion. I think that's the much more robust fix instead of trying
to paper over the fallout of this recursion here and everywhere else.

Can you look into reworking your patch like that?

Cheers, Daniel

> ---
>  drivers/tty/vt/vt.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 42d8c67..952a067 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1217,7 +1217,24 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>
>         if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
>                 return 0;
> +       if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
> +               return -EINVAL;
>
> +       /*
> +        * Since fbcon_resize() from resize_screen() can recurse into
> +        * this function via fb_set_var(), handle recursion now.
> +        */
> +       err = resize_screen(vc, new_cols, new_rows, user);
> +       if (err)
> +               return err;
> +       /* Reload values in case recursion changed vc->vc_{cols,rows}. */
> +       new_cols = (cols ? cols : vc->vc_cols);
> +       new_rows = (lines ? lines : vc->vc_rows);
> +       new_row_size = new_cols << 1;
> +       new_screen_size = new_row_size * new_rows;
> +
> +       if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
> +               return 0;
>         if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
>                 return -EINVAL;
>         newscreen = kzalloc(new_screen_size, GFP_USER);
> @@ -1238,13 +1255,6 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>         old_rows = vc->vc_rows;
>         old_row_size = vc->vc_size_row;
>
> -       err = resize_screen(vc, new_cols, new_rows, user);
> -       if (err) {
> -               kfree(newscreen);
> -               vc_uniscr_free(new_uniscr);
> -               return err;
> -       }
> -
>         vc->vc_rows = new_rows;
>         vc->vc_cols = new_cols;
>         vc->vc_size_row = new_row_size;
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
