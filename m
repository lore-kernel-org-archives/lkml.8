Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7C2C3404E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 05:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C2C21D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 05:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcJvnBF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgBSFjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 00:39:33 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42078 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgBSFjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 00:39:33 -0500
Received: by mail-yb1-f193.google.com with SMTP id z125so11802163ybf.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 21:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6qeSHn0R8eb7oUSh15TXKxMRyNgkmSfzopxI3yp3FM=;
        b=RcJvnBF7TNNpu0kEihSEJQdZW95fpfOgZ8O3iNQbqQAgROzILUpdP+uVsm/rcl1j+J
         pjHjdUQD8jTt8MxZmqU2s6sl3TKCO/vW71rwrEK/UNzllPgXKlnfv5KaYhTHQQZhpq0q
         JzCLLmRVQWZMfwLNHqdwVTUvsX+P25oawWZv8lgqmJqQxFnKmdRsV7u5bPjM+hGEOwQW
         jbjIL2+JuT+a7/TcxjKhX4/fI4aVB7FYyLDvxHe0mCM5rGF8gzWRiVHauRngciMbMnGR
         5cuP6muvicfgeDgvGntE9eVb9lOsAigqLa/NwsuMIcUXZjY07CHLO43xs3HWFA8ufjwd
         gpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6qeSHn0R8eb7oUSh15TXKxMRyNgkmSfzopxI3yp3FM=;
        b=XJiU1Rkr+N3WQ/uwAmW2T1gX0YQVCANzWViOiciBOwA1IVwdjOcRo1CMLXB4Q6sNuB
         5S1CTm0/hf5irsss/FfL0Uxgj5PJoZj4+xFaKBYcz+oZTqyV0a46q53uWK2RUd1dWQO8
         QxDkUptyj6f/u5Q7t3iqNqGJK6bac3YkeZn3XXA3+qkCe3TEf71Z0WZpcnDo4Qro/E9O
         ETNmHsFO9ZvrrtxcVOiqm3SlhpvJqO43/6yQnSWiAyEbwMM72C+hwd42PIvXATdTVbKp
         njtPjRPHev2fVAT7ICm+wWPtuu4+2jW0ICUJSqECnUUg7Ilj397XAgY700TL257mHr3b
         XMDw==
X-Gm-Message-State: APjAAAVYST8QjuQvv48ADXwUnpo1MWCSqXFCNXbkc2mNCkhTOqpNq/k2
        1WDFWnI8dMcTAq4iBC2JM5gd2+it+2EhYX9iSu0D2xWw
X-Google-Smtp-Source: APXvYqw7XK3ql/hUSl5JmamnqXChYaKmxXHXPH/aXXM9HWgu2rFUFD7ZrvlJDTyhaeZmP6y0+qG8Ip7GA1hGQ3aztoo=
X-Received: by 2002:a25:42ca:: with SMTP id p193mr20880605yba.147.1582090771031;
 Tue, 18 Feb 2020 21:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20200218172821.18378-1-wambui.karugax@gmail.com> <20200218172821.18378-6-wambui.karugax@gmail.com>
In-Reply-To: <20200218172821.18378-6-wambui.karugax@gmail.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Wed, 19 Feb 2020 15:39:20 +1000
Message-ID: <CACAvsv4fWZWqQozMFPnyk7nXVyGPvszhY33qEQ74D0eAHofp2Q@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau: remove checks for return value of
 debugfs functions
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 at 03:28, Wambui Karuga <wambui.karugax@gmail.com> wrote:
>
> As there is no need to check for the return value of debugfs_create_file
> and drm_debugfs_create_files, remove unnecessary checks and error
> handling in nouveau_drm_debugfs_init.
Thanks!

>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_debugfs.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> index 7dfbbbc1beea..15a3d40edf02 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> @@ -222,22 +222,18 @@ nouveau_drm_debugfs_init(struct drm_minor *minor)
>  {
>         struct nouveau_drm *drm = nouveau_drm(minor->dev);
>         struct dentry *dentry;
> -       int i, ret;
> +       int i;
>
>         for (i = 0; i < ARRAY_SIZE(nouveau_debugfs_files); i++) {
> -               dentry = debugfs_create_file(nouveau_debugfs_files[i].name,
> -                                            S_IRUGO | S_IWUSR,
> -                                            minor->debugfs_root, minor->dev,
> -                                            nouveau_debugfs_files[i].fops);
> -               if (!dentry)
> -                       return -ENOMEM;
> +               debugfs_create_file(nouveau_debugfs_files[i].name,
> +                                   S_IRUGO | S_IWUSR,
> +                                   minor->debugfs_root, minor->dev,
> +                                   nouveau_debugfs_files[i].fops);
>         }
>
> -       ret = drm_debugfs_create_files(nouveau_debugfs_list,
> -                                      NOUVEAU_DEBUGFS_ENTRIES,
> -                                      minor->debugfs_root, minor);
> -       if (ret)
> -               return ret;
> +       drm_debugfs_create_files(nouveau_debugfs_list,
> +                                NOUVEAU_DEBUGFS_ENTRIES,
> +                                minor->debugfs_root, minor);
>
>         /* Set the size of the vbios since we know it, and it's confusing to
>          * userspace if it wants to seek() but the file has a length of 0
> --
> 2.25.0
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
