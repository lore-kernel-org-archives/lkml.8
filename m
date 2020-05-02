Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF65C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 20:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121D4206F1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 20:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TEVaPpy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgEBUMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 16:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728473AbgEBUMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 16:12:40 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39727C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 13:12:40 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d16so10081976edv.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 13:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/LOaseKaG6V+rtNH18IaezwNbYZkddvKgyfOMm5QWjI=;
        b=TEVaPpy1e7qttjqHb7EHvlJ0Ss4UlvzqXCkMyp2wsJLM8xz3r1B7OQ5fsX18h/A3oZ
         ss1Udz2SOx1vCLY3Kk1weN5gx1NnYxPBXNm/kicNSHd1CSy+E1SRrDz2keHAxd6kxIYN
         0Bf3Wnu7dLQr+XYikSzg7E7Efewa7h42Fa46VZH8OnPiRhVDh4IywVyg39HS6WOSDXIc
         cYsnZmqfCyduA27QMlZUy/mfS82PCAcVd6TSzui7ADkTjzZED5I+iX3yQyhOXaDKZskw
         mx35fFNHFqjtBBMweGf/XvSOjVmQ9lkuzInD7dhJbacKIlBVS7J4IGcwN01c4B6D6PoW
         rjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/LOaseKaG6V+rtNH18IaezwNbYZkddvKgyfOMm5QWjI=;
        b=A5y0uac9lOeo4AcDrzqJR6pja74FkRqkW0G8PNHwX+75lIYsOJ2PfW8vMaafeMSbn9
         jyK7nTBRotB7FxUvvifSci4tuP9JIDo5wKqF77U2L1JOa8QCk1e3PDqw1x0wZoWOUxVO
         4Bcg9VYRCRnOcMhlKFdDnzWuqr4m0gj6xcRTiLq6RYt4XYw4bQ/PYmNsYh07kJaCYg99
         rm0N5hj2OvzKs1KMf+gQbJgRDf8lR9zobET6NXiq6tDV1bJKIZxLR0+zWlXx6qBaLGjz
         Gsd+zHWWcMm05ddq+kcqqr4k6GZOgF63rq3u71gclUKI6SG8gTvN7AgIfywakOVyF9p8
         Vn1g==
X-Gm-Message-State: AGi0Pub9rCwIyU6IJu/vs65nzVQN50RN6h1nWX0gv+NZcBl+N8Gb0ANT
        yUDAncQEKP/tLDZZjp4BOGN5BArvPfvlMX0Dz8o=
X-Google-Smtp-Source: APiQypLoKRoFB4j0P4SGI0u4W4wuHNiG2SBz6fnVNr0YCZ0RdM/Wen8nUr0q9Je35JiOhoMGcTXTHKtOfibtJ9m9X0w=
X-Received: by 2002:a50:f61c:: with SMTP id c28mr8272542edn.365.1588450358825;
 Sat, 02 May 2020 13:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200425203941.3188000-1-martin.blumenstingl@googlemail.com> <bf7e6eb5-4655-e958-819b-9d14effe745e@baylibre.com>
In-Reply-To: <bf7e6eb5-4655-e958-819b-9d14effe745e@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 2 May 2020 22:12:28 +0200
Message-ID: <CAFBinCB7=Mo2hxiNxjq=eWZXBp+yqMEPrDvw-tcUsm3PhEcobA@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: viu: fix setting the OSD burst length in VIU_OSD1_FIFO_CTRL_STAT
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jmasson@baylibre.com, linux-amlogic@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Apr 28, 2020 at 10:38 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> > @@ -444,9 +437,9 @@ void meson_viu_init(struct meson_drm *priv)
> >               VIU_OSD_FIFO_LIMITS(2);      /* fifo_lim: 2*16=32 */
> >
> >       if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
> > -             reg |= meson_viu_osd_burst_length_reg(32);
> > +             reg |= VIU_OSD_BURST_LENGTH_32;
> >       else
> > -             reg |= meson_viu_osd_burst_length_reg(64);
> > +             reg |= VIU_OSD_BURST_LENGTH_64;
> >
> >       writel_relaxed(reg, priv->io_base + _REG(VIU_OSD1_FIFO_CTRL_STAT));
> >       writel_relaxed(reg, priv->io_base + _REG(VIU_OSD2_FIFO_CTRL_STAT));
> >
>
> Thanks,
> Will run some tests !
Does this fix/improve anything for you?
On the 32-bit SoCs kmscube is not smooth (neither on the CVBS nor on
the HDMI output) with a burst length of 24 (which was the old
"accidentally used" value).


Martin
