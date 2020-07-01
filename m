Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616CBC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B9E206CB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbdbTMw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgGAMdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbgGAMdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:33:39 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3E0C03E97A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:33:39 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 18so21249886otv.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0/gKTgSPNiK1GV7dg8cAvLDkoEQTeqakLc9QEbntdl8=;
        b=fbdbTMw6Tb5X5nBvth0KPuKI856tB9W1ecb/TeVlGM2Sh2CqgtwD+f0+jNkWeSyzLX
         CueKuadzdH8A/E895sVW/RkBioxsTo6P8FV+JOyviJQqSzwSbOwhqm/xetV4x9suSlV3
         vC4pOo4pcTtuXA3sBZzFzPyFUD7Y0x+JWf4Vbc+FzL+4bbXUjXGTsVEUD3tMIe46a87p
         JTc/HkEikxDv68bmtcm4+7ds+RsM/qNi1u1Q1DKQE0jzkD6jJCiCBpay5zV/hyL4y1R8
         /Ng/L3vunJT7DVpBN8OYlPNPkRlXZoefjAfuUx3H8OF06JFdM8304vUFQp9baB4nm8Fx
         apaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0/gKTgSPNiK1GV7dg8cAvLDkoEQTeqakLc9QEbntdl8=;
        b=eDxYOq0OfLV+rjU6N9NWolspTxxkegEqi99q8Pu73bgpGqfSMLLuphGNHWdY/QBBUL
         hvs+JEKZZOozqiA4O67QjmkfbSP2i+rb2dKCw6wevO31rvaTz87nCJUn219V+mZJo+wj
         3uX4z2xG7HPnMxlYIJrzHILJeieGhdXnuzg2rrOjLxQ5zHDKttdz9a2XKnOhcdq5I+aV
         bgwVxNzm/dJaSA8m8rq5r433AjGs1vPTw8ytEbuJWtUiUV7gfzW1voNnjAOZsp3PJUyz
         tIgifS6cIymMw1KaaKApPalC7Rab7vAjuSKfKS0oZ5D8tqatFgDxOY6UeiQqPGSYMdd7
         KCmA==
X-Gm-Message-State: AOAM53055I7d3szsmELGgTcLNnqUnJ09JOgiqq8KP95o62jXKjfu6tHx
        SNMp/RaEvdeRsTo53MDuV6dmyNw5L6pqubJOGHMSng==
X-Google-Smtp-Source: ABdhPJx/rWPPNwXFCHG8PvPxNDYMqAHV8vIuxP4r0bLP3udJYhyRjrkyu0A1QaxqcR0enaXl2VCUcwVxaN76M1jvyJI=
X-Received: by 2002:a05:6830:2405:: with SMTP id j5mr22837641ots.371.1593606818955;
 Wed, 01 Jul 2020 05:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200701112559.22669-1-christian.koenig@amd.com> <CAKMK7uHqNaQPwATQf=Jfs6oQ=YEemHSHTEtC2=VqvNf+bMh_sQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHqNaQPwATQf=Jfs6oQ=YEemHSHTEtC2=VqvNf+bMh_sQ@mail.gmail.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 1 Jul 2020 18:03:27 +0530
Message-ID: <CAO_48GGh2zir-hszCv4Mp36REEKPwhcOmwj93kF5otFmkf8cOw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as DMA-buf maintainer
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all the good work here, Christian!

On Wed, 1 Jul 2020 at 17:20, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Jul 1, 2020 at 1:26 PM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > As discussed on the list.
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 40474982a21d..5d7130f8d342 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5089,6 +5089,7 @@ F:        fs/dlm/
> >
> >  DMA BUFFER SHARING FRAMEWORK
> >  M:     Sumit Semwal <sumit.semwal@linaro.org>
> > +M:     Christian K=C3=B6nig <christian.koenig@amd.com>
> >  L:     linux-media@vger.kernel.org
> >  L:     dri-devel@lists.freedesktop.org
> >  L:     linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
> > --
> > 2.20.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch


Best,
Sumit
