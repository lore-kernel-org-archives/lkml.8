Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17925C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86502076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1UvzusN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgDPQwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728621AbgDPQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:52:09 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3BAC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:52:07 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r17so6134542lff.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=APUlN2SyohYE3TMZoo4vmSwQg+0t4tO+0TGNZ3bBlE0=;
        b=n1UvzusNO2Rcn2bDf0NRYBXquabq4c/tHd3wR8FlPjMf0sYf/Qq0kmozER1LNg0R1J
         qrsGcfC4HLWAVrxFA+PBk66Ge+L56/er9nJL9uxxBNTwdShYjTuS9kopK7Ej6czuRz7O
         vWEfA9c3VNBqRmtI9NWJfhU8+dsHt09PrNhw9MlDRCTQ8BBFLtD4kD4kpY6XPRJQVsgd
         lAf6UOorr4V5diQfeUJmCR01jHL6PtuMOwQrnI5MW4/hB5d86hnQ0PkIgf0Vt7/VL3c1
         iq/QlChEsUzsEa7sRzyNZgXSIC2xjHWNU9QZ2IoDrxOM16mQPTm84LEa2uk8Y53g2RLf
         nQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=APUlN2SyohYE3TMZoo4vmSwQg+0t4tO+0TGNZ3bBlE0=;
        b=Hlljk7kARcC5SMfIIWkd2N+HfQ4/xz5SPvxyefBd/XV7FxWsF1Mpmw5vrRMDSfSICO
         INRF4AMlMiHfb6Eny+Vx59emM3SdGpOFSKtJcIU6SAHHdp5gK5zfISWWpl/n2eo9Xuu/
         Y2KsEAm038blWKRUiy2CiQ9rl57/Gy+snu56TyJ3rQIh9LfkebiPXDHOTYrTmzO9DE9S
         cfleSvT3gM0gkE1n4/EbY8bVOH7W/u+19p2GJzrPvuDcfwvrTzpRjaR+LM/Xu6q2LEjZ
         yB0tpIvZyTjgelvPi+kHvb1V5i0ZWiAB+kQrbVVYAmzqSaoid1Zvz8u4vc0PGxvdgzIF
         mdBw==
X-Gm-Message-State: AGi0PuZvKabBqLg5GI2gEJjz9c6Fu4WqF+r77HWAi3B64Jb2U1AtyOEL
        B7ZUDqEV5rYDknlX/6EITpLXj21nL2dbnSNg3TFdM/+5
X-Google-Smtp-Source: APiQypLLy9khTrsHaSVXFll+8db9vcB9f6SRRtyCIku9mKZWZQNfAcSuyjm4xnTMgyMpunFu6XVe6Gs58zevIW3oU1g=
X-Received: by 2002:a05:6512:685:: with SMTP id t5mr6408558lfe.47.1587055926080;
 Thu, 16 Apr 2020 09:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200414222713.32660-1-digetx@gmail.com> <CACRpkdY_J8e127etFFYkoxLDDkc334Xgg8ZbapdU36oGsaZ08g@mail.gmail.com>
 <e08c487c-5c2a-3172-7c9c-0e7d2cd51769@gmail.com>
In-Reply-To: <e08c487c-5c2a-3172-7c9c-0e7d2cd51769@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 18:51:54 +0200
Message-ID: <CACRpkdbMF4=-g2ic_SKgOkd6kfgKJqZ2UxCRaoXJjq0EiEn+pw@mail.gmail.com>
Subject: Re: [PATCH v1] iio: magnetometer: ak8974: Silence deferred-probe error
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 4:45 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> 16.04.2020 14:33, Linus Walleij =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > This misses some important aspects of dev_dbg(), notably this:
> >
> > #if defined(CONFIG_DYNAMIC_DEBUG)
> > #define dev_dbg(dev, fmt, ...)                                         =
 \
> >         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> > #elif defined(DEBUG)
> > #define dev_dbg(dev, fmt, ...)                                         =
 \
> >         dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
> > #else
> > #define dev_dbg(dev, fmt, ...)                                         =
 \
> > ({                                                                     =
 \
> >         if (0)                                                         =
 \
> >                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__=
); \
> > })
> > #endif
> >
> > If DEBUG is not defined the entire dev_dbg() message is enclodes in if =
(0)
> > and compiled out of the kernel, saving space. The above does not
> > fulfil that.
>
> Hello Linus,
>
> After some recent discussions in regards to the EPROBE_DEFER handling,
> Thierry Reding suggested the form which is used in my patch and we
> started to use it recently in the Tegra DRM driver [1]. The reason is
> that we don't want to miss any deferred-probe messages under any
> circumstances, for example like in a case of a disabled DYNAMIC_DEBUG.

I have a hard time to accept this reasoning.

Who doesn't feel that way about their subsystem? If you don't want
to miss the message under any circumstances then use dev_info().
Don't override the default behaviour of dev_dbg().

> The debug messages are usually disabled in a release-build and when not
> a very experienced person hands you KMSG for diagnosing a problem, the
> KMSG is pretty much useless if error is hidden silently.

So use dev_info().

> By moving the message to a debug level, we reduce the noise in the KMSG
> because usually people look for a bold-red error messages. Secondly, we
> don't introduce an additional overhead to the kernel size since the same
> text is reused for all error conditions.

dev_info() is not supposed to be an error message, it is supposed to
be information, so use that.

Yours,
Linus Walleij
