Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE47DC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8507D206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DGV+F2+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHRITr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgHRITl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:19:41 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2657CC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:19:41 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j23so9666690vsq.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7qc0PHRmHyAV4s08h+mPSQ2AKSM82PMkMzXSGAIjIyU=;
        b=DGV+F2+cb52Nj0BMWEB9lOedhoMtfTPFWPkhPnUA07d4XhpQRQncJtBjzy9Qd4fQvO
         wKMC5NqMbgse/bTlW2J66+51iNFlL5zsDgzZ+IHpo/YO18KOA7/VLYohfqy1geb6Hv2T
         6AamAPl7j4a62C9ohOa3SKrwZwXb5kf0R/790=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7qc0PHRmHyAV4s08h+mPSQ2AKSM82PMkMzXSGAIjIyU=;
        b=qQ4b4eWRUvH2YuZst1EYccHe5mQ7dUb2iigEApcRh8PA7tKlkS8ErHl89THm6ytlrt
         ZcXUe71kwb/K1FlXe4umavhZxG6+FZmvhQjgETaryyHZRxfID2FFqV9hiuyYGClsIzmf
         eQojyUsT0nCTfOUne3/wWk8VWgAIVC8Gzge6hLwih5h/kePbMv03KblIit57DrijMoba
         XijLLGEpZLdrVdoF/MfOnDj/eMWnybMEBUHXUIp5dx1T3n0K9Q2j+QgVrH0xY+1xBIUf
         w/GmcD7r5DOAGhWWvOj130QXDChu5WJVEuO1UXjmakdaWgPqB+gv0yoPinKc09Ge1QRv
         xL2w==
X-Gm-Message-State: AOAM5333GB1zQ4ZwxtU3ehP6BWijRCrwzpWf1qaJ4Peh8EOCRjF3+373
        D4kNE8/1hqJPpnZroRn6/Nn655fj231uo8q6TFGvENn/RH0=
X-Google-Smtp-Source: ABdhPJzreYfi0fbtitn2tr3QZ68MpwlV8vAMN6ra3gV3OoMTaqXKSc8vnlwpvhOn3Pco3m2Op2M0MAJHaVOIWKWSBNM=
X-Received: by 2002:a67:68d2:: with SMTP id d201mr10537283vsc.186.1597738780361;
 Tue, 18 Aug 2020 01:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200710144747.RESEND.1.Ifae7abaacb81af1cdc6475986cc788d71de8a13c@changeid>
In-Reply-To: <20200710144747.RESEND.1.Ifae7abaacb81af1cdc6475986cc788d71de8a13c@changeid>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 18 Aug 2020 16:19:29 +0800
Message-ID: <CANMq1KAe5o8oxzTyVMNsoZXBuopVFQqFdKassu67Fssx0xk8Ww@mail.gmail.com>
Subject: Re: [RESEND PATCH] media: camss: vfe: Use trace_printk for debugging only
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        linux-arm-msm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 2:48 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> trace_printk should not be used in production code. Since
> tracing interrupts is presumably latency sensitive, pr_dbg is
> not appropriate, so guard the call with a preprocessor symbol
> that can be defined for debugging purpose.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> Sent this before as part of a series (whose 4th patch was a
> change that allows to detect such trace_printk), but maybe it's
> easier to get individual maintainer attention by splitting it.

Mauro, can I get your attention on this patch? This still applies on
the latest 5.9-rc1/linux-next.

Thanks!


>
>  drivers/media/platform/qcom/camss/camss-vfe-4-1.c | 2 ++
>  drivers/media/platform/qcom/camss/camss-vfe-4-7.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
> index 174a36be6f5d866..0c57171fae4f9e9 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
> @@ -936,8 +936,10 @@ static irqreturn_t vfe_isr(int irq, void *dev)
>
>         vfe->ops->isr_read(vfe, &value0, &value1);
>
> +#ifdef CAMSS_VFE_TRACE_IRQ
>         trace_printk("VFE: status0 = 0x%08x, status1 = 0x%08x\n",
>                      value0, value1);
> +#endif
>
>         if (value0 & VFE_0_IRQ_STATUS_0_RESET_ACK)
>                 vfe->isr_ops.reset_ack(vfe);
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
> index 0dca8bf9281e774..307675925e5c779 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
> @@ -1058,8 +1058,10 @@ static irqreturn_t vfe_isr(int irq, void *dev)
>
>         vfe->ops->isr_read(vfe, &value0, &value1);
>
> +#ifdef CAMSS_VFE_TRACE_IRQ
>         trace_printk("VFE: status0 = 0x%08x, status1 = 0x%08x\n",
>                      value0, value1);
> +#endif
>
>         if (value0 & VFE_0_IRQ_STATUS_0_RESET_ACK)
>                 vfe->isr_ops.reset_ack(vfe);
> --
> 2.27.0.383.g050319c2ae-goog
>
