Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A72C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 00:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00FA320838
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 00:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596240791;
	bh=n7WNIjd113yI4hTkSUhS0MieCDn0mYiulcZegXarHiQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qL+IDkX+yLXLJ/Zabl1HJwvQ0OP/pADkrdz8LM9NziGao7Cg8NrWu2d92mGseCil1
	 PzmoafYfWO6B/PC7cPEaG5azs0rpO7yF5BvqB1aBqbWDybfD27xcu0QkRRfsuVTK6k
	 FvTABunJvIZtK/dH6G1O9cnzR43qXKzAEmo7kjzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgHAANJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 20:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgHAANJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 20:13:09 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD07320838;
        Sat,  1 Aug 2020 00:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596240789;
        bh=n7WNIjd113yI4hTkSUhS0MieCDn0mYiulcZegXarHiQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cwTK4nTdLjiSBKaFyrshHnlaq/mhK5249QxAYMkm0Wg4Lora9fjbCpn/V3wEf8MRk
         Q1alTIeZXZNLduDsnZT+c0hZDBCsfgI0o5HH9F9ZSa2o4NduJIN5mtpHKGZRuptS6k
         fCYMzf7cgUiskfH/b6FgOwLahq+30cwi7SiITHus=
Received: by mail-ed1-f46.google.com with SMTP id c15so13813478edj.3;
        Fri, 31 Jul 2020 17:13:08 -0700 (PDT)
X-Gm-Message-State: AOAM531fL8KSSEvQ1xg0HK9ehWV/3UYx2oghVewFonSCUBiGsXjY9wnl
        hAvBPc/Dap7Y44IN1YajwMzTKDdKzyt3SztoHg==
X-Google-Smtp-Source: ABdhPJwefFzeSQPuG9/zk5h5dJ0CnlevRnNRHabHnVcRCbp4uOMwHYFc8O2rJIMyRTAv+YG2GQmp5ufza+VEsIYo0t4=
X-Received: by 2002:a50:ccd0:: with SMTP id b16mr6220123edj.148.1596240787508;
 Fri, 31 Jul 2020 17:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com> <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 1 Aug 2020 08:12:56 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8aw=6E7bMJwz5jDLXUxYHpy9_Avbwc90osQGckzANNcg@mail.gmail.com>
Message-ID: <CAAOTY_8aw=6E7bMJwz5jDLXUxYHpy9_Avbwc90osQGckzANNcg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] soc: mediatek: add mtk-devapc driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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

This patch is for "mediatek,mt6779-devapc", so I think commit title
should show the SoC ID.

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8829=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:29=E5=AF=AB=E9=81=93=EF=BC=9A
>
> MediaTek bus fabric provides TrustZone security support and data
> protection to prevent slaves from being accessed by unexpected
> masters.
> The security violation is logged and sent to the processor for
> further analysis or countermeasures.
>
> Any occurrence of security violation would raise an interrupt, and
> it will be handled by mtk-devapc driver. The violation
> information is printed in order to find the murderer.
>
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---

[snip]

> +
> +struct mtk_devapc_context {
> +       struct device *dev;
> +       u32 vio_idx_num;
> +       void __iomem *devapc_pd_base;
> +       struct mtk_devapc_vio_info *vio_info;
> +       const struct mtk_devapc_pd_offset *offset;
> +       const struct mtk_devapc_vio_dbgs *vio_dbgs;
> +};

I think this structure should separate the constant part. The constant part=
 is:

struct mtk_devapc_data {
    const u32 vio_idx_num;
    const struct mtk_devapc_pd_offset *offset; /* I would like to
remove struct mtk_devapc_pd_offset and directly put its member into
this structure */
    const struct mtk_devapc_vio_dbgs *vio_dbgs; /* This may disappear */
};

And the context is:

struct mtk_devapc_context {
    struct device *dev;
    void __iomem *devapc_pd_base;
    const struct mtk_devapc_data *data;
};

So when you define this, you would not waste memory to store non-constant d=
ata.

static const struct mtk_devapc_data devapc_mt6779 =3D {
 .vio_idx_num =3D 510,
 .offset =3D &mt6779_pd_offset,
 .vio_dbgs =3D &mt6779_vio_dbgs,
};

Regards,
Chun-Kuang.

> +
> +#endif /* __MTK_DEVAPC_H__ */
> --
> 1.7.9.5
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
