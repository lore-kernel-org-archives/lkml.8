Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A06C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8922078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597966158;
	bh=bKIvHzrlFLAY5vwtgGAdC1wJCyUfAnJFseoDMgzigx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MZehBVDH4nruwu4DX0bCGZyKhsXbmDAheFhtVzsq4TYLAUP0XVblKj8tlAliLDxEb
	 WhsUj6FF2Znt02S1OpFv8dvK7+yCjLCEPNuuDY+0pa/rpYiusk7QPlCPFIYcoJHHia
	 p1sPhQDyRxuU1ko1FdkvSKMJz9vlMIt9kZ65bPNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgHTX3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbgHTX3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:29:17 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81EBA21775
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597966156;
        bh=bKIvHzrlFLAY5vwtgGAdC1wJCyUfAnJFseoDMgzigx8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b+bEnNLE6+HsWq7x5OSDXaMkftNAz4NFkwWLXj7ccDE94t43MARMMjC3J94xYQmsA
         f6D6XYta+/yyG4M3BjviD5IKk89CnoRql9WFbfQERyU6olplbfAeu88OQp3G0va2rJ
         bGU2Yp698SHeTgNFdhjPMsDKfzOGkI9IEw9Tczno=
Received: by mail-ed1-f43.google.com with SMTP id l23so2976235edv.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:29:16 -0700 (PDT)
X-Gm-Message-State: AOAM531fPY3svd0ESd4CvWkanPIsoF8eSsqJjymwHy07ynU+7EnL2xMt
        mKikyGJfhKRaX1RtnlERDpES2Dz91JhvPncpjg==
X-Google-Smtp-Source: ABdhPJxnbCezgbtFQptt9Mtdn2+1CJtKJfQTBL+lG8Rgr+Qfl6BIxij5gSLnal0+cXbH0RS4NEWuTAiH8SrgPMLvX0g=
X-Received: by 2002:aa7:c606:: with SMTP id h6mr278114edq.288.1597966155156;
 Thu, 20 Aug 2020 16:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200819154421.7013-1-chunkuang.hu@kernel.org>
 <20200819154421.7013-4-chunkuang.hu@kernel.org> <919b4b36-8deb-dfbe-81fe-c12f8da65dac@infradead.org>
In-Reply-To: <919b4b36-8deb-dfbe-81fe-c12f8da65dac@infradead.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 21 Aug 2020 07:29:03 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9NOFyxGzvmHPo_6Oqm2AvZSJczC26GzZqC9EVJ=cqy7A@mail.gmail.com>
Message-ID: <CAAOTY_9NOFyxGzvmHPo_6Oqm2AvZSJczC26GzZqC9EVJ=cqy7A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] phy: mediatek: Move mtk_hdmi_phy driver into
 drivers/phy/mediatek folder
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Randy:

Randy Dunlap <rdunlap@infradead.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:00=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 8/19/20 8:44 AM, Chun-Kuang Hu wrote:
> > diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfi=
g
> > index dee757c957f2..10f0ec2d5b54 100644
> > --- a/drivers/phy/mediatek/Kconfig
> > +++ b/drivers/phy/mediatek/Kconfig
> > @@ -35,3 +35,10 @@ config PHY_MTK_XSPHY
> >         Enable this to support the SuperSpeedPlus XS-PHY transceiver fo=
r
> >         USB3.1 GEN2 controllers on MediaTek chips. The driver supports
> >         multiple USB2.0, USB3.1 GEN2 ports.
> > +
> > +config PHY_MTK_HDMI
> > +    tristate "MediaTek HDMI-PHY Driver"
> > +    depends on ARCH_MEDIATEK && OF
> > +    select GENERIC_PHY
> > +    help
> > +          Enable this to support HDMI-PHY
>
> Fix indentation above.
>

OK,

Regards,
Chun-Kuang.

> thanks.
> --
> ~Randy
>
