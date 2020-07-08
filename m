Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD05AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1DA206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OzA7R+pv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGHRvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGHRvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:51:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BC0C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 10:51:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z15so38622112wrl.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7SQJhbW9iFT0GAfAIqHssBvgsuF+/Q2rlb1LOfoE3Dg=;
        b=OzA7R+pvW5s80iDwljKpzPfzJpi33QbPyL02J9vQRicBjee/2//LIsykAXKhMqcvfx
         7rPtOGJEBnbi78A8LFqY0fQ2wG5o4Ekz8g18p+6qFlIXZZerwp76g2kRTc+rOfrd1m/0
         Xl04VzboUPA0mE62FIpPY3fScjYQkYR8qTSy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7SQJhbW9iFT0GAfAIqHssBvgsuF+/Q2rlb1LOfoE3Dg=;
        b=k33a/6EekkaMcy+RGbaMkgtOKjNe8X0K+o1No04tXP3C/aYMwXdVI8nXGO71R/rWI/
         rfNfiMvCUM5qJdzR6GHtEC33FRaB8UtP9tv7iXVAqeq+UisB2obuvIlFpWKQ4ebFdkA5
         WIxCtIri4cm1p6idbQw8rgqaZNViAqol79XxQMdMniX0FCq3K826D4FQllB/+6/BYnsM
         aaP036aKcPkm3xMWtGmVuzQ1CTV6kRBVNWph8bE+7TAHJ0gc2Q+18Cbcr7+i/nqlbTIK
         2j61AXSR8nyzmAkULbDCPu0x+cGiyF8QzeqHT/K3aivNv0AXMFLiVO+RewzeckgmkKLs
         2Tgg==
X-Gm-Message-State: AOAM532yNxngl+jxEMdIT6k5g7XFKME25eehjMef5atr4GQahQjbmGw+
        eHBYIZozbILRJj0VKPop6jlLa6/taFF7QaUlmvOo2A==
X-Google-Smtp-Source: ABdhPJy2alGvzZL6wQszq75bUER1H71H1cXO2lQ2Kqo3cndUKYuoAJw+NUjXk0Tx7RN/Wp+wMSWb5XBs5ORDoJdCXZ0=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr30713365wrj.14.1594230671246;
 Wed, 08 Jul 2020 10:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200708071117.3070707-1-yuhsuan@chromium.org>
 <f6a0ea44-3805-5901-9864-72d4a3a4562e@collabora.com> <CABXOdTfV_oGgZWbyP3o07obMuYGOLY87fou2h3_gowQkV7QVNw@mail.gmail.com>
 <CAGvk5Po=BcHZ8uQJAp10cYHJcvc6-x613o-0Jj00K23xpeQpaQ@mail.gmail.com> <CABXOdTf1+nBtau7ujnUVTfNd68D-RijZBPU8XMv=ZQ-RLbpzAg@mail.gmail.com>
In-Reply-To: <CABXOdTf1+nBtau7ujnUVTfNd68D-RijZBPU8XMv=ZQ-RLbpzAg@mail.gmail.com>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Thu, 9 Jul 2020 01:51:00 +0800
Message-ID: <CAGvk5Po2osJOc077x6AWOn7bDgYsWzYSfqrSp64XBgjvjMHKsQ@mail.gmail.com>
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

Guenter Roeck <groeck@google.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=889=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=881:26=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Jul 8, 2020 at 9:17 AM Yu-Hsuan Hsu <yuhsuan@chromium.org> wrote:
> >
> > Guenter Roeck <groeck@google.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=888=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:28=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Wed, Jul 8, 2020 at 3:16 AM Enric Balletbo i Serra
> > > <enric.balletbo@collabora.com> wrote:
> > > >
> > > > Hi Yu-Hsuan,
> > > >
> > > > Thank you for your patch.
> > > >
> > > > On 8/7/20 9:11, Yu-Hsuan Hsu wrote:
> > > > > It is not guaranteed that I2S RX is disabled when the kernel boot=
ing.
> > > > > For example, if the kernel crashes while it is enabled, it will k=
eep
> > > > > enabled until the next time EC reboots. Reset I2S RX when probing=
 to
