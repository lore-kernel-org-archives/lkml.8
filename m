Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645DBC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A2C206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585068484;
	bh=PNu1cBEwyzzfPoT37OV9ratEn1KWxSdUE0FieGmawyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LpxIeXtxybjrZ7brL621mJYkLqp6U6kYrMF+to7RZmZ9HaX0V0zTUU9wXgjrLwH3s
	 qd16HM2r3y+eikTQaMAAL/4viwCzWIlROrgITEIH7IrFpThnT8iSyHZgOvP9jBIJwx
	 IfBZEJQIAsxWbCosWm2xVUNH+Z7Xr50bjLD1nVNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgCXQsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:48:03 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:45387 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgCXQsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:48:02 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 02OGljW1002189
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:47:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 02OGljW1002189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585068466;
        bh=4nGjHOPn1Qdp00y4tfz/8sjCtUPREPQ1cB4wp92G+Go=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i+xU4e061XbZEPioDSUPsgzKIthqclxHFXo1j4yUVASbGKS00sS7mN0dbzrlGZuIT
         Lt0PpDUtLZTV8hf9V6BjXNlOFvFgkhbMet/YSVVWckEHGB0UQufM5duFUonjXRS8ow
         KBrxmwNE1qLHzzuP5IlOmGGOMl1C5mamEQvoasTI/ymMnvAn6LKbVcuv9RuIrPvjJd
         vbSIflnmVZQnwvKt4iOar5Fu3KG2odXAsxVtC5HNWvxsybPPmadBqTSsjfGnw0zc6O
         851IfrugrDZNwwEc/UN4yvqy8IeqPayxY2mscJBiYfCTs1jcJkPx2okN4fgnZyFutL
         Aa1jHd1z4T+zA==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id a6so1716040uao.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:47:46 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1+M4G0TFdcmPLmIQ44m6OogWZE6Syor4Tywwok9oB3cFSLnIoR
        DQ6/u5TH45MmD2SOPcr7Nm74H1z/F3z5DIU0Xgg=
X-Google-Smtp-Source: ADFU+vtGiho80TDqAX96Yus6mxMxFu6xRjT221tw+EdgnOczkcdQo8Ti4tq0HKei8/xRnz73F3jsLDM/saoD+O6lBls=
X-Received: by 2002:a9f:32da:: with SMTP id f26mr18821086uac.40.1585068464826;
 Tue, 24 Mar 2020 09:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200213153928.28407-1-masahiroy@kernel.org>
In-Reply-To: <20200213153928.28407-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 25 Mar 2020 01:47:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNARvxFk=ct9AoRLwjZ9cKRsA_bjiLaq0di12TRe5+fpmGA@mail.gmail.com>
Message-ID: <CAK7LNARvxFk=ct9AoRLwjZ9cKRsA_bjiLaq0di12TRe5+fpmGA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/radeon: remove unneeded header include path
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?B?Q2hyaXN0aWFuIEvvv73vv73Dk25pZw==?= 
        <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think this series is a good clean-up.

Could you take a look at this please?



On Fri, Feb 14, 2020 at 12:40 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> A header include path without $(srctree)/ is suspicious because it does
> not work with O= builds.
>
> You can build drivers/gpu/drm/radeon/ without this include path.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  drivers/gpu/drm/radeon/Makefile | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
> index c693b2ca0329..9d5d3dc1011f 100644
> --- a/drivers/gpu/drm/radeon/Makefile
> +++ b/drivers/gpu/drm/radeon/Makefile
> @@ -3,8 +3,6 @@
>  # Makefile for the drm device driver.  This driver provides support for the
>  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
>
> -ccflags-y := -Idrivers/gpu/drm/amd/include
> -
>  hostprogs := mkregtable
>  clean-files := rn50_reg_safe.h r100_reg_safe.h r200_reg_safe.h rv515_reg_safe.h r300_reg_safe.h r420_reg_safe.h rs600_reg_safe.h r600_reg_safe.h evergreen_reg_safe.h cayman_reg_safe.h
>
> --
> 2.17.1
>


--
Best Regards
Masahiro Yamada
