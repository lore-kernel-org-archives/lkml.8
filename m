Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C18C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4E120658
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585318954;
	bh=TYBu9ieERy+Ta4ICp1zRuWs/eR3KjO5IyGqncme6DJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=APr8YSbV2ALILOJj5hhOGbWcDTvruqPA7sVoWl/mBDsFL/k2NLfd27TzGn4klczJx
	 EBw3QRAxBTaPpfkt1a1/2vFaZhv58mcY9tNmMhJGyIAvxOLWntgPeRIx/9J9oDHz1L
	 n4q24J74vm6Q/TKLOxNzyT/uRCicQvpJe7q78m/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgC0OWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 10:22:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbgC0OWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:22:32 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D21120658
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 14:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585318951;
        bh=TYBu9ieERy+Ta4ICp1zRuWs/eR3KjO5IyGqncme6DJc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qm0z3g39bQDBSrqz9++ujQKvtUBjNueacrWy37OBkqDntO3Gj19TmxguyvDh2QtRS
         KCzt2L26ha+faOp2qd9QYuW2Ul6gL70onVm2ixDr0UmbDwUXTW7mtAgqj+0mQZiHtZ
         ROBmTKm/m/ih1J4CnjeihLcTeQTZRL0j873B2/hU=
Received: by mail-wr1-f52.google.com with SMTP id d5so11667647wrn.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 07:22:31 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3D8+9wEHMAUTWUMuYm/bUOo3vmSPxWOUK+yOPvDJL+u2RG6Mn3
        mx4F2WjoKpUg/ntjpVhPzZuqYIrwvXkGeXUt/A==
X-Google-Smtp-Source: ADFU+vsE0Iq/qOsJLgem/9N0N8fAV8mgme65RNUzQmeCYNSDoKObf/LG9fWjTq9gzXMdb7KBtsJZ1NeEF0NZuYo0Rmc=
X-Received: by 2002:a5d:414f:: with SMTP id c15mr16766117wrq.60.1585318949779;
 Fri, 27 Mar 2020 07:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200326182742.487026-1-enric.balletbo@collabora.com>
In-Reply-To: <20200326182742.487026-1-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 27 Mar 2020 22:22:18 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9vCtr6Y3Geg3wJ7FjTdo6iPc+bdwtJKDZahJAY3Tih8Q@mail.gmail.com>
Message-ID: <CAAOTY_9vCtr6Y3Geg3wJ7FjTdo6iPc+bdwtJKDZahJAY3Tih8Q@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: mtk-mmsys: Export ddp_dis/connect symbols
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B43=E6=9C=8827=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=882:28=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> When building on arm64 with allmodconfig or CONFIG_DRM_MEDIATEK=3Dm we se=
e
> the following error.
>
>   ERROR: modpost: "mtk_mmsys_ddp_disconnect"
>   [drivers/gpu/drm/mediatek/mediatek-drm.ko] undefined!
>   ERROR: modpost: "mtk_mmsys_ddp_connect"
>   [drivers/gpu/drm/mediatek/mediatek-drm.ko] undefined!
>
> Export mtk_mmsys_ddp_connect and mtk_mmsys_ddp_disconnect symbols to be
> able to be used for other modules.
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>


> Fixes: 396c3fccaf03 ("soc / drm: mediatek: Move routing control to mmsys =
device")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/soc/mediatek/mtk-mmsys.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-=
mmsys.c
> index 32a92ec447c5..05e322c9c301 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -259,6 +259,7 @@ void mtk_mmsys_ddp_connect(struct device *dev,
>                 writel_relaxed(reg, config_regs + addr);
>         }
>  }
> +EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
>
>  void mtk_mmsys_ddp_disconnect(struct device *dev,
>                               enum mtk_ddp_comp_id cur,
> @@ -279,6 +280,7 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
>                 writel_relaxed(reg, config_regs + addr);
>         }
>  }
> +EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
>
>  static int mtk_mmsys_probe(struct platform_device *pdev)
>  {
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
