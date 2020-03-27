Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE42C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 07:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9139120663
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 07:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdU3jT5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgC0HTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 03:19:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36351 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgC0HTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 03:19:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id s1so6996132lfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 00:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8yD3/mZAPx4NyJAYvyAM42UOXEcrRRB02HlarcvJcpY=;
        b=cdU3jT5oe/H7QKTBQOhKMp9drgTOsgZe5NhZH3AgSZm3iIiqG7Mpdb7eiSi/aoXspU
         adDnKmgjnNQOPOlbHzzO67tuGNnmIIXVdvnZjQLsWvhaxncdd/E9LNTu0B8xituEt11S
         im4peLookDERzMUR0/fJILym8NflyDU2H23CU1F2sEboZO0GzyBnSX7Sw58NmW1eoFRz
         QmjqAIIJ9eQ8gHc/xFj9sQsbaUodlZeNkmUP/NtCyr8IOePkWyk2t1k8IYPAE5lUA9Un
         TRQsPtLWtJUdSDAhud+rUIempEHW9rwXfg91DpI/kpwYm00hGRzm7ZMusZ+CVcF3VjUC
         zW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8yD3/mZAPx4NyJAYvyAM42UOXEcrRRB02HlarcvJcpY=;
        b=OKtF3v9Ty5h0+o+c84WXsqhgh07t8C3N0VkbimX+MtP0srNDR/vaIXTP2kRIlC4hJ/
         sN5uviEj/Er4MpAjitFgXOnkbUaJa6MnUBv9qL2SzeiXyyxidxj5/cZcvA38KPW6iqZc
         sa4z18g2GjKACtMZMWzedEnoG5WeRpbHsDQjyBDVvMvQrprHdNijheVu8YR7FfLbKMKm
         0oPg+CeCeSmctYs1H5GmPmlI4mXiZ4bpbDjPUfnLwKgkeDSGBteacRaTrDjKMRDWqCvD
         1p57INgicNSvB93mPd0Ne2jqLcsypV0DophapAQNkn+IwMT5QpzYdX3L0rI3iHmlN3xd
         SOBw==
X-Gm-Message-State: ANhLgQ2CTRa4OS6Mfl6CBK6lzeVt9umYZzIDazzQNSf51bk2on/b6BcR
        E8g13mJli1zUXN6Z5WQf3NHGNQl4t+p9saq9c5T9UQ==
X-Google-Smtp-Source: ADFU+vsVleHzR2OlQgFnip8JwdTpgtyxbozUTC6A2rWBZO45SHy2RsvKY2E8cSZkDmSqmkfRqCMidvfUsGCh9kDJWeQ=
X-Received: by 2002:ac2:53b2:: with SMTP id j18mr8178328lfh.206.1585293557144;
 Fri, 27 Mar 2020 00:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200326182742.487026-1-enric.balletbo@collabora.com>
In-Reply-To: <20200326182742.487026-1-enric.balletbo@collabora.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 27 Mar 2020 08:19:06 +0100
Message-ID: <CADYN=9Kd-eWAFaN-ttX+Aq5HyH2AiUfqeCRC1mMTZM93DBshsA@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: mtk-mmsys: Export ddp_dis/connect symbols
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020 at 19:27, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> When building on arm64 with allmodconfig or CONFIG_DRM_MEDIATEK=m we see
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
> Fixes: 396c3fccaf03 ("soc / drm: mediatek: Move routing control to mmsys device")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

> ---
>
>  drivers/soc/mediatek/mtk-mmsys.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
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
