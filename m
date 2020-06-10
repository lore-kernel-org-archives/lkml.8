Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E03C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9013720823
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZoFELyV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgFJS6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgFJS6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:58:09 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C2EC03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:58:09 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id t132so1926600vst.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oAuiLS5G9yRr9AdnpqJ+b7J1vIYfSf3q36M8NOV942c=;
        b=ZoFELyV3tBihmyebsCsoJk3lsYw7dHxokZr208+Oi3cjS0rKE47GyTKi/8fqkKgIhj
         5s0cu1ckOGvd4aV4SjB5D5/nJDeMoIjxvt2U2Ccw/Kfve0CtzajVy/w53lYfU6Xu6k7N
         S8PCnMI8f5/e0ChFtq938rNtp430lbPGfI6Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oAuiLS5G9yRr9AdnpqJ+b7J1vIYfSf3q36M8NOV942c=;
        b=Nyy5y4dpf3c5clEuNTWVGQsnwq4lvHPGJtlfv7bsqHQBkUNtkp63MN8zzuMywJPrH4
         aI0DYJTLQhyUKqozdji3qb/ZipRcho844SZlQQ+WDL6UH15MljjP1qQM2kZ+WGal4T1A
         CzlerfkVjL/AVr09uRbfnzSTGV5HEXCS5xeZsCRXrgL1rCr6WnbQvkjNuhwEUPsih41J
         cbcqiORAjy9jiJlwZLwccAM1Wpdk4KAdSWL3gmcLsLTFT5jOnMsIVLdtc1QGlMn15JI+
         AmM3Y6ZlbofyYph9QQWoDiBGjjRJENpheP5DCfU4WNKMx46oIZeJX7fLRCUULMcBE0sQ
         Vu2g==
X-Gm-Message-State: AOAM532gjAH5bOTtUMZvYzfAAhWQGdghuwXh+Y+eXZwaYwr5ATA5wh8d
        PgtjaLrkd0TfppMsl9aCsZ3iLm4CL7c=
X-Google-Smtp-Source: ABdhPJx8hx7hp1wo5YACR9htPWm3GGkAEsqYfrXQ0Tn0fDiHD6cBvDGEm6aKYnMSiwwso5ry0jjuPw==
X-Received: by 2002:a67:ec09:: with SMTP id d9mr4017774vso.55.1591815488147;
        Wed, 10 Jun 2020 11:58:08 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id t76sm71314vkt.56.2020.06.10.11.58.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 11:58:07 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id r11so1912394vsj.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:58:07 -0700 (PDT)
X-Received: by 2002:a67:e445:: with SMTP id n5mr3989129vsm.73.1591815486605;
 Wed, 10 Jun 2020 11:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200609120455.20458-1-harigovi@codeaurora.org>
In-Reply-To: <20200609120455.20458-1-harigovi@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 Jun 2020 11:57:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UMELcq_-aYdQBW3CuJgTqZWYkE8c5AMKT74Z1Z0QHusg@mail.gmail.com>
Message-ID: <CAD=FV=UMELcq_-aYdQBW3CuJgTqZWYkE8c5AMKT74Z1Z0QHusg@mail.gmail.com>
Subject: Re: [v3] drm/bridge: ti-sn65dsi86: ensure bridge suspend happens
 during PM sleep
To:     Harigovindan P <harigovi@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>, nganji@codeaurora.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 9, 2020 at 5:05 AM Harigovindan P <harigovi@codeaurora.org> wrote:
>
> ti-sn65dsi86 bridge is enumerated as a runtime device. When
> suspend is triggered, PM core adds a refcount on all the
> devices and calls device suspend, since usage count is
> already incremented, runtime suspend will not be called
> and it kept the bridge regulators and gpios ON which resulted
> in platform not entering into XO shutdown.

The "XO shutdown" concept is a very Qualcomm-specific concept but this
bridge chip could be used on any board.  ...but I think it's fine to
leave it as-is since the meaning is clear enough.


> Add changes to force suspend on the runtime device during pm sleep.
>
> Signed-off-by: Harigovindan P <harigovi@codeaurora.org>
> ---
>
> Changes in v2:
>         - Include bridge name in the commit message and
>         remove dependent patchwork link from the commit
>         text as bridge is independent of OEM(Stephen Boyd)
>
> Changes in v3:
>         - Updating changelog to explain the need for patch
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 ++
>  1 file changed, 2 insertions(+)

Note that it's generally considered nice to CC folks who commented on
previous versions of the patch since they are folks who are almost
certainly interested in it.  In this case that would be me and Stephen
Boyd.

You could also, in theory, carry Stephen's Reviewed-by patch from v1
since you have fixed the subject as he requested and you have now also
fixed the commit message to have some details.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
