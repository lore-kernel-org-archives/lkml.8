Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC1EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 186D72075A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgE0TDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:03:50 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:54951 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgE0TDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:03:49 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MHGPA-1jrAUl44kS-00DIUv for <linux-kernel@vger.kernel.org>; Wed, 27 May
 2020 21:03:48 +0200
Received: by mail-qt1-f170.google.com with SMTP id i68so20158462qtb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:03:47 -0700 (PDT)
X-Gm-Message-State: AOAM531Ev+uEBnq7RhSz7DNwn/El6mTzDCUNwEwCxRI2pfx6XMGa/ph7
        U5z6PrgyENvzN3wmTxb/YR0g87km+J+4XizYf0Y=
X-Google-Smtp-Source: ABdhPJx2uEk/GDw083lErYgjdtJYswpXbBr+NRpNddoZvry1xc7WnNmlfDJSfucfklDsPGDKuPBFf5cTTyfn+MEOjKQ=
X-Received: by 2002:ac8:6a09:: with SMTP id t9mr5865155qtr.7.1590606226872;
 Wed, 27 May 2020 12:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200527133158.462057-1-arnd@arndb.de> <20200527145226.GA91560@ravnborg.org>
 <CAK8P3a2k2qPOdREo-+AwOL8JVcO2VFoouAFyx6-fr1UnpavwLA@mail.gmail.com> <20200527175012.GB98921@ravnborg.org>
In-Reply-To: <20200527175012.GB98921@ravnborg.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 21:03:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a29zkDn50DuRBK1wKDtZnLdyfq5VX5pC3kmEo+=BKCQbw@mail.gmail.com>
Message-ID: <CAK8P3a29zkDn50DuRBK1wKDtZnLdyfq5VX5pC3kmEo+=BKCQbw@mail.gmail.com>
Subject: Re: [PATCH] drm: pl111: add CONFIG_VEXPRESS_CONFIG dependency
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Q6avhh1cNXvVM3h9ol7N/BvMUU6EDuD043eAlxIhyZl32+kWi3j
 NPoZYLguPrUsl3vha5HCoR400nwpRinLKxZlGRVAMx+nvz+V12J3IS/bFkscIMWLouQahqW
 NSB2SZ5ofNkkDzzRmZd1PirgGYItSpZg1biY0Xn5Ple+RGODT5rYCSZnzRqaykyW6uVkc1F
 DH2bDYIRGGYGTRafPVrBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6occNd/W+cY=:hmMchwan4THeCmSPxMI745
 Kp1Fw+egsgYtIPRIJEL3r9ksLlIy/K8PF0vCMu/tW6jXEkoDmxId5QPu8XWym4RdD6hS4YuaI
 G9RimzLkSsvwMeuyoNei3jmvbsaYjUMI2QOyIlFKS05KSXVQQ/KYKs8QniLyBDGX9yWKnVr+L
 1GrBASCxMs27yW+mIKwTxF0Tr+KKx9TP6kJK7wHGLuANtuMKBeIZ8JYGzYy8gqpdPNU0pEslt
 0Z9oRCCRl1rOgyesmogsw3n6seBNcsiEEFBjFAIXNe4btLtama0h/s8TW2MkawgoWjzF73zhO
 lWP6eJCKOL+z3wwFlzSwXSuE61ETnUY+cDrcS1vDIFx/E3k9xuaXvoQlXfD+B6E6YKuzF32Tf
 p1cT0AgppfekOrBCwJ4R/yJTa6/mazO/qiEDKdTd3d9tgN5750ZrqkNQa99GbtG5htjnEalSj
 8ZtfeAbrvw9edLBFdMQD8+Z9wdPvyxL+rPQvckQHn5b55PvAU1FVNO9+61K43dis2jcKriNkj
 gWCBJKOQqL7hrv1BHkdNZKLKp3e7bmHB2Cih8uFLt6I11PdWNFIrHpML87MIYexUM81ihMCLe
 WZC+Q4j58GEZOlOCzeuHxUVsfGWMpDryDU2Ia5dpKE8zSoLMCEWXa4F04HrDV2DIJY6+pzHPn
 wTMvejQ2yva63u+uiFdhezD2h1v0UaTvf70GNZR7M5siUsHd0dyzmqOS9e3sPYejODGcLpyb4
 MfK9O6Yj1LDpLPS5uJmN1RoUFpVRExxFPZj2zS5xJTs7wJWIlYHF4IuORwE3zPdr5Nzw2xTS2
 pBKGjTi3Jlq19Je3pUMmDV2Pbe416e9XGI2FKjNoF89U0Iprug=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 7:50 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, May 27, 2020 at 05:47:21PM +0200, Arnd Bergmann wrote:
> > On Wed, May 27, 2020 at 4:52 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > >
> > > Hi Arnd.
> > >
> > > On Wed, May 27, 2020 at 03:31:42PM +0200, Arnd Bergmann wrote:
> > > > The vexpress_config code fails to link in some configurations:
> > > >
> > > > drivers/gpu/drm/pl111/pl111_versatile.o: in function `pl111_versatile_init':
> > > > (.text+0x1f0): undefined reference to `devm_regmap_init_vexpress_config'
> > > >
> > > > Add a dependency that links to this only if the dependency is there,
> > > > and prevent the configuration where the drm driver is built-in but
> > > > the config is a loadable module.
> > > >
> > > > Fixes: 826fc86b5903 ("drm: pl111: Move VExpress setup into versatile init")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Could this be another way to fix it:
> > >
> > > diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
> > > index 64f01a4e6767..1c38d3bd2e84 100644
> > > --- a/drivers/gpu/drm/pl111/pl111_versatile.c
> > > +++ b/drivers/gpu/drm/pl111/pl111_versatile.c
> > > @@ -379,7 +379,7 @@ static int pl111_vexpress_clcd_init(struct device *dev, struct device_node *np,
> > >         u32 val;
> > >         int ret;
> > >
> > > -       if (!IS_ENABLED(CONFIG_VEXPRESS_CONFIG))
> > > +       if (!IS_REACHABLE(CONFIG_VEXPRESS_CONFIG))
> > >                 return -ENODEV;
> > >
> > >         /*
> > >
> > >
> > > Then we no longer have the whole driver depending on
> > > the value of VEXPRESS_CONFIG.
> > > Not that I like IS_REACHABLE() but we already had
> > > IS_ENABLED() to cover up here, and that was not enough.
> > >
> > > With your patch would we then need the IS_ENABLED()
> > > check?
> >
> > The IS_ENABLED() check is what I'm adding, not removing. I'd still
> > the Kconfig dependency combined with that check over
> > IS_REACHABLE(), which is more likely to silently not work.
>
> Then the now redundant IS_ENABLED() check should go.
> With you patch it looks like this:
>
>         ...
>         if (IS_ENABLED(CONFIG_VEXPRESS_CONFIG) && ...)
>                 pl111_vexpress_clcd_init()
>
>
> And in pl111_vexpress_clcd_init() we have:
>
> {
>         if (!IS_ENABLED(CONFIG_VEXPRESS_CONFIG))
>                 return -ENODEV;
>
> The IS_ENABLED() in pl111_vexpress_clcd_init() is redundant
> and the patch should drop it.

Ah I see your point now, sorry I missed the double IS_ENABLED()
check at first. I'll remove the second one from my patch and
resubmit after some more build testing then.

        Arnd