> > > > > fix this issue.
> > > > >
> > > > > Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> > > > > ---
> > > > >  include/linux/platform_data/cros_ec_commands.h | 1 +
> > > > >  sound/soc/codecs/cros_ec_codec.c               | 7 +++++++
> > > > >  2 files changed, 8 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/platform_data/cros_ec_commands.h b/inc=
lude/linux/platform_data/cros_ec_commands.h
> > > > > index 69210881ebac8..11ce917ca924c 100644
> > > > > --- a/include/linux/platform_data/cros_ec_commands.h
> > > > > +++ b/include/linux/platform_data/cros_ec_commands.h
> > > > > @@ -4598,6 +4598,7 @@ enum ec_codec_i2s_rx_subcmd {
> > > > >       EC_CODEC_I2S_RX_SET_SAMPLE_DEPTH =3D 0x2,
> > > > >       EC_CODEC_I2S_RX_SET_DAIFMT =3D 0x3,
> > > > >       EC_CODEC_I2S_RX_SET_BCLK =3D 0x4,
> > > > > +     EC_CODEC_I2S_RX_RESET =3D 0x5,
> > > >
> > > > Is this a new command not available in the firmware that is already=
 in the field?
> > > >
> > > >
> > > > >       EC_CODEC_I2S_RX_SUBCMD_COUNT,
> > > > >  };
> > > > >
> > > > > diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/=
cros_ec_codec.c
> > > > > index 8d45c628e988e..5495214e73e68 100644
> > > > > --- a/sound/soc/codecs/cros_ec_codec.c
> > > > > +++ b/sound/soc/codecs/cros_ec_codec.c
> > > > > @@ -1034,6 +1034,13 @@ static int cros_ec_codec_platform_probe(st=
ruct platform_device *pdev)
> > > > >       }
> > > > >       priv->ec_capabilities =3D r.capabilities;
> > > > >
> > > > > +     /* Reset EC codec I2S RX. */
> > > > > +     p.cmd =3D EC_CODEC_I2S_RX_RESET;
> > > > > +     ret =3D send_ec_host_command(priv->ec_device, EC_CMD_EC_COD=
EC_I2S_RX,
> > > > > +                                (uint8_t *)&p, sizeof(p), NULL, =
0);
> > > > > +     if (ret)
> > > > > +             dev_err(dev, "failed to EC_CODEC_I2S_RESET: %d\n", =
ret);
> > > > > +
> > > >
> > > > With an old firmware I suspect this message will appear on every bo=
ot, right?
> > > > So, to solve the issue and get rid of this error you're forced to u=
pgrade the
> > > > firmware. Is that true?
> > > >
> > >
> > > It might possibly make more sense to fail this silently and to send
> > > EC_CODEC_I2S_RX_DISABLE as backup if it is not supported (-ENOTSUPP
> > > can possibly be used as trigger if the call returns it).
> > >
> > > Also, I don't accept dev_err() if the error is ignored for patches in
> > > my scope of responsibility.
> > >
> > > Guenter
> > Thanks for the suggestion. Our plan is to upstream this patch first.
> > And then we will merge it into the kernel after the firmware is
> > updated. Is it feasible? (I'm not sure whether there is the better way
> > if I want to update EC and the kernel at the same time.)
> >
> > I think calling EC_CODEC_I2S_RX_DISABLE does not make sense because it
> > checks the value of i2s_rx_enabled first. If i2s_rx_enabled is false,
> > it will skip the function. However, we don't need to reset while the
> > i2s_rx_enabled is already false.
> >
> Exactly my point. If i2s_rx_enabled is false, nothing needs to be
> done, and it doesn't hurt if the EC does nothing. If i2s_rx_enabled is
> true, it needs to be set to false, which is accomplished by sending
> EC_CODEC_I2S_RX_DISABLE.
Sorry my bad. If i2s_rx_enabled is false, it will skip and return
EC_RES_BUSY. And then we may need to handle one more error. I think it
may become too complicated to handle those errors. Could we just merge
this change after the firmware updates? So that we don't need to worry
about the unsupported command.

>
> > In addition, since it is a sub-command, it will return
> > EC_RES_INVALID_PARAM but not ENOTSUPP if the command is not supported.
> > And then EC_RES_INVALID_PARAM will turn into -EPROTO finally so it's
> > difficult to do other operators basing on the return value.
> >
>
> You might have to convince Enric to permit another error code to
> translate EC_RES_INVALID_PARAM. After all, that would meet his
> requirement that the error code must be used in the kernel to accept a
> translation.
>
> Guenter
>
> > Thanks,
> > Yu-Hsuan
> >
> > >
> > > > >       platform_set_drvdata(pdev, priv);
> > > > >
> > > > >       ret =3D devm_snd_soc_register_component(dev, &i2s_rx_compon=
ent_driver,
> > > > >
