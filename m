Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A70C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940BC206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQJ/t30z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgE2IEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgE2IEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:04:49 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58904C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:04:49 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e4so1496592ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Xro8I38WGB1vy4pn7r6IuOsUYoevHSF9a+82U3l5yY=;
        b=MQJ/t30zQcK6C9mw2k6k+xRtyvza3+g5NHHI4THl99n7ec9e17BtB1OzrvB3OB0g1z
         hjHnr9kYPJ2ZERhidkb3XANBk69T4Rko1VbwMrvGx8fLS0Ic+tvmb0XpEAk9YY6rQMTY
         ayDFinZWg5ZRmGs2MuOFArBSEAHcGNiI+u/6lGC+OLJ/mTmJEu88Be1AauOpQagHG+0C
         GNRD+wA8yFdvgTABgxdXFOlwvwnVh45gZH8raON/pp/zqqua/DgS0gO6J7XKsX1NiQzE
         jJoqqT4wAD3c6YO+T+InW1bDZsZpU/7PVAVAV7K1j+Y3YI41CVPPUeKGZbsJIY2iZ0KN
         U+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Xro8I38WGB1vy4pn7r6IuOsUYoevHSF9a+82U3l5yY=;
        b=Jf+m89aG20ysxIIRTEc5jtsXxs4auBd4k+sH6cRMMC9aiSkHBc2eAhIn4822BOKB4E
         kBdDiHdhVtj/C8SEVpW8wHcA+MDweIZx6jvVuSwbybL4Qxtuk52lexguyDaGqbAIwTVF
         QT2nImvvLWKDrNLTSgqQmlXNN4/nfutHSSPwiMMl8yDe4N4+JPPo21zY/xK1Z0ijR0wX
         eRAvx0RkKqXfDoJs+haMi2jAwYwsFwHd7L66Cws8xc6famrFtoY7o2LTuQHsEluCJWQp
         Oyw79hgMSaQBsBJo+AgYBOkEuyXR6u5VARtbu+MRVdHqEmmxh0Ceoqz8qLox9eBrFQu4
         Rmxg==
X-Gm-Message-State: AOAM531IgWkDfRIwyl3Yr+f/zxWDVyImZg4gNCayGyh2NTMXjwi4gNxZ
        /4wQezkLrfmcB3dbDq6grkbOzc2wYrPy1gFg6qk=
X-Google-Smtp-Source: ABdhPJwyA+BHbVbYT1WVanqisX6tqpuXN2oOqrt/1LkU+5dRO5m92sc1wnozuX8q5uyeHHTICQA6kmzYrqyxuhrwL84=
X-Received: by 2002:a2e:5712:: with SMTP id l18mr1246986ljb.87.1590739487819;
 Fri, 29 May 2020 01:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200528103942.17432-1-steves.lee@maximintegrated.com> <20200528115408.GA15800@sirena.org.uk>
In-Reply-To: <20200528115408.GA15800@sirena.org.uk>
From:   Steve Lee <steves.lee.maxim@gmail.com>
Date:   Fri, 29 May 2020 17:04:36 +0900
Message-ID: <CABff4NSc6oW9dt-2VbdKUnk=+8Tc52m8f2irr1P4_cGyXNq41A@mail.gmail.com>
Subject: Re: [V6 PATCH 2/2] ASoC: max98390: Added Amplifier Driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Steve Lee <steves.lee@maximintegrated.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, dmurphy@ti.com,
        jack.yu@realtek.com, nuno.sa@analog.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 8:54 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, May 28, 2020 at 07:39:42PM +0900, Steve Lee wrote:
> > This is the initial amplifier driver for max98390.
>
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.
>

  Thanks for feedback. I will send incremental patches.

> > Reported-by: kbuild test robot <lkp@intel.com>
>
> Don't think the lkp bot asked for this driver! :P

  Thanks, I will send split patch for this.
