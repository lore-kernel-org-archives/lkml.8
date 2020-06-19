Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B170FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5B320786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IpzTVX3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgFSFbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 01:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFSFbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:31:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6848C0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:31:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id h185so3938751pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mhcti4xi7gWs/72FZs9Ehs/eVsh06RolbwHz/6MmSNE=;
        b=IpzTVX3zxsyeSj4nCfy3gWzchcFjlFzOzjeKEmtT3pOOY9LZ2vGGrc4b+NscZ73mmA
         QA7cjS5dINpChAjEBH/szEqtgMKVyVrYhShoKTNM5mLxF7KX4x+3VGOM3e6vcvTfeWoe
         QTrAAwF7HhINHWjbHfGd9gRUeP8sAckBmUW2FfCuVj1OSE8SxL9BYM2tW8EjBcxUFcQK
         Ok5yI/ClbOX/CvPSn3gMqbFHT+NN74L4JApL60ezBv93WCagaGA6KstBnLGUp7WUpOmQ
         brdeWgHnyA0ge5U7R8u+MLQ7YWL0w+uKE33yoO5gAfCzWeiHEPY0lhcFVK9H+ta1IoFY
         9aUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mhcti4xi7gWs/72FZs9Ehs/eVsh06RolbwHz/6MmSNE=;
        b=SwK03yhagTBZhaUYpywfrHqk3FlxPo9997l2KSWUoSV+OFRJckgBHHr/dPZZfbdbHW
         AnY95D79mItsCANXTRuRJ3D/pkVlGcRrZWS/zpltLRuLGtCfdcF0LEyousxULqPWd0w3
         g8YMkGP1Z5dk1TxhRG6yaj9Vml2tT9gZ6tr+66tgk7S7roQG8VWvXYIK0u/bGE7MGPuj
         9Ldcqj0kddtLjI7BUGFN/RR1KssR/WyTO+m06+Z/2VOGraOmNpIgIVV7SMZBc4KSlic5
         3FTvYnXDooxOiF+J00SRfc7Qd8lBy+bCzFc1r6sl2LeoV2IP5RoOo61TCVotMqrl4LcY
         ROxg==
X-Gm-Message-State: AOAM533wFQJjbEHCWbm8M9ELPXl4MK2ifsO3JQlt+tGnoJLrdchkMFpk
        fHr27sYNKtVK1daMcJdaN6/1
X-Google-Smtp-Source: ABdhPJx/OOkxSyQhyygnCOZXnfq3yt/RvC1SMadep0wmUghMUQaer5u1aUK11GYClQg3dB4n9JE7xg==
X-Received: by 2002:a63:d148:: with SMTP id c8mr1670278pgj.51.1592544693006;
        Thu, 18 Jun 2020 22:31:33 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:59f:c065:651a:bc24:a9bb:ff41])
        by smtp.gmail.com with ESMTPSA id w11sm4432653pfi.93.2020.06.18.22.31.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jun 2020 22:31:32 -0700 (PDT)
Date:   Fri, 19 Jun 2020 11:01:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org
Subject: Re: [PATCH v3 1/4] bus: mhi: core: Add helper API to return number
 of free TREs
Message-ID: <20200619053125.GA3245@Mani-XPS-13-9360>
References: <1591899224-3403-1-git-send-email-hemantk@codeaurora.org>
 <1591899224-3403-2-git-send-email-hemantk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591899224-3403-2-git-send-email-hemantk@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 11:13:41AM -0700, Hemant Kumar wrote:
> Introduce mhi_get_no_free_descriptors() API to return number
> of TREs available to queue buffer. MHI clients can use this
> API to know before hand if ring is full without calling queue
> API.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> ---
>  drivers/bus/mhi/core/main.c | 12 ++++++++++++
>  include/linux/mhi.h         |  9 +++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index d25f321..1bd3b1e 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -258,6 +258,18 @@ int mhi_destroy_device(struct device *dev, void *data)
>  	return 0;
>  }
>  
> +int mhi_get_no_free_descriptors(struct mhi_device *mhi_dev,
> +				enum dma_data_direction dir)

How about "mhi_get_nr_free_descriptors"? Also align with '('

> +{
> +	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> +	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ?
> +		mhi_dev->ul_chan : mhi_dev->dl_chan;
> +	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
> +
> +	return get_nr_avail_ring_elements(mhi_cntrl, tre_ring);
> +}
> +EXPORT_SYMBOL_GPL(mhi_get_no_free_descriptors);
> +
>  void mhi_notify(struct mhi_device *mhi_dev, enum mhi_callback cb_reason)
>  {
>  	struct mhi_driver *mhi_drv;
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 6af6bd6..a39b77d 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -602,6 +602,15 @@ void mhi_set_mhi_state(struct mhi_controller *mhi_cntrl,
>  void mhi_notify(struct mhi_device *mhi_dev, enum mhi_callback cb_reason);
>  
>  /**
> + * mhi_get_no_free_descriptors - Get transfer ring length

Is the description correct? I'd suggest to just use the below one.

> + * Get # of TD available to queue buffers

How about, "Get # of available TREs to queue buffers"?

> + * @mhi_dev: Device associated with the channels
> + * @dir: Direction of the channel
> + */
> +int mhi_get_no_free_descriptors(struct mhi_device *mhi_dev,
> +				enum dma_data_direction dir);

Align this with '('

Thanks,
Mani

> +
> +/**
>   * mhi_prepare_for_power_up - Do pre-initialization before power up.
>   *                            This is optional, call this before power up if
>   *                            the controller does not want bus framework to
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
