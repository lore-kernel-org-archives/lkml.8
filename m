Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D5DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BDA2545C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnsjmqwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbgFVH1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731360AbgFVH1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:27:49 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2241AC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:27:49 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id s21so14745570oic.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i3nL1FOZiHj0yAhZuO+cTGxj+n7PLyTcuScPp7qWic0=;
        b=dnsjmqwHBtKGiOld1FMCqn5dRqN9aePTpgzT8zmcxrKfKdvQURQC6gYhBstXmbkspK
         mMPfpw1xWrHynJ+sfv3AFJTWl1elALark/Kw0lPVyIvPHwNM/1YfyK31aIO0/z9pvj65
         MVtPhKjORr2Fk46rpO9ulAs7BtXtCNqjxQaMSrWhU33MU3M1FeWVZ3WDeu6mCqlczb98
         TvaCUmGZavaXMZC46rs09PCgu/dHuW5GuaKm7jkIgWYuaqpiSlWCV58i93XFQOEvnID7
         lC7RRivzDmgEH4RjCcAixZUJBeAlPCCUda578U0D75/oZd7JLyahxlc8pyjlcZIqZ4Pr
         iEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i3nL1FOZiHj0yAhZuO+cTGxj+n7PLyTcuScPp7qWic0=;
        b=TJph7Oq4YpMK5A9qWc92ZJAb0xha9GRKcCXx1mrwkKiik68T9Qu+2Pbl8HoX4HYZUc
         aAaqdQAzFTpCEhq9uHr1QMIfYDNIUNJhec5zH38+wDBN09Z5MLJIAkOGuHP0MPXoJgkk
         1l369wtjdvQKYTqsbvkp1zeUAZ/9MMRDGZ3z24bb+XV7V/GOwk0YiVRPsaU7ROwH5Rrd
         vKQ4qH049ljtVJx6qSjA5f39mGIHvgV6+0/OxMIZd1dDQa0PnS+SDOPeMD46Fz038VSA
         YqMM1qTaS4s+xhZzpCGvc0xTURFPWfw1MMTVdOuxzu6zMcjPLdQwzOSsn9CtwVqDkjnr
         CYgQ==
X-Gm-Message-State: AOAM533fRx+ZiXSQBOTGjFipl4uA/IdbGCLRYaBUJZ862U5RSAlwHh4w
        6VGy748m7HSwKIQIRMNEiVzdpA==
X-Google-Smtp-Source: ABdhPJwkNkIrZFl2zFX8mXQVZUpNLjPQIfXAMBF3MzPdeWB99FmyhgpY9JP4a4wvf14F7mTVhBDQJQ==
X-Received: by 2002:aca:dec2:: with SMTP id v185mr11894603oig.171.1592810868372;
        Mon, 22 Jun 2020 00:27:48 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i72sm3015123oib.28.2020.06.22.00.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 00:27:47 -0700 (PDT)
Date:   Mon, 22 Jun 2020 00:25:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, s-anna@ti.com
Subject: Re: [PATCH v4 5/9] remoteproc: Introducing function rproc_validate()
Message-ID: <20200622072502.GG149351@builder.lan>
References: <20200601175139.22097-1-mathieu.poirier@linaro.org>
 <20200601175139.22097-6-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601175139.22097-6-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Jun 10:51 PDT 2020, Mathieu Poirier wrote:

> Add a new function to assert the general health of the remote
> processor before handing it to the remoteproc core.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 45 ++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index c70fa0372d07..0be8343dd851 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2060,6 +2060,47 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
>  #endif
>  EXPORT_SYMBOL(rproc_get_by_phandle);
>  
> +static int rproc_validate(struct rproc *rproc)
> +{
> +	/*
> +	 * When adding a remote processor, the state of the device
> +	 * can be offline or detached, nothing else.
> +	 */
> +	if (rproc->state != RPROC_OFFLINE &&
> +	    rproc->state != RPROC_DETACHED)
> +		goto inval;

I would prefer that you just return -EINVAL; directly.

Overall I think this would be better represented as a switch on
rproc->state though.


I think the logic is sound though.

Regards,
Bjorn

> +
> +	if (rproc->state == RPROC_OFFLINE) {
> +		/*
> +		 * An offline processor without a start()
> +		 * function makes no sense.
> +		 */
> +		if (!rproc->ops->start)
> +			goto inval;
> +	}
> +
> +	if (rproc->state == RPROC_DETACHED) {
> +		/*
> +		 * A remote processor in a detached state without an
> +		 * attach() function makes not sense.
> +		 */
> +		if (!rproc->ops->attach)
> +			goto inval;
> +		/*
> +		 * When attaching to a remote processor the device memory
> +		 * is already available and as such there is no need to have a
> +		 * cached table.
> +		 */
> +		if (rproc->cached_table)
> +			goto inval;
> +	}
> +
> +	return 0;
> +
> +inval:
> +	return -EINVAL;
> +}
> +
>  /**
>   * rproc_add() - register a remote processor
>   * @rproc: the remote processor handle to register
> @@ -2089,6 +2130,10 @@ int rproc_add(struct rproc *rproc)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = rproc_validate(rproc);
> +	if (ret < 0)
> +		return ret;
> +
>  	dev_info(dev, "%s is available\n", rproc->name);
>  
>  	/* create debugfs entries */
> -- 
> 2.20.1
> 
