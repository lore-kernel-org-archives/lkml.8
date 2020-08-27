Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CE0C433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 23:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A53207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 23:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598571983;
	bh=WuN9B34LzV+WTdN5AAx7tMjnWGBPJVTM+zsy0W61vqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bu6PdozTVQW1+Y/OFLKykyhG+j6L/NsQu6Z4F6CtGcg0kyWo11+d4dFJxFn4Kli0/
	 AE1CBufnoGFm3h5L2jGBYRmS57nC6pR0Ib5MoHRrwYwQFt8GSKd6zyIoO64vkm/hXS
	 XU5SNL3cHjjSWwGOcJ2bztP6fSfUnAyUZwE+uX/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgH0XqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 19:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgH0XqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 19:46:22 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B0C720C09
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 23:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598571981;
        bh=WuN9B34LzV+WTdN5AAx7tMjnWGBPJVTM+zsy0W61vqI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tBi+YX5JtPQczBiO05W9F5ZP739Ts1GRyM8mvOvl/GR8Cm7ZQmsuGKUPaSTzAdU05
         wSGs1hpiFVtz1EpSoDjhL5S6gs1D3esyPeMTuMdkbpn1Dmjg60I3T79rJmgGVRtAJz
         un3M6jy9tqRSbFPbQJasWRxguUndBWATe52iDdts=
Received: by mail-ej1-f43.google.com with SMTP id o18so9961656eje.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 16:46:21 -0700 (PDT)
X-Gm-Message-State: AOAM530YPg5EVf4e9S8QqaaBwk5ErQqnh6htnTEkzHsDjrt1RIcplNer
        en3eguqAqtYLS01iQeTQM0kDGV06whN+1imbSw==
X-Google-Smtp-Source: ABdhPJwOl/tRuPJoLPgbirz4Djn6rAAeOTWUMMwHZS2nr/HOlGX4LL/IA2S6rKrQkxqp557HPNIsWsEIZg6W73JHyf8=
X-Received: by 2002:a17:906:15cc:: with SMTP id l12mr24340249ejd.7.1598571979711;
 Thu, 27 Aug 2020 16:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200819081752.4805-1-linux@fw-web.de> <20200819081752.4805-4-linux@fw-web.de>
 <trinity-14a1b182-38ab-4f84-bb72-94d448b05fd5-1597994235320@3c-app-gmx-bs37>
 <81276d4c-8883-8bfd-d7d0-9b9ac025ed97@gmail.com> <trinity-ddd51146-41eb-49ae-9456-4588450d31aa-1598535710011@3c-app-gmx-bap26>
 <e0edfd9f-5916-80ee-3bef-92d7050f97db@gmail.com>
In-Reply-To: <e0edfd9f-5916-80ee-3bef-92d7050f97db@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 28 Aug 2020 07:46:07 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9R24-tcAMSfDhxLEXDFPAbMd5fYm8EwGODDMpULq-UZA@mail.gmail.com>
Message-ID: <CAAOTY_9R24-tcAMSfDhxLEXDFPAbMd5fYm8EwGODDMpULq-UZA@mail.gmail.com>
Subject: Re: Aw: Re: [PATCH v5 3/7] drm/mediatek: disable tmds on mt2701
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Frank Wunderlich <linux@fw-web.de>,
        chunkuang Hu <chunkuang.hu@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=88=
27=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:28=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 27/08/2020 15:41, Frank Wunderlich wrote:
> > Hi Matthias,
> >
> > any opinions about the dts-changes?
> >
>
> they look good to me.
>
> > maybe series except the tmds-Patch get merged...so i add it only to my =
own repo till we find a better way?
> > currently mainline does not support hdmi at all for the board. the tmds=
-patch is only a fix for specific resolutions which have a "flickering" wit=
hout this Patch.
> >
>
> Well let's see what CK's opinion.
>

Because no one has comment on this patch, I could apply this patch but
I need you to add more experiment information so if someone meets
another bug, he could fix his bug and consider your problem.

Regards,
Chun-Kuang.

> Regards,
> Matthias
