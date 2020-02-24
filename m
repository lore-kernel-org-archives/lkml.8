Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43A7C38BE1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E7A20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J38ofieD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBXSar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:30:47 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50293 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBXSar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:30:47 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so124067pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 10:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eB+RF5Mh4FenHE6w3IEcxS14k96bS8yZIKZCBidnPPI=;
        b=J38ofieDuZwieGmCqkTF7yAGdU9ZfG6J4h1Oex9EJi2MJ7UiXHedPEZIWhorABF9w1
         4LjBAflwCt5SlXeCaH6i5WilMtAyA6OV/uYRzixRdSSUTOzx6mnQgRWR4HMbDigZPqzn
         TFC07Pp933b4ftOkv9QPDT7GtUKAVRlKgyHDA4mw/6HVEeKspQjfkn5RzIqTCcdYIKPw
         diVTC03tNk5VYl0qckRql0EFXLRnSwMQ/ecb+6mEDjIWOsELPf61faJslWaJBAEE6ZO1
         e2MzZ/CTAAZ8wNUNAsYLwhXhxMZhXhkPw9ZC+f2YHLq/tRNNOyT8lwq3Ec3miG2/kYqJ
         CffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eB+RF5Mh4FenHE6w3IEcxS14k96bS8yZIKZCBidnPPI=;
        b=uDDXFBydRMmQZF4ZOk8UqI5YHYJzZZy5roValceDjWxmw4mt2n9k4/ZvNlWJeem+dc
         W/SltVZzoN0NCWLhoULQtr061JXy77nKsr77Q/SO3mjaTj80dgKQDO8Uu/83u2MJ4TqN
         RqO9W7JPMH6knVHmZRWUNplDDh2vV9xguphSJbHP0/NFEWRJnpQpUaIHr2VA4CgicwU9
         waogm/NeGTLa1jibztJqcfMKiL5Z279AvaXfv5jEUKY/GcBOAhqKvTF7BLmYmSkHm6Ns
         5RPGPPutuOrChQX08cKVvjaJLxRBTqrKg1d4TQtuqRMtBVVjWQhaQXUUrRi4hrsizV8B
         zEQw==
X-Gm-Message-State: APjAAAWE9jArdalBZ3MuVQEd7NDeJZ3DNx808jeyjV4lSG7F2Y0LWp5t
        IC9BEzvwu/98NxlOCj+MupruZURcNMU=
X-Google-Smtp-Source: APXvYqzGmaiP+bNpfJzHNfdIjk0x3NvdHLNFE+Z3xk6uvxo4EuiAxTQRcX9CZ1rdWNGXWJprqyebRQ==
X-Received: by 2002:a17:902:401:: with SMTP id 1mr50094099ple.177.1582569046452;
        Mon, 24 Feb 2020 10:30:46 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q7sm13363109pgk.62.2020.02.24.10.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:30:45 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:30:43 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: Re: [PATCH 1/2] remoteproc: core: Add an API for booting with
 firmware name
Message-ID: <20200224183043.GA9477@xps15>
References: <1582164713-6413-1-git-send-email-sidgup@codeaurora.org>
 <1582164713-6413-2-git-send-email-sidgup@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582164713-6413-2-git-send-email-sidgup@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siddharth,

On Wed, Feb 19, 2020 at 06:11:52PM -0800, Siddharth Gupta wrote:
> Add an API which allows to change the name of the firmware to be booted on
> the specified rproc. This change gives us the flixibility to change the
> firmware at run-time depending on the usecase. Some remoteprocs might use
> a different firmware for testing, production and development purposes,
> which may be selected based on the fuse settings during bootup.
> 
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/remoteproc.h           |  1 +
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 097f33e..5ab65a4 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1779,6 +1779,40 @@ int rproc_boot(struct rproc *rproc)
>  EXPORT_SYMBOL(rproc_boot);
>  
>  /**
> + * rproc_boot_with_fw() - boot a remote processor with the specified firmware
> + * @rproc: handle of a remote processor
> + * @firmware: name of the firmware to boot with
> + *
> + * Change the name of the firmware to be loaded to @firmware in the rproc
> + * structure, and call rproc_boot().
> + *
> + * Returns 0 on success, and an appropriate error value otherwise.
> + */
> +int rproc_boot_with_fw(struct rproc *rproc, const char *firmware)
> +{
> +	char *p;
> +
> +	if (!rproc) {
> +		pr_err("invalid rproc handle\n");
> +		return -EINVAL;
> +	}

        if (!rproc || !firmware)
                return -EINVAL;

There is no user involved here so no point in printing anything.  If @rproc or
@firmware is NULL than callers should be smart enough to figure it out from the
error code.

> +
> +	if (firmware) {
> +		p = kstrdup(firmware, GFP_KERNEL);
> +		if (!p)
> +			return -ENOMEM;

As in firmware_store() I think it is a good idea to mandate the MCU be offline
before changing the firmware name.  That way we avoid situations where what is
running on the MCU is not what gets reported in sysfs.

> +
> +		mutex_lock(&rproc->lock);
> +		kfree(rproc->firmware);
> +		rproc->firmware = p;

> +		mutex_unlock(&rproc->lock);
> +	}
> +
> +	return rproc_boot(rproc);

Function rproc_boot() is also an exported symbol and belongs in the caller -
please move it out of here.  When that is done rproc_boot_with_fw() can become
rproc_set_firmware_name() and concentrate on doing just that.

> +}
> +EXPORT_SYMBOL(rproc_boot_with_fw);

Although choosing the firmware image to boot without user involvement seems like
a valid scenario to me, this can't be added until there is an actual user of
this API.

> +
> +/**
>   * rproc_shutdown() - power off the remote processor
>   * @rproc: the remote processor
>   *
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 16ad666..e2eaba9 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -609,6 +609,7 @@ rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, int len,
>  			     u32 da, const char *name, ...);
>  
>  int rproc_boot(struct rproc *rproc);
> +int rproc_boot_with_fw(struct rproc *rproc, const char *firmware);
>  void rproc_shutdown(struct rproc *rproc);
>  void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
>  int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size);
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
