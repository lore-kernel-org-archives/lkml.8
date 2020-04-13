Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2A1C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 23:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69BF20739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 23:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c4eu2TsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbgDMXN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 19:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389929AbgDMXN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 19:13:26 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33943C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:13:25 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t11so7881501lfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXGNQQP4X3VX81J+kdAMQQHyCz96RnLdOdy+FSwZIMU=;
        b=c4eu2TsEdrQ5/05Gmd4JKvLX1E9PqFEvEqAm++vbEwjW5ViflcKiCykyDvWlCsMKip
         Ln9fa5zS5CzsUazSEwGQuS6uLeUtQXeuUsRs8rHx/ZSgb7malGhvFYaTAW3dqdWegXYF
         NDNnFSbGrDUe+wgoG3LKqKNwlWDWgWIuod6Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXGNQQP4X3VX81J+kdAMQQHyCz96RnLdOdy+FSwZIMU=;
        b=PaBEF0QnY6tOxiuy4zJw1QEQP0bz+o+ontWUYOu4lYztFq5efj4X1WXkG/9f2x/q5/
         0N6sGNel6TxZTjKIRSPeHxcFNtkeIEvX1heaEeRJBoTpfKWOKbXI043TUZjQ40O/FtAy
         inC/CH20sFji5jD1sSdp2AaNppNeT9XR7bmvAdY7/7PX9+HidHaSrH0SbtjdoY17MrM4
         DerxQ3ZuZfwr17p6sZM3CeSKPS/6xnfyDORh/z0/1H/vriavBDe6t0r5AQb3mTJk4+Br
         VAVS4L3AXRuONzoOY3UbbmiGnkQye7yDOwEKHcmYfRGUEy4qiF8kR1ycBVl0bXUeKwSR
         Ai4Q==
X-Gm-Message-State: AGi0PuZ+y0c0PfxLVG4/aFGjHrq68fj+CVHY3TSTujH+t/84XGMoEs+C
        qUFLXts35ZJ77FVljDIMYSyQzSfc0js=
X-Google-Smtp-Source: APiQypKjZ13NvdA3Iann9K1efgFkuRsqQjXItWcryc8u4zUwrQJfeRwEpwVlGz4CgVmNhTYHcQAKqQ==
X-Received: by 2002:a05:6512:d1:: with SMTP id c17mr11956217lfp.167.1586819603206;
        Mon, 13 Apr 2020 16:13:23 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id k21sm4542169ljc.81.2020.04.13.16.13.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 16:13:22 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id t11so7881435lfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:13:21 -0700 (PDT)
X-Received: by 2002:a19:4a03:: with SMTP id x3mr11835226lfa.159.1586819601453;
 Mon, 13 Apr 2020 16:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org> <813cc5b2da10c27db982254b274bf26008a9e6da.1579692800.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <813cc5b2da10c27db982254b274bf26008a9e6da.1579692800.git.saiprakash.ranjan@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 13 Apr 2020 16:12:44 -0700
X-Gmail-Original-Message-ID: <CAE=gft7HFBc7XtgiV1hkG-m3ONMUiE2vu8Vg_7Mu1dfe2BjYpA@mail.gmail.com>
Message-ID: <CAE=gft7HFBc7XtgiV1hkG-m3ONMUiE2vu8Vg_7Mu1dfe2BjYpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Allow client devices to select direct mapping
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 3:48 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> From: Jordan Crouse <jcrouse@codeaurora.org>
>
> Some client devices want to directly map the IOMMU themselves instead
> of using the DMA domain. Allow those devices to opt in to direct
> mapping by way of a list of compatible strings.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Co-developed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-qcom.c | 39 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.c      |  3 +++
>  drivers/iommu/arm-smmu.h      |  5 +++++
>  3 files changed, 47 insertions(+)
>
> diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> index 64a4ab270ab7..ff746acd1c81 100644
> --- a/drivers/iommu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm-smmu-qcom.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>   */
>
> +#include <linux/of_device.h>
>  #include <linux/qcom_scm.h>
>
>  #include "arm-smmu.h"
> @@ -11,6 +12,43 @@ struct qcom_smmu {
>         struct arm_smmu_device smmu;
>  };
>
> +static const struct arm_smmu_client_match_data qcom_adreno = {
> +       .direct_mapping = true,
> +};
> +
> +static const struct arm_smmu_client_match_data qcom_mdss = {
> +       .direct_mapping = true,

I don't actually see direct_mapping being used. Shouldn't this member
be checked somewhere?

-Evan
