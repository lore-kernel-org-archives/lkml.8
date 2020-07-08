Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C66CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DABBD207C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iia7mGZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbgGHQRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbgGHQRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:17:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C64BC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:17:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so3859422wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5kAcxP8yp944C33ROLXVPNzrfs8jnGeNlhJxbTbvZzg=;
        b=iia7mGZtpCQgy3YOdSOK6NvhZ9DV6sfk80EaAKaVG0F7rSN//EzGF6YidC4viD2yjE
         vI0mdKXKht4KbaakdleqqsPz/hS2gZSsGgDVnh/cvbATz0aI2VTNG78Gs7H5UbxJtXqG
         3MF9+QrQHlQNccapi8P93wGOJT2bpczaay6MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5kAcxP8yp944C33ROLXVPNzrfs8jnGeNlhJxbTbvZzg=;
        b=ZmA2YOoxpEjVWTfrbv8eNgWcB6KqWM8vNgD8gm8Nrdo7AhyJLQE1jT/OOMuaBRKpUl
         3H547IZvF8lxPg0SWeVJsQbZV6I9yo8NUWZnc9CFg8mDmsUnxR8k5CCJ9Us73CLzqYOw
         OdPwJCYa8VddO3g/EKM3sVdmK9AxdD2kDT5tG8d785h1Yh3oMyqOhYpmoH4S5gk2+KAQ
         8MeXacLzkLEqMmRLkgtILbuh7X9lyYkfErlDUVJLh162uy55BT33Iy0hoMl7fkmaP5BJ
         yDMcegcac2oV+mxpXk0E249yvyS/fe5Mr2m1Knz8iOmSDlC3FFUwDSsF/PSoOGjdq6/G
         ft7Q==
X-Gm-Message-State: AOAM531C1+J8OPChWCHbwHeX2Tmhakj3nsw7UCugyt98z+GxWRHUo197
        DkpTfjzYJdp0DeYkKhojkgmW3AeowtNb1filzftBww==
X-Google-Smtp-Source: ABdhPJwiVqLB7/Ty3jBK0KqJkumzblgAGK+E2oKwEaMcIEqr6+uFRi3qc6Vg7JRssEFSwhc7WzEdvjeO6GZcrCwWgSU=
X-Received: by 2002:a1c:e088:: with SMTP id x130mr9669890wmg.14.1594225038874;
 Wed, 08 Jul 2020 09:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200708071117.3070707-1-yuhsuan@chromium.org>
 <f6a0ea44-3805-5901-9864-72d4a3a4562e@collabora.com> <CABXOdTfV_oGgZWbyP3o07obMuYGOLY87fou2h3_gowQkV7QVNw@mail.gmail.com>
In-Reply-To: <CABXOdTfV_oGgZWbyP3o07obMuYGOLY87fou2h3_gowQkV7QVNw@mail.gmail.com>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Thu, 9 Jul 2020 00:17:07 +0800
Message-ID: <CAGvk5Po=BcHZ8uQJAp10cYHJcvc6-x613o-0Jj00K23xpeQpaQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: cros_ec_codec: Reset I2S RX when probing
To:     Guenter Roeck <groeck@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Yicheng Li <yichengli@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <groeck@google.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Jul 8, 2020 at 3:16 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > Hi Yu-Hsuan,
> >
> > Thank you for your patch.
> >
> > On 8/7/20 9:11, Yu-Hsuan Hsu wrote:
> > > It is not guaranteed that I2S RX is disabled when the kernel booting.
> > > For example, if the kernel crashes while it is enabled, it will keep
> > > enabled until the next time EC reboots. Reset I2S RX when probing to
> > > fix this issue.
> > >
> > > Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> > > ---
> > >  include/linux/platform_data/cros_ec_commands.h | 1 +
> > >  sound/soc/codecs/cros_ec_codec.c               | 7 +++++++
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/include/linux/platform_data/cros_ec_commands.h b/include=
/linux/platform_data/cros_ec_commands.h
> > > index 69210881ebac8..11ce917ca924c 100644
> > > --- a/include/linux/platform_data/cros_ec_commands.h
> > > +++ b/include/linux/platform_data/cros_ec_commands.h
> > > @@ -4598,6 +4598,7 @@ enum ec_codec_i2s_rx_subcmd {
> > >       EC_CODEC_I2S_RX_SET_SAMPLE_DEPTH =3D 0x2,
> > >       EC_CODEC_I2S_RX_SET_DAIFMT =3D 0x3,
> > >       EC_CODEC_I2S_RX_SET_BCLK =3D 0x4,
> > > +     EC_CODEC_I2S_RX_RESET =3D 0x5,
> >
> > Is this a new command not available in the firmware that is already in =
the field?
> >
> >
> > >       EC_CODEC_I2S_RX_SUBCMD_COUNT,
> > >  };
> > >
> > > diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros=
_ec_codec.c
> > > index 8d45c628e988e..5495214e73e68 100644
> > > --- a/sound/soc/codecs/cros_ec_codec.c
> > > +++ b/sound/soc/codecs/cros_ec_codec.c
> > > @@ -1034,6 +1034,13 @@ static int cros_ec_codec_platform_probe(struct=
 platform_device *pdev)
> > >       }
> > >       priv->ec_capabilities =3D r.capabilities;
> > >
> > > +     /* Reset EC codec I2S RX. */
> > > +     p.cmd =3D EC_CODEC_I2S_RX_RESET;
> > > +     ret =3D send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I=
2S_RX,
> > > +                                (uint8_t *)&p, sizeof(p), NULL, 0);
> > > +     if (ret)
> > > +             dev_err(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret)=
;
> > > +
> >
> > With an old firmware I suspect this message will appear on every boot, =
right?
> > So, to solve the issue and get rid of this error you're forced to upgra=
de the
> > firmware. Is that true?
> >
>
> It might possibly make more sense to fail this silently and to send
> EC_CODEC_I2S_RX_DISABLE as backup if it is not supported (-ENOTSUPP
> can possibly be used as trigger if the call returns it).
>
> Also, I don't accept dev_err() if the error is ignored for patches in
> my scope of responsibility.
>
> Guenter
Thanks for the suggestion. Our plan is to upstream this patch first.
And then we will merge it into the kernel after the firmware is
updated. Is it feasible? (I'm not sure whether there is the better way
if I want to update EC and the kernel at the same time.)

I think calling EC_CODEC_I2S_RX_DISABLE does not make sense because it
checks the value of i2s_rx_enabled first. If i2s_rx_enabled is false,
it will skip the function. However, we don't need to reset while the
i2s_rx_enabled is already false.

In addition, since it is a sub-command, it will return
EC_RES_INVALID_PARAM but not ENOTSUPP if the command is not supported.
And then EC_RES_INVALID_PARAM will turn into -EPROTO finally so it's
difficult to do other operators basing on the return value.

Thanks,
Yu-Hsuan

>
> > >       platform_set_drvdata(pdev, priv);
> > >
> > >       ret =3D devm_snd_soc_register_component(dev, &i2s_rx_component_=
driver,
> > >
