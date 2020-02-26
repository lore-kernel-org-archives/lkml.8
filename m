Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21004C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B2A206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PI1PswYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgBZItf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:49:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39410 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgBZItf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:49:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so2043785wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 00:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8JbXsvCikThW9EDnMbwsvFGe/45UV8vfI9xGN1UFZdw=;
        b=PI1PswYgVuOC1yR/vclMSbxz5we9tYJqxzFvTV4fG6gXAb2SXeeg7gwVp9r/OVm13K
         nmQNHmiTYNPqTyXQX9kjj8sWG2KwM2eR0D2G6+qn32ab9VBHLFyKWuIjo3k6l0SSX/RN
         DNSfqHb0zTdREn4814PzGD9A0Kl/S1DTgqSM2MGY+dUTqiEWp3s0at6zEw75M7tV+US9
         tef5MGNLepYldqezhKARN7t4WKCAKO/VlhBn5Gye2HiW8/9IZcqxkohnAsBGQfqJ6l1C
         vFVzSkkXT1ENLoz+KqB6/BnqpvEzTzmx3NuqW38A0qc41S4tmKvQUrWTxHErH8kcLluK
         iI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8JbXsvCikThW9EDnMbwsvFGe/45UV8vfI9xGN1UFZdw=;
        b=EBECYOQsSW/o3j0MgUW5raHttfXXiurxhzRPe/UdNArwJ6qgFbxUvTSii13P3nXYuF
         Spp3WaqS3EhAqeOJp4/XheLapnWVOeqCJd/Ptj/viQVeErtV6ROKykk9Cc/CT87hmBts
         Vr9EOlksaeHZ+AfUgE762Ksjo4g9Qj9o5bD2VkmRJTxnlMxkrBqXllWyq+XPYOOluuwX
         zEPm5XkBUWJyiJfeUaQMNsjXH1kPxWXxoPf7X6fadQb440nOFy00d2YP8fLSMC22cm0a
         YX4rTGdM9kpjjldwaXjfClhnSLX2/oxuDNmoxvvXRukNUhDVTLm+yOalLJS68Xns8c/x
         jesw==
X-Gm-Message-State: APjAAAX7+XftbL7fe82Pp8BZsiaJ59+wz+Fltw8LAoT9x40ULhFMGGHx
        DgXixWJaSZLd0Vqk58a8DRydZlk/pXU=
X-Google-Smtp-Source: APXvYqxVMmTr+1UWt/aUaZ5EfYeGwJq25ANzh7r2q6KlnsCe3kvY5mkCqS0455y2R7Z90JXPBoSI8A==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr4212058wmb.186.1582706973291;
        Wed, 26 Feb 2020 00:49:33 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id f8sm2332466wrt.28.2020.02.26.00.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:49:32 -0800 (PST)
Date:   Wed, 26 Feb 2020 08:50:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1] mfd: dln2: Fix sanity checking for endpoints
Message-ID: <20200226085004.GB3494@dell>
References: <20200218134348.10523-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200218134348.10523-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020, Andy Shevchenko wrote:

> While the commit 2b8bd606b1e6 ("mfd: dln2: More sanity checking for endpoints")
> tries to harden the sanity checks it made at the same time a regression,
> i.e.  mixed in and out endpoints. Obviously it should have been not tested on
> real hardware at that time, but unluckily it didn't happen.

This is why I usually insist on defining magic numbers.

That would be a better solution I feel.

> So, fix above mentioned typo and make device being enumerated again.
> 
> Fixes: 2b8bd606b1e6 ("mfd: dln2: More sanity checking for endpoints")
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/dln2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> index 984d6b438aca..3a729b196b1f 100644
> --- a/drivers/mfd/dln2.c
> +++ b/drivers/mfd/dln2.c
> @@ -754,8 +754,8 @@ static int dln2_probe(struct usb_interface *interface,
>  	    hostif->desc.bNumEndpoints < 2)
>  		return -ENODEV;
>  
> -	epin = &hostif->endpoint[0].desc;
> -	epout = &hostif->endpoint[1].desc;
> +	epin = &hostif->endpoint[1].desc;
> +	epout = &hostif->endpoint[0].desc;
>  	if (!usb_endpoint_is_bulk_out(epout))
>  		return -ENODEV;
>  	if (!usb_endpoint_is_bulk_in(epin))

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
