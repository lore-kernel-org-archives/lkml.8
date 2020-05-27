Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00825C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9AFD20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390015AbgE0Prl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:47:41 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50113 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgE0Prk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:47:40 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MysFQ-1iqyDo2xCE-00vyXU for <linux-kernel@vger.kernel.org>; Wed, 27 May
 2020 17:47:38 +0200
Received: by mail-qt1-f171.google.com with SMTP id x12so19497734qts.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:47:38 -0700 (PDT)
X-Gm-Message-State: AOAM531dYAj29+Osq5f+LevfXVHR44cDYsXqCaxtytpzR6JmnPg4QJH9
        AnhPLbSELR66xCxNHgJ3Lz+xy3mZpeNDV95oTCQ=
X-Google-Smtp-Source: ABdhPJw0NdvOXZo+VmWRkqDx65ClgSV3QtU9GhX4PfuIXXz+OXhKaOJ3BRC9zijhnhQVCPu/Z9JMb476EnADi1mFWKw=
X-Received: by 2002:ac8:6b15:: with SMTP id w21mr4983525qts.304.1590594457614;
 Wed, 27 May 2020 08:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200527133158.462057-1-arnd@arndb.de> <20200527145226.GA91560@ravnborg.org>
In-Reply-To: <20200527145226.GA91560@ravnborg.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 17:47:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2k2qPOdREo-+AwOL8JVcO2VFoouAFyx6-fr1UnpavwLA@mail.gmail.com>
Message-ID: <CAK8P3a2k2qPOdREo-+AwOL8JVcO2VFoouAFyx6-fr1UnpavwLA@mail.gmail.com>
Subject: Re: [PATCH] drm: pl111: add CONFIG_VEXPRESS_CONFIG dependency
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:V4MrD4QrlNTsIuhECRgI4Rdrki4hlNuGMm0wTSbkIekIwAQ12Uy
 T+JmFc9DlxA9KjOTgrOAKeRfhqJ/hb2x5OMosWrvYj5pXMh+m6isk/KqXT5UeGXOXtbH+pF
 p4qvOHvsSVBOYoD4epKGZfo29UL9M0i93RuaPbfABTJis0NhfQZMy2hv9PkkQi3SDWpvVJg
 yLue7RG0ZgyL4dLraYptA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KeLIrq5WbTM=:NGT7I/lYEsqIvs+sBkSqIL
 oTVfkbpSLthQM6+YzTObGNFMoQR3ssWP9YvJkgKpky3XyggXNOOPLuxsViprkBZsjknTw8c5E
 vw8crt/drbQPrzhqoOJxrhLNod3TB03VQviZGmKepHNm0AnQ2kGLSwQp1qi4iY7bg6mTmbeJO
 i67vNw2AoSId/uvLlErdE8OkfDeJwCUw1AfScAkvb15yha/BmMZg2HfR9V25uWCXpI0Crxu5h
 Q9rNGgZ1ap3t7gGJWGI1Mor3VQ1VHd9fGOjiEbe5IhPkpZmsi5O9zf53gAyiGLxTzC52hUAnF
 OC9zMun9u60bI34yQETCz0n3lUhxHPEOSrZwHmpVuazrCTMM9rcAxX+nc/FNK0iCXjyXRB5Mv
 mVOytvSYb9XCVXmfIsbMaNWaoR2hUma2vejky0I0DfuBFG76zdlHaDdDfud+4hPo/pBSCnsbA
 YQxhtZib1g2iN3TqmN5KobARV1vjM9L1L0HeTIFDOgfrLRq19XJTBO07K7QOgqW5rUPNWGuT5
 NUPmXtmPVTFn3TiZbGr5NThV/YXSn1wVR+pDc2wzF2zjtjAT0LXrk1TpvXXTrBS3CIQLQogPm
 bD5YsstlbOjurKbRjS4uAYbWvFgZX6Ey0iwhpxdIH9DsuX9ddeyNY+3yZHsrFGbsUclMzYmN3
 nxihiDKKo4A1VkpZ4LW0sM+FFchFuFuq3XsfWuprbygF65lRSD27ukiT742F5NhQ2YQkpnP5I
 akj0vA797UWIiDyzpH8xcRiQWTeHWL6Mu69fMKS5DrI9tBaCnPGCaAZ+X1V0lUNqPZKc3t6x9
 ZxQgi3yuUl757Y2ICHAeKkHcnKb5cjq05xhr+HYW2oWE9WJLT0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 4:52 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Arnd.
>
> On Wed, May 27, 2020 at 03:31:42PM +0200, Arnd Bergmann wrote:
> > The vexpress_config code fails to link in some configurations:
> >
> > drivers/gpu/drm/pl111/pl111_versatile.o: in function `pl111_versatile_init':
> > (.text+0x1f0): undefined reference to `devm_regmap_init_vexpress_config'
> >
> > Add a dependency that links to this only if the dependency is there,
> > and prevent the configuration where the drm driver is built-in but
> > the config is a loadable module.
> >
> > Fixes: 826fc86b5903 ("drm: pl111: Move VExpress setup into versatile init")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Could this be another way to fix it:
>
> diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
> index 64f01a4e6767..1c38d3bd2e84 100644
> --- a/drivers/gpu/drm/pl111/pl111_versatile.c
> +++ b/drivers/gpu/drm/pl111/pl111_versatile.c
> @@ -379,7 +379,7 @@ static int pl111_vexpress_clcd_init(struct device *dev, struct device_node *np,
>         u32 val;
>         int ret;
>
> -       if (!IS_ENABLED(CONFIG_VEXPRESS_CONFIG))
> +       if (!IS_REACHABLE(CONFIG_VEXPRESS_CONFIG))
>                 return -ENODEV;
>
>         /*
>
>
> Then we no longer have the whole driver depending on
> the value of VEXPRESS_CONFIG.
> Not that I like IS_REACHABLE() but we already had
> IS_ENABLED() to cover up here, and that was not enough.
>
> With your patch would we then need the IS_ENABLED()
> check?

The IS_ENABLED() check is what I'm adding, not removing. I'd still
the Kconfig dependency combined with that check over
IS_REACHABLE(), which is more likely to silently not work.

       Arnd
