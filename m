Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699F8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53ADE208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596556577;
	bh=r9szaxcb0fGCAe0HMLSnjnkiEt8lN82rikVx3Wzyc8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=siz4fg+yE1YCjX28EHUQlcPzo6KVNhHEj9o0y3mt8X6WtP8OjC/R/61NS+TLzUCbg
	 v/d58YlTOoze05k7Yw/8LXlIqyNSlqUKGadU8Zd3mzDIGUeWJ9WiMmrDkoHXo4sJL6
	 QdkiHywZyq10QOjNscAig1NlWyKrVNs7ZWPb4JSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgHDP4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgHDP4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:56:11 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCEF522BED;
        Tue,  4 Aug 2020 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596556571;
        bh=r9szaxcb0fGCAe0HMLSnjnkiEt8lN82rikVx3Wzyc8k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gn27xIYBRAdQ0HUbjrU0tl+T1HMHIOKi4NVP/JyyaE6gJ7Bdx/AQ+UqqHhNAgPxHU
         i+QHBYY/kYwJXZ29c9+zCWHKfuN+QTEA/tURLegO5jnKftEtEvMU94Y8SwrVDTH9kO
         7j9BEUqKjSaLkvJZ+eelyokQWgMscR0UTF6YnBWA=
Received: by mail-ed1-f44.google.com with SMTP id m20so20779504eds.2;
        Tue, 04 Aug 2020 08:56:10 -0700 (PDT)
X-Gm-Message-State: AOAM531JTRoeA4xeqB9qDGRXC1DsePAzuVzqsf5ubUeh7Hf38lewg7Lt
        7aSLXPIKZUMqwcxstzw+GtH+JC9/RM2pnsk6BA==
X-Google-Smtp-Source: ABdhPJw6PbsNIUkr8bnNDmHBfLq9tqqzI0fjOv2L1LAiywI4YCnZbHGEMCWLZ++QY9tilg2ZojDUiq6jFGbXXUGQAss=
X-Received: by 2002:a50:e109:: with SMTP id h9mr7783463edl.47.1596556569352;
 Tue, 04 Aug 2020 08:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com>
 <1596010690-13178-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_8aw=6E7bMJwz5jDLXUxYHpy9_Avbwc90osQGckzANNcg@mail.gmail.com>
 <1596427295.22971.20.camel@mtkswgap22> <CAAOTY__VPXMGcR9w8EdnGbJyVbxbLQY+SRAqLbOcTy0D_WLM0w@mail.gmail.com>
 <1596506892.17917.2.camel@mtkswgap22>
In-Reply-To: <1596506892.17917.2.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 4 Aug 2020 23:55:57 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-ndxjR1UQ4NQvxN3tVgT8t-cZb27j0U9Y7Q9CufUDc8Q@mail.gmail.com>
Message-ID: <CAAOTY_-ndxjR1UQ4NQvxN3tVgT8t-cZb27j0U9Y7Q9CufUDc8Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] soc: mediatek: add mtk-devapc driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=884=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8810:08=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 2020-08-04 at 00:04 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
> >
> > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=883=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8812:01=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Hi Chun-Kuang,
> > >
> > > On Sat, 2020-08-01 at 08:12 +0800, Chun-Kuang Hu wrote:
> > > > Hi, Neal:
> > > >
> > > > This patch is for "mediatek,mt6779-devapc", so I think commit title
> > > > should show the SoC ID.
> > >
> > > Okay, I'll change title to 'soc:mediatek: add mt6779 devapc driver'.
> > >
> > > >
> > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=882=
9=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:29=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > >
> > > > > MediaTek bus fabric provides TrustZone security support and data
> > > > > protection to prevent slaves from being accessed by unexpected
> > > > > masters.
> > > > > The security violation is logged and sent to the processor for
> > > > > further analysis or countermeasures.
> > > > >
> > > > > Any occurrence of security violation would raise an interrupt, an=
d
> > > > > it will be handled by mtk-devapc driver. The violation
> > > > > information is printed in order to find the murderer.
> > > > >
> > > > > Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> > > > > ---
> > > >
> > > > [snip]
> > > >
> > > > > +
> > > > > +struct mtk_devapc_context {
> > > > > +       struct device *dev;
> > > > > +       u32 vio_idx_num;
> > > > > +       void __iomem *devapc_pd_base;
> > > > > +       struct mtk_devapc_vio_info *vio_info;
> > > > > +       const struct mtk_devapc_pd_offset *offset;
> > > > > +       const struct mtk_devapc_vio_dbgs *vio_dbgs;
> > > > > +};
> > > >
> > > > I think this structure should separate the constant part. The const=
ant part is:
> > > >
> > > > struct mtk_devapc_data {
> > > >     const u32 vio_idx_num;
> > > >     const struct mtk_devapc_pd_offset *offset; /* I would like to
> > > > remove struct mtk_devapc_pd_offset and directly put its member into
> > > > this structure */
> > > >     const struct mtk_devapc_vio_dbgs *vio_dbgs; /* This may disappe=
ar */
> > > > };
> > > >
> > > > And the context is:
> > > >
> > > > struct mtk_devapc_context {
> > > >     struct device *dev;
> > > >     void __iomem *devapc_pd_base;
> > > >     const struct mtk_devapc_data *data;
> > > > };
> > > >
> > > > So when you define this, you would not waste memory to store non-co=
nstant data.
> > > >
> > > > static const struct mtk_devapc_data devapc_mt6779 =3D {
> > > >  .vio_idx_num =3D 510,
> > > >  .offset =3D &mt6779_pd_offset,
> > > >  .vio_dbgs =3D &mt6779_vio_dbgs,
> > > > };
> > > >
> > >
> > > Sorry, I still don't understand why this refactoring will not waste
> > > memory to store non-constant data. Could you explain more details?
> > > To my understanding, we still also have to allocate memory to store d=
ev
> > > & devapc_pd_base.
> >
> > In some situation, it is. You make the non-constant data a global
> > variable. I think the context data should be dynamic allocated. If
> > this driver is not probed, the non-constant data occupy the memory.
> >
>
> I got your point! In this case, we can save these 2 data structure
> space, right?
>
> struct device *dev;
> void __iomem *devapc_pd_base;

Right.

>
> I'll refactoring this data structures on next patch. Thanks !
>
> > Regards,
> > Chun-Kuang.
> >
> > >
> > > > Regards,
> > > > Chun-Kuang.
> > > >
> > > > > +
> > > > > +#endif /* __MTK_DEVAPC_H__ */
> > > > > --
> > > > > 1.7.9.5
> > > > > _______________________________________________
> > > > > Linux-mediatek mailing list
> > > > > Linux-mediatek@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> > >
>
