Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21715C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03E22074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPYFbGpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgFPGL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPGL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:11:59 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4DBC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:11:59 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id t9so10244145ybk.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lE4bGstBoggLPhv8uJAg4uGkYb5Z9vSRwF4L3Jje+wo=;
        b=MPYFbGpJdUMvtwjGmaIwzG3Iyrhfrd6AwKB1GEr0bqXVBhjaR2bczI97dfYYU+Qrd+
         RsnLtRSc/fJZeNSSmiNzKxBIkV9szGBKwiV4Ub74araqyuNEZBaSMhD2ec8JG2hUHYmp
         l/A0szY/4npdYOTqOj5E/WvTCjD6ZOvlDxdQyw2p39LrF33PYe+Y2Q+dvxVG2evXgdAw
         kMvfkDHgVRDWLMC0/lzGX8RFpZs04so3LLuRk2kYLCt6p8rF+Sfi2n12PKKvQ40Gd4KZ
         jllSxNBKYcH7FwKpG5Cnoulc/mPNInARGsRbMM5kFE0VKOzIcMl3KDYIhx65MHiP3BzW
         wfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lE4bGstBoggLPhv8uJAg4uGkYb5Z9vSRwF4L3Jje+wo=;
        b=UjgKe6jZ9wgkD1i0erWyGEhVUXLDdWOD+642BQvLo1CpzNoTFi3QxF89M9gDst3pu1
         ThbvbMBGbwwK+ourfzJJq8vL+MrCDePn3hKPNShINg1+r5x7LeiT8Jtt6c2U0tHc68mb
         /dVWQVNO97U+sfBKWkKyeAdQyBk/KQAX1ZGedBu2VYOtVCxSXZYDoXzuavWg+SjBvPoy
         zHHwCUpd7kCsFmkUVKap+LAbD6VVRVGonvX7LpRryef9j8S++wcBg6bP+crIj91R7Glc
         XcOzgEGo+ODR30fGZ6jyaH0Has8YcC1i2ap4BjzXxkKzVDwCDq6GTkqbHLudgnUWhw7M
         G5LA==
X-Gm-Message-State: AOAM532+S1KyAKHbx+e3K2GUPBiCI/qfmG+/xAlQYduNxcfnxAZzJGQ9
        5MdSd9mww73Zkoguwh/bAO+k9bvTHWjSTksySdo=
X-Google-Smtp-Source: ABdhPJzm7pCxfaqFQPtBekETYsKJpbYXHIQaJTYd2Y2htl0fodkpebMxxspxfSmn7vXOgp5JviDezUE2Iu1FpMnkCnQ=
X-Received: by 2002:a25:7b41:: with SMTP id w62mr1627864ybc.435.1592287918528;
 Mon, 15 Jun 2020 23:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200614014838.123171-1-pakki001@umn.edu>
In-Reply-To: <20200614014838.123171-1-pakki001@umn.edu>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Tue, 16 Jun 2020 16:11:47 +1000
Message-ID: <CACAvsv7FMUMpZToCQK4QtnaB5muyjk1MW5KOpyrGVtatM-gmsA@mail.gmail.com>
Subject: Re: [PATCH] drm/noveau: fix reference count leak in nouveau_debugfs_strap_peek
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     wu000273@umn.edu, David Airlie <airlied@linux.ie>,
        ML nouveau <nouveau@lists.freedesktop.org>, kjlu@umn.edu,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

I've grabbed this, and the others of the same sort you sent out at the
same time.

Ben.

On Mon, 15 Jun 2020 at 17:29, Aditya Pakki <pakki001@umn.edu> wrote:
>
> nouveau_debugfs_strap_peek() calls pm_runtime_get_sync() that
> increments the reference count. In case of failure, decrement the
> ref count before returning the error.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/gpu/drm/nouveau/nouveau_debugfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> index 63b5c8cf9ae4..8f63cda3db17 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> @@ -54,8 +54,10 @@ nouveau_debugfs_strap_peek(struct seq_file *m, void *data)
>         int ret;
>
>         ret = pm_runtime_get_sync(drm->dev->dev);
> -       if (ret < 0 && ret != -EACCES)
> +       if (ret < 0 && ret != -EACCES) {
> +               pm_runtime_put_autosuspend(drm->dev->dev);
>                 return ret;
> +       }
>
>         seq_printf(m, "0x%08x\n",
>                    nvif_rd32(&drm->client.device.object, 0x101000));
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
