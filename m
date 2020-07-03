Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A000C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E08204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FwsjIYfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgGCP6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGCP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:58:48 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8FEC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 08:58:48 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d18so22550627edv.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q/N+I6wlAniI0DD0itPuT/cLgyAhUPW3fibqZYnY1tM=;
        b=FwsjIYfTY+TNSmsO90G4fVb7hDX8DqNp9MwC7g9XcICwCqgTRv/4bS8LQ1wQBuHbf2
         BKQcVeHXNTyxt0k/ICF0pOTkhXsANIH0Jzs0BrOhxJH9y0XXz6ZH0OklBNCZpNbhl94p
         2WdseA+W7RuGsPzTRuhuergDlIHGd6Y2LUoHvNEmLeVf4/FfetVlrpLGUMn+Eb/VrQSk
         VSLWnfuuEKXx9QZedyt8wJPkUKhKgMTdv2CLRlD2XIwpgA9NR3Gr3BWnAjXsNrd916+B
         jlbSt1pFNBZp0jGGNvKZrLXNtE5G43HmKdHMadRCqjWO3FJTUXf4KZjP0REZ+ruLkZcV
         XCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q/N+I6wlAniI0DD0itPuT/cLgyAhUPW3fibqZYnY1tM=;
        b=Q8fUJzCRgS1IlD5nrTER5GI0HZJAG1cNDAc3aATIFITfPu8HBJkiM7qePGkAZhAVcV
         IVqFDwD3PWgvQN7X65ipi9ZYVn61lyQZpMa8X+onpcFBo08tB6g5yOudTJsydDkV6z2p
         3Re3fWyGJB3ppWuTgGptbccjgToZRt37DaYsP2gQU2NKCKiD7VClyog6Kme7hMBppRp7
         YPp4VIY7ot7pStEFvo1c9nZbBu8e5VcKpir3fDjbqaMeXCBQ01VDk9G8Jl2kOhL/aIbe
         x8Lzfg1/JJ29dQr5ifXrpvFUO1M9AZBHCK7dK9u8clN5P7+JhFGwx3hYnWPGWrwmg3ck
         gybQ==
X-Gm-Message-State: AOAM532I7GjSB4Q5PMK1Q6stGLBeqpAgU4q2+cQc095tXREv2t1aqNru
        TgOpDMN72qwgmYpT8mE8E6qm/lOIII+bLC8P5le1EA==
X-Google-Smtp-Source: ABdhPJzNZLv2k3bDhCuqcHfUOacDVJL1TIfyfOhpyzTgJJ7gwUSV//iehtbOiR+UB8diZNgTQI4L+KT77z5xL+FrO84=
X-Received: by 2002:a50:ed15:: with SMTP id j21mr14915524eds.246.1593791926531;
 Fri, 03 Jul 2020 08:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200703071913.2358882-1-yuhsuan@chromium.org>
 <8d21fc0c-b43e-75a0-d5d4-ed4872ec92cb@collabora.com> <CAGvk5Pqx475MOsefchcgs=CnVJiwFJxa+-J6eHcp1VgscVkTeg@mail.gmail.com>
 <cea2bc7e-035b-2c97-73bf-25dc55ab8801@collabora.com> <CAGvk5PoiWDchYCsaR_tqQ5mE0XA_hBXHy-hS5o3vFtuPzm_JiA@mail.gmail.com>
 <d5634533-3cf3-b52a-ff24-2bda3230927d@collabora.com>
In-Reply-To: <d5634533-3cf3-b52a-ff24-2bda3230927d@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 3 Jul 2020 08:58:35 -0700
Message-ID: <CABXOdTcP0DagxzUrBh5H_TXzSAZjMAG4UaV++0sW99W4ypC78w@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Log results when EC commands fail
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>,
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

On Fri, Jul 3, 2020 at 3:56 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Yu-Hsuan,
>
> On 3/7/20 11:40, Yu-Hsuan Hsu wrote:
> > Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=
=B9=B47=E6=9C=883=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:19=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >>
> >> Hi Yu-Hsuan,
> >>
> >> On 3/7/20 10:48, Yu-Hsuan Hsu wrote:
> >>> Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=
=E5=B9=B47=E6=9C=883=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:38=E5=
=AF=AB=E9=81=93=EF=BC=9A
> >>>>
> >>>> Hi Yu-Hsuan,
> >>>>
> >>>> Thank you for your patch
> >>>>
> >>>> On 3/7/20 9:19, Yu-Hsuan Hsu wrote:
> >>>>> Log results of failed EC commands to identify a problem more easily=
.
> >>>>>
> >>>>> Replace cros_ec_cmd_xfer_status with cros_ec_cmd_xfer because the r=
esult
> >>>>> has already been checked in this function. The wrapper is not neede=
d.
> >>>>>
> >>>>
> >>>> Nack, we did an effort to remove all public users of cros_ec_cmd_xfe=
r() in
> >>>> favour of cros_ec_cmd_xfer_status() and you are reintroducing again.=
 You can do
