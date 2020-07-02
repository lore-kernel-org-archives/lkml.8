Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFF3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F127F2088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kwLccC1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgGBUNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBUNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:13:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDD2C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 13:13:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so30016977wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=U0gw4d6sEKgljMIw/xorufjd8mwmlkHltY0nbeUDOQM=;
        b=kwLccC1jdmZ9S/sUIxMZYAluj9tT/wXdOzG/dR+FetpUWimq2lxiiwlfHzplVLVXRi
         mDeojQYiHjHJSxP9Hj/LYA9pKrxGWiVnsrIMuPwq4b9oZ2N1v7L2+JskNhJ9RfA0uMou
         S9j+a80Bdri/1MJ8MybUrqsRQuChqJVpE6b75FeQUqf3ofjIuNMWp2u1rTkZcP+G2ssK
         IGpG5EfgjFe498A8JMuQ+KZWWWPRm8ymFfC9u0MLTy81n8g2APX42whPf2sdrigH7PFJ
         ZT5oVGApgWFiuJd6eq3mH4Tm2a/EOohFPQ8rNG+KMJr7F3Bj0x7uCKCfD7V4376q1HHM
         nsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U0gw4d6sEKgljMIw/xorufjd8mwmlkHltY0nbeUDOQM=;
        b=Npdvj8q9jBCjLIwAWF4isnQcmmXO6tMqpgSWWZg8wQ8XgEjAfxO6BZF6lkFVZx9f7T
         341cAWvcsmjN7QS41YjE+UtaIYQdH8L+ake9z3yEXAGbKylPoMWiQPXRubxj6lA9Xp/m
         96ZsTSocrrupvtPj0p8VLUBrMYz0kDRVeI8KHRHguvlndJ5k6V1Zskbu/8qYMnZzPh0N
         hGoPs1Eob00Yj4I8jfA5hBhLyDU2xJTcwOJgdvpT/tA6cUE4lvEMxL+4hX/BuTzilZdL
         hcI23qFEcoHHYlA9tI588ChtT9XN8CaevrWO2QBVHH+n/eW8CzQJANDFVinwGK82wxEQ
         au5A==
X-Gm-Message-State: AOAM532Hvi90zVJ1f4bdfURh/DqK1IQxg4ELWCWE49vX8Cz+ZrJTYac/
        1MSdDNCE4vyq0fKixfRExhZJdA==
X-Google-Smtp-Source: ABdhPJzTK2k0WyLaXLeQ6CWKeQub3nkJmFi+VIBMJau3t+pYqru1fQrmoNRj4kXNlirbg6PvravgPw==
X-Received: by 2002:a05:600c:414f:: with SMTP id h15mr23304225wmm.82.1593720831500;
        Thu, 02 Jul 2020 13:13:51 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id u1sm2812615wrb.78.2020.07.02.13.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:13:50 -0700 (PDT)
Date:   Thu, 2 Jul 2020 21:13:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 15/15] mmc: host: sdhci-iproc: Tell the compiler that
 ACPI functions may not be used
Message-ID: <20200702201348.GT1179328@dell>
References: <20200701124702.908713-1-lee.jones@linaro.org>
 <20200701124702.908713-16-lee.jones@linaro.org>
 <3a32b98c-45c6-6f8d-0853-161f91e65b57@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a32b98c-45c6-6f8d-0853-161f91e65b57@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jul 2020, Scott Branden wrote:

> Hi Lee,
> 
> On 2020-07-01 5:47 a.m., Lee Jones wrote:
> > ... as is the case when !CONFIG_ACPI.
> > 
> > Fixes the following W=1 kernel build warning:
> > 
> >   mmc/host/sdhci-iproc.c:297:36: warning: ‘sdhci_iproc_acpi_ids’ defined but not used [-Wunused-const-variable=]
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ray Jui <rjui@broadcom.com>
> > Cc: Scott Branden <sbranden@broadcom.com>
> > Cc: bcm-kernel-feedback-list@broadcom.com
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/mmc/host/sdhci-iproc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> > index 225603148d7de..9c7d130205edd 100644
> > --- a/drivers/mmc/host/sdhci-iproc.c
> > +++ b/drivers/mmc/host/sdhci-iproc.c
> > @@ -294,7 +294,7 @@ static const struct of_device_id sdhci_iproc_of_match[] = {
> >   };
> >   MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);

> Would it better to compile this in if CONFIG_ACPI is defined instead?
> #if CONFIG_ACPI

Literally can't win.

 https://lore.kernel.org/linux-arm-kernel/CAGb2v66Ws4WNPZbOYQvikKoozj_2WjzS-Jq-o2VxT77=k0vODw@mail.gmail.com/

Damned if we do, damned if we don't. ;)

> > -static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
> > +static const struct acpi_device_id __maybe_unused sdhci_iproc_acpi_ids[] = {
> >   	{ .id = "BRCM5871", .driver_data = (kernel_ulong_t)&iproc_cygnus_data },
> >   	{ .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
> >   	{ /* sentinel */ }
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
