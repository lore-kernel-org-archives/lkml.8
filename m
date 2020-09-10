Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8139CC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A95720882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lbENKBHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgIJJ7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgIJJ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:57:22 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798DAC061786
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 02:57:22 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n61so4818496ota.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 02:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8o/OdIgmicw5SsCNp3Naz/+qmsku0fW0+vnOAgjeRQ=;
        b=lbENKBHnK8HQLUtN6t8VplidxfCxoX5K4jZeqGoVssrXlDImvZTG2rwIZ+Qd6Ad7Xg
         gP+UfXPkjv7Ljx+8p6viF0DjMEN6qv+iCguJagt9gvXXLucWEFBFfLPON39taOecj1tT
         TbIkQDfFk+YjILy4vCnwBCK5BAwbkvF4eqc44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8o/OdIgmicw5SsCNp3Naz/+qmsku0fW0+vnOAgjeRQ=;
        b=gIecWJjD5XDOJHPazyRn16GmpzQBBODfRSa19u/b8TQ+aU4mI7qOOjMddg9hyW+PMt
         NLMKZERGjYdQXm4sReceGIEALiU6W24YFqKvVhusQw/HgJN2Y4R8RwJ1RDcwJUbsM3CD
         7Tc6Bf0kk+z8elEYnyiPowpwpbdPUMDYobdaNW0U34fAVOXqlDnwdmOxYzP50q/exm/S
         V450jtcVI1AqBOF7CUrY4ZhtatSGNOGKINdjEqj6h6iGbo+pWpP2BRkokRx6PPopPqvq
         IMuPI1I7Ymh2AVCbz/4euPwlO+wD1zvSHwwrXfzkbnfKtlhwIO7T59Gnujh7EsKxrUrm
         E3ZQ==
X-Gm-Message-State: AOAM5315juJ4yKbFuAwO4yV0nTRxIajIOqJ0vUkqY1+ZwetSMX5Y21t5
        9PM3e8l9M8hq+g6CrUoSZ5xcpcz0wfybgz7WlThLCA==
X-Google-Smtp-Source: ABdhPJyKbkeuE1movR4GhbYugiEC9r5oz6JkFiWCCSIKzBoYaqZy8qzK822tETc4HGQtg9spjqqob/CkaHFshNtZwrU=
X-Received: by 2002:a05:6830:14d9:: with SMTP id t25mr3575661otq.188.1599731841886;
 Thu, 10 Sep 2020 02:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200910095250.7663-1-laurentiu.palcu@oss.nxp.com>
In-Reply-To: <20200910095250.7663-1-laurentiu.palcu@oss.nxp.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 10 Sep 2020 11:57:10 +0200
Message-ID: <CAKMK7uGsJcg81a_cGebBgk3pwxj4VPrFfmV5AF+5fRyK3_Pigw@mail.gmail.com>
Subject: Re: [PATCH] drm/imx/dcss: fix compilation issue on 32bit
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 11:53 AM Laurentiu Palcu
<laurentiu.palcu@oss.nxp.com> wrote:
>
> When compiling for 32bit platforms, the compilation fails with:
>
> ERROR: modpost: "__aeabi_ldivmod"
> [drivers/gpu/drm/imx/dcss/imx-dcss.ko] undefined!
> ERROR: modpost: "__aeabi_uldivmod"
> [drivers/gpu/drm/imx/dcss/imx-dcss.ko] undefined!
>
> This patch adds a dependency on ARM64 since no 32bit SoCs have DCSS, so far.

Usual way to fix this correctly is using the right division macros,
not limiting the driver to 64bit. But this works for now, would be
good to fix this properly for compile-testing and all that.

> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> Reported-by: Daniel Vetter <daniel@ffwll.ch>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Please push to drm-misc-next.
-Daniel



---
>  drivers/gpu/drm/imx/dcss/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/imx/dcss/Kconfig b/drivers/gpu/drm/imx/dcss/Kconfig
> index 69860de8861f..2b17a964ff05 100644
> --- a/drivers/gpu/drm/imx/dcss/Kconfig
> +++ b/drivers/gpu/drm/imx/dcss/Kconfig
> @@ -3,7 +3,7 @@ config DRM_IMX_DCSS
>         select IMX_IRQSTEER
>         select DRM_KMS_CMA_HELPER
>         select VIDEOMODE_HELPERS
> -       depends on DRM && ARCH_MXC
> +       depends on DRM && ARCH_MXC && ARM64
>         help
>           Choose this if you have a NXP i.MX8MQ based system and want to use the
>           Display Controller Subsystem. This option enables DCSS support.
> --
> 2.17.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
