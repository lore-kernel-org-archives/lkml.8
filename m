Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F646C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE66C2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588169775;
	bh=RTEeKjUF1paJxifL2yr5+8cCDLpxaByH64rNDTnk/74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OKmp66jUu4rFiwh5riwV6kYC4HpuCp4jzJm5TYXZZ82GW5+Ts1IUZNHq7EbanGruv
	 RBjsovkVbqIrDa0wyLiWJHv26cXSM/gsa54zVgjMsRxdtkg+zF1DF8cmbcnoySqkt0
	 fDUtkGLw0dU2Zakzdcq1Nz0BQmNbstaBxsFCxZxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgD2OQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgD2OQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:16:13 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6923420B80
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588169772;
        bh=RTEeKjUF1paJxifL2yr5+8cCDLpxaByH64rNDTnk/74=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k2JQJ8fpMdmxLGcpMg47+0e4J+hktbo4FqU0UFKJ4IbHu6TLTZ9vHZMac3cIZyjBS
         bqTFMJrMFH/92PkZFdiLNCU5Ck/JVhKH2Bls7kkThGiWwWTG18q1neQ95aatEkGcVZ
         ETk250WB2U1zIwmtoNRomh7rVskItnXAz4fJCy+8=
Received: by mail-ed1-f50.google.com with SMTP id w2so1652254edx.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:16:12 -0700 (PDT)
X-Gm-Message-State: AGi0PuaCU+HsgFA08yFJgOzBaOK3bg5qB/Gyk7rtAekwf0PN2ENVjZ5Y
        Ws0f+TVbiKwzgF61VFM3GY7YVnR7Om3cMQaYLw==
X-Google-Smtp-Source: APiQypItwtCq5f4ckv/WzvZKMkryr9MF+5+w+xUswDZzzQpddnaUOnlv7PJd7bxb8Txbi68jXzKqiS8LDs7q6NzaYYQ=
X-Received: by 2002:aa7:dd95:: with SMTP id g21mr2635984edv.148.1588169770819;
 Wed, 29 Apr 2020 07:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200420135045.27984-1-yuehaibing@huawei.com> <20200429071337.49528-1-yuehaibing@huawei.com>
In-Reply-To: <20200429071337.49528-1-yuehaibing@huawei.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 29 Apr 2020 22:15:58 +0800
X-Gmail-Original-Message-ID: <CAAOTY__5rwRQhuy4vT8OiAKMM2bQtCb7w5AW9B5rqL+UVdVpsg@mail.gmail.com>
Message-ID: <CAAOTY__5rwRQhuy4vT8OiAKMM2bQtCb7w5AW9B5rqL+UVdVpsg@mail.gmail.com>
Subject: Re: [PATCH v3 -next] drm/mediatek: Fix Kconfig warning
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.orc,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, YueHaibing:

YueHaibing <yuehaibing@huawei.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> WARNING: unmet direct dependencies detected for MTK_MMSYS
>   Depends on [n]: (ARCH_MEDIATEK [=3Dy] || COMPILE_TEST [=3Dn]) && COMMON=
_CLK_MT8173_MMSYS [=3Dn]
>   Selected by [y]:
>   - DRM_MEDIATEK [=3Dy] && HAS_IOMEM [=3Dy] && DRM [=3Dy] && (ARCH_MEDIAT=
EK [=3Dy] || ARM && COMPILE_TEST [=3Dn]) && COMMON_CLK [=3Dy] && HAVE_ARM_S=
MCCC [=3Dy] && OF [=3Dy]
>
> Make DRM_MEDIATEK depend on MTK_MMSYS to fix this.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Fixes: 2c758e301ed9 ("soc / drm: mediatek: Move routing control to mmsys =
device")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v3: make DRM_MEDIATEK depends on MTK_MMSYS
> v2: select COMMON_CLK_MT8173_MMSYS instead of adding DRM_MEDIATEK depende=
ncy
> ---
>  drivers/gpu/drm/mediatek/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/=
Kconfig
> index c420f5a3d33b..aa74aac3cbcc 100644
> --- a/drivers/gpu/drm/mediatek/Kconfig
> +++ b/drivers/gpu/drm/mediatek/Kconfig
> @@ -6,12 +6,12 @@ config DRM_MEDIATEK
>         depends on COMMON_CLK
>         depends on HAVE_ARM_SMCCC
>         depends on OF
> +       depends on MTK_MMSYS
>         select DRM_GEM_CMA_HELPER
>         select DRM_KMS_HELPER
>         select DRM_MIPI_DSI
>         select DRM_PANEL
>         select MEMORY
> -       select MTK_MMSYS
>         select MTK_SMI
>         select VIDEOMODE_HELPERS
>         help
> --
> 2.17.1
>
>
