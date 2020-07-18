Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49CAC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7D32076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNKJrMPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgGRP2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGRP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 11:28:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65514C0619D2;
        Sat, 18 Jul 2020 08:28:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t15so7770015pjq.5;
        Sat, 18 Jul 2020 08:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vLBlOX+xCLFwdjKITjGT3edrjFz/FA4boYyh19CkJFA=;
        b=qNKJrMPr9yz1jbbMLZbNdtaHYc8S4EHw8na7QRR9KksofNV4GcRJWNzT5F9Z7sh0rH
         ukBiGKYh81DAU2gDQfKQE5qEFrQLWcbgA2+dazm7wTPdkcSTbfy1yJOO15Qzij2ob1xo
         gRj/61bmmX4do0FvyItVowGSAfQkRxuLtf2mMVft1FhfUyOqu0NsqvJ4aeiZb3KvUl4M
         NxcFL+x8bG21OFcKpLCGhlk7ttIM2ML5tSgT8WbepY+ghbLSemqxqTZL+v4RQmIl8Wvd
         XtgOEEVpmeBOr1iR59m+yY3Yk1x5uDgwG9zxU4DlpwethOFjl4UMuTZ42xuYhUe58FKa
         0hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vLBlOX+xCLFwdjKITjGT3edrjFz/FA4boYyh19CkJFA=;
        b=g19DssC31uYlJoYm+0LKLRCtNtmw2RyLRzg0neZfmqsZA5XwbUAF8pjSLeoc1gysqb
         mweOYgfG0kcYoI04jzvrXdwFiEqAFPt/CO90v2nIVbLyvA8cskdaokUcc9+bE1Jr+sVw
         Fu+LK0Ej5z4Nto0U/bGicY58rRv/igkAOHTQRLGw0jBu3Dft32kBWkHV/7BMSEbDs7Ww
         tggnZZNPmwGqZXGyTRjqLeSaVeu/5R2/NuwKhRpQfxmxOe/osg/WPfnepCxu3fA4ZJxa
         lCGN/Eo1YhAc7Z/XJ0is2F/Uf/+5eMQWO9UQaFwpYdoSWdFh5qip755lFTbtYDZXz8w+
         gn8w==
X-Gm-Message-State: AOAM530yqO3eXcgbIe1Uc9jvj1zxoqcEK+Cad1SAduzMYMnUDSySKoqB
        DQp1rTOz/bOUZP+xvHv+Np0=
X-Google-Smtp-Source: ABdhPJxOu1A/jf62yQLZrubZtMFq2ZrWFJbfkEiZVzR7IiTNpim+NYbtMllpN4nyoyihT0LM/6oeAw==
X-Received: by 2002:a17:90a:43c3:: with SMTP id r61mr16006132pjg.216.1595086111658;
        Sat, 18 Jul 2020 08:28:31 -0700 (PDT)
Received: from blackclown ([103.88.82.25])
        by smtp.gmail.com with ESMTPSA id j5sm9898096pgi.42.2020.07.18.08.28.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 08:28:31 -0700 (PDT)
Date:   Sat, 18 Jul 2020 20:58:26 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: rtsx: Replace depracated MSI API
Message-ID: <20200718152826.GE26780@blackclown>
References: <20200718131856.GA10837@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718131856.GA10837@blackclown>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 06:48:56PM +0530, Suraj Upadhyay wrote:
> Replace depracated pci_enable_msi with pci_alloc_irq_vectors.
> 
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> ---
>  drivers/staging/rts5208/rtsx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
> index e28e162d004e..adc80e766412 100644
> --- a/drivers/staging/rts5208/rtsx.c
> +++ b/drivers/staging/rts5208/rtsx.c
> @@ -310,7 +310,7 @@ static int __maybe_unused rtsx_resume(struct device *dev_d)
>  	pci_set_master(pci);
>  
>  	if (chip->msi_en) {
> -		if (pci_enable_msi(pci) < 0)
> +		if (pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_MSI) < 0)
The conversion is buggy, It changes variable name.

>  			chip->msi_en = 0;
>  	}
>  
> @@ -881,7 +881,7 @@ static int rtsx_probe(struct pci_dev *pci,
>  	dev_info(&pci->dev, "pci->irq = %d\n", pci->irq);
>  
>  	if (dev->chip->msi_en) {
> -		if (pci_enable_msi(pci) < 0)
> +		if (pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_MSI) < 0)

This has the same mistake.

>  			dev->chip->msi_en = 0;
>  	}
>  
> -- 
> 2.17.1
> 

Resending this patch.
I hope this wasn't an annoyance.

Thanks,

Suraj Upadhyay


