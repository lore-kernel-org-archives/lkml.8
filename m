Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6197C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17C520720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OWbz3/Cq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgGIPfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgGIPf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:35:29 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9361C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 08:35:29 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j20so1179437pfe.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0q/rCvNt3k405F9K/TajOpXPAtgojFFtnqWJkLPEMF4=;
        b=OWbz3/CqrDpo/Wcvq2r+CzFCtoWft8EU3UQBsM0iXshdZeW30DCs/+vWW/pDAXePHh
         2oLzG8kSev55DDnOpuoGAbRzEEmpYfdKukcFXVxGuDNbCFFMWbv25beCD/NtvTEk6R1c
         g7W7jqGUm4nzWI01J6Ul1JxZcEbMXqtZSar7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0q/rCvNt3k405F9K/TajOpXPAtgojFFtnqWJkLPEMF4=;
        b=WavJCnHzEpomxzcdtxzx8ZnoEEBGmg3f0YRWVmxvhyztijHFQLrc3z1hyGmqpXdg9P
         U0bTxmt8G5Ox/HJxMFpvbvLnmE5uV308PshG/j8xYxZToI9vvIlXq/847ajtVJWT+SFY
         fS3VJP3z35gUl1gaQPu7pP3G4GWmqnTwP0qSAO9eQURzPgO5N/to1G1ytwG25ApUO+97
         jydhr6pwaQ7F+uhhvC/3jhKYPHsXv7S3vL+PBlx5382/DG8d0gLOW/+4jNoTGZmz5S+R
         LavR1XOvSfOShMCCzYE2KDawcvcIegSVntpv3x1XdnaUh0jJ3FR8bfvLtNhjdWhDGb9S
         OOGg==
X-Gm-Message-State: AOAM532NksSx6YDs4e4vXkTM31lxAmhHXg1o9aeMbu+WjJ5AQfajmZN3
        vGHLDpP0N+KkZ7trMiCFCtc7Cg==
X-Google-Smtp-Source: ABdhPJxezNzU/FHc9DH0NCqtmmgu7yFn9tCxihSQrSv2FyCRlXKSWOfUQMA/NNJhOf+7Z3KfioxOBA==
X-Received: by 2002:a62:a217:: with SMTP id m23mr27037150pff.291.1594308929281;
        Thu, 09 Jul 2020 08:35:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id b8sm3221741pjm.31.2020.07.09.08.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 08:35:28 -0700 (PDT)
Date:   Thu, 9 Jul 2020 08:35:27 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mike Tipton <mdtipton@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, agross@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add generic qcom bindings
Message-ID: <20200709153527.GJ3191083@google.com>
References: <20200623040515.23317-1-mdtipton@codeaurora.org>
 <20200623040515.23317-2-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623040515.23317-2-mdtipton@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 09:05:14PM -0700, Mike Tipton wrote:
> Add generic qcom interconnect bindings that are common across platforms. In
> particular, these include QCOM_ICC_TAG_* macros that clients can use when
> calling icc_set_tag().
> 
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> ---
>  include/dt-bindings/interconnect/qcom,icc.h | 26 +++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,icc.h
> 
> diff --git a/include/dt-bindings/interconnect/qcom,icc.h b/include/dt-bindings/interconnect/qcom,icc.h
> new file mode 100644
> index 000000000000..cd34f36daaaa
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,icc.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_ICC_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_ICC_H
> +
> +/*
> + * The AMC bucket denotes constraints that are applied to hardware when
> + * icc_set_bw() completes, whereas the WAKE and SLEEP constraints are applied
> + * when the execution environment transitions between active and low power mode.
> + */
> +#define QCOM_ICC_BUCKET_AMC		0
> +#define QCOM_ICC_BUCKET_WAKE		1
> +#define QCOM_ICC_BUCKET_SLEEP		2
> +#define QCOM_ICC_NUM_BUCKETS		3
> +
> +#define QCOM_ICC_TAG_AMC		(1 << QCOM_ICC_BUCKET_AMC)
> +#define QCOM_ICC_TAG_WAKE		(1 << QCOM_ICC_BUCKET_WAKE)
> +#define QCOM_ICC_TAG_SLEEP		(1 << QCOM_ICC_BUCKET_SLEEP)
> +#define QCOM_ICC_TAG_ACTIVE_ONLY	(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE)
> +#define QCOM_ICC_TAG_ALWAYS		(QCOM_ICC_TAG_AMC | QCOM_ICC_TAG_WAKE |\
> +					 QCOM_ICC_TAG_SLEEP)
> +
> +#endif

Would it make sense to squash the two patches of this series into a
single patch? This would make it more evident that this was moved
from drivers/interconnect/qcom/icc-rpmh.h and avoid duplicate
definitions if only this patch was applied.
