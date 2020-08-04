Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92687C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77685207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596553358;
	bh=iTbEpo6hT4ij3tiFeBOJjmAYZg4kRV7aj9Emq+WzyNA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QxyWKqeqbrfTmfUl2nqD3vOsyq0pHgdr1lsypXI9CC0JrLcv9BeBNQSTYrT59DkEb
	 /xQSu11SPYB4KOCsb3MlSMOCm2jp0y0G+C4+R+Ka+Z+PqkcgPrkBklBH4TI7q9pAG9
	 vh7eKiIip40LFpxQto1EqakUX1g6IQmLIt/Jj4Ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgHDPBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbgHDPBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:01:24 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8968822CB3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596553274;
        bh=iTbEpo6hT4ij3tiFeBOJjmAYZg4kRV7aj9Emq+WzyNA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y6jdF2/fPzm+oVlUu5TOqjL6vqTqk7bQIiPhw6vpc9F+Oeoa+Xm2x90VbQrFtJOhL
         ja7uWx9kM2sRjjqjFYipGu8Xwlp99RV1VnwQ04/TRnyC7Xp+3IWEpcmBPyf3SdWasN
         LpyZ5WRrTa1743/14iEjpAOXEs2BrctkqzUOBOVI=
Received: by mail-ej1-f46.google.com with SMTP id f24so22295270ejx.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 08:01:14 -0700 (PDT)
X-Gm-Message-State: AOAM531Zee1b5ac28saXF8edL45quZuyySxu+6IyRD6Tbpip/EDVajcL
        RIJC41CTttEsY8/CH3pkX9nv7bdWJtSwPls8qA==
X-Google-Smtp-Source: ABdhPJzJB/NAHbkY8K8FLXLQQxOKbF0xJx2EWEaw7fMZkjsTp92jQYxuFQfO/ANYXKnrA0eT795Wd5eXvPx0hCw5G9Q=
X-Received: by 2002:a17:906:60d5:: with SMTP id f21mr1337420ejk.94.1596553273100;
 Tue, 04 Aug 2020 08:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200804105849.70876-1-linux@fw-web.de> <20200804105849.70876-2-linux@fw-web.de>
 <CAAOTY_94Kt3Z4FhB+1Chca-tanzY1Xwun8D2ZQ09Y7p7+Jw40Q@mail.gmail.com> <trinity-5e5aa82a-c026-4138-9f33-d3776710eb47-1596552262328@3c-app-gmx-bap28>
In-Reply-To: <trinity-5e5aa82a-c026-4138-9f33-d3776710eb47-1596552262328@3c-app-gmx-bap28>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 4 Aug 2020 23:01:01 +0800
X-Gmail-Original-Message-ID: <CAAOTY__0HjikMH1iTJOkvt6fYXSao75GQQbVPL75vmVn+hpp5g@mail.gmail.com>
Message-ID: <CAAOTY__0HjikMH1iTJOkvt6fYXSao75GQQbVPL75vmVn+hpp5g@mail.gmail.com>
Subject: Re: Re: [PATCH v3 1/5] drm: mediatek: add ddp routing for mt7623
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Frank Wunderlich <linux@fw-web.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Wunderlich <frank-w@public-files.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=884=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:44=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi,
>
> > Gesendet: Dienstag, 04. August 2020 um 16:34 Uhr
> > Von: "Chun-Kuang Hu" <chunkuang.hu@kernel.org>
>
> > > -static const enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] =3D {
> > > +static enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] =3D {
> >
> > Why do you remove 'const'?
>
> was removed by previous patch and not re-added (revert failed), sorry. wi=
ll fix in next version, if all other is ok.

all other is ok.

Regards,
Chun-Kuang.

>
> regards Frank
