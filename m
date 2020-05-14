Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02F4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F31205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nksJk6Gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgENHcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 03:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgENHcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:32:05 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A17C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 00:32:04 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id b18so2339330ilf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZ2K4V2ivdKLfbKoVnSYBVoL3RBoX57AcCyNb6p0llo=;
        b=nksJk6GjfmfD/5RT/EYdBZA+tvS6AvDaCsOxEpxh8TCrLXJNioen89tW3J9mSLozUV
         8BRjfBrtVal+MgGkMJT+bNTqitzhK08cT4gM706x/5gbjCqsO0Uzd20uXVdFFvIf2J1a
         j+Tp+nZp8yQGTY6q36QPA0MLgIrWrb9Bx8cQNwtqqqjrVLZnZwioDmG3eRJoerGBWkAI
         Pv3w2egzEMJa5iEv6XuTYpnI6oj1/nhi9AJ6WwGopNYX6CDQ8lwucB4+jItLY1HdnFDy
         O9HQVwX3yfsI5HB5JYh5vovN24zNu4Pc1+L5H8CQvFgwozbNSZs17x31o5XVdAxKgpEH
         a1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZ2K4V2ivdKLfbKoVnSYBVoL3RBoX57AcCyNb6p0llo=;
        b=lErn6l2G2mTV5foH5vCbWpkmxVR/z+Et5cWmhMwwfVhro5s3DI/fwrRO50EnnWwgPD
         RnbwTLCXF6eKYZ9LDZJx5hjRQXdTwR9DPPKvvBAy2CTJhJA2gfTbiQJhM+DtMdV3TcOQ
         M6v4JcbjPe3LHUZy7c9tFv8QiZoMYqK2Gzwy6z9iiRkhwnFonMDuPhywDqjEXXWLYkjC
         AD25zQN82TR5pXJqbi/VPxLx0p5GZKeokgA0Dake4f7+Icywsyz9lGEDkaZWBdkAi8Ok
         ja6CXaaWu4X/hUmpau/Rjcp9Rs7BslDX8Bx2MbkUeMAHiEmW/nAlJB46jVhmWMCa5lrY
         cz5Q==
X-Gm-Message-State: AOAM532kEMcM/ldwIMRBx+1/vV2ovfwiwV3nVxEb1OEKO9nwzHrkSZEL
        XJkAbOnxQpr0BQECeY0Aan087syUV3CfxN5DNj2b3Q==
X-Google-Smtp-Source: ABdhPJyEf6dDNquRbPI7mEEjgyU7b8EI011IFLAx5lKqSQzM2yVPc6Ws5teiQOo/jZXJs8/jCxOFZasj4dXdjy3nlyA=
X-Received: by 2002:a92:8747:: with SMTP id d7mr3395657ilm.235.1589441523625;
 Thu, 14 May 2020 00:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200513074523.21086-1-steves.lee@maximintegrated.com>
In-Reply-To: <20200513074523.21086-1-steves.lee@maximintegrated.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 14 May 2020 15:31:52 +0800
Message-ID: <CA+Px+wV7o1P41ZdidpwNFtwWL1-RYcwV3dU9R7PG+66k1L_p_A@mail.gmail.com>
Subject: Re: [V3 PATCH 2/2] ASoC: max98390: Added Amplifier Driver
To:     Steve Lee <steves.lee.maxim@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, dmurphy@ti.com,
        jack.yu@realtek.com, nuno.sa@analog.com,
        steves.lee@maximintegrated.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 3:47 PM Steve Lee <steves.lee.maxim@gmail.com> wrote:
> +++ b/sound/soc/codecs/max98390.c
> @@ -0,0 +1,1030 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * max98390.c  --  MAX98390 ALSA Soc Audio driver
> + *
> + * Copyright (C) 2020 Maxim Integrated Products
> + *
> + */

My previous comments on Gerrit may confuse you.  Please use C++ style
comments (i.e. // for all lines) here as the maintainer asked.

Mark, may I ask why we need to do so?  Is it also applicable to header files?

> +static int max98390_dsm_calib_get(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       /* Do nothing. */
> +
> +       return 0;
> +}

This is an intentional NOP.

> +static int max98390_dsm_calib_put(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       struct snd_soc_component *component =
> +               snd_soc_kcontrol_component(kcontrol);
> +
> +       max98390_dsm_calibrate(component);
> +
> +       return 0;
> +}

Entry point from userspace to start to calibrate.

> +++ b/sound/soc/codecs/max98390.h
> @@ -0,0 +1,663 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020, Maxim Integrated.
> + */

I guess these block would also need to use C++ style comment.
