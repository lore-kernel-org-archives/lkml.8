Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6891AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE4E207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZDXrjZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgCEGc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 01:32:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39354 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCEGc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:32:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id l7so2265942pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 22:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OHuQ7NXNCR+ZoFua9rfpRHN3FD4skavIt3u2z9bFrLA=;
        b=WZDXrjZ/wdICqXkWYYByKRbIf8p6Ij0vCfwrQMcKeQFhVfxUpL6Yv8gCROOFRsqKdk
         XCs4P0NRPjjySp3UjhP2pD3WM/42WRANerdDg3/wEKbc/4qKPtOPXrz8fDA/zGxb6UyO
         fr707wVNAcx/F9aed07HZtmiexGn1diIloQ1XL/LCiRoiqGZzA45dzsu+zupcgUzZUp/
         AiMSPVKOONauBWnjMPVZ8BAfssaa3ArsWVOrfvzKNXKawI0YvqTgyTlw/8FDzG4MDXKl
         +E9RBoYCTCGjV7VKzmjyKul3wj6pVJcEqDnolM1PgYtq8jTv715kIHrh3zlPUY/SqTaO
         29DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OHuQ7NXNCR+ZoFua9rfpRHN3FD4skavIt3u2z9bFrLA=;
        b=p6/akauNCclFBnyffRh+sGHDnNPy9X6/4UbDSzkXmrWqKTdlEKxqHE7TsaUPmecAX0
         SjPVs2EnNAa43V8Y6wk1H1wbWA+z48vP9ydmpvSZ2aFhIuYbu4FS78W5M4GQ4DKGbua2
         q4pdg4xl3C/L6WebzX0OlT2ZywPX6GE4zZ+2ZVxGBVBpjWLS7FWHXK0xw7/++A4emphT
         3REdIKBGFXXBUhORYhOvIxMYFOLskSxS2xGuAG5NA6ZvI5QMqqVAmQmuL4BHxjQx0JJd
         SI7dKe+oQ997sqtNNSBsZOmv1B467FPt+4FCcKQx4NObRdwkIYHv941FCm5EMDH4rJ+t
         dSbw==
X-Gm-Message-State: ANhLgQ0CnSUueKLbrBCAIa8YSvwq33lkD+pdRmWPWjsdbTH803vdmLe7
        Lz1a865OLHHNVp/rU4Hi0ecFJw==
X-Google-Smtp-Source: ADFU+vtDYHksqnOq7nTdSPnOM7vgGEiUD2XIZwWXmDE10z1ICttq0kHgsv/JXqqKadQCsWRvBHF78A==
X-Received: by 2002:aa7:87d4:: with SMTP id i20mr6686632pfo.22.1583389977501;
        Wed, 04 Mar 2020 22:32:57 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 18sm31335508pfj.20.2020.03.04.22.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 22:32:56 -0800 (PST)
Date:   Wed, 4 Mar 2020 22:32:54 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC][PATCH] soc: qcom: rpmpd: Allow RPMPD driver to be loaded
 as a module
Message-ID: <20200305063254.GC264362@yoga>
References: <20200305054244.128950-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305054244.128950-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04 Mar 21:42 PST 2020, John Stultz wrote:

> Allow the rpmpd driver to be loaded as a module.
> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig | 4 ++--
>  drivers/soc/qcom/rpmpd.c | 5 ++++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index d0a73e76d563..af774555b9d2 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -123,8 +123,8 @@ config QCOM_RPMHPD
>  	  for the voltage rail.
>  
>  config QCOM_RPMPD
> -	bool "Qualcomm RPM Power domain driver"
> -	depends on QCOM_SMD_RPM=y
> +	tristate "Qualcomm RPM Power domain driver"
> +	depends on QCOM_SMD_RPM
>  	help
>  	  QCOM RPM Power domain driver to support power-domains with
>  	  performance states. The driver communicates a performance state
> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
> index 2b1834c5609a..9c0834913f3f 100644
> --- a/drivers/soc/qcom/rpmpd.c
> +++ b/drivers/soc/qcom/rpmpd.c
> @@ -5,6 +5,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/mutex.h>
> +#include <linux/module.h>
>  #include <linux/pm_domain.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -226,6 +227,7 @@ static const struct of_device_id rpmpd_match_table[] = {
>  	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, rpmpd_match_table);
>  
>  static int rpmpd_send_enable(struct rpmpd *pd, bool enable)
>  {
> @@ -421,4 +423,5 @@ static int __init rpmpd_init(void)
>  {
>  	return platform_driver_register(&rpmpd_driver);
>  }
> -core_initcall(rpmpd_init);
> +module_init(rpmpd_init);

Can't you keep this as core_initcall(), for the times when its builtin?

Additionally I believe you should add a call to unregister the driver,
and drop the suppress_bind_attrs.

> +MODULE_LICENSE("GPL");

"GPL v2" per the SPDX?

Regards,
Bjorn

> -- 
> 2.17.1
> 
