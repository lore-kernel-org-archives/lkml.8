Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3FAC31E5C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05C6208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdP0J4d6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgICUCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgICUCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:02:44 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FFDC061244;
        Thu,  3 Sep 2020 13:02:43 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b16so4713615ioj.4;
        Thu, 03 Sep 2020 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGULVC05C5sCXhEYpC/+9Z2Ga4C2yVjc8ZyDOioAvkU=;
        b=EdP0J4d67KA9Z04eQwpbg4AXblH4icfhJzxrgoDtGi1drJDGJZ6A1Cc4lOOZIzbNQ7
         I5oHurAQmm31BoHE99b0/vAeN27X5keXUvspjNeUF3NExOMeX8nHcTYWD66/Ve4AIA6r
         SNdpPYGHzM1H5zjZLGS2JkojrO7wAYpaoASrSbD73tj0yV8MHn9anwOlaR9JvBpuuBSH
         dwVFzH8iIlZSc6AL7/IDSjNNK0Y5jutH+tWMLDjsgRlCbgcvmitZdBDP5TADNPhsTkcK
         0m8KsTKjWyKXWMNKR8FcDXiyc4WQ8gIqNigZkMFg376s4xEo45c5wIz8GCbZI5LlCaxG
         90kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGULVC05C5sCXhEYpC/+9Z2Ga4C2yVjc8ZyDOioAvkU=;
        b=rK6MjSWyicxvppK0oiiK42ZRsUNpafoJcIYle9/Bk47eVX5sd5Mv+vwowf1lZ58CAi
         cq9TfMkAZWYfPgZ+WJNLb2yrdbYl8uEosMkF2r2dCuJfGi8XihDWxtUp/N/G9B4Q+agg
         hM5bvyjDBG/B/IszmjjQEjeJRsWWIySH0gkaMlt69kJ/qrL9N4iubKVuzOZc1TrmBJKY
         IRwO2+xp6wubomYj2pdJye++qoKynfxd9OLaI5Mne9Q906B5+DhezZbj2ZbIYwui7mz+
         C4R+/k30ljuacoTxBuXUes1VhSGfUISCDKDZeCaeGjruy/hxVIrUZLOQyUlRqwy1lQkO
         UYmQ==
X-Gm-Message-State: AOAM530g7JSJz505dl4SlrYmS4S6DAxr9vmkcoRCK3HVmFwNYNAOehoy
        1/LPNlLlaS3BRUPNzUoqgGKVe4z9QcD+NdY/CBk=
X-Google-Smtp-Source: ABdhPJw2fUBB+yaKwX5FZLc8HuO05Z9/+K7Ld3VyqD0BtRUWO7C/9O2RbrunRj9dOgQNqO3na4R8IxFkbgn6AW3k32k=
X-Received: by 2002:a6b:908:: with SMTP id t8mr4535957ioi.124.1599163362945;
 Thu, 03 Sep 2020 13:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200426104115.22630-4-peron.clem@gmail.com> <20200428081321.ht3el26yqhsnyfm4@gilmour.lan>
 <CAJiuCcdVs_drs40Q6537BYfz24F7NmC6B8S5-Lt4V4ggs-FXWA@mail.gmail.com>
 <20200429123529.y24dpy63wxq7uvkt@gilmour.lan> <CAJiuCcfXqizcq_JuXRCsqEqM2562cr1SGJ0pmy07jcJxAXojOw@mail.gmail.com>
 <20200430084600.samghw4zxb5zdbez@gilmour.lan> <CAJiuCcf_LHrJ6QdZgH8HyN6TRiT+GiD+t4UggFCrz-VwVHXV6w@mail.gmail.com>
 <20200504120942.lnrxnnmykqnvw3fb@gilmour.lan> <CAJiuCceF340FiLvyeXNZtvqftQMAmk=MtFDLT_9696ix+eH1Yw@mail.gmail.com>
 <20200729143927.47f5tbuaob4ph3lp@gilmour.lan> <20200729151548.GB5612@sirena.org.uk>
In-Reply-To: <20200729151548.GB5612@sirena.org.uk>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 3 Sep 2020 22:02:31 +0200
Message-ID: <CAJiuCcdf=TNLPTUPzHP9NzPHqdxG06TRDkQfONY+ScK0DV_v5w@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] ASoC: sun4i-i2s: Add support for H6 I2S
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wed, 29 Jul 2020 at 17:16, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jul 29, 2020 at 04:39:27PM +0200, Maxime Ripard wrote:
>
> > It really looks like the polarity of LRCK is fine though. The first word
> > is sent with LRCK low, and then high, so we have channel 0 and then
> > channel 1 which seems to be the proper ordering?
>
> Yes, that's normal.

Thank you very much for this test.

So I will revert the following commit:

ASoC: sun4i-i2s: Fix the LRCK polarity

https://github.com/clementperon/linux/commit/dd657eae8164f7e4bafe8b875031a7c6c50646a9

Regards,
Clement
