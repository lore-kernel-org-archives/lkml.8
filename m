Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C210BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 20:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA712078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 20:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nymJ5+tO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgHZUuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgHZUuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 16:50:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4843C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:50:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a65so3174510wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9BaKjLl1F4E3WG9x32pZx6L6jhUxxfqUOzRaIPS/D6E=;
        b=nymJ5+tO1YbnKkRM6ldq0ucFxtXQI6RGWyaXiSrMjx8eo4S5NB1wQK+6i9tf1RAJlZ
         v9TsyVWBeaf0bR/w01DZBM1tm3mo9pXF4Ix5dlbr5cXMVqO3DjptiwYuwlcQcq7u+pHI
         b6fytSdIKh94YcyMPAWrZsy+hk0lRGShtLNRFvhA2bUD6NiADs8Ab89nx+w4hHQhkB/R
         mwDrJoyEOtf6VUweXzJOnaL4XxZjh4NVTV7WbNVa42viMex5DhMkV9tt1jrK1Zuoj3fU
         2eMjukQiW71GOcmlbb6mIjQExf0cP8IouXhYqr4TMDIIC1cBkOKmrqpQhy5fN+zs4D3y
         qYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9BaKjLl1F4E3WG9x32pZx6L6jhUxxfqUOzRaIPS/D6E=;
        b=BCmZBVbDc3uC352ec9Lk3VPJEqDPs9ZgpxyNUqguFK7DNV7X62+rnJtNHDO4jdFr1K
         QMCAvbktq4yjS+sKBhcQg+4ZxGD+Z963Vz05/Lj85GYhGo1BzS+CDgp+FP0fKngwz6B9
         rZdS+JRJ9cZxn6SfP52/LJkNOkCF1kUTeuF98f91fF/B5WA1sxAy+vHrKxZ4iSJ58S/t
         oi02dwuEyKH4yQj77JYB3WSiUKkm8tXfGRYKbyxbm91u47t+S6+XdLv8+odXXlToyyNI
         E3rk+uosa+BlR2+RYAraAU2W2Tu8hS5EI+Ifv4Rw0cpOgiWgq95xwN/qGCGo0BTV45ip
         4bGQ==
X-Gm-Message-State: AOAM530D1ckNh3KyavS4oNu8UpelDg0SNcKIxuAjmdTmTEbVJCXe39jK
        OIE3+Drl3tW6B89Bm8F8aeg=
X-Google-Smtp-Source: ABdhPJz3HjRuL1A3zOhrETsONMNElibpsRplzpBg6UruDUil6V+PW+KHVLHLDaytHVipTY65dWhR4w==
X-Received: by 2002:a1c:c20a:: with SMTP id s10mr1426600wmf.55.1598475002040;
        Wed, 26 Aug 2020 13:50:02 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id e2sm509657wrt.66.2020.08.26.13.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 13:50:01 -0700 (PDT)
Date:   Wed, 26 Aug 2020 17:49:54 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/vkms: fix warning in vkms_get_vblank_timestamp
Message-ID: <20200826204954.u6aqwcmwpsudrkh4@smtp.gmail.com>
References: <20200825144248.1751-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825144248.1751-1-realwakka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sidong,

Thanks for this patch.

The code looks good to me; however, I see some issues in the patch
format and commit message. Please, see inline comments.

On 08/25, Sidong Yang wrote:
> From: Sidong Yang <realwakka@gmail.com>, Haneen Mohammed <hamohammed.sa@gmail.com>

You need to fix the Author name.
> 
> When vkms_get_vblank_timestamp() is called very first time without
> enabling vblank before, vblank time has just intial value and it makes
> warning message. this patch prevents warning message by setting vblank
> time to current time.

I consider *fix* a somewhat strong term to this change. In my opinion,
it would be better to choose another term in the commit message like
*avoid* timestamp warning when vblanks aren't enabled.

In the body of the commit message, I think interesting to include the
exactly warning message that this patch addresses. You could also
describe the initial values that triggers this warning and why this
approach is reasonable, as VKMS has fake clocks.

> 
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> Cc: Melissa Wen <melissa.srw@gmail.com>
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index ac85e17428f8..09c012d54d58 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -86,6 +86,11 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
>  	struct vkms_output *output = &vkmsdev->output;
>  	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
>  
> +	if (!READ_ONCE(vblank->enabled)) {
> +		*vblank_time = ktime_get();
> +		return true;
> +	}
> +

Apart from issues in commit message and format, I checked the code and it
works fine.

Reviewed-by: Melissa Wen <melissa.srw@gmail.com>

>  	*vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
>  
>  	if (WARN_ON(*vblank_time == vblank->time))
> -- 
> 2.17.1
> 
