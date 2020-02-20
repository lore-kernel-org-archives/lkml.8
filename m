Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5347DC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2006D2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5fK4c9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgBTQGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:06:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44758 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgBTQGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:06:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id y5so2119675pfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=krrxH27lIx2E4AVPC5iG7lBwI8cN/o92i3R8uGjhA/Y=;
        b=I5fK4c9rp/OihwtRRnjqrk6Pl5kAQr+ph/FS95THm84A8bmHugVwBBatLx5r6r4UuW
         7F1QDwGtILZ+Epjb+I52hPzrMGpGzRpsSe+McqLUPAs2ulmrxoYd/pOwVsN/ru4xBZuM
         4spkoiEom4nFsrFcvwu6vMekGBqtIJS3431pjzl4QrAv55HpwchqgRoA32FHh2KgaCUh
         yKfA1IaIZUeAIKjVVwf47wY3YrLsMv/D3HYX6V/pjtXK3mYuIX5QOnHAsaAzOC+D/b94
         S9loLac7IhaQ/jsPGm9pFaVLj033U5wzb4I0EFm+XNaLXjthyv6m9WjcOwqQaCiEGj/z
         CpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=krrxH27lIx2E4AVPC5iG7lBwI8cN/o92i3R8uGjhA/Y=;
        b=ebcCm4V1XZ0pbRDr9OZsi35IHq1kTJuLHiIvioPd+CqD2B2wimLC/lUIbj44An29QA
         UPdQRuUj4Mzc6xvOLfGZxrYLrtGIxTdbrk9EVMgUjS2mX0g8a/EmlNikPdgAuYpavZfI
         NMHyCE5gloGh76u1vnKcWS9H0IpMI47OsD8bTiOa33O2ofiug6EWryVpTc1BY+duJZ/B
         5UOIxYTQ3PR3YI+H/fvAzzYZMTu5xnKrdvvw30viglSbBwyUPqYTQo5LR+7oh3vjxCcW
         UrOOdPWdw0oW1FuN+Eqhvyfzls3rixEkRLjOYXzAMZoHWZQRtlfpsgKG9cEWDXBgohZJ
         8aTg==
X-Gm-Message-State: APjAAAW5jaS2sR5K1huO0xobyxmCvu6halklG/FRPxnEMRYLAxYIrYPM
        HS3HvBSqTAm4ePKuUS1x6palbA==
X-Google-Smtp-Source: APXvYqyA8SiL9zsGCO9QowSVOhf6FmRdpkFI7ig6gwV4ex9e2FlfmsxL+158EqyfEvVpLwpH6Y/2lg==
X-Received: by 2002:a63:c903:: with SMTP id o3mr8845679pgg.109.1582214778283;
        Thu, 20 Feb 2020 08:06:18 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r9sm36631pfl.136.2020.02.20.08.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:06:17 -0800 (PST)
Date:   Thu, 20 Feb 2020 08:05:22 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 6/6] regulator: Use driver_deferred_probe_timeout for
 regulator_init_complete_work
Message-ID: <20200220160522.GH955802@ripper>
References: <20200220050440.45878-1-john.stultz@linaro.org>
 <20200220050440.45878-7-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220050440.45878-7-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19 Feb 21:04 PST 2020, John Stultz wrote:

> The regulator_init_complete_work logic defers the cleanup for an
> arbitrary 30 seconds of time to allow modules loaded by userland
> to start.
> 
> This arbitrary timeout is similar to the
> driver_deferred_probe_timeout value, and its been suggested we
> align these so users have a method to extend the timeouts as
> needed.
> 
> So this patch changes the logic to use the
> driver_deferred_probe_timeout value if it is set, otherwise we
> directly call the regulator_init_complete_work_function().
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Change-Id: I9fa2411abbb91ed4dd0edc41e8cc8583577c005b

Change-Id...

> ---
> v4:
> * Split out into its own patch, as suggested by Mark
> ---
>  drivers/regulator/core.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index d015d99cb59d..394e7b11576a 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -5767,18 +5767,21 @@ static int __init regulator_init_complete(void)
>  		has_full_constraints = true;
>  
>  	/*
> -	 * We punt completion for an arbitrary amount of time since
> -	 * systems like distros will load many drivers from userspace
> -	 * so consumers might not always be ready yet, this is
> -	 * particularly an issue with laptops where this might bounce
> -	 * the display off then on.  Ideally we'd get a notification
> -	 * from userspace when this happens but we don't so just wait
> -	 * a bit and hope we waited long enough.  It'd be better if
> -	 * we'd only do this on systems that need it, and a kernel
> -	 * command line option might be useful.
> +	 * If driver_deferred_probe_timeout is set, we punt
> +	 * completion for that many seconds since systems like
> +	 * distros will load many drivers from userspace so consumers
> +	 * might not always be ready yet, this is particularly an
> +	 * issue with laptops where this might bounce the display off
> +	 * then on.  Ideally we'd get a notification from userspace
> +	 * when this happens but we don't so just wait a bit and hope
> +	 * we waited long enough.  It'd be better if we'd only do
> +	 * this on systems that need it.
>  	 */
> -	schedule_delayed_work(&regulator_init_complete_work,
> -			      msecs_to_jiffies(30000));
> +	if (driver_deferred_probe_timeout >= 0)
> +		schedule_delayed_work(&regulator_init_complete_work,
> +				      driver_deferred_probe_timeout * HZ);
> +	else
> +		regulator_init_complete_work_function(NULL);

Why not schedule_delayed_work(..., 0) in this case, to get it off the
initcall context and to avoid the difference in execution paths?

Regards,
Bjorn

>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
