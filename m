Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D61EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34CB220809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOsvyRva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgG3Rbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 13:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgG3Rbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 13:31:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F7BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 10:31:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k13so6969628plk.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ILNdye9cVLfdysjIxugrVuHxI0LQBaSoR5uAbKyBjbU=;
        b=sOsvyRvaznHQ+fEqmpRqRvNQvCyyJMs5Zdyi8i4QcjV26kJw+TP5C/yk1DPvirm6QY
         Q8yUykPfNHfaljFJlJBZIMEMqbZx3ZC7XY3o/GlBCX6TnLjWPpZaocnuQxu7S9DBj3xG
         Z83Lv9aplqTUs+ucikhhP5lxcFwOpq68hDPZkPCAqEiBbTk4YMBv2y5qWx5Ge+q55H6a
         yy4+wvMa+nKrtZgZ+O1yhThz/rLTAAzwQQ9oL0lg7qGS8MLBTtOCz4ChdOSPdqYxORu3
         amrCjBYV4XunHfTSListkAe1VUQ/Uiy0geCVbIL2sMe1OeWZXU0tN3zwNHtpfaATWDUZ
         7s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ILNdye9cVLfdysjIxugrVuHxI0LQBaSoR5uAbKyBjbU=;
        b=cTNS169ZJJWGNLewOAZI4x3Z+75tCI0YnN8f6oNOl9uw2Fju32ajdn3n0Bsaz1G/Ax
         AfFTVvhjxlnAf8UEeSy6xI15VAk3Z4H7+arV2urbbRnWGARM6VD0nkw1+3dsQAvGC8i1
         9kxsIRBJYWuHZPncluEbyWrY+efXe2GJpW2YT68BbA03xpI4mdHWBjS2028VQEc88aJ6
         Cwx+4EbapqZ0OMmouvTRNDGnnd2p9N1GwX9ILn3A1W1uBzJujyxBuisTUoXJct/jmq9Z
         0xGwoIAhpKoarh7fKOz9qebGnE/ILat75PWkE4Kl7kknLIemTmTaSB13R2DqHYT2LmQe
         3n8g==
X-Gm-Message-State: AOAM531/TbDTVOa55nk5Gp6coCRTOtkrL7AKuVPYK+f5+e2pqs7f6I1f
        wDHgLdyD9+LuS8JQugC0FF2xLw==
X-Google-Smtp-Source: ABdhPJy4yB9ch9yzdH6jeNl8vHftgeKnzg7T5QjZqVQ83mo/HAsl0LCVdAkgUIKh+hfLtc3vpfjNkQ==
X-Received: by 2002:a17:902:a511:: with SMTP id s17mr254117plq.334.1596130294696;
        Thu, 30 Jul 2020 10:31:34 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y68sm6938528pfy.185.2020.07.30.10.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 10:31:33 -0700 (PDT)
Date:   Thu, 30 Jul 2020 11:31:31 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org
Subject: Re: [RFC PATCH 04/14] coresight: etm4x: Free up argument of
 etm4_init_arch_data
Message-ID: <20200730173131.GA3155687@xps15>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-5-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722172040.1299289-5-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 06:20:30PM +0100, Suzuki K Poulose wrote:
> etm4_init_arch_data is called early during the device probe,
> even before the coresight_device is registered. Since we are
> about to replace the direct access via abstraction layer, we
> need a way to pass in the csdev_access for the given device.
> Towards this free up the argument, which is already available
> via etmdrvdata[smp_processor_id()].
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 7bb74c659c4f..67deb4a4e618 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -614,7 +614,8 @@ static const struct coresight_ops etm4_cs_ops = {
>  	.source_ops	= &etm4_source_ops,
>  };
>  
> -static void etm4_init_arch_data(void *info)
> +
> +static void etm4_init_arch_data(void *__unused)
>  {
>  	u32 etmidr0;
>  	u32 etmidr1;
> @@ -622,8 +623,14 @@ static void etm4_init_arch_data(void *info)
>  	u32 etmidr3;
>  	u32 etmidr4;
>  	u32 etmidr5;
> -	struct etmv4_drvdata *drvdata = info;
> -	int i;
> +	struct etmv4_drvdata *drvdata;
> +	int i, cpu;
> +
> +	cpu = raw_smp_processor_id();

Can you provide details on the motivation to use the raw_ version over the regular
one?  As far as I can see in linux/smp.h there is no difference between them
unless DEBUB_PREEMPT is enabled.  Even then the debug version won't complain
since the task is CPU affined.

> +	drvdata = etmdrvdata[cpu];
> +
> +	if (WARN_ON(!etmdrvdata[cpu]))
> +		return;
>  
>  	/* Make sure all registers are accessible */
>  	etm4_os_unlock(drvdata);
> @@ -1517,7 +1524,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	etmdrvdata[drvdata->cpu] = drvdata;
>  
>  	if (smp_call_function_single(drvdata->cpu,
> -				etm4_init_arch_data,  drvdata, 1))
> +				etm4_init_arch_data,  NULL, 1))
>  		dev_err(dev, "ETM arch init failed\n");
>  
>  	ret = etm4_pm_setup_cpuslocked();
> -- 
> 2.24.1
> 
