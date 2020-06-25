Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81880C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623A520709
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcmE+Im9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390982AbgFYJk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389532AbgFYJk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:40:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A744C061795
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:40:55 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h5so5126711wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TlmH6CUdIAxBdzHoXkJA+99qDumm1XXj1357pinG+ZI=;
        b=YcmE+Im9XZ7cBXoYmYZkFd+TUXCQKZaFtyX9M0aBLCnTaDtwFXG10K875A7mhoZgFt
         71yo/XAjAgPkE6om6A1NlAGHl5mT5y+rnAdDz3TI3Bz7sJi8vkncQfEH9CTwuAIpUyc0
         fbTj0m2ZDGn7crejTzpH8uULmP6iMzU3QGX51+wJhV86k/NL3gAuPAKmhU89hYWVGoxI
         ddnqMAc2yOq5YxlYo6U+wHMioDAziVOu84iKChzwHytbpmGwuL5s1IZt26PKbH5oM4+T
         8rbFbtcP259jH0szLCcN2Snog/qW6IEqmYSOkq1HVbKvvLIkllftm6UYFoAOg6mchBRA
         yk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TlmH6CUdIAxBdzHoXkJA+99qDumm1XXj1357pinG+ZI=;
        b=D9r9kB+gS3B3rYAbJbb2hd03lfKS/ldD6xHw7cfYhvDMgqfQyUh5TjEs+o/9iEbl04
         agp1oF1AGNnTaHd0mGaynuC1QYPa01i7pCMQlR0P/Upg+wqbwzWozQSGdcSorVbyL2PV
         s9n2CBakoldUc0o894UcIXJfY/65ZfOB+aeUKpPtVw2//8YXeo/QhsJ0uqi4kVQKuTUp
         ZSTu9sOt4OY5ylskwAoDr5MpRXHytQA0gYSQ+1zpGXmc86rc0DumiAbOe5HPwQc3lqPz
         V+PIiCUt0HTZHLzBHVTia1cM7ptjg1Yh3rmctVdTfSiNYZ76HGV8coFuyK66VfnFW+1N
         n6QA==
X-Gm-Message-State: AOAM530rGCL71U+5Rv7TeN0m3Ar/snNyM2D1M3cFcmR80YnCnskUuf7r
        LM3cTI+/Sl28bxFNrbKl0bKJHWcrK44=
X-Google-Smtp-Source: ABdhPJy87UtoAD2RwowyPkHPcmUfIwaVK7ldX8ETiKlJPlPgPIPmViUdDBSNcBx2Wk03qCIhThHFvQ==
X-Received: by 2002:adf:b608:: with SMTP id f8mr36492832wre.363.1593078053819;
        Thu, 25 Jun 2020 02:40:53 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d9sm30518424wre.28.2020.06.25.02.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 02:40:53 -0700 (PDT)
Date:   Thu, 25 Jun 2020 10:40:51 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jingoohan1@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Software Engineering <sbabic@denx.de>
Subject: Re: [PATCH 3/8] backlight: ili922x: Add missing kerneldoc
 descriptions for CHECK_FREQ_REG() args
Message-ID: <20200625094051.u4hanl3rycczlwiy@holly.lan>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624145721.2590327-4-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624145721.2590327-4-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:57:16PM +0100, Lee Jones wrote:
> Kerneldoc syntax is used, but not complete.  Descriptions required.
> 
> Prevents warnings like:
> 
>  drivers/video/backlight/ili922x.c:116: warning: Function parameter or member 's' not described in 'CHECK_FREQ_REG'
>  drivers/video/backlight/ili922x.c:116: warning: Function parameter or member 'x' not described in 'CHECK_FREQ_REG'
> 
> Cc: <stable@vger.kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Software Engineering <sbabic@denx.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/video/backlight/ili922x.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
> index 9c5aa3fbb2842..8cb4b9d3c3bba 100644
> --- a/drivers/video/backlight/ili922x.c
> +++ b/drivers/video/backlight/ili922x.c
> @@ -107,6 +107,8 @@
>   *	lower frequency when the registers are read/written.
>   *	The macro sets the frequency in the spi_transfer structure if
>   *	the frequency exceeds the maximum value.
> + * @s: pointer to controller side proxy for an SPI slave device

What's wrong with "a pointer to an SPI device"?

I am aware, having looked it up to find out what the above actually
means, that this is how struct spi_device is described in its own kernel
doc but quoting at that level of detail of both overkill and confusing.


Daniel.


> + * @x: pointer to the read/write buffer pair
>   */
>  #define CHECK_FREQ_REG(s, x)	\
>  	do {			\
> -- 
> 2.25.1
> 
