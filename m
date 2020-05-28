Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E164EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F7F206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590701789;
	bh=OoAF5fvIG1WmbRJ5iRaCNNCS+LjmEmUP4Qo1q5Oyk6w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eicFXZ38qEBboW+6ya9K2qA8RBK0HN66NE5PkC2D+wrDAvOayFa7xIlQ28QpBCQeA
	 yuS2Q6BVuuM2tbITC+JzlAUFCXAMJxuV5I78CaUcPp63PzhrIou137z2PGOsCv5DLE
	 /OiRub+e05bYzsiyX2NutBHLoUvy3u22hhqMsz6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436616AbgE1Vg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436551AbgE1Vg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:36:27 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A04A8208DB
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 21:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590701786;
        bh=OoAF5fvIG1WmbRJ5iRaCNNCS+LjmEmUP4Qo1q5Oyk6w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o0GkkhtZ8QpR/veUWBqt5ZlBS+ugjq2lZ0GKrbLqf8SuC0kD+4knERlmDIvrNmlzS
         ovqeRKJQpwt8qwLC+bPU2uIif/Lq7b7Aikh2uChFNCyX9AtdPOuk5U9gHff/MKIRPM
         5KjaB6PU6oyL18I+x0F4c3elfO4OYJfupqLt/6lk=
Received: by mail-oi1-f181.google.com with SMTP id 23so573476oiq.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 14:36:26 -0700 (PDT)
X-Gm-Message-State: AOAM530rqN2qY9IML8c+fMspnL/ZqaaiGF/0G+0YVFotXZ7Dsw59Tm7R
        1TMM+jV/21P/3B8qYX3LhKECO3/vvT/EA8kR1A==
X-Google-Smtp-Source: ABdhPJwDx2guAg9SflWlLoutWBpSTVGcHdHMRb+K71BTWTeXSll0xvCgAOVKBI8yLMvnVyvEEHdb0V2Q6bV/XPl81rA=
X-Received: by 2002:aca:f084:: with SMTP id o126mr3777839oih.106.1590701785888;
 Thu, 28 May 2020 14:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200527133158.462057-1-arnd@arndb.de>
In-Reply-To: <20200527133158.462057-1-arnd@arndb.de>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 28 May 2020 15:36:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLntJKYTNXrmjZqxnzc70hK3=b2=5Cw2X6-Z8WrF=68KA@mail.gmail.com>
Message-ID: <CAL_JsqLntJKYTNXrmjZqxnzc70hK3=b2=5Cw2X6-Z8WrF=68KA@mail.gmail.com>
Subject: Re: [PATCH] drm: pl111: add CONFIG_VEXPRESS_CONFIG dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 7:32 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The vexpress_config code fails to link in some configurations:
>
> drivers/gpu/drm/pl111/pl111_versatile.o: in function `pl111_versatile_init':
> (.text+0x1f0): undefined reference to `devm_regmap_init_vexpress_config'
>
> Add a dependency that links to this only if the dependency is there,
> and prevent the configuration where the drm driver is built-in but
> the config is a loadable module.
>
> Fixes: 826fc86b5903 ("drm: pl111: Move VExpress setup into versatile init")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/pl111/Kconfig           | 1 +
>  drivers/gpu/drm/pl111/pl111_versatile.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
> index 80f6748055e3..33a005816fdd 100644
> --- a/drivers/gpu/drm/pl111/Kconfig
> +++ b/drivers/gpu/drm/pl111/Kconfig
> @@ -3,6 +3,7 @@ config DRM_PL111
>         tristate "DRM Support for PL111 CLCD Controller"
>         depends on DRM
>         depends on ARM || ARM64 || COMPILE_TEST
> +       depends on VEXPRESS_CONFIG || !VEXPRESS_CONFIG

That's really non-obvious. Sometimes I hate kconfig. Thanks for fixing my mess.

Rob
