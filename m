Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A46C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C43F206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bp+7dUOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGHR0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgGHR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:26:07 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB1CC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 10:26:07 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ga4so51337815ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WYGcMzQopQZDl14XIf4O4aJ8BVHuo25BvGp6Q85HroM=;
        b=bp+7dUOnLcc5Oi0kcl0BX2Obs1NxiJlDg0C8uv+GcIGbI+HrfNnVyLLtLdkJBjtpDs
         Jd+7uOpv8tA3ruYnfx2BqlFdsX/EJXgVEMFOodZkUZwppigwcgshzQx/ISW6kWgrllhA
         a8ZtNTs/E47tyxx2jVnB9rL3SiUbCNQIPy/5yYc7StbQzbe3PTuHRWEY07GomGUD5gBl
         lVb+9OKBBcf9RW9e2AtaF3ug+7inYhr4QbhN1pj8dFV9muqRZwOqL/flBOekrGs7KVcD
         aMKpoIphe1iMnM9BnvH1O17VUOD2o4p+lX+RfQvRrZlFEGN4QLrMgLuNWdNuiuhBqbU4
         hGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WYGcMzQopQZDl14XIf4O4aJ8BVHuo25BvGp6Q85HroM=;
        b=jCApOXpuxSN+G9t9d8kwqBXqFw3Fqg4oqMX6fwcij7LCb7R5V1aRXuj2TvnB9Dnedq
         Ke6YzSf8t05e0ZLpmIso8w/tXyX+jCq8c80dQ74hQzaILxbBLxRkufFy3WARvgNlTuOi
         kI1hCiFI6elS/vCn5CgkXq5lYDn31u2WKnGXva5zeQcHPyQqG+uHB1NQCmZDUjXqUQQ9
         IJhilD3NV5Q/ud9jS9ojjBx0LLy87OTqaWfBVfO1mNqiLa5/2Nrg4r3nAxnzxCyfH2ZH
         WjVwKASZZzMY2Z2GsQVd5xb8dSzkw4mqAq82blMLL+B/rOYKkZydZZgv3ubHJVYbeYqZ
         Q/Jg==
X-Gm-Message-State: AOAM531JD9UwSJd8MmpDOKq4gdX0/GYMNIUQKDpaVD/3yNBM5cAxZczy
        jPWtwSZEDdTWvb9ktldFN5vKVpJoGe0896jIjeipTyIVve28AA==
X-Google-Smtp-Source: ABdhPJwoV8t4uI2XTaRmyyeDgy9Qsz9XS2zDyH9zjWSg0c/g1+8CPRgzIj+mHgwez+VbOKXbzSXSV3JYOaGJVwNzRHg=
X-Received: by 2002:a17:906:8316:: with SMTP id j22mr51325891ejx.97.1594229165528;
 Wed, 08 Jul 2020 10:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200708071117.3070707-1-yuhsuan@chromium.org>
 <f6a0ea44-3805-5901-9864-72d4a3a4562e@collabora.com> <CABXOdTfV_oGgZWbyP3o07obMuYGOLY87fou2h3_gowQkV7QVNw@mail.gmail.com>
 <CAGvk5Po=BcHZ8uQJAp10cYHJcvc6-x613o-0Jj00K23xpeQpaQ@mail.gmail.com>
In-Reply-To: <CAGvk5Po=BcHZ8uQJAp10cYHJcvc6-x613o-0Jj00K23xpeQpaQ@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 8 Jul 2020 10:25:54 -0700
Message-ID: <CABXOdTf1+nBtau7ujnUVTfNd68D-RijZBPU8XMv=ZQ-RLbpzAg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: cros_ec_codec: Reset I2S RX when probing
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
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

