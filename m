Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A807BC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 07:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC5724655
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 07:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jwrbc4bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgAWHxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 02:53:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38841 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgAWHxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 02:53:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so1438973wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 23:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LkS/V988Ti/1GfKcQfeUkMBm9SsC4LVrMiS9Hhq0LuA=;
        b=Jwrbc4bf/9zfn+7g7L6Mdt6K1JnykaDSeM1CbIruN3JXLZdou2iBHVAZn0K2Rywx3u
         j2keMcRx9RG6t90wQAYQ7g3NnKMOQS1GZfR5r/CKi9hJyXJONTeAvnmTI2UuS2IEvrms
         8p6oUdFLySKJewP3QtHK73gAZo6G83s8DHqx1UtZITLksupSHVgqBBvE+ydGJUtAIkTs
         VnHbh3HI7mIXTrfeBLCP3FsDadqwpFP1ndooqP0tZyoOReFQTiRhtsNeXsjEe/TpQAuK
         kRPrsj7rOxZ0t8HxZZaYRVPb7I9V280AEXOARLuvhXUCaOY1IVzf4Aw075bcorF/HbAF
         Yi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LkS/V988Ti/1GfKcQfeUkMBm9SsC4LVrMiS9Hhq0LuA=;
        b=F35P70IJzGFFwZ/7nzgz/u0b0jxK035TWmqymnr3iREsdvmGYtc7OyEnraUM8ZAdxz
         N64WgMZh3SM99srXyQoSlFiekUg7EcKxYq2swEV22GeDOegMUGFhlUe6DCGPPKe8IDMS
         Y1vHulcU85t/fVJbs3h4jW6YiAmI1bPkgXQ6tjHI3aE5qeM+3yGaj5ZR/klkd4pcZD9t
         s5zLxx7JL3P1Z4eRcyJiTDigvw3eF0zI7V7yXkP0Mk+y5p7BwhJ8/4/ZAtGH6RyXizTQ
         0b0t1ETLcW6McjpXWGm+lZFS6qKOuUkpPoLPRJ8FDNeoytE7gB22Oxq46/szkLVK2JBD
         Wh/g==
X-Gm-Message-State: APjAAAW2XxRS/l4E3+3qB2pyUloZr7Cu8UtA9N9RNgVOpuC8o8E6JS4f
        PkciwtFoMK08Vess43ovdOvH0MISRsE=
X-Google-Smtp-Source: APXvYqzGzPSg/J8qJs1czckc4vtx2G3GfA0fJSoq5iEDFGfxcQef6z7Qhnri8k6z2Zv7KcKTZZf2Gg==
X-Received: by 2002:a7b:cd1a:: with SMTP id f26mr2619310wmj.164.1579766012421;
        Wed, 22 Jan 2020 23:53:32 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id z25sm1749383wmf.14.2020.01.22.23.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 23:53:31 -0800 (PST)
Date:   Thu, 23 Jan 2020 07:53:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, kgunda@codeaurora.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] backlight: qcom-wled: fix unsigned comparison
 to zero
Message-ID: <20200123075345.GO15507@dell>
References: <20200122013240.132861-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200122013240.132861-1-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020, Chen Zhou wrote:

> Fixes coccicheck warning:
> ./drivers/video/backlight/qcom-wled.c:1104:5-15:
> 	WARNING: Unsigned expression compared with zero: string_len > 0
> 
> The unsigned variable string_len is assigned a return value from the call
> to of_property_count_elems_of_size(), which may return negative error code.
> 
> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> changes in v2:
> - fix commit message description.
> 
> ---
>  drivers/video/backlight/qcom-wled.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
