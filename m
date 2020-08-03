Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B1CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0594E2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596469103;
	bh=VGGeypM3Y8d4rW8Akt3xtmhJwtC3U7dVg9Cx0Njqevg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PYB3NsLR/Ej8TGTTVHQCrfCJ+Kl7fpjCxbUj43N8yGp95yt8uOewEJ4/rzwgdg35e
	 KU6bUwun54Vye7p7OPQnYYpMQ3Qx7LOq7G8vzJb7zO/Ls3JBQKQ2xyWWNCv7GisCWm
	 Hnfhlsta6uwftnlFbZ4oeObQaXkZmGxJgThQMW2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHCPiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:38:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgHCPiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:38:22 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D3422076C;
        Mon,  3 Aug 2020 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596469100;
        bh=VGGeypM3Y8d4rW8Akt3xtmhJwtC3U7dVg9Cx0Njqevg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pC/KVE5SCSZWrzVR8rov+RgaeDIeFWUHety8ET9Hg7JeRcy9gSf4G+AQ0onwO00Ew
         QXaBBP0qFAKninI1M7yRvb3Og9QlNns1KhGmBNS9JE1PykiuedRdGXu1iQrDTY1r3e
         kQAR4HGgKjBHHfLgTivocZk47DnNmusgrBgdY+/s=
Received: by mail-ej1-f41.google.com with SMTP id o18so39081640eje.7;
        Mon, 03 Aug 2020 08:38:21 -0700 (PDT)
X-Gm-Message-State: AOAM531gd7hUqX/aO13XUsU8jFNkJ4zT1l82/S1CfQSiaiXHOg+sJUh+
        RvdVpXZ+4o0WnM6Yyb9JvJoIuuaZapyYYAodIQ==
X-Google-Smtp-Source: ABdhPJx0djev732p1WU9SALM5bkMkTGBFI5wI7IhthD/RGPTy0cqLYgXOMTgB1GPtG3Sq1pVIonzpFw17wCZyky8cuc=
X-Received: by 2002:a17:906:f14f:: with SMTP id gw15mr16562338ejb.245.1596469100238;
 Mon, 03 Aug 2020 08:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com>
 <1596010690-13178-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_-RMT-1+-5aPxqhgLbk74j0MH8U78mibBZppt_OPPQrJA@mail.gmail.com>
 <1596427546.22971.23.camel@mtkswgap22>
In-Reply-To: <1596427546.22971.23.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 3 Aug 2020 23:38:07 +0800
X-Gmail-Original-Message-ID: <CAAOTY__Jc2eGCA6JqYnLCZCTYz40GBmyhiZqzMxTfj9F9xTdoQ@mail.gmail.com>
Message-ID: <CAAOTY__Jc2eGCA6JqYnLCZCTYz40GBmyhiZqzMxTfj9F9xTdoQ@mail.gmail.com>
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=883=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8812:05=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On Sun, 2020-08-02 at 07:50 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
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
> >
> > This is devapc context, so prefix 'devapc' is redundant.
> > And, what does 'pd' mean?
>
> 'pd' means power down. Of course we would also remove it as well.
> I suggest to change it as 'infra_base'.

This is OK for me.

>
> >
> > Regards,
> > Chun-Kuang.
> >
> > > +       struct mtk_devapc_vio_info *vio_info;
> > > +       const struct mtk_devapc_pd_offset *offset;
> > > +       const struct mtk_devapc_vio_dbgs *vio_dbgs;
> > > +};
> > > +
>
