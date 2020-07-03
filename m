Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C817FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2910206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WHa7wIC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgGCIKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCIKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:10:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84183C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 01:10:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so31141805wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 01:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RhXU/shYl4I18iyGPVD6lf1/ryMOjlMTWXMnIVHwxHA=;
        b=WHa7wIC9Cp235EQtCgtS/QrzR/3IT8+1JlGUE/lrcD+CFI5wqQG00Vn7R1Ex3A4Nty
         jmne9LDywJ5PqLiqzZfWFdPsu9YYHVs8sjrlNxe7wFStnRgN1Zw302Qb5iMp349s4/Dn
         yOfE2e4+hRLMzix1+FPOe66atzr05M9mW9OAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RhXU/shYl4I18iyGPVD6lf1/ryMOjlMTWXMnIVHwxHA=;
        b=osyTEavAiADyAdf4IVeVzWXlUZ7El0qpZH19dXnyamjGTqnKTEHv6LcL7QOiHBEqpc
         QdT2/oJjfCFDU92JigF+tMbupKdBnAidWfvoHLyd+fpQCF6jnwryUxIRIZThMWn4bb/Y
         Ivps8oRplo3MTN/orBvC5klzaLBXf3qwe2Yuza+LHpsKfdIZfF+Q5Mc71q1uq0OfDTdn
         kEl81JxUtppQY9M5Lbx4C7011jL5e4hjLoFTlqvok1jA1e1ezoEATe4x1wD/MI7jT8FC
         pCUsjbEGcQwKf9nVSZauhqlwvmfH1QQqocTwpwrY0XPGx0mbjXO+oftN+95Dnq3/Uj0O
         4FxA==
X-Gm-Message-State: AOAM532P0oSFUq63XNh1+dYQ9GagsnzoO6oG8OrVs0RRfeFgDFaSMk88
        wQ/3i9Afce65hyglIER9dXUmSMIBnEqazLFazxVyqLmtKoY=
X-Google-Smtp-Source: ABdhPJzsT1dmTHVeTD6QEDdeal+6mGCCF0UPc7BZQcA0v0N6TkV126o349aF96Pd3keeeXFjy3LF4hTjm8rmadmo7CU=
X-Received: by 2002:a1c:e088:: with SMTP id x130mr34133709wmg.14.1593763850259;
 Fri, 03 Jul 2020 01:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200703071913.2358882-1-yuhsuan@chromium.org> <CA+Px+wVQC0vu5osOECC+x9JdsxdS8VpN+ni6y1k6YvOErsmKqA@mail.gmail.com>
In-Reply-To: <CA+Px+wVQC0vu5osOECC+x9JdsxdS8VpN+ni6y1k6YvOErsmKqA@mail.gmail.com>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Fri, 3 Jul 2020 16:10:39 +0800
Message-ID: <CAGvk5PpSO5yjsvF1jq6v+EdPBvZVeEGgPJJeuixjZJ7MS-DvWg@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Log results when EC commands fail
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tzung-Bi Shih <tzungbi@google.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=883=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Jul 3, 2020 at 3:19 PM Yu-Hsuan Hsu <yuhsuan@chromium.org> wrote:
> > Log results of failed EC commands to identify a problem more easily.
> >
> > Replace cros_ec_cmd_xfer_status with cros_ec_cmd_xfer because the resul=
t
> > has already been checked in this function. The wrapper is not needed.
>
> Alternatively, you can still use cros_ec_cmd_xfer_status( ).  I guess
> it is okay to have 2 logs for an error.
>
> > diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_e=
c_codec.c
> > index 8d45c628e988e..a4ab62f59efa6 100644
> > --- a/sound/soc/codecs/cros_ec_codec.c
> > +++ b/sound/soc/codecs/cros_ec_codec.c
> > @@ -90,10 +90,17 @@ static int send_ec_host_command(struct cros_ec_devi=
ce *ec_dev, uint32_t cmd,
> >         if (outsize)
> >                 memcpy(msg->data, out, outsize);
> >
> > -       ret =3D cros_ec_cmd_xfer_status(ec_dev, msg);
> > +       ret =3D cros_ec_cmd_xfer(ec_dev, msg);
> >         if (ret < 0)
> I am thinking of if it is a better solution to print msg->result here.
The problem is the msg->result is not always meaningful.
In cros_ec_cmd_xfer_status, we know that the msg->result is meaningful
only when ret =3D=3D 0. Therefore, we can not print the msg->result
directly here.

In addition, adding a conditional operator here to check whether ret
is -EPROTO is not a good way, either.
We should consider the situation that cros_ec_cmd_xfer may return
-EPROTO directly.

>
> >                 goto error;
> >
> > +       if (msg->result !=3D EC_RES_SUCCESS) {
> > +               dev_err(ec_dev->dev, "Command %d failed: %d\n", cmd,
> > +                       msg->result);
> > +               ret =3D -EPROTO;
> > +               goto error;
> > +       }
> So that you don't need this block.
