Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B30C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2331020773
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="I1ljf0ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgCRNua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:50:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42584 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgCRNu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:50:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id v11so30553982wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 06:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=XccCPctkAdV/8ABAxnQ5VwYEjRgb5OJA1jC/yCtBVYI=;
        b=I1ljf0adRaW/V1KC7utnbIQYNKvRQb1ZxU01eNnezjuv6EmUivN+cWO5CNflsS0hfT
         jEdCgSSpd2PjWSGulDFhZdEd5eMe927eZpiD8EAxAhIZW9sHj/TFlO+3WfH1U8fj4ecb
         QMQkS+2Y3qzE0h9pV5V5sro3G19mLqWB/pfac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XccCPctkAdV/8ABAxnQ5VwYEjRgb5OJA1jC/yCtBVYI=;
        b=gvOupIJh/IrgSkmPO4YGdIoAb793JCsgVCXywNSiR+0lBgCIETb/jmSiHqWtQQGPxP
         MAq+/EHFbIF2cZLe7Y1YO98cVhYY/6HEPqyt7F04QgA5ewEMUcU8b+zhlpurTLPioMwW
         FNzzFxuSjSOGvy4RTf/nyFTbXGt0yD94m50MVFK9Q7Hc+Rls2tHJKhjrA8cUmVCzWNMJ
         fnAhNqiMalo2xoCDQJFJQQTja+z47q5cpYul3pHI7wintQYrGwFL7X7e8vdpNaNvfG+i
         802jgl2uJRsezeJd6I2LUPrU5UJUgwIT8M8vk1Ay5zxKsOK+Pz04NZazjULVcKU0J5zt
         BZCA==
X-Gm-Message-State: ANhLgQ0/9FCdqtHw0kt0VcZsslOp/FA3OZi5fzbqOC/qXO7f9P8S9jIx
        Yb3q7S19wv47tPVw3VadEj6dow==
X-Google-Smtp-Source: ADFU+vuDk7wnQRImLnOiwAYtmQ9nntEm5AfmJm2mHPI5WuMxgr+Um1lVXT09iRpAmPaIlMWncT25VA==
X-Received: by 2002:a5d:414f:: with SMTP id c15mr6321028wrq.60.1584539427182;
        Wed, 18 Mar 2020 06:50:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w19sm3880374wmi.0.2020.03.18.06.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:50:26 -0700 (PDT)
Date:   Wed, 18 Mar 2020 14:50:24 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Rodrigo.Siqueira@amd.com,
        rodrigosiqueiramelo@gmail.com, andrealmeid@collabora.com
Subject: Re: [PATCH v2] drm: Correct a typo in a function comment
Message-ID: <20200318135024.GX2363188@phenom.ffwll.local>
Mail-Followup-To: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, sumit.semwal@linaro.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rodrigo.Siqueira@amd.com, rodrigosiqueiramelo@gmail.com,
        andrealmeid@collabora.com
References: <20200317210339.2669-1-igormtorrente@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317210339.2669-1-igormtorrente@gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 06:03:39PM -0300, Igor Matheus Andrade Torrente wrote:
> Replace "pionter" with "pointer" in the drm_gem_handle_create description.
> 
> Changes in v2:
> - Change subject text
> 
> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>

Thanks for your patch, queued for 5.8 in drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/drm_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 6e960d57371e..c356379f5e97 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -432,7 +432,7 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
>   * drm_gem_handle_create - create a gem handle for an object
>   * @file_priv: drm file-private structure to register the handle for
>   * @obj: object to register
> - * @handlep: pionter to return the created handle to the caller
> + * @handlep: pointer to return the created handle to the caller
>   *
>   * Create a handle for this object. This adds a handle reference to the object,
>   * which includes a regular reference count. Callers will likely want to
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