> >>>> the same but using cros_ec_cmd_xfer_status(). In fact, your patch wi=
ll not build
> >>>> on top of the upcoming changes.
> >>> Thanks! But I have a question about implementing it. Does it look lik=
e
> >>> the one below?
> >>> ret =3D cros_ec_cmd_xfer_status(ec_dev, msg);
> >>> if (ret < 0) {
> >>
> >> In this case will already print an error.
> >>
> >> What are you trying to achieve?
> >>
> >> If the only reason is of this patch is print a message you should eith=
er, or
> >> enable dynamic printk and enable dev_dbg or event better use the kerne=
l trace
> >> functionality. There is no need to be more verbose.
> >>
> >> Example:
> >>     $ echo 1 > /sys/kernel/debug/tracing/events/cros_ec/enable
> >>     $ cat /sys/kernel/debug/tracing/trace
> >>
> >>     369.416372: cros_ec_request_start: version: 0, command: EC_CMD_USB=
_PD_POWER_INFO
> >>     369.420528: cros_ec_request_done: version: 0, command:
> >> EC_CMD_USB_PD_POWER_INFO, ec result: EC_RES_SUCCESS, retval: 16
> >>
> >> Cheers,
> >>  Enric
> >>
> > Thank Enric,
> >
> > The situation is that some users encountered errors on ChromeBook.
>
> And, aren't you able to reproduce the issue?
>
>
> > From their feedback reports, we only get the message like
> > 'cros-ec-codec GOOG0013:00: ASoC: Failed to set DAI format: -71'.
> > We know that -71 is -EPROTO but it is not clear enough for us to find
> > out the root cause. That's why we want the detail of the result.
>
>
> If I am not mistaken this ends calling i2s_rx_set_daifmt() into the EC fi=
rmware,
> if the result is -EPROTO that means is not returning EC_RES_SUCCESS, so t=
here
> are few options:
>
>         if (i2s_rx_enabled)
>                 return EC_RES_BUSY;
>
>         if (daifmt >=3D EC_CODEC_I2S_RX_DAIFMT_COUNT)
>                 return EC_RES_INVALID_PARAM;
>
>         if (audio_codec_i2s_rx_set_daifmt(daifmt) !=3D EC_SUCCESS)
>                 return EC_RES_ERROR;
>
> > Because the situation happens on users' side, it is not possible for
> > them to enable kernel trace (ChromeOS does not allow users to touch
> > kernel).
> >
>
> Are you sure that when you know the error code you'll find the root cause
> (without adding more prints)? There is only three possibilities? You can'=
t start
> adding prints just to debug a user issue because you don't allow to be mo=
re
> verbose. I understand that might help you but is not the way to go.
>
> You should really reproduce the issue yourself an use actual debug
> tools/prints./traces.
>

Another possibility would be to change cros_ec_cmd_xfer_status() to
return a more granular error code, such as -EINVAL for
EC_RES_INVALID_PARAM, -EBUSY for EC_RES_BUSY, -EINPROGRESS for
EC_RES_IN_PROGRESS,  -ETIMEDOUT for EC_RES_TIMEOUT, -EOVERFLOW for
EC_RES_OVERFLOW, -ENODATA for EC_RES_UNAVAILABLE, and so on.

However, it appears that the various low level functions already
replace various EC error codes with a blank EC_RES_ERROR. No amount of
logging will tell us what exactly went wrong in those functions. Lucky
for us, audio_codec_i2s_rx_set_daifmt() only ever returns EC_SUCCESS,
so we know that the problem is either that i2s_rx_enabled is true or
that daifmt is too large. None of those really warrants more verbose
logging.

From the context, my personal bet is that i2s_rx_enabled is true: I
don't immediately see how disabling it is enforced before trying to
set the DAI format, and I don't see how "daifmt >=3D
EC_CODEC_I2S_RX_DAIFMT_COUNT" can ever be true.

Guenter


Guenter

> Cheers,
>  Enric
>
> > The other way we thought is changing dev_dbg to dev_err in
> > cros_ec_cmd_xfer_status. But we are not sure whether it is also an
> > error for other usages.
> >
> >>>   if (ret =3D=3D -EPROTO)
> >>>     dev_err(..., msg->result)
> >>>   goto error;
> >>> }
> >>> I'm not sure whether it makes sense to check ret =3D=3D -EPROTO here.
> >>>
> >>>>
> >>>>> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> >>>>> ---
> >>>>>  sound/soc/codecs/cros_ec_codec.c | 9 ++++++++-
> >>>>>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cr=
os_ec_codec.c
> >>>>> index 8d45c628e988e..a4ab62f59efa6 100644
> >>>>> --- a/sound/soc/codecs/cros_ec_codec.c
> >>>>> +++ b/sound/soc/codecs/cros_ec_codec.c
> >>>>> @@ -90,10 +90,17 @@ static int send_ec_host_command(struct cros_ec_=
device *ec_dev, uint32_t cmd,
> >>>>>       if (outsize)
> >>>>>               memcpy(msg->data, out, outsize);
> >>>>>
> >>>>> -     ret =3D cros_ec_cmd_xfer_status(ec_dev, msg);
> >>>>> +     ret =3D cros_ec_cmd_xfer(ec_dev, msg);
> >>>>>       if (ret < 0)
> >>>>>               goto error;
> >>>>>
> >>>>> +     if (msg->result !=3D EC_RES_SUCCESS) {
> >>>>> +             dev_err(ec_dev->dev, "Command %d failed: %d\n", cmd,
> >>>>> +                     msg->result);
> >>>>> +             ret =3D -EPROTO;
> >>>>> +             goto error;
> >>>>> +     }
> >>>>> +
> >>>>>       if (insize)
> >>>>>               memcpy(in, msg->data, insize);
> >>>>>
> >>>>>
