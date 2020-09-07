Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E91C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 305EC21927
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599519415;
	bh=NSfi6wd9qqZTJhGfu2dBWUH/ZuOy9FYmKPjqOXlrGdY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PhY1+XZ3m/MqLVIRLoUGXkFAjstjT/kDYlhGSvNbV8U10EQTjG6ru8FPTakoTRrEu
	 jGZTiMzf89N2xP8F3YNh3+skT+Gep+IO4jvIw+ePBKDMw94J9mpjXsqasqF55gQr80
	 woXOdjuIhojJM92x/5pysn+OvpFrpp3AdYLUWhWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgIGW4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 18:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgIGW4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 18:56:51 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D04A2193E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 22:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599519411;
        bh=NSfi6wd9qqZTJhGfu2dBWUH/ZuOy9FYmKPjqOXlrGdY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DYL874Ft8lJajzJzSkE08InkYufgly609Dly2f3AmCFg0kllg6SfudOSXe7qRMWqI
         xAJPQVXK02BLjsfoDOaCNPQJIOwBt85PQQ+6cOclK8lu1CxEiMMxAwcxMiDFBc1SXZ
         1Pahyg0bnLv9oV4C/+D8CSqc7CPBTzlO8tk79p0w=
Received: by mail-ed1-f52.google.com with SMTP id t16so9247361edw.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 15:56:50 -0700 (PDT)
X-Gm-Message-State: AOAM531jhAQ85CylLCInTiNnR/qlZldyr5neRdOdsK+g2ff/VJF4hwrS
        iotxGLt35sBriIsSiRX8ReRmNeQx4UmIpUE5TQ==
X-Google-Smtp-Source: ABdhPJy5CZYbL8ciYgmudWTBCh6+c6fY0KeeVANf0EFcV7pTO+zprkngyGmaklVX6wbgwtJoJPgINeDzP7xumcmZZLw=
X-Received: by 2002:a05:6402:1451:: with SMTP id d17mr23241583edx.48.1599519409620;
 Mon, 07 Sep 2020 15:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200905083058.1631726-1-yukuai3@huawei.com>
In-Reply-To: <20200905083058.1631726-1-yukuai3@huawei.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 8 Sep 2020 06:56:36 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-BQx0rozw0qoGj1bt4hO2rFmYvKrjQHbA-K04txUWW+w@mail.gmail.com>
Message-ID: <CAAOTY_-BQx0rozw0qoGj1bt4hO2rFmYvKrjQHbA-K04txUWW+w@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: add missing put_device() call in mtk_ddp_comp_init()
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yt.shen@mediatek.com, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu Kuai:

Yu Kuai <yukuai3@huawei.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=885=E6=97=A5 =
=E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=884:31=E5=AF=AB=E9=81=93=EF=BC=9A
>
> if of_find_device_by_node() succeed, mtk_ddp_comp_init() doesn't have
> a corresponding put_device(). Thus add put_device() to fix the exception
> handling for this function implementation.
>

This patch looks good to me, but I find another thing related to this.
mtk_ddp_comp_init() is called in a loop in mtk_drm_probe(), when this
component init fail, I think we should uninitialize previous
successive init component and put their device. Would you like to make
this patch more complete?

Regards,
Chun-Kuang.

> Fixes: d0afe37f5209 ("drm/mediatek: support CMDQ interface in ddp compone=
nt")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 57c88de9a329..526648885b97 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -496,6 +496,7 @@ int mtk_ddp_comp_init(struct device *dev, struct devi=
ce_node *node,
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         if (of_address_to_resource(node, 0, &res) !=3D 0) {
>                 dev_err(dev, "Missing reg in %s node\n", node->full_name)=
;
> +               put_device(&larb_pdev->dev);
>                 return -EINVAL;
>         }
>         comp->regs_pa =3D res.start;
> --
> 2.25.4
>
