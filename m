Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771C9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE472083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y7vF9niF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbgGaPpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbgGaPpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:45:14 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581FBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 08:45:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a21so31849058ejj.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7m+/JdShBAl8ZFhgGbxzIHmxleILf3IO0zdQ2ETCdA=;
        b=Y7vF9niFn53UM3USo/9vLjcOj3BjbGGNGcNZNOYb+jWP9BM9+uecOaBedA8idf7Yui
         Hncnfb6i0gcHFVCXqNFQ448xEQCg5ICDMd/gOnxaiLb4RFVL+ZLzDss9P04b5XiIK7XP
         yT2lx/QZnv49aDXAMrILcUSTqjxhxDIfA+/cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7m+/JdShBAl8ZFhgGbxzIHmxleILf3IO0zdQ2ETCdA=;
        b=Qm642o9tRf3mlzRD70rG9xAVPhBbNyeJkFKTuK353CL7RHPWVtmdbSx1sdecd+MDDa
         m2kzBKrQB0et0Zq61oSKXmTOPG+d4ZUt8OCEbbC+OqPYzde4cgrt8xpi95yyHgI5SsmG
         FZLW+MWblxNgSz1FYC9036eNChV1PjnEFRc58SmM9jpnULkUDhHRZmJxIR3hbnjoniLU
         BfK9dM8bNnfyNC6P4Vj7SEBQfQJq4E45sW9bm3ItX5mSH2+W/SeP7wLxuQEuJ0wf8k4v
         WiXWc6/4tHq1+XzoqiFB4YOzi4L1gV3eYBv+ug90RfjUGIlfb2WrvebyqGugBMspOlNM
         clhA==
X-Gm-Message-State: AOAM533U0SJv+CTPAxEEFCO3uy6froaJRVDixh73MLfKexDAv3sq0foD
        /I1vJNWB1+31yFl/FaDuajABeOzh3Yk=
X-Google-Smtp-Source: ABdhPJwTj0EJKglbuEzDsRSXqXBx2PYR6WywXfHXS3Mi5HdKntxrK71CLwPIBymiazySny4FKqJ9dA==
X-Received: by 2002:a17:906:3a17:: with SMTP id z23mr4532008eje.238.1596210312784;
        Fri, 31 Jul 2020 08:45:12 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id l9sm10043336edj.12.2020.07.31.08.45.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 08:45:11 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id g8so8903846wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 08:45:11 -0700 (PDT)
X-Received: by 2002:a1c:e908:: with SMTP id q8mr4627256wmc.59.1596210310707;
 Fri, 31 Jul 2020 08:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200728151258.1222876-1-campello@chromium.org>
 <20200728230520.2011240-1-campello@chromium.org> <20200728170317.v2.7.Iecaa50e469918a385b3e5dab375e442540ea2ad4@changeid>
 <159598461271.1360974.15436404116157938506@swboyd.mtv.corp.google.com> <CAHp75Vc_3VYAkVcTCAXzqxqFnpQ4Qi=iPSFW_sUjYGO=o6YMtA@mail.gmail.com>
In-Reply-To: <CAHp75Vc_3VYAkVcTCAXzqxqFnpQ4Qi=iPSFW_sUjYGO=o6YMtA@mail.gmail.com>
From:   Daniel Campello <campello@chromium.org>
Date:   Fri, 31 Jul 2020 09:44:34 -0600
X-Gmail-Original-Message-ID: <CAHcu+VaKGNxAY_OQ4oS5NtkoDLGkv2x_VrQhZ7OvEFAnNbYZeg@mail.gmail.com>
Message-ID: <CAHcu+VaKGNxAY_OQ4oS5NtkoDLGkv2x_VrQhZ7OvEFAnNbYZeg@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] iio: sx9310: Use long instead of int for channel bitmaps
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 1:00 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Jul 29, 2020 at 4:03 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > Quoting Daniel Campello (2020-07-28 16:05:13)
> > > Uses for_each_set_bit() macro to loop over channel bitmaps.
>
> ...
>
> > > +       unsigned long chan_prox_stat;
> >
> > This can be DECLARE_BITMAP(chan_prox_stat, SX9310_NUM_CHANNELS)
>
> > > +       unsigned long chan_read;
> > > +       unsigned long chan_event;
> >
> > Same for these?
All of these are eventually used by regmap_update_bits() which expects
unsigned int. I believe the extra complexity is not worth it given the
number of channels.
>
> ...
>
> > > +       prox_changed = (data->chan_prox_stat ^ val) & data->chan_event;
> >
> > I was expecting:
> >
> >
> >         bitmap_xor(&prox_changed, &data->chan_prox_stat, &val, SX9310_NUM_CHANNELS);
> >         bitmap_and(&prox_changed, &data->chan_event, SX9310_NUM_CHANNELS);
>
> I agree with this. On a small number of channels (up to 32) it will be
> reduced to simple operations, but will leave a possibility to have
> more with easy redefine.
>
> (though _and() above misses one argument AFAICT)
>
> ...
>
> > > +       unsigned long channels = 0;
> >
> > Use DECLARE_BITMAP(channels, SX9310_NUM_CHANNELS)?
>
>
> --
> With Best Regards,
> Andy Shevchenko
