Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BB3C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE63A20735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VWLDmipX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCQR1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:27:14 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39637 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgCQR1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:27:12 -0400
Received: by mail-ua1-f66.google.com with SMTP id o16so8317347uap.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYxhd4YbdvKna+Hk3H++oy2r+2XxoGCrQ2OcQrBquQI=;
        b=VWLDmipX7IFDQ/yHjCAzFxlk/+VluSSJwe4qv5jpHr4e6B0U7gp1YOW3C9Csk4kZHd
         NXgx0kZ6qhPzwcHQS3y9Qvp7AMowj6bjIngubmHTjWmVhTh0fc8O7LbAKQh0NHGA4pJV
         mU73ACIJwkVyGoLSZZRtAPc2yjx+8+foKjquI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYxhd4YbdvKna+Hk3H++oy2r+2XxoGCrQ2OcQrBquQI=;
        b=EYAzgakzpb+xT7vdQLZ0EpDlMV4PwStaibH1bWBrT73FSoMLVx1RZq0s1u8lFAU0CG
         7AKi/iWBhoJZZP1FM2jFaD4AjhZhRfQVlKbh4E7fo8rrGYZwUkztsTBad82gWXhI8/gc
         sHrUioqu/0DGjuw922A3gA+lJv2u5S5gZ8eADppXh9zLvjFxC7XYe6qULZP/VcPffx73
         bzQZVR7W9ovFBVWSQQoswDh9DqETmQWkBQqNAyLpOMt9W/z9DkADPQtSFd5RZMlbjVgP
         GKefNHajmmu1VSXfh2iP9xKqrAApil2fW5O0vW6VgTQP/jc4d2JbwPiokvFVp4EWdDRL
         5zog==
X-Gm-Message-State: ANhLgQ3DvkTQ0LI8tNMu09cY2r94LL8T52421Slv06vnd2OIS0mSzaTn
        4OTfF/olBQyGcuCTfFfr8CipUCv9th4=
X-Google-Smtp-Source: ADFU+vtgCvY1F0DQ5519q0wlCUjQ6x4u3JxGIi6OwVqly9C774QTuidXgSuvugrtIjq1+lX308QA/g==
X-Received: by 2002:ab0:32d1:: with SMTP id f17mr70020uao.84.1584466029313;
        Tue, 17 Mar 2020 10:27:09 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id s140sm1638304vka.50.2020.03.17.10.27.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 10:27:08 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id m25so5641036vsa.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:27:07 -0700 (PDT)
X-Received: by 2002:a67:e951:: with SMTP id p17mr22233vso.106.1584466026884;
 Tue, 17 Mar 2020 10:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200315194239.28785-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200315194239.28785-1-christophe.jaillet@wanadoo.fr>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 17 Mar 2020 10:26:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WrncW_y+dtXHU7Lj1J0Lh7w8Kw+d28KZF52-OMs=0pSQ@mail.gmail.com>
Message-ID: <CAD=FV=WrncW_y+dtXHU7Lj1J0Lh7w8Kw+d28KZF52-OMs=0pSQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix an error handling path 'msm_drm_init()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 15, 2020 at 12:42 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If this memory allocation fails, we have to go through the error handling
> path to perform some clean-up, as already done in other other paths of
> this function.
>
> Fixes: db735fc4036b ("drm/msm: Set dma maximum segment size for mdss")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/msm/msm_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

This has already been posted as:

https://lore.kernel.org/r/20200309101410.GA18031@duo.ucw.cz
