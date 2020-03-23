Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA8FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85232051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULCTdGYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgCWTFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:05:15 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39047 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgCWTFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:05:12 -0400
Received: by mail-pj1-f68.google.com with SMTP id ck23so263899pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2fG9H5eoXdycQoQZNrJnabanTjIbabhsOmyO2vTW0Qc=;
        b=ULCTdGYaRnUW3TAkI2l1l6dqbs5e4hV+SJAAgt7Qj+zm8rTBzJ5an1mE4YfgCqphqf
         w4Y6Y1zyKBlUONTUVx+BRLqxC9o3uD+F6XVqzL3V/AWEkh5+i4oWCgrqy/XfRMsp4pTy
         WHBpseWaIpSe5W1P7ffAQcQqccVJWSUy+D2ymeixpOEwjpZXZ/xr3cU9F24nqcRY1JMS
         v19aP4WicgYQwd5HzUZuYDn3IXhcHI7ecRc3NQLv9bSQFchVGqoe1xYR0wmeVPFDR/+z
         10t+AFUc8tGNTPKjyQRI2paTSkPzBaJbT2RvtLzap5MGg2/kAZmZhtImv0yCiDJ+w2HK
         VSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2fG9H5eoXdycQoQZNrJnabanTjIbabhsOmyO2vTW0Qc=;
        b=c11MNtwV/uLrScas5RTavFRYy4FinVoqgM6vR20XpXNk2pJJtEdLzpd+K1kbfgK4Uw
         jh25KkD1m3jdqzhFw3RqsfYCG4xiuTd7n6nbyvQxYq0jtM7mhIQ2+ZN78H6u/ReajJcq
         Ah985HNInLAsx2R1wroNnG5O0Ipqq5FoLga8QIZV3WPlw0p3IuAvl175r842qS/KcKYL
         3fOJdu0GmLS+9gWyrY4gmU9kHbbfHC5x+zhwbsNfxQJ/fuDCuia2lhKku1HutCxt9WTl
         R4NmvpJUdCn8RcniwVEGpJwjeTut4c6PqVMU2iK6Sr9zh4DuQvoCCUn1EVgjYbJPiZ1I
         0tWQ==
X-Gm-Message-State: ANhLgQ2yHRNv1Iur4twsqIw6+0449c9a+tN1fd7u9UeVB2QOkYuW3F7n
        ErQgRm43Whx4kFBMhMBLn+/xpw==
X-Google-Smtp-Source: ADFU+vtRpFfD90HBITTvBcmhzzZwkmWFUae0+E0TWgZEUq5uZU7LqUIzvkKha49ShXRkmBPkKxQsDQ==
X-Received: by 2002:a17:90a:71c5:: with SMTP id m5mr835384pjs.193.1584990310063;
        Mon, 23 Mar 2020 12:05:10 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x11sm11535091pgq.48.2020.03.23.12.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:05:09 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:05:06 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net,
        smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] bus: mhi: core: Pass module owner during client
 driver registration
Message-ID: <20200323190506.GB119913@minitux>
References: <20200323122108.12851-1-manivannan.sadhasivam@linaro.org>
 <20200323122108.12851-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323122108.12851-2-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23 Mar 05:21 PDT 2020, Manivannan Sadhasivam wrote:

> The module owner field can be used to prevent the removal of kernel
> modules when there are any device files associated with it opened in
> userspace. Hence, modify the API to pass module owner field. For
> convenience, module_mhi_driver() macro is used which takes care of
> passing the module owner through THIS_MODULE of the module of the
> driver and also avoiding the use of specifying the default MHI client
> driver register/unregister routines.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/bus/mhi/core/init.c |  5 +++--
>  include/linux/mhi.h         | 19 ++++++++++++++++++-
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 5fb756ca335e..eb7f556a8531 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -1189,7 +1189,7 @@ static int mhi_driver_remove(struct device *dev)
>  	return 0;
>  }
>  
> -int mhi_driver_register(struct mhi_driver *mhi_drv)
> +int __mhi_driver_register(struct mhi_driver *mhi_drv, struct module *owner)
>  {
>  	struct device_driver *driver = &mhi_drv->driver;
>  
> @@ -1197,12 +1197,13 @@ int mhi_driver_register(struct mhi_driver *mhi_drv)
>  		return -EINVAL;
>  
>  	driver->bus = &mhi_bus_type;
> +	driver->owner = owner;
>  	driver->probe = mhi_driver_probe;
>  	driver->remove = mhi_driver_remove;
>  
>  	return driver_register(driver);
>  }
> -EXPORT_SYMBOL_GPL(mhi_driver_register);
> +EXPORT_SYMBOL_GPL(__mhi_driver_register);
>  
>  void mhi_driver_unregister(struct mhi_driver *mhi_drv)
>  {
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 79cb9f898544..0e7071dbf2c3 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -514,11 +514,28 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>   */
>  void mhi_unregister_controller(struct mhi_controller *mhi_cntrl);
>  
> +/*
> + * module_mhi_driver() - Helper macro for drivers that don't do
> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces module_init() and module_exit()
> + */
> +#define module_mhi_driver(mhi_drv) \
> +	module_driver(mhi_drv, mhi_driver_register, \
> +		      mhi_driver_unregister)
> +
> +/*
> + * Macro to avoid include chaining to get THIS_MODULE
> + */
> +#define mhi_driver_register(mhi_drv) \
> +	__mhi_driver_register(mhi_drv, THIS_MODULE)
> +
>  /**
>   * mhi_driver_register - Register driver with MHI framework
>   * @mhi_drv: Driver associated with the device
> + * @owner: The module owner
>   */
> -int mhi_driver_register(struct mhi_driver *mhi_drv);
> +int __mhi_driver_register(struct mhi_driver *mhi_drv, struct module *owner);
>  
>  /**
>   * mhi_driver_unregister - Unregister a driver for mhi_devices
> -- 
> 2.17.1
> 
