Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EB4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F3A206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nkBUMx+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgFPICD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPICA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:02:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C46C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:01:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y20so2046022wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=k3IyOecJ9U8+RFNYzcJYgMtOOcr6g2iirCuzmycgq3U=;
        b=nkBUMx+bauu7tHtywYZH+P3WU21cPGV7QxrxKt+P4lqpdb1RNLJJ7QDbvG2CvCP3j3
         afQ7JUBQLjBACAB6q7xCQyjmgXr0YQrWJo7pHrnEHInQD2sn1bWBWtjUl5iI9NN41aXI
         EtfuP8d+/H/w0C5NBJOf7wdPUXKwBhOPMi4pQPmP9jiOgT2DqQt2eMMlOUXFDXefc5py
         w3NwBUH+icYj3jn6XuqNnI0AcXykDJfFzNs79IGJkXlHO0sSIMVBiIRmQ07RQjve1e81
         hqlqksW9bQdOU02VZ3cpW4TPZ/IFc7R2/bXrJJHOIYMkfAeuqGI6/8LoFm8FusYIHnI/
         29YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k3IyOecJ9U8+RFNYzcJYgMtOOcr6g2iirCuzmycgq3U=;
        b=jjBv1KhCrqNihBV+ENwQUQ7v+Wz6VGEcTc/+aylJIrbQ4g0SHGlkDKfdfSEXpPh9+j
         t8CKGSSynbvwl0dgADBEDan5IyGrcixyOQh0Kcyqst4cqLXlI3G+C4FHFiBB5dtU2M+P
         O1oZAn62jOeiqkxTCFGvmgCXmLEeWVdtqNQRA2YNDv9eqOjGnUooJKWtm6JaogiikIrC
         ZGar4HVPi8qqpMJepPQCVusZlZvb3HU0pEcSBlOBVEdGG9XEXxL2S36h3rzLQfRgjQfU
         toPn12PM5UO9vnF1kCnthuWdjp4d6lI+c8jcQfbJfqDyNJgrIf33pi/UOaR5O861jnrV
         aW5Q==
X-Gm-Message-State: AOAM530J/1SGv8vqmNOW8Tbn/3SvBJtsSEPKgpn5qMQPbXqjzvjSzzrZ
        DVAnJvjN6Nj/bZWCamFxOyWzmw==
X-Google-Smtp-Source: ABdhPJwC9O1cX1bz3pVrfK8wV4xAvHFn5HcuDqJiOwjfTE2sEPvZgDVLYz5l5PxZKps81fvVXWPCVw==
X-Received: by 2002:a1c:49d6:: with SMTP id w205mr1921297wma.151.1592294513848;
        Tue, 16 Jun 2020 01:01:53 -0700 (PDT)
Received: from dell ([109.180.115.156])
        by smtp.gmail.com with ESMTPSA id m129sm2966824wmf.2.2020.06.16.01.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:01:53 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:01:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     s.nawrocki@samsung.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2 3/4] mfd: madera: Remove unused forward declaration of
 madera_codec_pdata
Message-ID: <20200616080151.GI2608702@dell>
References: <20200615135323.15215-1-ckeepax@opensource.cirrus.com>
 <20200615135323.15215-3-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615135323.15215-3-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020, Charles Keepax wrote:

> This forward declaration is redundant since the header including the
> full data structure is included.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> New since v1 of the series.
> 
> Thanks,
> Charles
> 
>  include/linux/mfd/madera/pdata.h | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
