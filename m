Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5FDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D4D720734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yYCvnUfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFAI4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAI4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:56:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCF7C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 01:56:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c3so10586085wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 01:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3lN90ESHdAtfWrT5T6IQG7bkz331NJLtWeswPh0blMI=;
        b=yYCvnUfMDp+IpLiYGROy8JhuG/gNCjiLWsEyLwA6eJG3REBPOHQBW1azw6mrVq7UjG
         RjYBQB36w4xgFyyrUsUQJmCJKsQPedPOPJUdTbVziRs8RW8iuViChfa3fgAl60VTif4r
         86xma4k4+nxQw2u7q2msgnOBam/fA3CZLQ1IJy00giqS+OwsV6DrJ1huLWyl53bs/0fo
         mTqLMnMP/wnqc92WjV+xvZvj/+A5XTuXG0LdU8GdEK5KVGIXj/wMGhWKT5OUaMhzsy/r
         dv7mySf2tt03qy9FIajeBW1AUN4QkyfApDN7fUfXisuYe70nFEDQxUD1G9aiob+wxQvn
         xAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3lN90ESHdAtfWrT5T6IQG7bkz331NJLtWeswPh0blMI=;
        b=nP60Pum+M4SqXmtF+tv0KA5itjBaHtzHxdv0v01tSbyHYb5eFqmAL4wep2uZEdhx0Z
         KIcSw/ukttK3pn3NAT98c6u7GZNYvhIP6iht5hSYJoHOj74Fgvl6LXWCCCKIPVTw8n2M
         2o0NmL5pdcRAfLj50yGr82JXK43ZTw+xQSIzUx14l+tPKsNZIRpwVPB9l8IrTRRxARof
         Pi5nNe0/0QhCkIMl9tUQpOVp/uybTABfsIrx9lRiYgdVaFTq4iB1gOSVwkQDA7nOCpFH
         8CMHf4Y+y4kLV71nNkH3/Qv9BSjxLms4oPBo6y3vYrq0t0CmA1b6nrVtN+QiIJhTk5Q9
         GW5A==
X-Gm-Message-State: AOAM532LAgTMBrW0piomP3Tg4G/mkK57pp3BS/UxCAyHraA106KnjGVy
        r/X4U3WJwS0PaTdHTBAs+bOIwUj4Mm4=
X-Google-Smtp-Source: ABdhPJxhwiG2vXXlQ/PE0ItyHpDeCTZPkvev1aWIDGhZjuz+sSJad4aotNWA6glGoQErQJOWyg0y1A==
X-Received: by 2002:adf:f4d2:: with SMTP id h18mr21135315wrp.370.1591001781750;
        Mon, 01 Jun 2020 01:56:21 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n204sm13005254wma.5.2020.06.01.01.56.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 01:56:21 -0700 (PDT)
Subject: Re: [PATCH] nvmem: Enforce nvmem stride in the sysfs interface
To:     Douglas Anderson <dianders@chromium.org>
Cc:     evgreen@chromium.org, Ravi Kumar Bokka <rbokka@codeaurora.org>,
        linux-kernel@vger.kernel.org
References: <20200528165250.1.Iad7dec5afecba175c816773a0088be805476453f@changeid>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5cff6fae-4f4d-216c-ab96-d0e3463ad876@linaro.org>
Date:   Mon, 1 Jun 2020 09:56:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200528165250.1.Iad7dec5afecba175c816773a0088be805476453f@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/05/2020 00:53, Douglas Anderson wrote:
> The 'struct nvmem_config' has a stride attribute that specifies the
> needed alignment for accesses into the nvmem.  This is used in
> nvmem_cell_info_to_nvmem_cell() but not in the sysfs read/write
> functions.  If the alignment is important in one place it's important
> everywhere, so let's add enforcement.
> 
> For now we'll consider it totally invalid to access with the wrong
> alignment.  We could relax this in the read case where we could just
> read some extra bytes and throw them away.  Relaxing it in the write
> case seems harder (and less safe?) since we'd have to read some data
> first and then write it back.  To keep it symmetric we'll just
> disallow it in both cases.
> 
> Reported-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/nvmem/core.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 05c6ae4b0b97..1c0e7953f90d 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c


Thanks Doug, This was something I wanted to streamline on all the code 
paths, but never got to it!

Applied Thanks,
srini

> @@ -111,6 +111,9 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
>   	if (pos >= nvmem->size)
>   		return 0;
>   
> +	if (!IS_ALIGNED(pos, nvmem->stride))
> +		return -EINVAL;
> +
>   	if (count < nvmem->word_size)
>   		return -EINVAL;
>   
> @@ -148,6 +151,9 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
>   	if (pos >= nvmem->size)
>   		return -EFBIG;
>   
> +	if (!IS_ALIGNED(pos, nvmem->stride))
> +		return -EINVAL;
> +
>   	if (count < nvmem->word_size)
>   		return -EINVAL;
>   
> 
