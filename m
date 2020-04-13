Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FD4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07B620663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9kHoKxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725272AbgDMU46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388654AbgDMU4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:56:53 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644D8C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 13:56:52 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b12so10887818ion.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 13:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uC+i7PG2W1Z3WS3zlyBPsJpZoWvsgugoZpuCkaGAEfc=;
        b=H9kHoKxUM8IqcV3Lai4EB3JozuSrdW7Rr2pzohz0PiboVHQ2TtcxbPt/y4AlgNDefw
         DLvqJoHzjgVD4ieBgwu+i6lEo4yLJ5ICs6wHAKpSGIPGDPueQMca1gY/rdRf52WTqFQi
         VFhc5dzmAv8QUWXFr0LZEgYGORXHgoT5Ab25CcmqPJ6RJDy136RYgtSJtxqddeE/8Yld
         Vho+C92ZjqRD8Ts6aEAus+wj7+U9GjQWu9BPZnRza5Jl400meamsIbcd4iCk1kw2BqLs
         PoxPiB3oXQYb3P0rZK7IrYU8Ml4zvzzlx2PtgWvbVeVKlvW07S8+MrTUz/SRj7OBKq3E
         CsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uC+i7PG2W1Z3WS3zlyBPsJpZoWvsgugoZpuCkaGAEfc=;
        b=OdDORIBejo79QtvY56tTJKDtrIN2u1yW17ytbFqPF2zMXShANAxQeyRCEQ97x2sBHY
         buWBhB0ONaXCWiDBZl1l6OD9wAZKDx5HCAPsMA8FJxq2IIYU5oWDmOq0wmv/sh0vNe13
         jTqnNUklWS0zh117s5D9myFo8WmUvcaRw9LVMunw0EiTvfeGOGYt7E+RkzWxjwhKmA3e
         Y7NB6b3Kc5/MZkpRIzyQyORrbTrgB/yh3DBGHNBVotYyiCg+6lf4/axxQ69DYCPWRaD7
         7q08nEDayvi/xy9hgFs83KggVIb1bElG6QxEGaKoyYLo4ag6XjBer1sjXQO6VRw203CY
         QvfA==
X-Gm-Message-State: AGi0PuZ891C3XufKeD8e8HaD8uT7hZRDGMxqADsoUMo4g3Atl6Y+V2RG
        yb8EuTXApLZ9FSZaqlReGTHbi02voCha0g==
X-Google-Smtp-Source: APiQypKQJqyf72+XOzIeELgnvQn8R2zl/6Kv1AVqMXBC6w+Xla0gafqGuB/BLiEaY5/Puhl0aFOCTQ==
X-Received: by 2002:a02:bb91:: with SMTP id g17mr17264505jan.88.1586811411124;
        Mon, 13 Apr 2020 13:56:51 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id g26sm1893203ile.3.2020.04.13.13.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 13:56:50 -0700 (PDT)
Subject: Re: [PATCH 4/4] remoteproc: Get rid of tedious error path
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     s-anna@ti.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200413193401.27234-1-mathieu.poirier@linaro.org>
 <20200413193401.27234-5-mathieu.poirier@linaro.org>
From:   Alex Elder <elder@linaro.org>
Message-ID: <7e1d808b-b4ae-72c6-266b-684894e41731@linaro.org>
Date:   Mon, 13 Apr 2020 15:56:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200413193401.27234-5-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/20 2:34 PM, Mathieu Poirier wrote:
> Get rid of tedious error management by moving firmware and operation
> allocation after calling device_initialize().  That way we take advantage
> of the automatic call to rproc_type_release() to cleanup after ourselves
> when put_device() is called.

Looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index c272d78f07e8..10009b95867a 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2061,12 +2061,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	if (!rproc)
>  		return NULL;
>  
> -	if (rproc_alloc_firmware(rproc, name, firmware))
> -		goto free_rproc;
> -
> -	if (rproc_alloc_ops(rproc, ops))
> -		goto free_firmware;
> -
>  	rproc->name = name;
>  	rproc->priv = &rproc[1];
>  	rproc->auto_boot = true;
> @@ -2079,12 +2073,17 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	rproc->dev.driver_data = rproc;
>  	idr_init(&rproc->notifyids);
>  
> +	if (rproc_alloc_firmware(rproc, name, firmware))
> +		goto out;
> +
> +	if (rproc_alloc_ops(rproc, ops))
> +		goto out;
> +
>  	/* Assign a unique device index and name */
>  	rproc->index = ida_simple_get(&rproc_dev_index, 0, 0, GFP_KERNEL);
>  	if (rproc->index < 0) {
>  		dev_err(dev, "ida_simple_get failed: %d\n", rproc->index);
> -		put_device(&rproc->dev);
> -		return NULL;
> +		goto out;
>  	}
>  
>  	dev_set_name(&rproc->dev, "remoteproc%d", rproc->index);
> @@ -2105,11 +2104,8 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	rproc->state = RPROC_OFFLINE;
>  
>  	return rproc;
> -
> -free_firmware:
> -	kfree(rproc->firmware);
> -free_rproc:
> -	kfree(rproc);
> +out:
> +	put_device(&rproc->dev);
>  	return NULL;
>  }
>  EXPORT_SYMBOL(rproc_alloc);
> 

