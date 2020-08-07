Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AFFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 05:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B3C2075A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 05:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ci362HhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgHGFPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 01:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgHGFPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 01:15:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72975C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 22:15:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g19so526315plq.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 22:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MBiQY6LTeMAyrNDctZTGpI85Qrwm/lT3KljbOVSIsIU=;
        b=Ci362HhGecTknDyD27bYk4NYh2QVzDcBfO5JQOtXkzSJOH1PsDnNYNdS10gyCsxzW3
         O2vhmsHj9bEZmccLTmftVbo7hou0KQZbD5F62V9aze/T99c8Pz4rIDbZ16gco/NaNnV9
         2gFnxGn+VlYt1WQmNrIPkPzzlcdP81j+I9ccqNRBi1qWCgs6KlaaB7Kn70nb8v3hBOkR
         emD26LjP48leji/aZd60gL0SZ8jY6Ghxx4HSXefXQncpDmKEFhFfIAgms+hYWTcbApsq
         ARWz9fGTdBnBQS1ZgxG+WVvNwmKKKbKe0RTTFkztJjTGQTZ1be62Mn8S9/NJWpZkW2Mp
         scvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MBiQY6LTeMAyrNDctZTGpI85Qrwm/lT3KljbOVSIsIU=;
        b=HhgGVFaOIJJeRWR3np92CFaTsTBB9IVPj8KqJwake1RtIwsyr5LoOBd93BkSCLwext
         sluRqnEwKARwCYPIUBRqZ0mzO5GDVrJXmfXnKklMpbHjs6Rc7dlY/ME/Lovjqnzsn5Xj
         2KhowJTRfR3HMM5oyk4Nay2L8nejN6cuAO7tiqmme0+QPMurP3Hf6XOHMe2Q7fSEk6rT
         BEX5ogRtskNQmwSVm3w1AaodxagCryEfrPMSq1QaWkLD7015LPHL8XbfbGqozGZKsfyw
         HNVwwbQ0embRy++KW0FLd+uj9d6U3GEut5X/phDumQ1YeCxcAKeilxHGPwLHIhNyOjU6
         JzMw==
X-Gm-Message-State: AOAM531JQCphkGU2mc45Ymdy2lLg0n3Ke01yzCWHvJCBBHXWCCYN1wY1
        JqxgpRLmxoEbN3aWwF2Vg/Vv
X-Google-Smtp-Source: ABdhPJzG9ys4l85i7KE9prlVjbCU4+da2W4YntUlOve0TVyv78oxfwb4fCiY74JgzuE5lkX2gZs0hg==
X-Received: by 2002:a17:902:b20d:: with SMTP id t13mr11008275plr.312.1596777344811;
        Thu, 06 Aug 2020 22:15:44 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6d15:d4c4:a84b:5551:d33e:ccd2])
        by smtp.gmail.com with ESMTPSA id s61sm9630018pjb.57.2020.08.06.22.15.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 22:15:44 -0700 (PDT)
Date:   Fri, 7 Aug 2020 10:45:38 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/11] bus: mhi: core: Introduce APIs to allocate and
 free the MHI controller
Message-ID: <20200807051538.GC3230@Mani-XPS-13-9360>
References: <1595901740-27379-1-git-send-email-bbhatt@codeaurora.org>
 <1595901740-27379-11-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595901740-27379-11-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 07:02:19PM -0700, Bhaumik Bhatt wrote:
> Client devices should use the APIs provided to allocate and free
> the MHI controller structure. This will help ensure that the
> structure is zero-initialized and there are no false positives
> with respect to reading any values such as the serial number or
> the OEM PK hash.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Can you please also add the Suggested-by tag?

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/init.c | 16 ++++++++++++++++
>  include/linux/mhi.h         | 12 ++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index d2c0f6e..972dbf0 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -959,6 +959,22 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
>  }
>  EXPORT_SYMBOL_GPL(mhi_unregister_controller);
>  
> +struct mhi_controller *mhi_alloc_controller(void)
> +{
> +	struct mhi_controller *mhi_cntrl;
> +
> +	mhi_cntrl = kzalloc(sizeof(*mhi_cntrl), GFP_KERNEL);
> +
> +	return mhi_cntrl;
> +}
> +EXPORT_SYMBOL_GPL(mhi_alloc_controller);
> +
> +void mhi_free_controller(struct mhi_controller *mhi_cntrl)
> +{
> +	kfree(mhi_cntrl);
> +}
> +EXPORT_SYMBOL_GPL(mhi_free_controller);
> +
>  int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>  {
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index d15e9ce..a35d876 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -530,6 +530,18 @@ struct mhi_driver {
>  #define to_mhi_device(dev) container_of(dev, struct mhi_device, dev)
>  
>  /**
> + * mhi_alloc_controller - Allocate the MHI Controller structure
> + * Allocate the mhi_controller structure using zero initialized memory
> + */
> +struct mhi_controller *mhi_alloc_controller(void);
> +
> +/**
> + * mhi_free_controller - Free the MHI Controller structure
> + * Free the mhi_controller structure which was previously allocated
> + */
> +void mhi_free_controller(struct mhi_controller *mhi_cntrl);
> +
> +/**
>   * mhi_register_controller - Register MHI controller
>   * @mhi_cntrl: MHI controller to register
>   * @config: Configuration to use for the controller
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
