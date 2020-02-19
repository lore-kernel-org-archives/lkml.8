Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64FDC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C27620801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzcA9hwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgBSK3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:29:38 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42552 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgBSK3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:29:38 -0500
Received: by mail-vs1-f67.google.com with SMTP id b79so14728511vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 02:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N/FWsOslLeWJ8wc9PPiLEWzxti0Lz4tyLMKB84GK8Qg=;
        b=zzcA9hwk8oBqEzK/Sk5smaykWWWhkqLgdN2ggNaL0cspzNwa1q+GoinNOOoh2h9V51
         Lv7ZUcQx+nj4ydcgo+MumePOIXyd+adldZYvoZGHUzMACLER4enSZC94mRb28MJr6c1A
         J0zDWaHD7YQ525Kl6Y1gatEtQ406L9F6WgmgJkakqPk8Q+C9ZZgLDbcn0PVAxkoeaFBp
         u1Zh99N7KbfqvYQDnfJFNmIip0HZ15FT2UcLc3U/w813BeSgu1q8swKVqPbRLuHM9XJ3
         Uxz065dq2yY9KSl+injyEt5q+2tCcO4d067fxfYm7S/GKS+XZflxxlWeTWxnoNcErJqI
         wpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N/FWsOslLeWJ8wc9PPiLEWzxti0Lz4tyLMKB84GK8Qg=;
        b=MeKWpMJQJ6KoUy8dmN+nWjLEERrbKo5apubV1r4jtV7n1jCNyd/8m5H3oaMYKYPN+W
         D0a9Zn7CWu0UQdY7UiGXz0tXlzehM230jsTDyjxJuFFqLtW6IM1XHtNwzbSSFW0UTsQe
         vHe8oXFG6LWtmuAAtt6MsmGI6l68ily808unUwZkq0NCHixNlNDL2TucyxzI7t3Cdwsk
         XzxlLUXLMsDjgNigA1dD190I6AIHy1BSrZ36QVJbFfwav0cz0HMSP4nn4c1ju0oO6nFr
         ZvoFsl6l86Ot3dXjINjkzExLhJ4JLAD2kU9AusJZqN9XX8bdJHVfVCZGTzB2EZdcBvvu
         KbaQ==
X-Gm-Message-State: APjAAAWxle6CW0+csjYh0LJ82aCDX/PZBA5tVf0qx4QZ+bIjDIHA4dJo
        d7RiZ1cmo5ZPXjNnPUsFNlOeBca2L5cHf3B7sAIkaQ==
X-Google-Smtp-Source: APXvYqwdd1WVvropN/Ah9GWZ4j1iP+qWglk6pATFnqpFpANspIETm+lPq1ohJHYuPnh9a1IcHgjcTAcwzRPQ36OkB7Q=
X-Received: by 2002:a67:5e45:: with SMTP id s66mr13897757vsb.200.1582108175469;
 Wed, 19 Feb 2020 02:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20200128090636.13689-1-ludovic.barre@st.com> <20200128090636.13689-10-ludovic.barre@st.com>
 <853f4b14-a188-f329-34e5-8e88fcafa775@st.com>
In-Reply-To: <853f4b14-a188-f329-34e5-8e88fcafa775@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Feb 2020 11:28:59 +0100
Message-ID: <CAPDyKFrKunZ1nDiSR-6ZgZNxkxs=_R-i3N9QWNovnZ4iY=DP=g@mail.gmail.com>
Subject: Re: [PATCH V2 9/9] mmc: mmci: add sdmmc variant revision 2.0
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020 at 15:44, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf
>
> Le 1/28/20 =C3=A0 10:06 AM, Ludovic Barre a =C3=A9crit :
> > This patch adds a sdmmc variant revision 2.0.
> > This revision is backward compatible with 1.1, and adds dma
> > link list support.
> >
> > Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> > ---
> >   drivers/mmc/host/mmci.c | 30 ++++++++++++++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> >
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index 24e630183ed4..a774c329c212 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -275,6 +275,31 @@ static struct variant_data variant_stm32_sdmmc =3D=
 {
> >       .init                   =3D sdmmc_variant_init,
> >   };
> >
> > +static struct variant_data variant_stm32_sdmmcv2 =3D {
> > +     .fifosize               =3D 16 * 4,
> > +     .fifohalfsize           =3D 8 * 4,
> > +     .f_max                  =3D 208000000,
> > +     .stm32_clkdiv           =3D true,
> > +     .cmdreg_cpsm_enable     =3D MCI_CPSM_STM32_ENABLE,
> > +     .cmdreg_lrsp_crc        =3D MCI_CPSM_STM32_LRSP_CRC,
> > +     .cmdreg_srsp_crc        =3D MCI_CPSM_STM32_SRSP_CRC,
> > +     .cmdreg_srsp            =3D MCI_CPSM_STM32_SRSP,
> > +     .cmdreg_stop            =3D MCI_CPSM_STM32_CMDSTOP,
> > +     .data_cmd_enable        =3D MCI_CPSM_STM32_CMDTRANS,
> > +     .irq_pio_mask           =3D MCI_IRQ_PIO_STM32_MASK,
> > +     .datactrl_first         =3D true,
> > +     .datacnt_useless        =3D true,
> > +     .datalength_bits        =3D 25,
> > +     .datactrl_blocksz       =3D 14,
> > +     .datactrl_any_blocksz   =3D true,
> > +     .stm32_idmabsize_mask   =3D GENMASK(16, 5),
> > +     .dma_lli                =3D true,
> > +     .busy_timeout           =3D true,
>
> I forget "busy_detect           =3D true," property
> I add this in next patch set

No need for a re-send, I amended this when I applied it.

>
> > +     .busy_detect_flag       =3D MCI_STM32_BUSYD0,
> > +     .busy_detect_mask       =3D MCI_STM32_BUSYD0ENDMASK,
> > +     .init                   =3D sdmmc_variant_init,
> > +};
> > +
> >   static struct variant_data variant_qcom =3D {
> >       .fifosize               =3D 16 * 4,
> >       .fifohalfsize           =3D 8 * 4,
> > @@ -2343,6 +2368,11 @@ static const struct amba_id mmci_ids[] =3D {
> >               .mask   =3D 0xf0ffffff,
> >               .data   =3D &variant_stm32_sdmmc,
> >       },
> > +     {
> > +             .id     =3D 0x00253180,
> > +             .mask   =3D 0xf0ffffff,
> > +             .data   =3D &variant_stm32_sdmmcv2,
> > +     },
> >       /* Qualcomm variants */
> >       {
> >               .id     =3D 0x00051180,
> >

Kind regards
Uffe
