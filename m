Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D175C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C4122B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EZwGBR7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgBRTAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:00:43 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45056 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgBRTAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:00:43 -0500
Received: by mail-oi1-f195.google.com with SMTP id v19so21180606oic.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVon9MCR2eKlk3dtcH82oPxf8ZW6p7b6JHgOz9jQlJ8=;
        b=EZwGBR7wltaso7KhEh5dfSJbjAp4uSZHWmBk/Y+mD4q9cTqryM6/WOKaX6tY5jqXyZ
         uLqXtUPtOlgsxM5z7Au9JuQbFew4H2vmEZFtsqH6qZzC2WL00Snld3cL6E+pGUhqs9Jc
         11g1hFBfNlSpwjlDkVO1lpcQxQhXZGPmeqcJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVon9MCR2eKlk3dtcH82oPxf8ZW6p7b6JHgOz9jQlJ8=;
        b=QwMyvBm2pXj3zsTUS2RB6hzO842tGU17/n3Rse+4GRnYblPIxBqG/B5a0cso9OvUhC
         QyEC4cP7JLcB3krq9DmWfUMFG+WPtIuHeRUtwcIBoodqe+Y226CXwY90fK6FIoPG8XXn
         TVf0Hy2nyqrgJMZU/LzhicCMt3E88t5/YGFojxETrj9CSW/P9asOiziX+3q43i0H/pOh
         VMuxdVxhWVXGkJFl5RSAJOFThU8KnBAacBZKKCeAEVGspsQF8Vrgf7mbBZMJZJxv4fok
         dECBpHW1buZFtWcXRoE6cP8USb57ZU9vfyKSbpfVub/ocP8volJyo1sliYZ9kqfCR8aR
         gcHw==
X-Gm-Message-State: APjAAAWVULOopgMagw1PjgL4PQddqwXktHL57G1/oXcTTLEitZdNeY6E
        RHdb38islUHT2xKcPfNL77FiO97PlZuekntT02Mvcg==
X-Google-Smtp-Source: APXvYqwFFnV1mL2xMZPIBgZloQiK9LP4j3LCKSgLL4kBiHdrCnQ/AeAqqg7MVL9ZKN98b//hq7cvNGKRbvdJqFGadB4=
X-Received: by 2002:a05:6808:10b:: with SMTP id b11mr2254105oie.110.1582052441303;
 Tue, 18 Feb 2020 11:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20200218172821.18378-1-wambui.karugax@gmail.com>
In-Reply-To: <20200218172821.18378-1-wambui.karugax@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 18 Feb 2020 20:00:30 +0100
Message-ID: <CAKMK7uHeSW-sFCZK09n89mJ66J3sb0EtxYU9Ojfi-adM7czTug@mail.gmail.com>
Subject: Re: [PATCH] drm/arc: make arcpgu_debugfs_init return 0
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     Alexey Brodkin <abrodkin@synopsys.com>,
        Dave Airlie <airlied@linux.ie>,
        Greg KH <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 6:28 PM Wambui Karuga <wambui.karugax@gmail.com> wrote:
>
> As drm_debugfs_create_files should return void, remove its use as the
> return value of arcpgu_debugfs_init and have the latter function
> return 0 directly.
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/gpu/drm/arc/arcpgu_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/arc/arcpgu_drv.c b/drivers/gpu/drm/arc/arcpgu_drv.c
> index d6a6692db0ac..660b25f9588e 100644
> --- a/drivers/gpu/drm/arc/arcpgu_drv.c
> +++ b/drivers/gpu/drm/arc/arcpgu_drv.c
> @@ -139,8 +139,10 @@ static struct drm_info_list arcpgu_debugfs_list[] = {
>
>  static int arcpgu_debugfs_init(struct drm_minor *minor)
>  {
> -       return drm_debugfs_create_files(arcpgu_debugfs_list,
> -               ARRAY_SIZE(arcpgu_debugfs_list), minor->debugfs_root, minor);
> +       drm_debugfs_create_files(arcpgu_debugfs_list,
> +                                ARRAY_SIZE(arcpgu_debugfs_list),
> +                                minor->debugfs_root, minor);
> +       return 0;

For cases like these I think we should go a step further and also
remove the return value from the driver wrapper. And that all the way
up until there's something that actually needs to return a value for
some other reason than debugfs.
-Daniel

>  }
>  #endif
>
> --
> 2.25.0
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
