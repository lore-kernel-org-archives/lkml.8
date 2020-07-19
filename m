Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B791FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 04:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F62220656
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 04:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCbW7w8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgGSEe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 00:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGSEe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 00:34:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DDFC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 21:34:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so8715466pgf.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 21:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RhbYjjsEblGVOuvzmWtzkghGNNIuxewncjcXQDojD18=;
        b=hCbW7w8q3DIJ+GO6/km3FYPzqVf9Pws1jTbEbxW+51WpDajtn6MweSiLR0ErBCJne4
         xfOizeRktAI3+vhiKT4gHx525ovZatSRsgqw8+kY0gu2YVBBMvqlVUFfj3Tg+ZjRvQeD
         OWvxVNpR6QFtrEgiyIUDt+qFggF0QO1yu7E7gn7g53vZG1PElKB0wc12Os1z7mfFjwIV
         9mYi8DSIo8wStdRzWnFOeyF7iSuE+8VvUPejid6ya2VmyKdyHJ4vDX5/KmFtpMtoNlKg
         pM9K4RzX8FHbrznat+QFUQdSDz/RfkjVjck1OZ+tFe9EMwoznFwGEYBOFJdc/JRFq0l5
         zKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RhbYjjsEblGVOuvzmWtzkghGNNIuxewncjcXQDojD18=;
        b=MexJ7YPATrxnmg5tvVYOs2lVFd96wBpcyfyJKSUKxrYjS/4uw9kTcNGdKyQJ9UrEg5
         TxPVQhFmqbzML4epq6dR4RPKDuYEroVT/XqT7YaHd19TI7bS61fLmfE4op+SrDFCv6Fb
         5JrBUWt+yS+7JsRo2CDCX0SmGrlrfDaFSRHvBmsnZSnt+dIIOFiK4XSwYdn3JHUu/17m
         zeLei51AwsHxo/QWZ3sBEhgMCqeE3T2Tx363VZ5vnGJdq28zgO6/Gn+w1NQoNMBMTNrO
         xIRtnJfeFgilDJcRobKGa0g/gQqcamOIsE4SfZ6fYmyDgH/QiLCf5bCr5d7DEhkIuBP6
         GERA==
X-Gm-Message-State: AOAM533Cq/tDiIMIF6DMwJvgS5V8nvB+hIP2bEyA/HZvDj7SMdpKTXcx
        uyn0hlEqMVMc5cZ59OZgq86y7l/PVmgsiA==
X-Google-Smtp-Source: ABdhPJwE18GYMkdPelTI6cVgEYieCBABEOjhsycjTp2RvICPtMnZjo2Np9QXeIwCUgb8fjn/EjiTIA==
X-Received: by 2002:a63:e442:: with SMTP id i2mr14690576pgk.105.1595133297970;
        Sat, 18 Jul 2020 21:34:57 -0700 (PDT)
Received: from blackclown ([2405:204:219:61b6:3945:8436:8c57:56d5])
        by smtp.gmail.com with ESMTPSA id y198sm12046055pfg.116.2020.07.18.21.34.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 21:34:57 -0700 (PDT)
Date:   Sun, 19 Jul 2020 10:04:50 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rts5208: rtsx: Replace depracated MSI API
Message-ID: <20200719043450.GB28510@blackclown>
References: <20200718154030.GA28042@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718154030.GA28042@blackclown>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 09:10:30PM +0530, Suraj Upadhyay wrote:
> Replace depracated pci_enable_msi with pci_alloc_irq_vectors.
> 
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> ---
>  drivers/staging/rts5208/rtsx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Hii, don't merge this patch.
It is still incomplete.
It doesn't replace pci_disable_msi.
I hope this didn't cause any annoyances.

Thanks,

Suraj Upadhyay.

> diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
> index e28e162d004e..b39d3f8b54df 100644
> --- a/drivers/staging/rts5208/rtsx.c
> +++ b/drivers/staging/rts5208/rtsx.c
> @@ -310,7 +310,7 @@ static int __maybe_unused rtsx_resume(struct device *dev_d)
>  	pci_set_master(pci);
>  
>  	if (chip->msi_en) {
> -		if (pci_enable_msi(pci) < 0)
> +		if (pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI) < 0)
>  			chip->msi_en = 0;
>  	}
>  
> @@ -881,7 +881,7 @@ static int rtsx_probe(struct pci_dev *pci,
>  	dev_info(&pci->dev, "pci->irq = %d\n", pci->irq);
>  
>  	if (dev->chip->msi_en) {
> -		if (pci_enable_msi(pci) < 0)
> +		if (pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI) < 0)
>  			dev->chip->msi_en = 0;
>  	}
>  
> -- 
> 2.17.1
> 


