Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D639DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE319205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9XuKevR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgG0LI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgG0LI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:08:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B3AC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:08:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so14440831wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qURU45Kb+6c1KqHtW0F2gSyFK0AFPhbSpzUMWZVfYyw=;
        b=V9XuKevRcMdAg3nJ98vwGFYpUqj6aTb99a24/sEOyectnuhsyGk0ZogRrquWiL19BV
         yuxxUqMfj0B+lxbDfuUYV/aRINiRDFZXstTO6h7JRdh2kzRV4zuuI2DKG5NekLDpBDN1
         OWQCzWN6pUyPJxRyOsxySFKaE1Uvnn22hYGFh5gDl+XNEYqckBu7FoD0FanBeY6JC2SU
         SYSLznGYb5kkP/4a7cUeSnu+rUGhndxh0Yh4c69dBLv33SocW+LVOLTfriQD9bDyBroE
         K1yJ1CppcNxh/lQBT2bGvjA3qQHjHR3rHcM8pXw9NjM8cw/3muuvH1BtlntUgEs0RP10
         nACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qURU45Kb+6c1KqHtW0F2gSyFK0AFPhbSpzUMWZVfYyw=;
        b=tHbLBj05+b+GqjQltbSm8hJvlMTOSYJbWAaQ+YMQhWVCn+ZINo9LsDfhzyYAhWaNNj
         xb4LnZdHzjjh2JMHqvL4Ak+eBMAj2mrg6SR8/Aa1ZcPSPjI7kuTPLBW6X5xjSn8MJWfL
         5cCUQqZcqgEF9TMObV9dSxmu94bwvcvcPSyaYAdpRDrAdXpHSBGGNYB5SdQFpZSIJlut
         tcNso0lKJWetWjHr8ZuKx1cG70AMa0Q/GAZ0HgjAlk2e047kxeZhk9dO2/H03wKolRqA
         d34NOfKCC1uBWjMGl0/KBnRo6MTW5D5eBwKEdh37h8kt4nUKv9g82QKsRyOpciCQHmOl
         rEEw==
X-Gm-Message-State: AOAM530W556cPNm8IHpqMusqtLflSFj4CRfWOpP4rwBpPN8yyNWYYF6l
        nM0AD/uIYnH8/c9n/8aaFhyv2A==
X-Google-Smtp-Source: ABdhPJw3u23L4RGaem28Ie9bN9I/a+j+lvOfQgQboVl6nTwgWMo2fvXQmJKjwCEeluX+TMOAYG+oRg==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr18894627wrm.327.1595848103943;
        Mon, 27 Jul 2020 04:08:23 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id g3sm13325267wrb.59.2020.07.27.04.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 04:08:23 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:08:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 1/9] mfd: mt6360: Rearrange include file
Message-ID: <20200727110821.GH1850026@dell>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-2-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594983811-25908-2-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Rearrange include file without sorting by alphabet.

Why are you making this change?

> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/mt6360-core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index e9cacc2..df4506f 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -5,15 +5,14 @@
>   * Author: Gene Chen <gene_chen@richtek.com>
>   */
>  
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/i2c.h>
> -#include <linux/init.h>
> +#include <linux/crc8.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
>  #include <linux/interrupt.h>
> -#include <linux/kernel.h>
>  #include <linux/mfd/core.h>
> -#include <linux/module.h>
> -#include <linux/of_irq.h>
> -#include <linux/of_platform.h>
> -#include <linux/version.h>
>  
>  #include <linux/mfd/mt6360.h>
>  

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
