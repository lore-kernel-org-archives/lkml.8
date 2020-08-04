Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D97C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3FEB21744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIOl0w4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgHDUqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgHDUqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:46:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1352C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 13:46:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 88so38613709wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hmLYwEdYmReif4AtTx6zmAM3miB1yj7XFy+BqIPWbw4=;
        b=KIOl0w4FwboDnjvjlkqqDu1OxofAxj/P73GbkdF6hsdLTq6DT2SsS3LmeyPcIBTH4P
         a85SOTO5omchO0S+jZnLgzVZqagTfWXAhVLEFkamDKJ5hJ6vpPgYHLqK6oWBz8EJT99g
         qBtxhf4VmhsjgiSApBiatweeiwuYPMEfsoi8vesL4CN6e3l8QLzsxfzObitW/1yjOYkw
         e3/mST69yrjb0xbS4p3bQFUTLobAhgj/ByjPFZTP+/5yLkjfXjHgwQ+vzEbES/EYq9Pi
         vk6fshP2rBNSwtpzD8qf97jA6raVzDEK3D2nMYXqxbq1MvJyEndZAH5f7QOeZiWK+aGn
         tkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hmLYwEdYmReif4AtTx6zmAM3miB1yj7XFy+BqIPWbw4=;
        b=lYQggNxpJctap4rZ1MQvn/aEFp5hHU3owsTlIQexjEucPdcqRpE90qE1vTQ4xGThIN
         wMdkO98gqxH5TeXXA6alViKBiHbNAOKgqrZ1v/+OHmpkdOKqBkbt6hyD7vOWkyQw+mAt
         VmPqKoNWtYB8Phd0d4KVL4OER/Z2OgScFD+nsSjT+DaL7Vn53NfghMjs6Q1Fkhpraxb7
         AbXlqd06B2+aiBziwtabgdRkuqU0ULghLx/56A2qOuru3eyof7rWtak5I50deOGqCP9r
         zIE5E2QcCMc/g1A0OG8qbN5ub/Ci5FtVtH45ZzbhZD8D8RgZ5bWSPYlU26mnnZBQSqFy
         URBw==
X-Gm-Message-State: AOAM530y3Fejpx1svWvj+yp4axoYrYioseNPRRmba09R6fVooVsEFK6u
        NKDP8wgcTsFp28+6sMJPA2Tv3dYyTMS3NHg/srw=
X-Google-Smtp-Source: ABdhPJzJkwBm0KFsobN5hiTTc96hoQzGbYvZRBWimBwQZafGM9AQIiNnCGIfLHhFbLoTlubG3YteOYX+yBrSy/Cdia8=
X-Received: by 2002:adf:a351:: with SMTP id d17mr20682645wrb.111.1596573998509;
 Tue, 04 Aug 2020 13:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200804200655.30495-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20200804200655.30495-1-rikard.falkeborn@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 4 Aug 2020 16:46:27 -0400
Message-ID: <CADnq5_Na7hB-AQ9WqEhop=GLMb=q8jZuVjUKBDhu9Xs+kNtZTw@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amd/display: Constify static resource_funcs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied the series.  Thanks!

Alex

On Tue, Aug 4, 2020 at 4:08 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> Constify a couple of instances of resource_funcs that are never
> modified to allow the compiler to put it in read-only memory.
>
> The other drivers in drivers/gpu/drm/amd/display/dc already have
> these as const.
>
> Rikard Falkeborn (3):
>   drm/amd/display: Constify dcn20_res_pool_funcs
>   drm/amd/display: Constify dcn21_res_pool_funcs
>   drm/amd/display: Constify dcn30_res_pool_funcs
>
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
