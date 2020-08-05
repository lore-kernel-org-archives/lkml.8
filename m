Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9831AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 719E22067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="R9PgmfP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgHEJh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgHEJgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:36:54 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD9C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 02:36:54 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h22so3598877otq.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 02:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QAf2r22ie0nJ9P9yn7tCrZWYCPDCIRxVkswdnQpyC0=;
        b=R9PgmfP4r/afAuE6yEI5xwzwZqrkDG1FMSlt+zUdxWUaS4wWM+lhaaJ3udKFGIHV/W
         Sxr3aqMHHy30L/DQSNLDdmhLhwdZ6M+XCwLD+M0bLPKXBlfV9xBmPsPg27gzv1ujq3a2
         YgKJtw3aPeIIZqvGF1oQZ/LAv6nhBrxZ1HTv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QAf2r22ie0nJ9P9yn7tCrZWYCPDCIRxVkswdnQpyC0=;
        b=VByxOfoGjYoFbAxQ3PE6B0+Lcii9d0caxVlJ7Dnf3TcIp40kU2U11CdiEJV8ZTuIHN
         c/imBA6WlaxajqlIos2oroDytzg0rTSlxZdkSo/UcS+a2qQHJZA2KeF5qkQR4vcgVjW3
         U5O+BZjT5TNlTACwcPU1bMLAQbcm3YZ86duQE5AgIjyjbBTHcGqWw57vwSA6AojdebxD
         F5H4y9zO0jFewdaXKMN1a86i9171sCkJjtsqQWrRBZqCMFxh1U2ntOTS6ymeq9GmDe6/
         8xKTvesqMtIdjP+NgJMr+x3uDP05fvwa8e02Slq5Hyt6lh6k5YRK+ATSurBtCAPhNIFs
         cIOA==
X-Gm-Message-State: AOAM533Wss3z91bK5SDnKPqiJH6svayoPa4+r63r0cASaa5w0LyCgsc1
        d0X8mRbn4YApLX4ulKCgrhNZ5f3KDCd9WDnUGLvhCA==
X-Google-Smtp-Source: ABdhPJxbvKXGNnuWD4z2BMkiilvW3CUx+kj1KpLvwjAj9AlKw4Z10kOAXFUtCEfBE2pJ5diZAjtOip4Pqm/YdXEBojM=
X-Received: by 2002:a9d:7283:: with SMTP id t3mr1760637otj.303.1596620213781;
 Wed, 05 Aug 2020 02:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200805083646.4123-1-hjc@rock-chips.com>
In-Reply-To: <20200805083646.4123-1-hjc@rock-chips.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 5 Aug 2020 11:36:42 +0200
Message-ID: <CAKMK7uGmKJqZJ0ONQjjquZn6mksKbkScmcUSEA43eg1jFskmTg@mail.gmail.com>
Subject: Re: [PATCH] drm: sysfs: Add to get current mode
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Tao Huang <huangtao@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 10:37 AM Sandy Huang <hjc@rock-chips.com> wrote:
>
> add this node to get the current true mode.
>
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>

Uh what's this for? Since it's sysfs, I guess there's something
parsing this, which means we'd kinda need to have that piece too.

If it's just for debugging purposes, then we already have this
information in debugfs, together with everything else that's in the
atomic modeset state.
-Daniel

> ---
>  drivers/gpu/drm/drm_sysfs.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 939f0032aab1..f39bcd34853b 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -19,6 +19,7 @@
>  #include <linux/slab.h>
>
>  #include <drm/drm_connector.h>
> +#include <drm/drm_crtc.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_modes.h>
> @@ -236,16 +237,45 @@ static ssize_t modes_show(struct device *device,
>         return written;
>  }
>
> +static ssize_t current_mode_show(struct device *device,
> +                     struct device_attribute *attr,
> +                     char *buf)
> +{
> +       struct drm_connector *connector = to_drm_connector(device);
> +       struct drm_display_mode *mode;
> +       struct drm_crtc_state *crtc_state;
> +       bool interlaced;
> +       int written = 0;
> +
> +       if (!connector->state || !connector->state->crtc)
> +               return written;
> +
> +       crtc_state = connector->state->crtc->state;
> +       if (!crtc_state)
> +               return written;
> +
> +       mode = &crtc_state->mode;
> +
> +       interlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
> +       written += snprintf(buf + written, PAGE_SIZE - written, "%dx%d%s%d\n",
> +                           mode->hdisplay, mode->vdisplay,
> +                           interlaced ? "i" : "p", drm_mode_vrefresh(mode));
> +
> +       return written;
> +}
> +
>  static DEVICE_ATTR_RW(status);
>  static DEVICE_ATTR_RO(enabled);
>  static DEVICE_ATTR_RO(dpms);
>  static DEVICE_ATTR_RO(modes);
> +static DEVICE_ATTR_RO(current_mode);
>
>  static struct attribute *connector_dev_attrs[] = {
>         &dev_attr_status.attr,
>         &dev_attr_enabled.attr,
>         &dev_attr_dpms.attr,
>         &dev_attr_modes.attr,
> +       &dev_attr_current_mode.attr,
>         NULL
>  };
>
> --
> 2.17.1
>
>
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
