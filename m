Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360A0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1368B20720
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QcPIfJT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390953AbgFYJnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390531AbgFYJnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:43:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FADC061795
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:43:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h15so5125228wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MqP8eNt5kwKUBAByimv8vaw/hFZlRD99sPA2Bo3gQ/A=;
        b=QcPIfJT0OYuMimVCuS3u7waeycKOlpWv1A6SwNnzq88479wkKhcjXVPkab2vluMUX5
         LeeTArYmmhswzaY/daOOdr5sF6wdkDWQp17nI/brLbmrDDjepmJdul0+lk+0uX1UxvZr
         buN0EhR1tUvzo4Z/TumMGB9c57ZCJHgulDKYH/BU9AGQURU7Dld75NtJwyyBlsrabgpG
         dCWzNGGCrFwBPWctYAT6eG9ugrrhh08GlrzsmMrgGshMttLdCvsa3pwMT3xBVjpgSJKH
         7X+DHAadcNLe9HyuDwmDuQxk9yu4mk1E+zQKjoS76LezdLZc2d5mAutvLXMQ6Dehan0v
         VqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MqP8eNt5kwKUBAByimv8vaw/hFZlRD99sPA2Bo3gQ/A=;
        b=MmkLUbt5EL2LusVCwMay9/GIy8IF0eKazP7SYMShzCAeoMZR117KxDCaaQskB6DuVi
         VlmVjVPHcUlvBo/aqeQ3kcz7a9mt54IKzIrb7N3st52Vvh6/QQAUhXZ6iciVc/LtEHmL
         81fJKzIyoQYbn4EEKzosDEM3xXOmUvT+gimBiyki/fCJ/+ZdMpgVa3JNo1NWFMf7EOMT
         EgTD3WVi6kh2IMk44H5I7x0jyB6BerkQ+DlLyiuCmtHCXhGhF9k6osJh/HWH7YTI521n
         4Ts/yfExVCifkTNKqzyuust0t1pD/2C1tYJcxziCiK4YFKpWkoMYbEiti0EqoUn56K+y
         yuwA==
X-Gm-Message-State: AOAM5312XhAL36HnmP/egBhOIXIUNZ/l+li5juFWzls8RClcEPqy2JlR
        sB7fjd++4qQ+ICOxkOFKj5KvfA==
X-Google-Smtp-Source: ABdhPJxi4S3Sc2l8ebR+2X/0lvGbwaCCrXXH0BrvjqecfUvwyNjsH13vgYRHtDkjWkf3uBbECp8RmQ==
X-Received: by 2002:a5d:4845:: with SMTP id n5mr19419236wrs.353.1593078226184;
        Thu, 25 Jun 2020 02:43:46 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f13sm10976485wmb.33.2020.06.25.02.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 02:43:45 -0700 (PDT)
Date:   Thu, 25 Jun 2020 10:43:43 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jingoohan1@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jamey Hicks <jamey.hicks@hp.com>,
        Andrew Zabolotny <zap@homelink.ru>
Subject: Re: [PATCH 6/8] backlight: backlight: Supply description for
 function args in existing Kerneldocs
Message-ID: <20200625094343.koh2ln4fy6v6h7mo@holly.lan>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624145721.2590327-7-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624145721.2590327-7-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:57:19PM +0100, Lee Jones wrote:
> Kerneldoc syntax is used, but not complete.  Descriptions required.
> 
> Prevents warnings like:
> 
>  drivers/video/backlight/backlight.c:329: warning: Function parameter or member 'reason' not described in 'backlight_force_update'
>  drivers/video/backlight/backlight.c:354: warning: Function parameter or member 'props' not described in 'backlight_device_register'
> 
> Cc: <stable@vger.kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Jamey Hicks <jamey.hicks@hp.com>
> Cc: Andrew Zabolotny <zap@homelink.ru>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/backlight.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 92d80aa0c0ef1..744ba58488e01 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -320,6 +320,7 @@ ATTRIBUTE_GROUPS(bl_device);
>   * backlight_force_update - tell the backlight subsystem that hardware state
>   *   has changed
>   * @bd: the backlight device to update
> + * @reason: reason for update
>   *
>   * Updates the internal state of the backlight in response to a hardware event,
>   * and generate a uevent to notify userspace
> @@ -344,6 +345,7 @@ EXPORT_SYMBOL(backlight_force_update);
>   * @devdata: an optional pointer to be stored for private driver use. The
>   *   methods may retrieve it by using bl_get_data(bd).
>   * @ops: the backlight operations structure.
> + * @props: pointer to backlight's properties structure.
>   *
>   * Creates and registers new backlight device. Returns either an
>   * ERR_PTR() or a pointer to the newly allocated device.
> -- 
> 2.25.1
> 