On Wed, Jul 8, 2020 at 9:17 AM Yu-Hsuan Hsu <yuhsuan@chromium.org> wrote:
>
> Guenter Roeck <groeck@google.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=888=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:28=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Wed, Jul 8, 2020 at 3:16 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> > >
> > > Hi Yu-Hsuan,
> > >
> > > Thank you for your patch.
> > >
> > > On 8/7/20 9:11, Yu-Hsuan Hsu wrote:
> > > > It is not guaranteed that I2S RX is disabled when the kernel bootin=
g.
> > > > For example, if the kernel crashes while it is enabled, it will kee=
p
> > > > enabled until the next time EC reboots. Reset I2S RX when probing t=
o
> > > > fix this issue.
> > > >
> > > > Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> > > > ---
> > > >  include/linux/platform_data/cros_ec_commands.h | 1 +
> > > >  sound/soc/codecs/cros_ec_codec.c               | 7 +++++++
> > > >  2 files changed, 8 insertions(+)
> > > >
> > > > diff --git a/include/linux/platform_data/cros_ec_commands.h b/inclu=
de/linux/platform_data/cros_ec_commands.h
> > > > index 69210881ebac8..11ce917ca924c 100644
> > > > --- a/include/linux/platform_data/cros_ec_commands.h
> > > > +++ b/include/linux/platform_data/cros_ec_commands.h
> > > > @@ -4598,6 +4598,7 @@ enum ec_codec_i2s_rx_subcmd {
> > > >       EC_CODEC_I2S_RX_SET_SAMPLE_DEPTH =3D 0x2,
> > > >       EC_CODEC_I2S_RX_SET_DAIFMT =3D 0x3,
> > > >       EC_CODEC_I2S_RX_SET_BCLK =3D 0x4,
> > > > +     EC_CODEC_I2S_RX_RESET =3D 0x5,
> > >
> > > Is this a new command not available in the firmware that is already i=
n the field?
> > >
> > >
> > > >       EC_CODEC_I2S_RX_SUBCMD_COUNT,
> > > >  };
> > > >
> > > > diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cr=
os_ec_codec.c
> > > > index 8d45c628e988e..5495214e73e68 100644
> > > > --- a/sound/soc/codecs/cros_ec_codec.c
> > > > +++ b/sound/soc/codecs/cros_ec_codec.c
> > > > @@ -1034,6 +1034,13 @@ static int cros_ec_codec_platform_probe(stru=
ct platform_device *pdev)
> > > >       }
> > > >       priv->ec_capabilities =3D r.capabilities;
> > > >
> > > > +     /* Reset EC codec I2S RX. */
> > > > +     p.cmd =3D EC_CODEC_I2S_RX_RESET;
> > > > +     ret =3D send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC=
_I2S_RX,
> > > > +                                (uint8_t *)&p, sizeof(p), NULL, 0)=
;
> > > > +     if (ret)
> > > > +             dev_err(dev, "failed to EC_CODEC_I2S_RESET: %d\n", re=
t);
> > > > +
> > >
> > > With an old firmware I suspect this message will appear on every boot=
, right?
> > > So, to solve the issue and get rid of this error you're forced to upg=
rade the
> > > firmware. Is that true?
> > >
> >
> > It might possibly make more sense to fail this silently and to send
> > EC_CODEC_I2S_RX_DISABLE as backup if it is not supported (-ENOTSUPP
> > can possibly be used as trigger if the call returns it).
> >
> > Also, I don't accept dev_err() if the error is ignored for patches in
> > my scope of responsibility.
> >
> > Guenter
> Thanks for the suggestion. Our plan is to upstream this patch first.
> And then we will merge it into the kernel after the firmware is
> updated. Is it feasible? (I'm not sure whether there is the better way
> if I want to update EC and the kernel at the same time.)
>
> I think calling EC_CODEC_I2S_RX_DISABLE does not make sense because it
> checks the value of i2s_rx_enabled first. If i2s_rx_enabled is false,
> it will skip the function. However, we don't need to reset while the
> i2s_rx_enabled is already false.
>
Exactly my point. If i2s_rx_enabled is false, nothing needs to be
done, and it doesn't hurt if the EC does nothing. If i2s_rx_enabled is
true, it needs to be set to false, which is accomplished by sending
EC_CODEC_I2S_RX_DISABLE.

> In addition, since it is a sub-command, it will return
> EC_RES_INVALID_PARAM but not ENOTSUPP if the command is not supported.
> And then EC_RES_INVALID_PARAM will turn into -EPROTO finally so it's
> difficult to do other operators basing on the return value.
>

You might have to convince Enric to permit another error code to
translate EC_RES_INVALID_PARAM. After all, that would meet his
requirement that the error code must be used in the kernel to accept a
translation.

Guenter

> Thanks,
> Yu-Hsuan
>
> >
> > > >       platform_set_drvdata(pdev, priv);
> > > >
> > > >       ret =3D devm_snd_soc_register_component(dev, &i2s_rx_componen=
t_driver,
> > > >
