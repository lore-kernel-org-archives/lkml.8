Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90D3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3882071A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="afY0mSX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436965AbgE1WUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436952AbgE1WUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:20:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3984C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:20:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m7so159260plt.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=NIrmsov8fCmRXlFvg/QT7vVocTnt+ne2gI6KC0HBK0s=;
        b=afY0mSX4ecEhor/wnhCdYO9il2Qtq7+n+SMWBVmU+POSzCk+3OpQZWwmv7EVvRA818
         1/xOb28Rt8SImGKI/oRgohVUXOtsGfffbAFwMcGZYFHDW8aYoSNHechWOLGk5al4qV7z
         vSI8HsqGIo6mCTOjm919fK1nnMI69ZuEw3k30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=NIrmsov8fCmRXlFvg/QT7vVocTnt+ne2gI6KC0HBK0s=;
        b=MNPkQamXzTAY7p+GVUlZxLRUDWh3BPQLqmxtctfb7HbCJ+nZF8kNL5rrGxm/u73fjA
         r8QiULyDDzvi0x0gc5x9PBdxcuoRe02evp0DgiX1JIYyAdbb3St6Mahu26w/bO3XYOMc
         MoNxj0TPSkIJtsbU+tOj+zJsgs74vMh/PIZ56DDy8GsV36WcOnsE4VrOn1hSFuAqLT4L
         SqoTxwXdohXoGUlIDQzQkU6LBNF5jzO9LfFqcuLx9aBZPkPBDNRUBuUmvfQGdDLQuX8q
         eVUS7Xed95nhwnuuDS0CSLgZ2o3LHFVop72RkCbW6ACCJK+NAd7F2Z6LGa/ft/U7dGiK
         fYCw==
X-Gm-Message-State: AOAM532/6Xj66XTZNtsA0H6ueFLkwaAjLE7Q/QIkxuMtr2yRrXBCIUY6
        nDZQOI4AKSUM3UYp+8IpvFmBdg==
X-Google-Smtp-Source: ABdhPJzUwecS9O4N+0Q5MiuUxbCuwmR873e50Cqr3EvQobTbxJBzbn00SvqWBzMofBCP1ZKG8DsPNQ==
X-Received: by 2002:a17:902:a604:: with SMTP id u4mr5665326plq.196.1590704420073;
        Thu, 28 May 2020 15:20:20 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v1sm6539323pjn.9.2020.05.28.15.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:20:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1590655103-21568-1-git-send-email-mkrishn@codeaurora.org>
References: <1590655103-21568-1-git-send-email-mkrishn@codeaurora.org>
Subject: Re: [v1] drm/msm: add shutdown support for display platform_driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Krishna Manikandan <mkrishn@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        kalyan_t@codeaurora.org, nganji@codeaurora.org, mka@chromium.org
To:     Krishna Manikandan <mkrishn@codeaurora.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Date:   Thu, 28 May 2020 15:20:18 -0700
Message-ID: <159070441846.69627.1650074507855844615@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krishna Manikandan (2020-05-28 01:38:23)
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index e4b750b..7a8953f 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -1322,6 +1322,18 @@ static int msm_pdev_remove(struct platform_device =
*pdev)
>         return 0;
>  }
> =20
> +static void msm_pdev_shutdown(struct platform_device *pdev)
> +{
> +       struct drm_device *drm =3D platform_get_drvdata(pdev);
> +
> +       if (!drm) {
> +               DRM_ERROR("Invalid drm device node\n");
> +               return;
> +       }

When would this ever happen? Please drop this useless check.

> +
> +       drm_atomic_helper_shutdown(drm);
> +}
> +
>  static const struct of_device_id dt_match[] =3D {
>         { .compatible =3D "qcom,mdp4", .data =3D (void *)KMS_MDP4 },
>         { .compatible =3D "qcom,mdss", .data =3D (void *)KMS_MDP5 },
