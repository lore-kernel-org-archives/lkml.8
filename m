Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59770C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EADF20671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="azCcvFSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgEOHKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726601AbgEOHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:09:59 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6207FC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:09:59 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 1so630751vsl.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XjkJ6YZw78kFrDcBiwncLGTu3WX+gLM63uhHvT2r/RE=;
        b=azCcvFSpVMkZs86s0Y10CZHQwMhm28bTVxKMFXRpDBDkJwegum5IYIG/+vP6h7lGDO
         aJphvLTruIQfbqPJqpAoTipB5YSlerRvrvzto9Ox1ihK9ASZC37lijUwZm4xXu/oljBS
         Uo7KYC0HM/ne9KmrQma1pdSUXT64jil+cKhlYMegw0ew0OO24cwZuZo6I7aV5FlgbxRf
         7o+Zmd8uECcYyEKktC0fnXsJ+GQaLyv6/rBG1jBkruwFdmnxjWgn0I7ATjzUFbYEiE6h
         zRWawl+uUXq2Fcgk4WGpNIwJVsphoyjomQvCJ/glHjo803eXTzMAQu43F02ryZOod1vQ
         2yNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XjkJ6YZw78kFrDcBiwncLGTu3WX+gLM63uhHvT2r/RE=;
        b=Lzy/odJlzqKOrENFY0JpeUgemb1AKIQSX6aHoE5Sq2oXvFjHeYo2ovKm0HwmXNoR9J
         MOvtOki0nsquMA47D4Et+7q78FHctSdcUjdshB1vk6InL6sjJKUAzJkgPXOs2v+nvD9P
         OsbMuBYFsMxlY/+MUCZJh0RniRj3yt/zINxyeICWvqPj2DURfBqkSn4vHm833yIbILN2
         gF/EykrjqJhEcmZgE82MiW7VRCESbiLtMR38Kwt/63Oj6vLDStcbnMZ2wDjlgrIW5h6J
         0uBO+v6ysuvgutuQNz5nXTGYcF9cqupSexQ1aVKE6fMxnK8v/E9V56FohiCqq983i6yy
         HU1g==
X-Gm-Message-State: AOAM533nDU+m9nMmxytR2XOT8Qpg9N5qQOMOKEyHYE9Xy/EAyCkOTTtW
        RFEa1PWhu/dubyWTYRq9kVoOtBzfDV+ypy2R12EF3w==
X-Google-Smtp-Source: ABdhPJzhjR8/+1QYHCwTobyuu+CT2+1JyCbC/A+7py9jp2N5YLSIUsXHI5+SOl33iP4/9uEhA0jQHrY4BNrTIGpZXIU=
X-Received: by 2002:a05:6102:242:: with SMTP id a2mr1472708vsq.200.1589526598420;
 Fri, 15 May 2020 00:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200511161902.191405-1-Jerome.Pouiller@silabs.com>
In-Reply-To: <20200511161902.191405-1-Jerome.Pouiller@silabs.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 May 2020 09:09:22 +0200
Message-ID: <CAPDyKFrB_U4cHHsj3VupDS8-kf-vOcUeOhzO99HZhpt2+xMA2g@mail.gmail.com>
Subject: Re: [PATCH] mmc: fix compilation of user API
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 at 18:19, Jerome Pouiller
<Jerome.Pouiller@silabs.com> wrote:
>
> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>
> The definitions of MMC_IOC_CMD  and of MMC_IOC_MULTI_CMD rely on
> MMC_BLOCK_MAJOR:
>
>     #define MMC_IOC_CMD       _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cm=
d)
>     #define MMC_IOC_MULTI_CMD _IOWR(MMC_BLOCK_MAJOR, 1, struct mmc_ioc_mu=
lti_cmd)
>
> However, MMC_BLOCK_MAJOR is defined in linux/major.h and
> linux/mmc/ioctl.h did not include it.
>
> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  include/uapi/linux/mmc/ioctl.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioct=
l.h
> index 00c08120f3ba..27a39847d55c 100644
> --- a/include/uapi/linux/mmc/ioctl.h
> +++ b/include/uapi/linux/mmc/ioctl.h
> @@ -3,6 +3,7 @@
>  #define LINUX_MMC_IOCTL_H
>
>  #include <linux/types.h>
> +#include <linux/major.h>
>
>  struct mmc_ioc_cmd {
>         /*
> --
> 2.26.2
>
