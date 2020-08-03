Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C6CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784002068F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596470689;
	bh=/UX1OU9tHTJm7VObpjM87RBY5SlTmYFqwKSYlfihuqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X0PwujBJ7sYKLL0D2EMQIHlIQUVQsIMq3vVopp4yRMDyzHtK6nBvtPTlizLFGtMM8
	 iErJBnGLRbzQQVvWNx5AqepR2BpANlQcoU/C205LUPLmldif/rVfoRj3ETH4pWo+gX
	 MYZp4MJ4+dgl4WTjSM5S4LouBG8BYaP9g7mCCjGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgHCQEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgHCQEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:04:47 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DF23207FB;
        Mon,  3 Aug 2020 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596470685;
        bh=/UX1OU9tHTJm7VObpjM87RBY5SlTmYFqwKSYlfihuqs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Aex1PHJJaysd09vlU+np1whABVJWYO/wgGVEovV9wOg6cLl2CSU719BxSEiosliwK
         wHInjDZVIy8Mkb2GSxlkHKBZx23l5uhEGcX56SdQsqnYYjVkxSXdgN5xk9ZV3BAO+u
         ZiLZxLktesZol9ClUnGepKSVXZxgvYc2LulD6qic=
Received: by mail-ej1-f53.google.com with SMTP id qc22so24397867ejb.4;
        Mon, 03 Aug 2020 09:04:45 -0700 (PDT)
X-Gm-Message-State: AOAM533OvhGiBbd/rAPnHnPjpIPrEL4YZTN8tlWHXI1MZ5KgbS9AmxXQ
        zyBk+J+JsNuxgLhh11E+/neQjQyEtALsUOyNpg==
X-Google-Smtp-Source: ABdhPJwRrgFwRW06WGSZvbtle0QlHRJDgbphx4LdcrD/9UInwK+e+ZsDqq23da9XgbPticp6xo1sUinxOUHtS7ayNBw=
X-Received: by 2002:a17:906:7492:: with SMTP id e18mr16973100ejl.375.1596470684579;
 Mon, 03 Aug 2020 09:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com>
 <1596010690-13178-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_8aw=6E7bMJwz5jDLXUxYHpy9_Avbwc90osQGckzANNcg@mail.gmail.com>
 <1596427295.22971.20.camel@mtkswgap22>
In-Reply-To: <1596427295.22971.20.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 4 Aug 2020 00:04:30 +0800
X-Gmail-Original-Message-ID: <CAAOTY__VPXMGcR9w8EdnGbJyVbxbLQY+SRAqLbOcTy0D_WLM0w@mail.gmail.com>
Message-ID: <CAAOTY__VPXMGcR9w8EdnGbJyVbxbLQY+SRAqLbOcTy0D_WLM0w@mail.gmail.com>
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

Hi, Neal:

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=883=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8812:01=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On Sat, 2020-08-01 at 08:12 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
> >
> > This patch is for "mediatek,mt6779-devapc", so I think commit title
> > should show the SoC ID.
>
> Okay, I'll change title to 'soc:mediatek: add mt6779 devapc driver'.
>
> >
> > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:29=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > MediaTek bus fabric provides TrustZone security support and data
> > > protection to prevent slaves from being accessed by unexpected
> > > masters.
> > > The security violation is logged and sent to the processor for
> > > further analysis or countermeasures.
> > >
> > > Any occurrence of security violation would raise an interrupt, and
> > > it will be handled by mtk-devapc driver. The violation
> > > information is printed in order to find the murderer.
> > >
> > > Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> > > ---
> >
> > [snip]
> >
> > > +
> > > +struct mtk_devapc_context {
> > > +       struct device *dev;
> > > +       u32 vio_idx_num;
> > > +       void __iomem *devapc_pd_base;
> > > +       struct mtk_devapc_vio_info *vio_info;
> > > +       const struct mtk_devapc_pd_offset *offset;
> > > +       const struct mtk_devapc_vio_dbgs *vio_dbgs;
> > > +};
> >
> > I think this structure should separate the constant part. The constant =
part is:
> >
> > struct mtk_devapc_data {
> >     const u32 vio_idx_num;
> >     const struct mtk_devapc_pd_offset *offset; /* I would like to
> > remove struct mtk_devapc_pd_offset and directly put its member into
> > this structure */
> >     const struct mtk_devapc_vio_dbgs *vio_dbgs; /* This may disappear *=
/
> > };
> >
> > And the context is:
> >
> > struct mtk_devapc_context {
> >     struct device *dev;
> >     void __iomem *devapc_pd_base;
> >     const struct mtk_devapc_data *data;
> > };
> >
> > So when you define this, you would not waste memory to store non-consta=
nt data.
> >
> > static const struct mtk_devapc_data devapc_mt6779 =3D {
> >  .vio_idx_num =3D 510,
> >  .offset =3D &mt6779_pd_offset,
> >  .vio_dbgs =3D &mt6779_vio_dbgs,
> > };
> >
>
> Sorry, I still don't understand why this refactoring will not waste
> memory to store non-constant data. Could you explain more details?
> To my understanding, we still also have to allocate memory to store dev
> & devapc_pd_base.

In some situation, it is. You make the non-constant data a global
variable. I think the context data should be dynamic allocated. If
this driver is not probed, the non-constant data occupy the memory.

Regards,
Chun-Kuang.

>
> > Regards,
> > Chun-Kuang.
> >
> > > +
> > > +#endif /* __MTK_DEVAPC_H__ */
> > > --
> > > 1.7.9.5
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
