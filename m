Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99883C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7251920767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ztxpc9P/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbgDNWV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387609AbgDNWVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:21:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F0BC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:21:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h69so569662pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZwCrJaGxUOzJeHGKvHVPJYFgPdIhYcpo9yljCYyVINA=;
        b=ztxpc9P/5puzYuVP0ylIYDNls2wP+oCoQ5LomytlmZgClZ8aqrPg2fpqTfLkJP0M5d
         M5oSppS5NwlpOa/pz5s2uovRhN+jYnYinexRX3NPf63kKPMvZ7zhLwaTtbi9D9jCqpER
         mhqeL3QaxlvVdHn++gqu5g9eBYEnmz1e7jyFNlaAkPNUGcq7wbWL/gXE8mi0BxjCDtQ6
         Lt/2iTHeZcRji2SzUGOiKfZiqGfELyN/ghfduK24lqDlUfw4TaMWSfFUPmHqzq6HC9QR
         PcAbJkyq3KZ5gFA6edT3pBTPuojwr1xEiYfG21HRCwtcecUblGhE1kS0PHNwBzQFC76t
         0oVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZwCrJaGxUOzJeHGKvHVPJYFgPdIhYcpo9yljCYyVINA=;
        b=dyOZ2LEajqlU0pOjd22iw7ooHHQFZ8Dc+cUPYIZjn1j/d8pCbX4i1wRs48qt7Ytqvx
         dMmSXEFVB1Bx0RCuruzv6aZ1G0cYpFr6SBQxp3p35Jrx/vXIaP6/mzwikTp/HR3OnGJw
         4LsrXWGyGjxanEnx7IzIVlWmFjnLE3I9PCbffDYb23gQtzpkcrsqvc3H0KkU9gODwx71
         9JSTDNoT7iNDs3+1AxDRLSlaSHiJNDQNvXgldnf6rwNfT+vo3b6QXuUdRRse+XlWC+qi
         SuXmsi6VIgSIUm1cKBq6lSMnDpnEGCCJjro8+pVJUqvfUpRrD6p/ISEEc6WoqboanU26
         lNOg==
X-Gm-Message-State: AGi0PuZGcfSGjZbJDaUjfWEGHjEcsH/5O78eASEevz4qDfM53mC8kgxu
        sXOyLDOXw717RNUzJfH8zHvJjmShsUw=
X-Google-Smtp-Source: APiQypJK7Z+ffXbRR1wnDe41MyryqC1NgQllHHYkqbCtNvpgKWSRtwZTf1HG5yhq46Qb6hqUYGuF7w==
X-Received: by 2002:a62:5c1:: with SMTP id 184mr13429191pff.68.1586902903205;
        Tue, 14 Apr 2020 15:21:43 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g9sm11056999pgc.46.2020.04.14.15.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 15:21:42 -0700 (PDT)
Date:   Tue, 14 Apr 2020 15:21:58 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] soc: qcom: rpmpd: Allow RPMPD driver to be loaded
 as a module
Message-ID: <20200414222158.GL576963@builder.lan>
References: <20200326224459.105170-1-john.stultz@linaro.org>
 <20200326224459.105170-2-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326224459.105170-2-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26 Mar 15:44 PDT 2020, John Stultz wrote:

> This patch allow the rpmpd driver to be loaded as a permenent
> module. Meaning it can be loaded from a module, but then cannot
> be unloaded.
> 
> Ideally, it would include a remove hook and related logic, but
> apparently the genpd code isn't able to track usage and cleaning
> things up? (See: https://lkml.org/lkml/2019/1/24/38)
> 
> So making it a permenent module at least improves things slightly
> over requiring it to be a built in driver.
> 
> Feedback would be appreciated!
> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: linux-arm-msm@vger.kernel.org
> Acked-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Fix MODULE_LICENSE to be GPL v2 as suggested by Bjorn
> * Leave initcall as core_initcall, since that switches to module_initcall
>   only when built as a module, also suggested by Bjorn
> * Add module tags taken from Rajendra's earlier patch
> ---
>  drivers/soc/qcom/Kconfig | 4 ++--
>  drivers/soc/qcom/rpmpd.c | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
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
> index 2b1834c5609a..22fe94c03e79 100644
> --- a/drivers/soc/qcom/rpmpd.c
> +++ b/drivers/soc/qcom/rpmpd.c
> @@ -5,6 +5,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/mutex.h>
> +#include <linux/module.h>

module comes before mutex in the alphabet.

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
> @@ -422,3 +424,7 @@ static int __init rpmpd_init(void)
>  	return platform_driver_register(&rpmpd_driver);
>  }
>  core_initcall(rpmpd_init);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPM Power Domain Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:qcom-rpmpd");

Is there any reason for this alias?

The module will be automatically loaded based on compatible and the
MODULE_DEVICE_TABLE() information above, and for ACPI would need a
similar acpi_device_id table.

Regards,
Bjorn

> -- 
> 2.17.1
> 
