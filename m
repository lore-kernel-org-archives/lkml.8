Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F490C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0A320771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYjoP/t+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438243AbgDPHHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437060AbgDPHHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:07:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F10C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:07:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so3407926wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=A6wKLGtd50OKgYXcdDZZHFJ4Jbv+Z5+XK/O56sFh+Ks=;
        b=IYjoP/t+QDQrS7LpjoPocIxI4DZlQTIFJmQku0alpWKJHE4maTnXkL+Vye6RnHia0K
         QO/0lknv6vOtiObqLGYLdbmoA6kDB+eFsZXBUE96k8W74Ha1KezKqT5Edo6qREojmuMq
         vgp5MTdxJ9zIlOARse3f511urB5QkeAV2OoSGyweIpJLlUfwM8jDXK0gOndP1K5l15nv
         GJjq07p2h7ftV0Atgqih7B7uLjs4mjJgg5t+ZJrr5TCzHjACu8yK2nU6BrQ3MRpX8wj0
         bmF2B9HVDGgpsn+54qihf3CGtqLw2uvzPeZ+AIAGlgtMk0uDqy3h78yGcpb3ePqsNfra
         VqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=A6wKLGtd50OKgYXcdDZZHFJ4Jbv+Z5+XK/O56sFh+Ks=;
        b=tqZxWoFDSCZr2A+rVC7IUpIkxwuwzCzQf5H4qKkFd99P3s2vKej2a5hgCtiOTh4Y3o
         zSKP8DY5Pa9O+iyi+QtyRRG+0pvUkWyxdW6DUJHI4887xGTh/7hlnP1tdHwWYco+gdX2
         vH9nsIbJPtX4RwZk+P7iZVMB9TijRGVr+F7/bQnUQeoVnrdvdb3h91LIH0zIF/Havm+q
         k44CEWH4OVs/c+HB7rLBQA8/qb5hYuNxdCLfLke8wXehE6roTelE9UPvKrbicecSp4Dq
         VxRrO3T03pStFIC7xHPZsIH09wOINkX9okKcl4z9XxsfmQTfAO7KYHw03v7KJZKWeLMC
         rsmQ==
X-Gm-Message-State: AGi0Puakmnpx+zGdpU/PxdE6hEcUPow/hknMPsT/8KANvK64gLqwdUs7
        Yyelh7SJTnKD9P8f8m7u6QnyhhRud9Q=
X-Google-Smtp-Source: APiQypL5oE/VED78mXQNK2lpCPpXbsTvzU8LZEhJOekVFjrizDQlM7ZOW5kcY74RYyS9Cw06C3N9TQ==
X-Received: by 2002:a1c:2007:: with SMTP id g7mr3268181wmg.70.1587020827961;
        Thu, 16 Apr 2020 00:07:07 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id r5sm2429200wmr.15.2020.04.16.00.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 00:07:07 -0700 (PDT)
Date:   Thu, 16 Apr 2020 08:08:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd:asic3:Delete redundant variable definition
Message-ID: <20200416070802.GQ2167633@dell>
References: <20200403042020.17452-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200403042020.17452-1-tangbin@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Apr 2020, Tang Bin wrote:

> In this function, 'ret' is always assigned, even if 'pdata->leds'
> don't carry out,it has already been assigned a value in the above
> code, including '0',so it's redundant.

Which line initialises/assigns 'ret' before this one?

> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/mfd/asic3.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
> index a6bd2134c..cee7454b3 100644
> --- a/drivers/mfd/asic3.c
> +++ b/drivers/mfd/asic3.c
> @@ -924,7 +924,6 @@ static int __init asic3_mfd_probe(struct platform_device *pdev,
>  			goto out;
>  	}
>  
> -	ret = 0;
>  	if (pdata->leds) {
>  		int i;
>  

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
