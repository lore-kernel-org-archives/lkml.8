Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E56BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B0F206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aJEAYlF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgGCIsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgGCIsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:48:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6176BC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 01:48:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so31804970wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 01:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xb10fGbQEewc8w4Mpzil0TOmZbH7lO0KwQ7/eQ52SrU=;
        b=aJEAYlF8aIECZQxzcfyfyqdjftWvSSpF+csFfpJMo+/vgoLKbm9luSQlNJuA4kgtwh
         zk0HpqhMsz/+aCQ70TdIAMpqtdDSQhyg6EHVBd18s4yqb7gkYykoclDaZzVyKdEodXC8
         QmXpy+lal9YXxC12KfcEN7PFy8D+5YYdLb24I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xb10fGbQEewc8w4Mpzil0TOmZbH7lO0KwQ7/eQ52SrU=;
        b=j+mQH5QP2f5Aiphd89VpG1BCMef7Lenlc8AT+3IzuGfKxvw5zRzXAnfeST7s653oVv
         M5szxflEjkTuGl4XYtszA/iueuJSjuADPRSAXNGMREdgBQmGJLVqzg3LxgiMwPsb9bw4
         Is8O+p30o20SvQ3dnUrb8058jK6P68yLbgiLIERbpBUZEgprETeQVOCn5Bc+1nUJlCxX
         gG4cVGtU8I1Sxpndbb0JVneXpJsnbAAUiTAsHUgoUmxMwF1/s05CFJMkoSjmgImjuxPT
         W3MpPuoi50huALeWA7KRsxo8wZtCSJxJvffNLcxFJibHhsC+fvFhWf/RLTjKnanKW17e
         wqjg==
X-Gm-Message-State: AOAM5325OsEu0VvXlQ2TN5K38GKXF+zye5JeavzP6EZnZ77Yv5S7s3s6
        8HDog7TdTN5/VQ6IyTHFxLkbykwIHMYZPQTHOGbcLQ==
X-Google-Smtp-Source: ABdhPJzcWVgNiu3r40nGMGWUt3AisZNEy5A+lTnetC8tnFv/zE5OGnjdkTmf8V4AYxA5F1l8MVug9qB5V3mxK10CATU=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr6866927wrj.14.1593766108964;
 Fri, 03 Jul 2020 01:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200703071913.2358882-1-yuhsuan@chromium.org> <8d21fc0c-b43e-75a0-d5d4-ed4872ec92cb@collabora.com>
In-Reply-To: <8d21fc0c-b43e-75a0-d5d4-ed4872ec92cb@collabora.com>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Fri, 3 Jul 2020 16:48:18 +0800
Message-ID: <CAGvk5Pqx475MOsefchcgs=CnVJiwFJxa+-J6eHcp1VgscVkTeg@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Log results when EC commands fail
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B47=E6=9C=883=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:38=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hi Yu-Hsuan,
>
> Thank you for your patch
>
> On 3/7/20 9:19, Yu-Hsuan Hsu wrote:
> > Log results of failed EC commands to identify a problem more easily.
> >
> > Replace cros_ec_cmd_xfer_status with cros_ec_cmd_xfer because the resul=
t
> > has already been checked in this function. The wrapper is not needed.
> >
>
> Nack, we did an effort to remove all public users of cros_ec_cmd_xfer() i=
n
> favour of cros_ec_cmd_xfer_status() and you are reintroducing again. You =
can do
> the same but using cros_ec_cmd_xfer_status(). In fact, your patch will no=
t build
> on top of the upcoming changes.
Thanks! But I have a question about implementing it. Does it look like
the one below?
ret =3D cros_ec_cmd_xfer_status(ec_dev, msg);
if (ret < 0) {
  if (ret =3D=3D -EPROTO)
    dev_err(..., msg->result)
  goto error;
}
I'm not sure whether it makes sense to check ret =3D=3D -EPROTO here.

>
> > Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> > ---
> >  sound/soc/codecs/cros_ec_codec.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_e=
c_codec.c
> > index 8d45c628e988e..a4ab62f59efa6 100644
> > --- a/sound/soc/codecs/cros_ec_codec.c
> > +++ b/sound/soc/codecs/cros_ec_codec.c
> > @@ -90,10 +90,17 @@ static int send_ec_host_command(struct cros_ec_devi=
ce *ec_dev, uint32_t cmd,
> >       if (outsize)
> >               memcpy(msg->data, out, outsize);
> >
> > -     ret =3D cros_ec_cmd_xfer_status(ec_dev, msg);
> > +     ret =3D cros_ec_cmd_xfer(ec_dev, msg);
> >       if (ret < 0)
> >               goto error;
> >
> > +     if (msg->result !=3D EC_RES_SUCCESS) {
> > +             dev_err(ec_dev->dev, "Command %d failed: %d\n", cmd,
> > +                     msg->result);
> > +             ret =3D -EPROTO;
> > +             goto error;
> > +     }
> > +
> >       if (insize)
> >               memcpy(in, msg->data, insize);
> >
> >
