Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5682EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2409020729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KbbUV9Fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgG0UT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgG0UT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:19:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E65FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:19:57 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d4so10564911pgk.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9vwww9/H9z0XVuIaPzgOzhMhWfDAZBEc6TFuy96OSf0=;
        b=KbbUV9FnKtOtEDcaY4l9nsErpo99ysUh7wjDRRb3BXPd7mtIwE4up4DbvPalNNaOng
         8b8r8PEI3aTiAQAVxCbTtWA+0NnFBKZupRHD5YxZLKy4ENjHNE2cymYH5BcogsjLTWWt
         pA1vf1Hv7Ai/loLQscjcKMO9lXfEolWE8Bsi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9vwww9/H9z0XVuIaPzgOzhMhWfDAZBEc6TFuy96OSf0=;
        b=WY1AVbulDM295Gap7xz5GteCGIE6cO+H6XhO5TzlWnhvi9ppb1+5erRY5fShwIo2gH
         HenBC3yrsMlxHU3ZlrLeEhazDvTVdr8tEXUeZGmQasMcQEB89+EKRDtOXqmjmKNkIg6J
         Gca9HLc3Z2FpLry9YDGa/5dUHhU3LedgmrdY9kTa1bO96ZnnsXvsyFtNhpmWV4I8Piyi
         LbfJEMMFJkSpIAMz9ExZ9wyq5tlGjhIhs96/rbV1eMkqOiL5VAU7IHhH5hRaQl8BCNUS
         ICztgnF2eqpGZzqJUGsDfM4HX9Yu1bmpb/VX6weYUPDwIJ93drtNOfmLchAK36lksEAr
         dgLg==
X-Gm-Message-State: AOAM531vQCT5Cz1x6khnJCDjmUexHjN08/C9zWo4vgXs8LqMEOMQ8yIz
        NiRaq+Nqppwvu2mco6sTam1syeycFj4=
X-Google-Smtp-Source: ABdhPJyJqlkAhUctdPxcxoCe8OZDXiJej7r/04cQ49MMlVxsNnANvzYpwWGdMLA/W5RogTUuuZ1xPg==
X-Received: by 2002:a63:8c4f:: with SMTP id q15mr21001301pgn.373.1595881196932;
        Mon, 27 Jul 2020 13:19:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id 15sm465075pjs.8.2020.07.27.13.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 13:19:56 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:19:55 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        sibis@codeaurora.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] interconnect: qcom: Implement xlate_extended() to
 parse tags
Message-ID: <20200727201955.GF3191083@google.com>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
 <20200723130942.28491-3-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200723130942.28491-3-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 04:09:38PM +0300, Georgi Djakov wrote:
> Implement a function to parse the arguments of the "interconnects" DT
> property and populate the interconnect path tags if this information
> is available.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/qcom/icc-rpmh.c | 27 +++++++++++++++++++++++++++
>  drivers/interconnect/qcom/icc-rpmh.h |  1 +
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index 3ac5182c9ab2..44144fabec32 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -6,6 +6,8 @@
>  #include <linux/interconnect.h>
>  #include <linux/interconnect-provider.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
>  
>  #include "bcm-voter.h"
>  #include "icc-rpmh.h"
> @@ -92,6 +94,31 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  }
>  EXPORT_SYMBOL_GPL(qcom_icc_set);
>  
> +struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
> +{
> +	struct icc_node_data *ndata;
> +	struct icc_node *node;
> +
> +	if (!spec)
> +		return ERR_PTR(-EINVAL);
> +
> +	node = of_icc_xlate_onecell(spec, data);
> +	if (IS_ERR(node))
> +		return ERR_CAST(node);
> +
> +	ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
> +	if (!ndata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ndata->node = node;
> +
> +	if (spec->args_count == 2)
> +		ndata->tag = spec->args[1];

Would a higher number of arguments (currently) be an error? Is so,
should it be reported?
