Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63F6C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C252077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="a0cqNtVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgDVVNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgDVVNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:13:04 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F0BC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:13:02 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n17so2995166ejh.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1ihfPfQEm2aQwNzlV21Qu7y5TOw2uGbX6A635/ijcM=;
        b=a0cqNtVTTV+nhgMWLbfLbZJ1KDdwX/sQv0li7sAMa4YncTjRvmpf42R5qaJyoSk7xZ
         4fjblaEI1rkZU5E11tn1LivEd4rKY+iP0xqgwcoj0sWC79s6mY+p/Wvg8DMbuKUojeTk
         MKvLPlLE6a4MGwQsxRn1mzMVhI0UyQVxYWDBcIZ3BdQSMJNEk4GkWdo7ixo7B+9pTKz8
         nIvQM2yHiwbKRGcLES7cQFiaBaxGH+dI2un2gH0az0StWT7pBtvNwrPqdLF9J7wspqE2
         /Yj6lBV3bIcU57XdmeaokjOO+H7H9cVnl7HnZ0rrrD6/ox6h0Oh+VCg+zp2ZPVeBLn8m
         od5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1ihfPfQEm2aQwNzlV21Qu7y5TOw2uGbX6A635/ijcM=;
        b=lZCgPOL7yQtyQjB9LJjleBDEuBW4J7qAqG9UTOjWazw9toeI0eRPjmjOwh7A2k5CtM
         cHEG75ab5hVyPodJU+QvPCon1tF55c3f+vkf6rxes8x13oQP0CUEfPpA60QtdvxRZS/b
         pfIKs5kgpcWtBPWwQCleCBhg7CwIPgT6DlM8zF2CsdoF2BGIn8J/vm2E95uRUgHyX2D1
         inIhfbXVgkGFX6y1mkH/Af0q+Z/BoYKwMGPAOBK9iHU92hoMyvmMUtbjIHPrzVrylhzX
         0F/iYmrMeTROaBq//lU4WvYk4HQ2PbFzcf2UK6CXkAKuU/2PYoHUbQyR8Gmic3IT419+
         q28Q==
X-Gm-Message-State: AGi0PuZxs/4RNoE7f+MX9sJk5uAhCPadCTH2ghVsOmnpWSdzJw5US/Pv
        rjai67SuO2QSHjjpbtyQyojCVCL7z7Z7WM4hJ4Y=
X-Google-Smtp-Source: APiQypJFSh3bXWuJ7x6+DbhV4xicuxImfcUvi6SvtUeplKK7p+MxUJ6HoV3iLTo8/qjdhHIAUdqX4A3BxnHAJhLGxbQ=
X-Received: by 2002:a17:906:1199:: with SMTP id n25mr287851eja.30.1587589981187;
 Wed, 22 Apr 2020 14:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200421134410.30603-1-narmstrong@baylibre.com>
In-Reply-To: <20200421134410.30603-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 22 Apr 2020 23:12:50 +0200
Message-ID: <CAFBinCAGP7ZE-OksaE=6E54r2e0VJk2wMTEwKU65qAoR4dQvxw@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: add mode selection limits against specific SoC revisions
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Apr 21, 2020 at 3:44 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index e8c94915a4fc..dc3d5122475a 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -695,6 +695,13 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
>         dev_dbg(connector->dev->dev, "%s: vclk:%d phy=%d venc=%d hdmi=%d\n",
>                 __func__, phy_freq, vclk_freq, venc_freq, hdmi_freq);
>
> +       /* Check against soc revision/package limits */
> +       if (priv->limits) {
> +               if (priv->limits->max_hdmi_phy_freq &&
> +                   phy_freq > priv->limits->max_hdmi_phy_freq)
> +                       return MODE_CLOCK_HIGH;
> +       }
I think that this will also be useful for the 32-bit SoCs as well.
is there a chance you can move it to meson_vclk_vic_supported_freq
(called right below), where all the existing frequency limit checks
are already?


Thank you!
Martin
