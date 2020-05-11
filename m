Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D3FC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD0D4206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nriex5rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgEKQTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728556AbgEKQTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:19:34 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAF7C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:19:34 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k6so10404549iob.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5ultGYWM+kfVUYl0Re6KP46o+DUiGBX2CPe2HnhgSc=;
        b=nriex5rlMS5ZsBeaDpFICXYiiBtfrgAuBtSp+OnnEr07vu/8XPmuGDpGaSjT1+ghA2
         9rCdJbniSEQlWagTWL5/nm1BjG9Zn/TsfH5kleNw/4v9OZfKbgPCnrCyNankn93I+hKK
         mOQAAbJ6VFajiDuDTt08lyywtkMW/Clf5KPeqUoZly6UpGEULps5WEJiEIYTcibkeywy
         6tTPZQtKb4itbJ0zchS4vkCddRFdSrK5EFJCq/nBDhEv2lgiwEBYBWtpPAXjD1xifPZ4
         Uk2RJ1JZk5fjOfpNJl66v//Gvd2m2abQg4d2HBYFkMRtwJfnS78FaKDbiYj4S3235Rod
         cCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5ultGYWM+kfVUYl0Re6KP46o+DUiGBX2CPe2HnhgSc=;
        b=uL7yoh3+kOJcQa5ZH1/PBwqyXKfS1jQcViC23bBLHZIHOSsyboRYYlgNT3ayfy8Qv6
         3cCDXf9N6GcSSapiCx4OG8XbQlXc4yzWvykfY4K6iRKOP03sFeQD3VZoNib78bsaPmRJ
         fnO+mQ8/W8QO/gm57q3lpr876JBef9302XK3GVLj1q+xEnIJ0vbL5MFMjmlfZ9LK7F0T
         iixmNxKsG50SQLGSHk9rGu2Y1fexvoS5zTEmihUT5QNvI3rEBlpc8rqOrpnS+t5wWqkE
         U13n87YzBnn/r9njKZ2FdpBMSV2UFNsiGC4j5nDJXCrDYdNtRlzMshe3J2XFFbQRLYo/
         X5oA==
X-Gm-Message-State: AGi0PuYR8nztKAwiDi0q0fOxcO+vKLeyedAmzBDcb23WhmtwzGxCwYis
        8TAL00Q22ip5xJmtDNNe3A78VGg+llfqcDPkA7nh+Q==
X-Google-Smtp-Source: APiQypIG522t0DAZMpOjlzhdn49pBkF6ZH6NY71G/guvuD3UeKSFMkvkzdllJUW4hevTFT8SMr9vzW9j3KAqXSdMgas=
X-Received: by 2002:a5d:8d1a:: with SMTP id p26mr2156549ioj.131.1589213972847;
 Mon, 11 May 2020 09:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200511083400.26554-1-saiprakash.ranjan@codeaurora.org>
In-Reply-To: <20200511083400.26554-1-saiprakash.ranjan@codeaurora.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 11 May 2020 10:19:22 -0600
Message-ID: <CANLsYkx640pjt_crfHMUQt25w-xOfoVteYVpocYgPHRw-y-WeQ@mail.gmail.com>
Subject: Re: [PATCH] coresight: replicator: Reset replicator if context is lost
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

On Mon, 11 May 2020 at 02:34, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> On some QCOM SoCs, replicators in Always-On domain loses its
> context as soon as the clock is disabled. Currently as a part
> of pm_runtime workqueue, clock is disabled after the replicator
> is initialized by amba_pm_runtime_suspend assuming that context
> is not lost which is not true for replicators with such
> limitations. Hence check the replicator idfilter registers
> in dynamic_replicator_enable() and reset again.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>
> More info here - https://lore.kernel.org/patchwork/patch/1231182/
>
> ---
>  drivers/hwtracing/coresight/coresight-replicator.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index e7dc1c31d20d..11df63f51071 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -68,6 +68,17 @@ static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
>         int rc = 0;
>         u32 reg;
>
> +       /*
> +        * On some QCOM SoCs with replicators in Always-On domain, disabling
> +        * clock will result in replicator losing its context. Currently
> +        * as a part of pm_runtime workqueue, amba_pm_runtime_suspend disables
> +        * clock assuming the context is not lost which is not true for cases
> +        * with hardware limitations as the above.
> +        */
> +       if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0) &&
> +           (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0))
> +               dynamic_replicator_reset(drvdata);
> +

Based on your comment here[1] and the ongoing conversation, I will
wait for a V2.

Thanks,
Mathieu

[1]. https://lkml.org/lkml/2020/5/11/650

>         switch (outport) {
>         case 0:
>                 reg = REPLICATOR_IDFILTER0;
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
