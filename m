Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A009C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF4220671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJeSS+kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgETSVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 14:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgETSVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:21:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2F5C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:21:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m185so3897000wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RW8P2ENxQMCRzJDvhD6yay/4wTNgEveKbVybNJiHgVo=;
        b=IJeSS+krA8BtcjjkI47iWUeYnFuBSbFDXEP2RNUnOMWW5cZeNSgk+DVsm4/yZxPNAz
         4ezHVkCWd2qDdZ8SjSzgAAt0DjfVbkWimRZVm+WR9wT0/SKcLMYkWBvnUZ7pj9sAWUsL
         ZgmPy2iZ28uJqlh+QSHst7qpORZOUvAzMfF1b52kEFMzglrR+Fh8cVq2LKtQ3qvCG5gV
         IWdqLYAOdCwkkYSx5UZFd9b5vYHO8lsF+rCypmOHyJDAuAhuz9QemgjE44UNIRa2iZQ3
         44WhDBjFLLW/HYFqWjH6BkzwJNaN3y/oZMO9bVJjv37evfX8IEKmg7CSxANYY+MQCBe8
         LIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RW8P2ENxQMCRzJDvhD6yay/4wTNgEveKbVybNJiHgVo=;
        b=lxVZC+/SV6K/1yWneXOr0Eh52Hawi46ZEtA1uoQqfI0vDA9GZ5Tt+j8acBSZh659n1
         FsUmqTjbz/APybw6RgNg1mjdQQcPrnipRLlsVYkl8EzZ+JP7qgZ/NE/rlZ/WZgoBORwi
         A95hkd5oF64dcz/j3rMQILDs8nvXFC1MKXPOzvjXUO4Hka0VI88sfo8gYdBCxO0+rj6w
         eRAat1iVgcrXIvekTKCQqJFbxAPkwNDE9x5zKZobIA4DPiOfNg7757eUBng0O1mT3gJM
         VwoqAHHcGY8SdZb6auUKq0Z4WIXoX/ga9haRNOv+hQcuxAVE4iKRKbkEIKAXfOMNxwp8
         qRww==
X-Gm-Message-State: AOAM532rkRRiYzE7xTnun8RlKNM6+NPZHHIPTBiecFxdR8vtOwRCsog2
        FtWKrQUYlE3pqk2R9xZiYyBOt3j8TPMam+Ta5Ag=
X-Google-Smtp-Source: ABdhPJxCW5X0NOlDHehi0pwlVrhAXnzeTfYJOtmzMEsCtQvgrfQ3aAfUCod8O8QieU4Qp1Bg6CBcbd7ODrrsnDAhjMA=
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr5643658wmh.39.1589998880315;
 Wed, 20 May 2020 11:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200520135306.11221-1-aurabindo.pillai@amd.com>
In-Reply-To: <20200520135306.11221-1-aurabindo.pillai@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 20 May 2020 14:21:08 -0400
Message-ID: <CADnq5_MBME9=yu=fdK-NWgEEZYUwBH-c7Ra7Mg-NrSru9zBS9g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdkfd: Fix large framesize for kfd_smi_ev_read()
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Amber Lin <Amber.Lin@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 9:53 AM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> The buffer allocated is of 1024 bytes. Allocate this from
> heap instead of stack.
>
> Also remove check for stack size since we're allocating from heap
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Tested-by: Amber Lin <Amber.Lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 26 +++++++++++++++------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index f5fd18eacf0d..5aebe169f8c6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -77,9 +77,11 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
>         int ret;
>         size_t to_copy;
>         struct kfd_smi_client *client = filep->private_data;
> -       unsigned char buf[MAX_KFIFO_SIZE];
> +       unsigned char *buf;
>
> -       BUILD_BUG_ON(MAX_KFIFO_SIZE > 1024);
> +       buf = kzalloc(MAX_KFIFO_SIZE * sizeof(*buf), GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
>
>         /* kfifo_to_user can sleep so we can't use spinlock protection around
>          * it. Instead, we kfifo out as spinlocked then copy them to the user.
> @@ -88,19 +90,29 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
>         to_copy = kfifo_len(&client->fifo);
>         if (!to_copy) {
>                 spin_unlock(&client->lock);
> -               return -EAGAIN;
> +               ret = -EAGAIN;
> +               goto ret_err;
>         }
>         to_copy = min3(size, sizeof(buf), to_copy);
>         ret = kfifo_out(&client->fifo, buf, to_copy);
>         spin_unlock(&client->lock);
> -       if (ret <= 0)
> -               return -EAGAIN;
> +       if (ret <= 0) {
> +               ret = -EAGAIN;
> +               goto ret_err;
> +       }
>
>         ret = copy_to_user(user, buf, to_copy);
> -       if (ret)
> -               return -EFAULT;
> +       if (ret) {
> +               ret = -EFAULT;
> +               goto ret_err;
> +       }
>
> +       kfree(buf);
>         return to_copy;
> +
> +ret_err:
> +       kfree(buf);
> +       return ret;
>  }
>
>  static ssize_t kfd_smi_ev_write(struct file *filep, const char __user *user,
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
