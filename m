Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38B3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9808320888
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceY3GOfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgFRXo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgFRXoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:44:25 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E66DC0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 16:44:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k2so3302682pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 16:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yvMb0a2c10861vhwKbOrdUepqOFkOOTrJVCk2dRfuZY=;
        b=ceY3GOfJpNh0ZC/Fk/jOULWNhQVbB5DWH9hsXiIJPYBcRUoNpbt1Qsj/70w29kdaD+
         Wl7AaXV1XouuHHR8bDaZ++vSMCCFR4atOHlv7cRBBxVkOKKkaeKN54Pc3hJsrRvL15XB
         L0o+v/kLgFBNzOCDuE/RR/SdvLQIchUdVhIhwMifEVe0Zzy5lhyreetnLITGYGsnqaBP
         bNDkldIDaNGYip8xamFAVWn3Wz1D7aSrUEVUe7YeaavLcmxNRF91YY7AEDcJNYCG9Rnf
         t/w8tOcnYbO3kh1D/edX4na0mJuVD7Y0LUmTeh1GX5SV2ExvQrWX7AuO7rSRBNk0ftr4
         YEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yvMb0a2c10861vhwKbOrdUepqOFkOOTrJVCk2dRfuZY=;
        b=E+XitbCB9ROYZ5xFJ3jt5yqpgb1G0OhVUIHjjCKQ6MmepqNn6PPoFjtzjK+bszv1Al
         hg5m9B0u6vOAiaAMNskjIEFJpC2mpIzOPxKgs9YnsGcMZIRjsww2FUCxFghjxLWUcbgt
         4v7QaURC+/Jjzy0HUFASOXeRhwj9UzrtvtUUzh3pv9oyMyi6gUPORRTgSMhyrY0c44wB
         YWnvTapEoYfiEVF4t3m6unjcrezWFI6hBQS1C9WDRmJqVEft0AUee1dZDG0uTEYUEGVR
         RihxoLWvjVPLpXbD5zFNVx5MJGuv5884KQAuu4wtKsaj3X4QoomU7LE5sWGnlAHT2LrG
         yv+g==
X-Gm-Message-State: AOAM533iMMiCZYohx2YO2H3ojQ+88Pa9oHEg0kGtVMFi1I3RFafMTHUj
        rHfDIZDjuH7cqWSMrmslR76H5w==
X-Google-Smtp-Source: ABdhPJyNWW8E/cNTuVgEqsGVFJm/OQSR0fcdze58ugdAUPV3L4aNzeiuPCG4YmpZJ7ubSzIfsKricQ==
X-Received: by 2002:a17:902:b216:: with SMTP id t22mr5527631plr.181.1592523863778;
        Thu, 18 Jun 2020 16:44:23 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h9sm3967767pfe.32.2020.06.18.16.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 16:44:22 -0700 (PDT)
Date:   Thu, 18 Jun 2020 16:44:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     agross@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, nishakumari@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org,
        rnayak@codeaurora.org
Subject: Re: [PATCH v4 1/5] regulator: Allow regulators to verify enabled
 during enable()
Message-ID: <20200618234420.GI11847@yoga>
References: <20200602100924.26256-1-sumit.semwal@linaro.org>
 <20200602100924.26256-2-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602100924.26256-2-sumit.semwal@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02 Jun 03:09 PDT 2020, Sumit Semwal wrote:

> Some regulators might need to verify that they have indeed been enabled
> after the enable() call is made and enable_time delay has passed.
> 
> This is implemented by repeatedly checking is_enabled() upto
> poll_enabled_time, waiting for the already calculated enable delay in
> each iteration.
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> --
> v2: Address review comments, including swapping enable_time and poll_enabled_time.
> ---
>  drivers/regulator/core.c         | 58 +++++++++++++++++++++++++++++++-
>  include/linux/regulator/driver.h |  5 +++
>  2 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 7486f6e4e613..d9ab888da95f 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -2347,6 +2347,32 @@ static void _regulator_enable_delay(unsigned int delay)
>  		udelay(us);
>  }
>  
> +/* _regulator_check_status_enabled

Please make all your kerneldoc follow:
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation

> + *
> + * returns:
> + *          1 if status shows regulator is in enabled state
> + *          0 if not enabled state
> + *          else, error value as received from ops->get_status()
> + */
> +static inline int _regulator_check_status_enabled(struct regulator_dev *rdev)
> +{
> +	int ret = rdev->desc->ops->get_status(rdev);
> +
> +	if (ret < 0) {
> +		rdev_info(rdev, "get_status returned error: %d\n", ret);
> +		return ret;
> +	}
> +
> +	switch (ret) {
> +	case REGULATOR_STATUS_OFF:
> +	case REGULATOR_STATUS_ERROR:
> +	case REGULATOR_STATUS_UNDEFINED:
> +		return 0;
> +	default:
> +		return 1;
> +	}
> +}
> +
>  static int _regulator_do_enable(struct regulator_dev *rdev)
>  {
>  	int ret, delay;
> @@ -2407,7 +2433,37 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
>  	 * together.  */
>  	trace_regulator_enable_delay(rdev_get_name(rdev));
>  
> -	_regulator_enable_delay(delay);
> +	/* If poll_enabled_time is set, poll upto the delay calculated
> +	 * above, delaying poll_enabled_time uS to check if the regulator
> +	 * actually got enabled.
> +	 * If the regulator isn't enabled after enable_delay has
> +	 * expired, return -ETIMEDOUT.
> +	 */
> +	if (rdev->desc->poll_enabled_time) {
> +		unsigned int time_remaining = delay;
> +
> +		while (time_remaining > 0) {
> +			_regulator_enable_delay(rdev->desc->poll_enabled_time);
> +
> +			if (rdev->desc->ops->get_status) {
> +				ret = _regulator_check_status_enabled(rdev);
> +				if (ret < 0)
> +					return ret;
> +				else if (ret)
> +					break;
> +			} else if (rdev->desc->ops->is_enabled(rdev))
> +				break;
> +
> +			time_remaining -= rdev->desc->poll_enabled_time;
> +		}
> +
> +		if (time_remaining <= 0) {
> +			rdev_err(rdev, "Enabled check failed.\n");
> +			return -ETIMEDOUT;
> +		}
> +	} else {
> +		_regulator_enable_delay(delay);
> +	}
>  
>  	trace_regulator_enable_complete(rdev_get_name(rdev));
>  
> diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
> index 29d920516e0b..bb50e943010f 100644
> --- a/include/linux/regulator/driver.h
> +++ b/include/linux/regulator/driver.h
> @@ -322,6 +322,9 @@ enum regulator_type {
>   * @enable_time: Time taken for initial enable of regulator (in uS).
>   * @off_on_delay: guard time (in uS), before re-enabling a regulator
>   *
> + * @poll_enabled_time: Maximum time (in uS) to poll if the regulator is
> + *                          actually enabled, after enable() call

I read this as "how long should we stay in the poll loop". I think it
would be better describes as something like "The polling interval to use
while checking that the regulator was actually enabled".

Regards,
Bjorn

> + *
>   * @of_map_mode: Maps a hardware mode defined in a DeviceTree to a standard mode
>   */
>  struct regulator_desc {
> @@ -389,6 +392,8 @@ struct regulator_desc {
>  
>  	unsigned int off_on_delay;
>  
> +	unsigned int poll_enabled_time;
> +
>  	unsigned int (*of_map_mode)(unsigned int mode);
>  };
>  
> -- 
> 2.26.2
> 
