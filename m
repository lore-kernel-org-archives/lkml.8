Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F74C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D8820658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597102526;
	bh=mUFFmkou94l0+oI7TalaQjtTqBSFTvrCHtwnmz6LL0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IDnLzedr4dnvBK/VGnN63L008A+8U7pt/Y+eAzgdQQEfCvh+lz8nnj8iBayXwmnR5
	 AdG/NurJg7Ife/MsOi7Kt/rnltlhSbCQKKJD0itJ3/wPrhmFj35PsNjrEBEFkMlaW3
	 LURK/D6kRBYa5mHzQnuNGQhkQDOKh6N8EgwsH2is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgHJXfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 19:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbgHJXfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:35:25 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8014E2075D;
        Mon, 10 Aug 2020 23:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597102524;
        bh=mUFFmkou94l0+oI7TalaQjtTqBSFTvrCHtwnmz6LL0A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vBW9u2mlbk5HoC5arbS7XOKaq/n3mNVP07JZtF9T6scT1DVVIeBJqU1VYp5xuk/Yn
         4FBVO3aOU5SVhzZLb1x+ovVr9CuYnZuaAJAbppWuHOUphiM+H4QnI3UuYWb5JrcMPm
         L/7l50z+giBwjQtpb4bayVeukl18kzJK9afq3cWY=
Received: by mail-ej1-f43.google.com with SMTP id a26so11151962ejc.2;
        Mon, 10 Aug 2020 16:35:24 -0700 (PDT)
X-Gm-Message-State: AOAM533ooCUsnP8767vqt83ho+APFWpB77Ot4DJTW9IrKp6BFUSzPqw2
        L22nHiKVfxPmP8Cz1IQuYA1J32PbQfiCb+oDlQ==
X-Google-Smtp-Source: ABdhPJwBk2x2WfFrL8VJcib6l0+cEkseFLtLxcww+LQRp8tRkSoMlZaGe/disJzE6QbWTXApPzJSvByWzdkYXp0Lx7g=
X-Received: by 2002:a17:906:2356:: with SMTP id m22mr23377263eja.124.1597102523075;
 Mon, 10 Aug 2020 16:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com> <1596855231-5782-4-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1596855231-5782-4-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 11 Aug 2020 07:35:10 +0800
X-Gmail-Original-Message-ID: <CAAOTY____7Yd1Gh-22oiOxsvftBjOHQ0T9CmKtGw6XLjw11gcQ@mail.gmail.com>
Message-ID: <CAAOTY____7Yd1Gh-22oiOxsvftBjOHQ0T9CmKtGw6XLjw11gcQ@mail.gmail.com>
Subject: Re: [RESEND v7, PATCH 3/7] mtk-mmsys: add mmsys private data
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=888=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8810:56=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> the reason why split out display connection function:
> 1. there will more and more Mediatek Soc upstream, and the display path
> connection function mtk_mmsys_ddp_mout_en, mtk_mmsys_ddp_sel_in and
> mtk_mmsys_ddp_sout_sel will complicated more and more
> 2. many of the connection are only used in some SoC, and useless for
> other SoC and not readable,
> 3. if we add a new SoC connection, we need check is this affect other
> Soc
>
> the reason why not apply the previous series method:
> this version is more readable and clear
> if go on use v6, except mt2701/mt8173/mt2712, we need add two more
> private data array for mt6779 and mt6797, and the connect function
> will add more if/else usecase
>
> move current display connection function into mt2701-mmsys.c
> keep mt2701/mt8173/mt2712/mt6779/mt6797 with original version
> connection function
> the corresponded SoC upstream member will coding these and test it
> on the SoC if it is need.
>

For this patch, I prefer [1]'s implementation. In [1], for each SoC,
the only difference is an array for routing register setting. In this
patch, the difference are three function which is more complicated
than [1]. If you like, you could pick [1] to upstream.

[1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/2345186

Regards,
Chun-Kuang.

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/soc/mediatek/Makefile             |   1 +
>  drivers/soc/mediatek/mmsys/Makefile       |   2 +
>  drivers/soc/mediatek/mmsys/mt2701-mmsys.c | 250 ++++++++++++++++++++++++=
+++
>  drivers/soc/mediatek/mtk-mmsys.c          | 271 +++++-------------------=
------
>  include/linux/soc/mediatek/mtk-mmsys.h    |  15 ++
>  5 files changed, 314 insertions(+), 225 deletions(-)
>  create mode 100644 drivers/soc/mediatek/mmsys/Makefile
>  create mode 100644 drivers/soc/mediatek/mmsys/mt2701-mmsys.c
>
