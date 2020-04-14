Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1333C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A754B2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bmlnEgpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391903AbgDNWZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391879AbgDNWZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:25:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7803FC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:25:02 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r20so611859pfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o6i20Ks1PEy0O2Dez1crBLWSnGkxHA1qZ6Sv65Y5ZcE=;
        b=bmlnEgpOTsqn8jWMcxn9YPJfTQ2qJzPH+g1Mg0JzBWIy3G6ewnL6gvNwUexCEy+G/G
         Z/icrTbm6ig5neLhjjHSbppVp0ZyApdxNapUlQtkL/8T0L1Lq61csRBGAaUA/DVv1lRM
         KPD9pj755ZQihBzbjGXcwdbLg7UQIvhwglFQWm1tTdPzpyQafypNyi2cFC6GY48ZYqmA
         XyVEAqEZWwZplV8drZ54w5IEnRhJxN+F+vk4WLCKMbse/Vv6xJuINTfY1SrKvelgAYPh
         SEgOgTW+oM1CN48HrF9rY5h9w/h4OSEFI4g8vWlisXsov3fUPfbkPA10ilLctcknksai
         9vtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o6i20Ks1PEy0O2Dez1crBLWSnGkxHA1qZ6Sv65Y5ZcE=;
        b=qMR24KHVCpxg040bICTfHwXN5cFPzzZMdUAwfjKsggcJMR/y89YqVWO602E90c4bPe
         be+gef37rqb1Sl3eY+b1ilqP6Pn9QiJEhEg+/AMxZixSfJc6HGWHwtwydJwAv0qriSzP
         5b+vikNrq4GWJrjWGLpbIZoyKJjlNHa0CvOs6GY+frTrnH+u/FddQ0JgRiUtXr+33ffQ
         hCUyBHaox/8IBW6IE1Eq+MU6AU23esu8m5v+lgGdwi0AjYNluoO3r9fflkY84+WSAMLO
         KdlMLgkzAqEAL3F6tuMJimAGu9GYT7sSakKzzhYzXzvWX8XM/8axesLu1+eCeH2h9j9z
         Zcbg==
X-Gm-Message-State: AGi0PuZY4TSEsAuHlPkX6E2v0CEgzt5gA5JJIIJhQ4kMeh1ktK4eBd8d
        WZDzLZtx6NEd8bV6SezETEYYiw==
X-Google-Smtp-Source: APiQypL0GsDHjhCV+L1MOkC/mR6A9G4Q3663J9tosl/v69Mi9xv+tX2h21MJvEapbUUaAITtAPKDnw==
X-Received: by 2002:a63:e60a:: with SMTP id g10mr23481248pgh.51.1586903101953;
        Tue, 14 Apr 2020 15:25:01 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 7sm8245619pff.109.2020.04.14.15.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 15:25:01 -0700 (PDT)
Date:   Tue, 14 Apr 2020 15:25:17 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 3/3] soc: qcom: rpmhpd: Allow RPMHPD driver to be
 loaded as a module
Message-ID: <20200414222517.GN576963@builder.lan>
References: <20200326224459.105170-1-john.stultz@linaro.org>
 <20200326224459.105170-4-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326224459.105170-4-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26 Mar 15:44 PDT 2020, John Stultz wrote:

> This patch allow the rpmhpd driver to be loaded as a permenent
> module. Meaning it can be loaded from a module, but then cannot
> be unloaded.
> 
> Ideally, it would include a remove hook and related logic, but
> apparently the genpd code isn't able to track usage and cleaning
> things up?
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
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

and applied.

Regards,
Bjorn

> ---
>  drivers/soc/qcom/Kconfig  | 2 +-
>  drivers/soc/qcom/rpmhpd.c | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index ac91eaf810f7..ffc04285840b 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -114,7 +114,7 @@ config QCOM_RPMH
>  	  help apply the aggregated state on the resource.
>  
>  config QCOM_RPMHPD
> -	bool "Qualcomm RPMh Power domain driver"
> +	tristate "Qualcomm RPMh Power domain driver"
>  	depends on QCOM_RPMH && QCOM_COMMAND_DB
>  	help
>  	  QCOM RPMh Power domain driver to support power-domains with
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 4d264d0672c4..0bb12d5870a7 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -4,6 +4,7 @@
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pm_domain.h>
>  #include <linux/slab.h>
> @@ -189,6 +190,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
>  	{ .compatible = "qcom,sm8150-rpmhpd", .data = &sm8150_desc },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, rpmhpd_match_table);
>  
>  static int rpmhpd_send_corner(struct rpmhpd *pd, int state,
>  			      unsigned int corner, bool sync)
> @@ -460,3 +462,6 @@ static int __init rpmhpd_init(void)
>  	return platform_driver_register(&rpmhpd_driver);
>  }
>  core_initcall(rpmhpd_init);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPMh Power Domain Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 
