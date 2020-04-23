Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6CCC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93C62073A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjTDFYBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgDWUsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgDWUsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:48:01 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA0EC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:47:59 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f8so2832178plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mygZ2oLzOSrM9OExIOMlnR/IwBRaCuTdVDfC6iUa40Q=;
        b=bjTDFYBFaY9zf1z9GiFUczbthZicDkH6EDLpdUdgGqapvWANwxtnw7wukTLOU5vSQW
         +2L3G2tslXqty1NcuZLcNv7fTVAIbX6rorJ4hMS1jdvxbBf2hTSiDMkpV8cQFaNuYnpq
         9NH4oZT5pu41xxRGePvhc4+K86NpLMNKfK7CurxdG6HQOCaZyazWCXWaEyLSi31l6JV1
         ipREJgC6deSXyQuS2blYdZ6GBgfq+IruOdeKAPtyMoehh3tKDNYVItIvrzzWE47XZ9N1
         LSYOesTtJpYdW9yA/q0Yo4pPfzEpuXuOZBdukONmYw6hGGYETAKzRLIPcBaKc5LL/9Lz
         dQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mygZ2oLzOSrM9OExIOMlnR/IwBRaCuTdVDfC6iUa40Q=;
        b=uNXSp57YA/ae5PUm3YGY8HthJt/Sgdpu+sNIzzo1FyfPT6jykShpnSw+UzhknMHGt5
         iCPIJfbR0o0AZ0qzsxL7IvSispLfEyRKOH+w8OG9ol74OlmtYZ6ECnT6QOe+8ScAo2ei
         kBk3juimK+h0L1yHS3N5ToZ4XaNCBesELs4uj5c+Zth7iy/yunSGbONFOrdxchZFqsPh
         YdOpkS4sX4I+Clim6BLQkuY6byaaXi38AQd7RZyeOTbm6Y5CtksaRnZRTnE8L36VD3pL
         oHZ+uAOyrNM4eeqF41YESbcQSzA7zFq5stcYDSjlGlkZWEWtz8mmSRZn7yD936no+tBU
         NLIQ==
X-Gm-Message-State: AGi0PuZXGQHMXz4x5rij1lA9M9HvAYLwSCPlO0Q/nJPBFGeRU4F8JWno
        msL8+yxu96deDQoxT0eCtsH3gw==
X-Google-Smtp-Source: APiQypJaCtbDdpOwegGYhY/R2XgIQGjlWASlsgr3xsJQTgvEfo422bz4lcffB+kphgfULcT+f/+3dw==
X-Received: by 2002:a17:90a:d0c3:: with SMTP id y3mr2679528pjw.128.1587674879215;
        Thu, 23 Apr 2020 13:47:59 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id x13sm3485951pfq.154.2020.04.23.13.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 13:47:58 -0700 (PDT)
Date:   Thu, 23 Apr 2020 14:47:56 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, ohad@wizery.com, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH 3/3] remoteproc: Add coredump sysfs attribute
Message-ID: <20200423204756.GA4548@xps15>
References: <1587062312-4939-1-git-send-email-rishabhb@codeaurora.org>
 <1587062312-4939-3-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587062312-4939-3-git-send-email-rishabhb@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 11:38:32AM -0700, Rishabh Bhatnagar wrote:
> Add coredump sysfs attribute to configure the type of memory dump.
> User can select between default or inline coredump functionality.
> Also coredump collection can be disabled through this interface.
> This functionality can be configured differently for different
> remote processors.
> This provides an option to dynamically configure the dump type
> based on userpsace capability.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_sysfs.c | 57 +++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index 7f8536b..d112664 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -9,6 +9,62 @@
>  
>  #define to_rproc(d) container_of(d, struct rproc, dev)
>  
> +/*
> + * A coredump-configuration-to-string lookup table, for exposing a
> + * human readable configuration via sysfs. Always keep in sync with
> + * enum rproc_coredump_conf
> + */
> +static const char * const rproc_coredump_str[] = {
> +	[COREDUMP_DEFAULT]	= "default",
> +	[COREDUMP_INLINE]	= "inline",
> +	[COREDUMP_DISABLED]	= "disabled",
> +};
> +
> +/* Expose the current coredump configuration via sysfs */
> +static ssize_t coredump_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct rproc *rproc = to_rproc(dev);
> +
> +	return sprintf(buf, "%s\n", rproc_coredump_str[rproc->coredump_conf]);
> +}
> +
> +/* Change the coredump configuration via sysfs */
> +static ssize_t coredump_store(struct device *dev, struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct rproc *rproc = to_rproc(dev);
> +	int err;
> +
> +	err = mutex_lock_interruptible(&rproc->lock);
> +	if (err) {
> +		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, err);
> +		return -EINVAL;
> +	}
> +
> +	if (rproc->state == RPROC_CRASHED) {
> +		dev_err(dev, "can't change coredump configuration\n");
> +		err = -EBUSY;
> +		goto out;
> +	}
> +
> +	if (sysfs_streq(buf, "disable"))
> +		rproc->coredump_conf = COREDUMP_DISABLED;
> +	else if (sysfs_streq(buf, "inline"))
> +		rproc->coredump_conf = COREDUMP_INLINE;
> +	else if (sysfs_streq(buf, "default"))
> +		rproc->coredump_conf = COREDUMP_DEFAULT;
> +	else {
> +		dev_err(dev, "Invalid coredump configuration\n");
> +		err = -EINVAL;
> +	}
> +out:
> +	mutex_unlock(&rproc->lock);
> +
> +	return err ? err : count;
> +}
> +static DEVICE_ATTR_RW(coredump);
> +
>  /* Expose the loaded / running firmware name via sysfs */
>  static ssize_t firmware_show(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
> @@ -127,6 +183,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
>  	&dev_attr_firmware.attr,
>  	&dev_attr_state.attr,
>  	&dev_attr_name.attr,
> +	&dev_attr_coredump.attr,

This new entry needs to be documented in [1].  The set also needs to be rebased
on rproc-next.

Thanks,
Mathieu

[1]. https://elixir.bootlin.com/linux/v5.7-rc2/source/Documentation/ABI/testing/sysfs-class-remoteproc

>  	NULL
>  };
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
