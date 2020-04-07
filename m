Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE311C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D77820730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y1pqSFEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgDGGPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:15:30 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40217 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDGGPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:15:30 -0400
Received: by mail-pj1-f66.google.com with SMTP id kx8so302025pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 23:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fEIqeEmnHR4VL1Tnz06wxL1tDtYZh8O0YFMdittrvdc=;
        b=y1pqSFEkmWsND2TA4O92usByCfgNi9LYD8b5RYzM2l4cL2WXaBRJQV/2+uhmDB8Aq6
         yuEq/8npHPWpl5vGpknMxFP862x9r6JTehMqgpLw5iRpwi65aiU58j4a9pDG/WvhYPb7
         bvcPFkeav++vUe9tGu9OJ0bHDyPwUYcxoZPi5rHq1V9nHvwVSl3SBaZe9w4oOj0qw9Jo
         tZbK/kjQowFso4aSfNCfqNLRgmsAemcEiWrLNgCnNZCW6KCpj2M3Z6OEALkwO/9xEBLH
         z/DMxC4Jej3xO6BMLJ7LzhKkdU2kR5z0UKbdX4PVFGkMWLdv61JFAiduFGrMwkNXEu7U
         bazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fEIqeEmnHR4VL1Tnz06wxL1tDtYZh8O0YFMdittrvdc=;
        b=LCXDA7XWzCRHtDrBlYtT02g7Kqc2T1bbgUPs2WFCh5KrH/+KOEv02nb/Klx9cdar/h
         pvn6QN8Ecf9xIh8FLGSsVKhEK2rZ5tpx6yqMitRr49/s3KzUAIyhkgOGx8n2oxcWB53p
         arCMbfAgs89ierKKp1bztIsGRdKV3EiW5tI0RulviAeMvN8neLj+iqLxHr9WRSaE0tKo
         XDdudSeogJqeXvFNbkpMXHidaedZki/sXQq0rX5hc8iT2WbAVZtjDZUMeAjvENs5x3JU
         Wd2m2Vm2gknbhTe5Co197+SZG2MmgJfUf7wjyyPIGr4PynnK+95+USSOR3i6Ag29upfF
         hsPw==
X-Gm-Message-State: AGi0PuZ9oGKdrLiL5IRBeiVgFByqWo1aMP2QRolTeBZIXwl0WDfMGUL5
        VOuw+e7LFit/omEFuAM8OvMXHg==
X-Google-Smtp-Source: APiQypIku5Lm6YYYlW1dpEix4cJ2o/v/7l1PWYoX6qIkRNJjo8wpaP+/Kt4RgOl+bpzsQHMzs6HUVA==
X-Received: by 2002:a17:902:7c93:: with SMTP id y19mr961074pll.155.1586240128918;
        Mon, 06 Apr 2020 23:15:28 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id na18sm688432pjb.31.2020.04.06.23.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 23:15:28 -0700 (PDT)
Date:   Mon, 6 Apr 2020 23:15:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] soc: qcom: smp2p: Delete an error message in
 qcom_smp2p_probe()
Message-ID: <20200407061533.GA576963@builder.lan>
References: <eb92fcfb-6181-1f9d-2601-61e5231bd892@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb92fcfb-6181-1f9d-2601-61e5231bd892@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 05 Apr 09:12 PDT 2020, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 5 Apr 2020 18:08:13 +0200
> 
> The function “platform_get_irq” can log an error already.
> Thus omit a redundant message for the exception handling in the
> calling function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks Markus, picked up for 5.8.

Regards,
Bjorn

> ---
>  drivers/soc/qcom/smp2p.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> index c7300d54e444..07183d731d74 100644
> --- a/drivers/soc/qcom/smp2p.c
> +++ b/drivers/soc/qcom/smp2p.c
> @@ -474,10 +474,8 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
>  		goto report_read_failure;
> 
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "unable to acquire smp2p interrupt\n");
> +	if (irq < 0)
>  		return irq;
> -	}
> 
>  	smp2p->mbox_client.dev = &pdev->dev;
>  	smp2p->mbox_client.knows_txdone = true;
> --
> 2.26.0
> 
