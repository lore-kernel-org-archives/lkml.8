Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7941DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 00:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5758A206B5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 00:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596933428;
	bh=OwZbj9j2fVznBXJWG+kGBBS6B2y4BHwVj3nvv2bUc+o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GHIQUTc+zTH6y1+gvf4uDdUHaE8rJVGNZ7AuZ3S+Dr5utOZEuCd4B7g4cpEHyfk2P
	 6HkokheyqAw5UC2z0IQ8gBTs2nIvX2E09kySwPtowREd58a1ioc4jPCPJ3UaFg8f0j
	 JN+FKBMXTgaKs9XxIMxXTSn54WSU0BTIamsVWvYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgHIAhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 20:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgHIAhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 20:37:06 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 190C9206D8;
        Sun,  9 Aug 2020 00:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596933425;
        bh=OwZbj9j2fVznBXJWG+kGBBS6B2y4BHwVj3nvv2bUc+o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TlFTbbMV/k+o66PWyKj3MJLo37tNkgYDcrrUiK+N73KaD55/NMcj9yl4sXEqJV+Ve
         8sU2kjCPKUYEX7g0XgGoRl8cq5fnESFhrnVv4Z+af7+hm6EgI9NLQlKLqlzc+cFXLT
         /NFLdgtWCZuXa/8F1GZhNh0CeqKGSZRSA133jfII=
Received: by mail-ej1-f49.google.com with SMTP id o23so5883887ejr.1;
        Sat, 08 Aug 2020 17:37:05 -0700 (PDT)
X-Gm-Message-State: AOAM532TPaFDjnLnLocy1y2clMYxexZzYeQWFmaAC4ndhpF8N7a86J3C
        3KeaWHCCmldVXRvtm1kexgfVCUSuJKDjWqfPfg==
X-Google-Smtp-Source: ABdhPJyRhNiwUtOdFe5BV5TXi2CdPsenCRK7yZwtV8dYfmYgEntYLcapnDUx1Pn9vQyDNpXrZ1cECP5wWDwV76cWsVI=
X-Received: by 2002:a17:906:12d8:: with SMTP id l24mr4040593ejb.260.1596933423727;
 Sat, 08 Aug 2020 17:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 9 Aug 2020 08:36:52 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8nE4mHq0O2hnqr7+ooKSPS-O2CB6MprODF95gEJB_naQ@mail.gmail.com>
Message-ID: <CAAOTY_8nE4mHq0O2hnqr7+ooKSPS-O2CB6MprODF95gEJB_naQ@mail.gmail.com>
Subject: Re: [RESEND v7, PATCH 0/7] add drm support for MT8183
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

This series is 'v8', not 'RESEND v7'

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=888=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8810:56=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This series are based on 5.8-rc1 and provide 7 patch
> to support mediatek SOC MT8183
>
> Change since v6
> - move ddp component define into mtk_mmsys.h
> - add mmsys private data to support different ic path connection
> - add mt8183-mmsys.c to support 8183 path connection
> - fix reviewed issue in v6
>
> Change since v5
> - fix reviewed issue in v5
> base https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D2=
13219
>
> Change since v4
> - fix reviewed issue in v4
>
> Change since v3
> - fix reviewed issue in v3
> - fix type error in v3
> - fix conflict with iommu patch
>
> Change since v2
> - fix reviewed issue in v2
> - add mutex node into dts file
>
> Changes since v1:
> - fix reviewed issue in v1
> - add dts for mt8183 display nodes
> - adjust display clock control flow in patch 22
> - add vmap support for mediatek drm in patch 23
> - fix page offset issue for mmap function in patch 24
> - enable allow_fb_modifiers for mediatek drm in patch 25
>
> Yongqiang Niu (7):
>   dt-bindings: mediatek: add rdma_fifo_size description for mt8183
>     display
>   drm/mediatek: move ddp component define into mtk_mmsys.h
>   mtk-mmsys: add mmsys private data
>   mtk-mmsys: add mt8183 mmsys support
>   drm/mediatek: add fifo_size into rdma private data
>   drm/mediatek: add support for mediatek SOC MT8183
>   arm64: dts: add display nodes for mt8183
>
>  .../bindings/display/mediatek/mediatek,disp.txt    |  14 ++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  98 ++++++++
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |  18 ++
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |  25 +-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c             |  47 ++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  34 +--
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  43 ++++
>  drivers/soc/mediatek/Makefile                      |   1 +
>  drivers/soc/mediatek/mmsys/Makefile                |   3 +
>  drivers/soc/mediatek/mmsys/mt2701-mmsys.c          | 250 +++++++++++++++=
++++
>  drivers/soc/mediatek/mmsys/mt8183-mmsys.c          | 154 ++++++++++++
>  drivers/soc/mediatek/mtk-mmsys.c                   | 276 ++++-----------=
------
>  include/linux/soc/mediatek/mtk-mmsys.h             |  48 ++++
>  13 files changed, 749 insertions(+), 262 deletions(-)
>  create mode 100644 drivers/soc/mediatek/mmsys/Makefile
>  create mode 100644 drivers/soc/mediatek/mmsys/mt2701-mmsys.c
>  create mode 100644 drivers/soc/mediatek/mmsys/mt8183-mmsys.c
>
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
