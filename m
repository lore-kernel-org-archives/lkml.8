Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FE4C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 23:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB4720724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 23:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587511896;
	bh=RPY9/TAPtMpNAGRQZw/dlkxmaqPwTqvSl3q13yOk+XI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=d1yMQjyg7ye37HG5y9RbwRKwVWaqYaJb2yrENP9dvL+mYMbgX0Uw666ABjA9M5rUe
	 4LkIIFiGT6mjGqhSVt72v1jQn8CMxhDEc0QK6coiEbAej1VNCTV/LEwerDcy7rhi/n
	 wZ91mF0e6E8DAf9GUrBiwV4eTtwSYRvmfZE+n0r8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDUXbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 19:31:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgDUXbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 19:31:35 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83ECC20724;
        Tue, 21 Apr 2020 23:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587511894;
        bh=RPY9/TAPtMpNAGRQZw/dlkxmaqPwTqvSl3q13yOk+XI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2s72HPDDsl1QTP+FODWwiPUTuk0v4TPC/n61PVeE9RDv3L6UJIXLNfatjGwILnpao
         g7LNzo9wa6PB/uzg/ll2Epz+WWwNIrR1NrbZxUbfD+1YT6mbuMvcavfEhXqFHSS+Fk
         66OH7EL2qAF1SeLI0P8nudCKobke3dP858Nw2I+w=
Received: by mail-ed1-f53.google.com with SMTP id j20so160327edj.0;
        Tue, 21 Apr 2020 16:31:34 -0700 (PDT)
X-Gm-Message-State: AGi0PubedbnQYhp5ObyrCVdhky+PR11WhF529nhMbhlJxKoYhKOCjGmJ
        Y+f5kga0X9JgCQXveUViFvgJ9hjMyRTH2ZeokA==
X-Google-Smtp-Source: APiQypJo9yp2SonxjWMw73VqqdawuFNXOhrZk2P9FYz3xedbgGtLGvC53P/2on6r1rrbXobjcKm43t2LLpC5Lt5jrNE=
X-Received: by 2002:a05:6402:1587:: with SMTP id c7mr20059512edv.61.1587511893020;
 Tue, 21 Apr 2020 16:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200411074408.38090-1-jitao.shi@mediatek.com>
In-Reply-To: <20200411074408.38090-1-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 22 Apr 2020 07:31:21 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-78CsRocevQK-h-CsBZTTDpYCtpuswcL0MkNyhVvAADg@mail.gmail.com>
Message-ID: <CAAOTY_-78CsRocevQK-h-CsBZTTDpYCtpuswcL0MkNyhVvAADg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Config mipi tx current and impedance
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        huijuan.xie@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

For this series, applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8811=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=883:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Changes since v5:
>  - remove memset()
>  - add return to remove "else"
>
> Changes since v4:
>  - add Reviewed-by:
>  - move the get the calibration data code to probe.
>
> Changes since v3:
>  - refine drive-strength-microamp as from 3000 to 6000.
>
> Changes since v2:
>  - fix the title of commit message.
>  - rename mipitx-current-drive to drive-strength-microamp
>
> Changes since v1:
>  - fix coding style.
>  - change mtk_mipi_tx_config_calibration_data() to void
>
> Jitao Shi (4):
>   dt-bindings: display: mediatek: add property to control mipi tx drive
>     current
>   dt-bindings: display: mediatek: get mipitx calibration data from nvmem
>   drm/mediatek: add the mipitx driving control
>   drm/mediatek: config mipitx impedance with calibration data
>
>  .../display/mediatek/mediatek,dsi.txt         | 10 ++++
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.c        | 54 +++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |  4 ++
>  drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c | 28 ++++++++++
>  4 files changed, 96 insertions(+)
>
> --
> 2.21.0
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
