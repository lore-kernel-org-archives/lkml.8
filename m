Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7A6C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4775B20767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZqY5AWHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCRPqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:46:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42095 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgCRPqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:46:30 -0400
Received: by mail-ot1-f66.google.com with SMTP id a2so5119121otq.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=id6fBYRzTbPVezHvRzigBUZtyyZNpNKX7bIyeQ3xLJM=;
        b=ZqY5AWHXrV9Z2i8Ua3vsaXc3to2MTtBlwtEXOAVw9RupFkSH1bX6L0cTqQDlwqErWb
         eomul9v2lD950rkiS2a3jZwWiAsWjYXZrR8M08zA59FVXYUq2pYVkUxqdViqpwow6hhW
         FoMJAtslfTAk3nhnW2Vn9bjp2QrldSTw0/1RUEf+XHEPlzHVg8d2h67gK9F5UPDdogwi
         F3cRlXyOuE51QSLJaSnfl8ECEjYS9ZWxtkwcx/YH/PTOxO/A1sk9G67aTh5bQqmoJa5V
         1enPYeqqN2ThSayKVcx8K7gywVPMjaaRznUF+j7FWO5+TRBcx8VpnA4b0TZLaBDDXVe4
         UfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=id6fBYRzTbPVezHvRzigBUZtyyZNpNKX7bIyeQ3xLJM=;
        b=DXk+9Gsy+HesOL8u0Ff/TF6boyMcZXyyG3eQYRqrxHWGbpNzmxUhBm9og4NU2l2NmA
         xhuTZsEQleg4UyDF9Lx7QGj4OAvCNS0qpb9MKfHHlhqgSv87ICr5Y+kUm44uoM6Hp+JK
         uPbtwLqDONv2tRnBu9zD6yxQX5kHy4WT9yo3LWCoTvtlvIKeZ/IIoUudu3ZUYsMJIIW7
         EChdkuUisUSn8LNUQrnnm5wS2LXPIWBZIrBnZoREQ2dgkhLl2DyY91wUkczoW56fxuBS
         2At3hFgoiVCPgE3T7xiBvlW0XsfyytFyJBsNXdNAxplVdebGsGsPb+joDETMa89PEgOh
         pzZQ==
X-Gm-Message-State: ANhLgQ3mtAnr/hHcIIxWZdOqsjXSRDpFoyO6wMcJ/xf3p/9vJ8Fg87dw
        bMDGuewRDNVELj+nh77DzoyeTGentS/LfpzmEwvgSQ==
X-Google-Smtp-Source: ADFU+vvX20CIlM83oLPc+apgYzRAvWB4Y3fF6uDgiS0UN5JGeqEbtOLb0rxc9QNhm7ohNQlk5lyNBFi0+55SbHMyakg=
X-Received: by 2002:a05:6830:193:: with SMTP id q19mr4286283ota.164.1584546389617;
 Wed, 18 Mar 2020 08:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200317205643.1028398-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20200317205643.1028398-1-daniel.vetter@ffwll.ch>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 18 Mar 2020 21:16:17 +0530
Message-ID: <CAO_48GH1YkA4mvjyQ=88VRrDPc4Kh8fiFsm-MOaNFfWhhaxfbw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Better regex for dma_buf|fence|resv
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Linaro MM SIG <linaro-mm-sig@lists.linaro.org>,
        Joe Perches <joe@perches.com>, Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

Thanks for the patch.

On Wed, 18 Mar 2020 at 02:26, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> We're getting some random other stuff that we're not really interested
> in, so match only word boundaries. Also avoid the capture group while
> at it.
>
> Suggested by Joe Perches.
>
> Cc: linux-media@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: Joe Perches <joe@perches.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> ---
> v2: No single quotes in MAINTAINERS (Joe)
> v3: Fix typo in commit message (Sam)
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3005be638c2c..ed6088a01bfe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5025,7 +5025,7 @@ F:        include/linux/dma-buf*
>  F:     include/linux/reservation.h
>  F:     include/linux/*fence.h
>  F:     Documentation/driver-api/dma-buf.rst
> -K:     dma_(buf|fence|resv)
> +K:     \bdma_(?:buf|fence|resv)\b
>  T:     git git://anongit.freedesktop.org/drm/drm-misc
>
>  DMA-BUF HEAPS FRAMEWORK
> --
> 2.25.1
>
