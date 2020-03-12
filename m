Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139F7C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED352206CD
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="wQ9KH1Lq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbgCLFVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 01:21:39 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35803 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLFVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 01:21:39 -0400
Received: by mail-vs1-f68.google.com with SMTP id m9so2933944vso.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 22:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2rL0f1stvcai+881pBzgsoAh3qUJVmAXvCC/htsXh94=;
        b=wQ9KH1LqIfVUdGWfsDTAG+874YZgIwVtgGGlTea3dhDmu2xXr5bh2weH8pSA1cs83v
         LNFpEJqNoPoqs+FEeeoIZHDx0Gr5xJkhp0s+019VRA8mCVD43rqr+D50dcKYJUc5lH9I
         wKTLDyLEFgqgfReS4ykjcWppP0hwPyKfk69aHc6JLu6M80sjR0hC1S4Udb2ACOs+Y0by
         0cOCsM00sI3dUnZoKqNcupUFnORtwYBWWoOX+2PBDVM31fFx+K6JOC30cnvFcZdlrSN1
         xMt23dbDLuGi0ffPtdHN99su4OlLUarO+DVokGJtrYJxAff1NbPDWI0nzroqCjY9sXL0
         ASXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2rL0f1stvcai+881pBzgsoAh3qUJVmAXvCC/htsXh94=;
        b=C6pKC2EuZvYaVKpP1ZmsA+dFIaeRQ3rseYCu2mcPvkwAlWbiLi+vpgCt7N0y+nLJ2L
         pYSpGa+HiVuTo8g+sH3vmZaKOFtbKRDZ6F/glF3/JyStBCeeTtjBXpLHVBCplIlsw/HH
         /dKqjTJ+o1utHMsPwCsYjn7InwBL9/JlBCkMP7LPtsWXZMC7qp5yr1m9pvByMDuRjnqp
         monZ5OOQr1HCJhN5jii/aGMttSi2WdAbaaUM1JyY9Xr7Jc2y+4gxduQSMZzwqUcX/zru
         EaXol6nvlh3LygKvIyloU9vflLEQNkzaCt6iV/44PxUE/aRCydoyqUPsp0zuBVTw/pAM
         +DBg==
X-Gm-Message-State: ANhLgQ0yxQ0BQo0jyiV/f5leUSBVbp9jVqcEGaP3JHtBlBJClEpufolk
        wR/CHH8wKI7D24wOyE9ivZq8BSsstSEMDZgkzNzEyA==
X-Google-Smtp-Source: ADFU+vvcIQBsD6+Qf4EXhXxuhdx/RuDKXyEsnw/NEhzlaB7+WISf9/LVykqfs227GC7dL+5kSizWix/lKMiNIw74MX8=
X-Received: by 2002:a67:e99a:: with SMTP id b26mr4269737vso.27.1583990496623;
 Wed, 11 Mar 2020 22:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200311233039.928605-1-bjorn.andersson@linaro.org>
In-Reply-To: <20200311233039.928605-1-bjorn.andersson@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 12 Mar 2020 10:51:25 +0530
Message-ID: <CAHLCerMxf5HwcFqqyOuV+LjMqw_6PJdcsGLQzW2GDSSwt_Uz4w@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable Truly NT35597 WQXGA panel
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Anson Huang <Anson.Huang@nxp.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 5:02 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The Truly NT35597 WQXGA panel is found on the Qualcomm SDM845 MTP,
> enable the driver for it.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index e8be14b93b40..07b57510394b 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -573,6 +573,7 @@ CONFIG_DRM_TEGRA=m
>  CONFIG_DRM_PANEL_LVDS=m
>  CONFIG_DRM_PANEL_SIMPLE=m
>  CONFIG_DRM_DUMB_VGA_DAC=m
> +CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
>  CONFIG_DRM_SII902X=m
>  CONFIG_DRM_THINE_THC63LVD1024=m
>  CONFIG_DRM_TI_SN65DSI86=m
> --
> 2.24.0
>
