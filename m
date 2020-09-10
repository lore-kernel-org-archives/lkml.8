Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA70C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E21420672
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lx6Vm/zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgIJGuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgIJGuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:50:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D225C061796
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:50:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so4463989wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6K8nbSBvOysqmngdwTYc4SuAGeryD94ysxVFYA+CYNQ=;
        b=lx6Vm/zhbogm29Nsfjoo2QC11UF10KJkfCORkCabZpNESTffgQrIk4NEZVy5uNQBJ2
         BdSTzDyg8NGbuwMDzHa8GXPNRMyGRuQ2a6IqN8cdEnTU5z9gPPacr6Se2hKTjG9aHZS3
         7Eh14dxJ/Xmnx5KGgV1HL4tbryd3rxwh+GkoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=6K8nbSBvOysqmngdwTYc4SuAGeryD94ysxVFYA+CYNQ=;
        b=Uf2QWiO3u9B+SQGypNDMUddzYq5ozS81Gc2whZuiFvI8vyv71pu0ui6V/SG5m0LWrl
         NdUjtjzrkqzmjAQeeGiP0j4A5Rc0+nqU/l0b4cK4ZoH77aKl4P6RHWDTuB3MOxskIC0N
         e13Lp+rapWQsWC7mUB4ukb15PoopLKLHc5xmC+spjw8JO4sdYoc1P7V46K7WLdnqfSMN
         2vcxerJrr/PF2w0mfOo/I3n7Tq3PQqwS0e8Eb8VlLwtGPxfIiA3YqRYKSynmupynyvis
         ZhZe1vaX8ij71m6kykoaVA0SKVxMWWA1/ZwW/HilmNE/QlwfOrgS0i/N1l4IZmPGXCDx
         ENag==
X-Gm-Message-State: AOAM533h8nPj8ih3OAfcEEI5FFdVBN+JAND5JL4oHCjT142vrOl4Oxau
        JUSxTagzau/D393tXN80V9g5bg==
X-Google-Smtp-Source: ABdhPJwTurRXB/NpA+DGJ+d8NsfFwEMvmjFxCd1mQhdq6VDqHkm/1nJx5Jp51b/sWVcVTI8e+ubShA==
X-Received: by 2002:a7b:c182:: with SMTP id y2mr6693155wmi.21.1599720608240;
        Wed, 09 Sep 2020 23:50:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a83sm2084506wmh.48.2020.09.09.23.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:50:07 -0700 (PDT)
Date:   Thu, 10 Sep 2020 08:50:05 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, linus.walleij@linaro.org, paul@crapouillou.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/panel: s6e63m0: Add missing MODULE_LICENSE
Message-ID: <20200910065005.GD438822@phenom.ffwll.local>
Mail-Followup-To: YueHaibing <yuehaibing@huawei.com>,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        linus.walleij@linaro.org, paul@crapouillou.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200909134137.32284-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200909134137.32284-1-yuehaibing@huawei.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 09:41:37PM +0800, YueHaibing wrote:
> Kbuild warns when this file is built as a loadable module:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/gpu/drm/panel/panel-samsung-s6e63m0.o
> 
> Add the missing license/author/description tags.
> 
> Fixes: b7b23e447687 ("drm/panel: s6e63m0: Break out SPI transport")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for your patch, pushed to drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> index 044294aafe27..3eee67e2d86a 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> @@ -534,3 +534,7 @@ int s6e63m0_remove(struct device *dev)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(s6e63m0_remove);
> +
> +MODULE_AUTHOR("Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>");
> +MODULE_DESCRIPTION("s6e63m0 LCD Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
