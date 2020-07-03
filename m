Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA33C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54E720870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aCP0cShj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgGCJkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgGCJky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:40:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5EAC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 02:40:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so31419686wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 02:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DdinKhU6Vgfi2yzkEzkWpZ1cEblZoAeY2Qj+FjvvzvE=;
        b=aCP0cShjbrykQvr0g1Vb+DEj00lwAxg0T78dsiIDjyKDfQDVu3sax35VsD+5BopxBx
         Xk1fdV5P6jRSIY3aeIF3Auv39STfQHSfFib4ytai0iieU4CPbdF4Idi+KfDPU565e6/t
         JK60Gs6fQ2v3r7hZrbrjVy3+FWxGjTx1n1jQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DdinKhU6Vgfi2yzkEzkWpZ1cEblZoAeY2Qj+FjvvzvE=;
        b=FS2w5ceQqMCaAUKpb6bbdGcIhiRU12P4gvsqGFaETMqG+Nl3FkFhxQDsFJ9fKibuVE
         YSpalWACtcjNTpbjZFpzhwEt0IYNdd1CMCTNLIa3n2xUuqnypTzVaGArsGEUK2J9v2wl
         kLYwV4ztB1rSORNV+/BkwDZfniv2qWW7AQs0mqalH7ye8Q2HJerPt4xopEvxYIEk6Qs0
         xwWRYzud7C3xtTu4gXkzYfyUkklNhPUIEYTYMI/uGdT4squ4nFGzeWvrRoCqZO+o8duY
         0s0GUXAK34cam30YIHiDcnfm0+PX15X6AmPsvbscg74+bTtcNVbbr54Pk7EqwXvfXTBa
         6o9g==
X-Gm-Message-State: AOAM532xrgiTnfYSRkAXujJxuLGYBzm4Yy0UHVeiSCOUbWiQdmQth7aF
        2TrmCi0jszTym6xtG3Sy87GN21jt9bo4Q82DTONMbg==
X-Google-Smtp-Source: ABdhPJyK3bZA5YHuYaknx92LE0w8p979gJTs+4780PHItenqBWsn4/F2bJXGGYP51jn4Y3LxXJfRoekc1uTcz5f/J10=
X-Received: by 2002:a1c:bb43:: with SMTP id l64mr36903087wmf.151.1593769253122;
 Fri, 03 Jul 2020 02:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200703071913.2358882-1-yuhsuan@chromium.org>
 <8d21fc0c-b43e-75a0-d5d4-ed4872ec92cb@collabora.com> <CAGvk5Pqx475MOsefchcgs=CnVJiwFJxa+-J6eHcp1VgscVkTeg@mail.gmail.com>
 <cea2bc7e-035b-2c97-73bf-25dc55ab8801@collabora.com>
In-Reply-To: <cea2bc7e-035b-2c97-73bf-25dc55ab8801@collabora.com>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Fri, 3 Jul 2020 17:40:42 +0800
Message-ID: <CAGvk5PoiWDchYCsaR_tqQ5mE0XA_hBXHy-hS5o3vFtuPzm_JiA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Log results when EC commands fail
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
=B47=E6=9C=883=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:19=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hi Yu-Hsuan,
>
> On 3/7/20 10:48, Yu-Hsuan Hsu wrote:
> > Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=
=B9=B47=E6=9C=883=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:38=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >>
> >> Hi Yu-Hsuan,
> >>
> >> Thank you for your patch
> >>
> >> On 3/7/20 9:19, Yu-Hsuan Hsu wrote:
> >>> Log results of failed EC commands to identify a problem more easily.
> >>>
> >>> Replace cros_ec_cmd_xfer_status with cros_ec_cmd_xfer because the res=
ult
> >>> has already been checked in this function. The wrapper is not needed.
> >>>
> >>
> >> Nack, we did an effort to remove all public users of cros_ec_cmd_xfer(=
) in
> >> favour of cros_ec_cmd_xfer_status() and you are reintroducing again. Y=
ou can do
> >> the same but using cros_ec_cmd_xfer_status(). In fact, your patch will=
 not build
> >> on top of the upcoming changes.
> > Thanks! But I have a question about implementing it. Does it look like
> > the one below?
> > ret =3D cros_ec_cmd_xfer_status(ec_dev, msg);
> > if (ret < 0) {
>
> In this case will already print an error.
>
> What are you trying to achieve?
>
> If the only reason is of this patch is print a message you should either,=
 or
> enable dynamic printk and enable dev_dbg or event better use the kernel t=
race
> functionality. There is no need to be more verbose.
>
> Example:
>     $ echo 1 > /sys/kernel/debug/tracing/events/cros_ec/enable
>     $ cat /sys/kernel/debug/tracing/trace
>
>     369.416372: cros_ec_request_start: version: 0, command: EC_CMD_USB_PD=
_POWER_INFO
>     369.420528: cros_ec_request_done: version: 0, command:
> EC_CMD_USB_PD_POWER_INFO, ec result: EC_RES_SUCCESS, retval: 16
>
> Cheers,
>  Enric
>
Thank Enric,

The situation is that some users encountered errors on ChromeBook.
From their feedback reports, we only get the message like
'cros-ec-codec GOOG0013:00: ASoC: Failed to set DAI format: -71'.
We know that -71 is -EPROTO but it is not clear enough for us to find
out the root cause. That's why we want the detail of the result.
Because the situation happens on users' side, it is not possible for
them to enable kernel trace (ChromeOS does not allow users to touch
kernel).

The other way we thought is changing dev_dbg to dev_err in
cros_ec_cmd_xfer_status. But we are not sure whether it is also an
error for other usages.

> >   if (ret =3D=3D -EPROTO)
> >     dev_err(..., msg->result)
> >   goto error;
> > }
> > I'm not sure whether it makes sense to check ret =3D=3D -EPROTO here.
> >
> >>
> >>> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> >>> ---
> >>>  sound/soc/codecs/cros_ec_codec.c | 9 ++++++++-
> >>>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros=
_ec_codec.c
> >>> index 8d45c628e988e..a4ab62f59efa6 100644
> >>> --- a/sound/soc/codecs/cros_ec_codec.c
> >>> +++ b/sound/soc/codecs/cros_ec_codec.c
> >>> @@ -90,10 +90,17 @@ static int send_ec_host_command(struct cros_ec_de=
vice *ec_dev, uint32_t cmd,
> >>>       if (outsize)
> >>>               memcpy(msg->data, out, outsize);
> >>>
> >>> -     ret =3D cros_ec_cmd_xfer_status(ec_dev, msg);
> >>> +     ret =3D cros_ec_cmd_xfer(ec_dev, msg);
> >>>       if (ret < 0)
> >>>               goto error;
> >>>
> >>> +     if (msg->result !=3D EC_RES_SUCCESS) {
> >>> +             dev_err(ec_dev->dev, "Command %d failed: %d\n", cmd,
> >>> +                     msg->result);
> >>> +             ret =3D -EPROTO;
> >>> +             goto error;
> >>> +     }
> >>> +
> >>>       if (insize)
> >>>               memcpy(in, msg->data, insize);
> >>>
> >>>
