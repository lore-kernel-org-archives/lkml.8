Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679C1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E4E207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuBEyfGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbgFPSBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730823AbgFPSBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:01:17 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDC1C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:01:16 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id d67so20038762oig.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgZ/XoQ64awNfeRabXBKQp1DrgKmmqukpGMGvJR38Xk=;
        b=TuBEyfGOsjP2n116q5v6t3QrerQ9ug/HfGwCnWfT0pegZ2gnRoGwNWLeaHaAPA4fKT
         ZN9V/ILRPj/LpWI6wiR+rwyqidjH60mPpFa0fqZFlt7Qysr1HNsWItP2yl5FMFE74uiR
         kwQaTrX0aeMb7i+2aVVHfhMg9t+dacsYrWUPGqDJzS1V1CxpLY3AIS23JwcaejBU2UGs
         KrAcEbUZ5OW0Wg9PDeEDdlRX6QQrFOdBbmuqTPSWNjGJ7z9qzU7u64uqKeqZXxdm72Vs
         c30lpVzUqDFeS+ZaXGYjfVynGXL7TuBXYyTS16O32LIwQJAjl/VUPUP0kpXOYJL/0PZo
         hj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgZ/XoQ64awNfeRabXBKQp1DrgKmmqukpGMGvJR38Xk=;
        b=kIwvDoor0eZuA8z7yJJcy2RC/Yp9r84cQcQAss1FD8Z9lg2eVAH1MkAomEy0fVreh6
         ZV8qeQsGFq0vfPiOeP+wETje52zAiU87ImsEOhVwcXPXKLzKw+zCk75OOqL8p8Q96xdm
         rQaON6xIdkHyFoC1AZimD3evwrlQl+9QHwG+mD+3dG9uQDE5/gcs3JuyXdWw8m/JKhzx
         mI+7IWyZqN1vpaNO7UVSxtR6QAVIrjPnwV9836qrTKy75HZPQjsOcwG5x2TFya7y0UFv
         Cgfa7qI2gcHdkBCM3F+RXfizR45QRXYR0tZ5Uduq5/Zep7mv0PHNhjeDHkXpnkwORnTy
         ZCGw==
X-Gm-Message-State: AOAM532izSRTmNRbJ3FJ/0R30vVCGSvwBILW3Bw1Wn05fiAIoL38nBxV
        XVfvrTh+O395z/MwM4UpFBQHN561WAxBgJ1ApZpb9w==
X-Google-Smtp-Source: ABdhPJwCMY2BCv+SW9qiOfPCgfX5ll96BrmVpQuKJWGEA0auXyzgdvga0VidL8pRv3v7D4D1zuMjJNfmX1WfAw9ZflE=
X-Received: by 2002:aca:2108:: with SMTP id 8mr4531179oiz.10.1592330474306;
 Tue, 16 Jun 2020 11:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200616063417.110263-1-john.stultz@linaro.org> <8f7f563b-fae7-e25e-33f2-18c608c338e6@linaro.org>
In-Reply-To: <8f7f563b-fae7-e25e-33f2-18c608c338e6@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 16 Jun 2020 11:01:02 -0700
Message-ID: <CALAqxLXnijNBB4HBqLG4k679FRcHT8hjSLMnpjE_+0UkqU7Y0w@mail.gmail.com>
Subject: Re: [RESENDx2][PATCH] sound: qcom: Kconfig: Tweak dependencies on SND_SOC_SDM845
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 1:25 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> On 16/06/2020 07:34, John Stultz wrote:
> > CROS_EC isn't strictly required for audio to work
> > on other SDM845 platforms (like the Dragonboard 845c).
> >
> > So lets remove the dependency and select the related
> > CROS_EC options if CROS_EC is already enabled.
>
> Sorry John, totally missed this one out!

No worries!

> > diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> > index f51b28d1b94d..0434f2c7d746 100644
> > --- a/sound/soc/qcom/Kconfig
> > +++ b/sound/soc/qcom/Kconfig
> > @@ -99,12 +99,12 @@ config SND_SOC_MSM8996
> >
> >   config SND_SOC_SDM845
> >       tristate "SoC Machine driver for SDM845 boards"
> > -     depends on QCOM_APR && CROS_EC && I2C && SOUNDWIRE
> > +     depends on QCOM_APR && I2C && SOUNDWIRE
> >       select SND_SOC_QDSP6
> >       select SND_SOC_QCOM_COMMON
> >       select SND_SOC_RT5663
> >       select SND_SOC_MAX98927
> > -     select SND_SOC_CROS_EC_CODEC
> > +     select SND_SOC_CROS_EC_CODEC if CROS_EC
>
> Isn't "imply SND_SOC_CROS_EC_CODEC" better option here?

I've honestly not gotten my head around "imply", so I'll have to take
a closer look.
What I have in this patch least is easier to compare and match with
the existing code. :)

Thanks for the feedback!
-john
