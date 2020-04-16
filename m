Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2BCC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A82C322241
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzuDzGpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504059AbgDPPXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392261AbgDPPX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:23:26 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E55C061A0C;
        Thu, 16 Apr 2020 08:23:26 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k21so3381056otl.5;
        Thu, 16 Apr 2020 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sDKDxRsvr9/0tnocd3cnf/IOYw0smGMIaggntAhf7sA=;
        b=qzuDzGpLCGu7BUgaNTFhhEejkw0MvAlN2DPmQLMrBqU1v4yWsiG1tEqyPbXbNvUjeo
         bLcBrNKgxIgnQVm4Pew28MRBLZUTdZVShPop7K3izBQBymzxAxLjDf6pXZI5xRsDE7L5
         DVkwvDK0nGVpckgYmdkRer8sDuQ5EMrmIx6eKhPKl4sCoDB7+KxvNX7MYKmPAjWWLCJ0
         iIre7bCji+qEPwN41tTHgeU2eKhSv57vbXZhW06MIRJSa+wsQRo27LG+aJYSnQM3YJF9
         26R5vq4zelVgz+BGRozeyaD1U/bEVK1Eq0pZrVtUTBjnxuO7kf4VDUqrvmuqMD08k6LF
         8skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sDKDxRsvr9/0tnocd3cnf/IOYw0smGMIaggntAhf7sA=;
        b=M67WDtCELfvAqgpF53XJhtwjgbGH72wr0Rn4P05y8TAueRUNRIF3S+bC0BosjoZ/6B
         XaeJ/VLRbU6gyzBb+5CEZWxKQAtKneegl5hyTHiBynById/61zJLVEk6aW7QxvAeYnFL
         YQOqIcALQsmWfxqdrryVWUVyd0HmpRrCOgGQMndRbrUsXVUO1o6ki8JO7FpwKaHsvah7
         lV0+y4SXVmAABr+4ZXBhptICQxuOBPRrAnY9rL+1VamHTp2o7gbFNFfhMW0+7kBJlJkX
         LIdxmp3ZLJoCLgZXy6kIl0kIOpLmFtNR1KkSelgt+gRH1E14rwBo4wcPsheNSCgH9uG0
         hurA==
X-Gm-Message-State: AGi0PuaVOUK8kBQyNrmZ1RVlMzTPc8kkgx4Xu9mSBZZB8OoQ1LQqKUtL
        W+OGeMkuz+xwYpZzKq7eQ/5+14LDd4X2MJpg/Ho=
X-Google-Smtp-Source: APiQypJE2h+x6KBr6qqRxBMg3KHROW+KikW03R+TXV1d2SClZNdS7Dc8Qzpwvc2hixH/5z7JnCNbiVjdFOBVmuUm0oU=
X-Received: by 2002:a9d:19ca:: with SMTP id k68mr27607601otk.232.1587050605773;
 Thu, 16 Apr 2020 08:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200416001414.25746-1-TheSven73@gmail.com> <20200416001414.25746-2-TheSven73@gmail.com>
 <20200416124239.GH5354@sirena.org.uk>
In-Reply-To: <20200416124239.GH5354@sirena.org.uk>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 16 Apr 2020 11:23:14 -0400
Message-ID: <CAGngYiVXk+1Qzs3yLwyne3X567_yvbuRfXkjihmGc0EigHo50A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ASoC: Add initial ZL38060 driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Mark for the constructive feedback !
A few follow-up questions below.

On Thu, Apr 16, 2020 at 8:42 AM Mark Brown <broonie@kernel.org> wrote:
>
> > +++ b/sound/soc/codecs/zl38060.c
> > @@ -0,0 +1,643 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Codec driver for Microsemi ZL38060 Connected Home Audio Processor.
> > + *
>
> Please make the entire comment a C++ one so things look more
> intentional.

The 'weird' combination of // SPDX and /* Description/copyright */ seems to
be a kernel-wide standard (for C files, at least) ?

E.g.:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/wm9090.c?h=v5.7-rc1#n2
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/wm8904.c?h=v5.7-rc1#n2

Ok to keep?

>
> > +skip_setup:
> > +     if (priv->amp_en_gpio && tx) {
> > +             /* enable the external amplifier before playback starts */
> > +             gpiod_set_value_cansleep(priv->amp_en_gpio, 1);
> > +             if (priv->amp_startup_delay_ms)
> > +                     msleep(priv->amp_startup_delay_ms);
> > +     }
>
> This external amplifier support shouldn't be here, if there's other
> devices in the system then they will have their own drivers and the
> machine driver will take care of linking things together.

In our application, the amp is a "dumb" class-D amp with a single enable line:
https://www.onsemi.com/pub/Collateral/FAB3103-D.pdf

I am not sure how I could make this more general. Could you point me to an
example somewhere in the tree?

>
> > +     priv->regmap = devm_regmap_init(dev, &zl38_regmap_bus, spi,
> > +                                     &zl38_regmap_conf);
> > +     if (IS_ERR(priv->regmap))
> > +             return PTR_ERR(priv->regmap);
>
> devm_regmap_init_spi()

I wish !! This chip has complex SPI addressing, using an "address" which:
- is variable length, depending on the page of the register being accessed;
- contains a field with the length of the data to follow.

Unfortunately, during firmware programming, multi-writes are mandatory
(usually address header + 32 data bytes).

Implementing my own regmap_bus looked like the only way out.
