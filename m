Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE905C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 01:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C2E207F7
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 01:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxJQF59b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgFABYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 21:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgFABYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 21:24:34 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85216C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 18:24:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z13so6118638ljn.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 18:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YhQH8I2I3NjxjK27pEINQezU+RgZa56+2s6b1VECNM=;
        b=kxJQF59bGNtUydcDUuV16HcI8FvlqgLfyAkWAqIXcJTzMNbXEmTKsC8DtpxH0EzX2e
         sJn8sm/bH7sjBmuMnPlxMqzZI5JLte31xRJHRr5XkMUPo4XWqXPLG8wN/nrXwQPzGG8h
         GZhTJd+B8nteMqWigdB2pXZHMlCgyOf6EFYKXtv0/6NI21oH0IgoUS+mogX/3LirEnOw
         KfWZzAzIZYXn7ofwnLlkBpskRERMezT6sQ4r49eJ+dE5QGNaUrCjux+LkzBCHTc2QJbd
         3Daj03nPQIfIiq5+KEqmwhu76rUbM0GE0VfhW1m9QnOrww+MUkgKN1TBY7zDyxcWla1C
         eKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YhQH8I2I3NjxjK27pEINQezU+RgZa56+2s6b1VECNM=;
        b=Du5a7d66jBI4NCje+UDTxt9jP4j6XrTfKS9ZM1QXF2mist+WfmEsFE9a/W5c3u/pZL
         8Zncvn8H4WJbnH8OR3C4JzWBL1FKIk+3/Kd0HSjjD+NRWh0yfLFu3fu7OxI4/uQBH6Yp
         Pv5Uqiu+epVbCpRouHIIvVkoB9eGf0f/BU8H4eggMKyrhgC0J2wZMLbAj068PsiRYcpy
         VgDhEmfvLvM+AKWwbxemPGfWl3J5LwTJbxsHdLTdB3SsuJtQI4/gDqqfAsLkHijV5Uab
         FpZcxmWowbc6fROTqpOfA1VSSZLTaPljwj0uQ8IYnDydeAP+Nliv2JRNKWTLsXrLrH2D
         BCPA==
X-Gm-Message-State: AOAM5316qcahkiGHs9nLY2cFfAAZDeWEfDT72faOk/Nu/iS4NgFOA/XM
        +i/e8DeKhplOba8HWnKK7W76/hGcbzU2kuyV6SaVHA==
X-Google-Smtp-Source: ABdhPJztAAqlzWoZXptW+WMrbkw+sZ1Zs06fNPzwuk1dGmymYCi9KdhB/cd0Q+4V9l6beKHigLm33Isg/7gWGgTwgmk=
X-Received: by 2002:a2e:5712:: with SMTP id l18mr6938608ljb.87.1590974672898;
 Sun, 31 May 2020 18:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200528103942.17432-1-steves.lee@maximintegrated.com>
 <20200528115408.GA15800@sirena.org.uk> <CABff4NSc6oW9dt-2VbdKUnk=+8Tc52m8f2irr1P4_cGyXNq41A@mail.gmail.com>
 <20200529093502.GA4610@sirena.org.uk>
In-Reply-To: <20200529093502.GA4610@sirena.org.uk>
From:   Steve Lee <steves.lee.maxim@gmail.com>
Date:   Mon, 1 Jun 2020 10:24:21 +0900
Message-ID: <CABff4NR4AE6FEN-szVJ_3df=4k1t_tVTH4ZAHo_TsbLKhK4adQ@mail.gmail.com>
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

On Fri, May 29, 2020 at 6:35 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, May 29, 2020 at 05:04:36PM +0900, Steve Lee wrote:
> > On Thu, May 28, 2020 at 8:54 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > > Reported-by: kbuild test robot <lkp@intel.com>
>
> > > Don't think the lkp bot asked for this driver! :P
>
> >   Thanks, I will send split patch for this.
>
> No, just don't add the line when it's a new driver.

 Now I understand, thanks for guide.
