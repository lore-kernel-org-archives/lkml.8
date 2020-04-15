Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30835C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BD82064A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Po4qxnD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416772AbgDOSZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416763AbgDOSZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:25:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640BEC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:25:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d1so384718pfh.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=apBr6U14gYAAXnZtkH5iEMZA/sjqdQJ3G2FfRV4H7YQ=;
        b=Po4qxnD3VdhSZtdSzQscRSZsNseMPMZihIabc7K9yyi8mc1G8NKK8ikzG6/Ypuu/ks
         Ol3VVFgueALm9UtzNcZn9TQ3V9f4FiSAPKX7Pu3gljKEXTMuXZELrctTSBE8FvyBAP4+
         iBwJH7Jq+3Yfd+RZ/m3PkOnAszwWpPxH8fLHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=apBr6U14gYAAXnZtkH5iEMZA/sjqdQJ3G2FfRV4H7YQ=;
        b=MaQFpkXChy/Hd3PccBGOCBj4BqesZ5J5CwF+4F/MDSMRlV+MB/BJe4Wec83bPS3rU/
         pnf2hDhbq2Wqay+8utrPWP973loeTz7sQri6BzvhbhI5Pg4cdXUy/gXEmYWU1DlWwbUr
         elMgMJyalf7ovoO4eHlKqW7QAXlP6ANx4tITUEi2/PlBerGLUS8lMxsEuCztzlNGGpj4
         RM/TPK+bSXklWIR9jqRQqav223QwPIoJks0Xh8XdBCnMY/YrATwRmX0KUGxVGU1FQkvM
         cl60OKTVHHBdAUUQ7APMeeJ3AwLc144WSeLAgcTZbReaicEbjK7d1q+4VivIwDFu3uyO
         TH0A==
X-Gm-Message-State: AGi0PuZtq/ZEdslgx0gZ9MPSxp+9HvaaUrKFVboD023ztNIv7PAK+i/v
        nT+4YdHe8NMhmldi5R68G+eLPg==
X-Google-Smtp-Source: APiQypJAnIDjHsDbTZhHp1Ut7lqwB7mc5nU6RFZeHtVBd7LVASQYggF/EztLTh6wgsDBA5J1iYwGXA==
X-Received: by 2002:a62:cdcc:: with SMTP id o195mr29335324pfg.323.1586975138818;
        Wed, 15 Apr 2020 11:25:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id i15sm2661368pfo.195.2020.04.15.11.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 11:25:37 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:25:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 2/3] soc: qcom: rpmh: Allow RPMH driver to be loaded
 as a module
Message-ID: <20200415182536.GX199755@google.com>
References: <20200326224459.105170-1-john.stultz@linaro.org>
 <20200326224459.105170-3-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326224459.105170-3-john.stultz@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

with commit efde2659b0fe ("drivers: qcom: rpmh-rsc: Use rcuidle
tracepoints for rpmh") the rpmh-rsc driver fails to build as a
module:

drivers/soc/qcom/rpmh-rsc.c:281:3: error: implicit declaration of function 'trace_rpmh_send_msg_rcuidle' [-Werror,-Wimplicit-function-decr]
                trace_rpmh_send_msg_rcuidle(drv, tcs_id, j, msgid, cmd);


The problem is that the _rcuidle() functions are not generated for modules:

#ifndef MODULE
#define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_args) \
	static inline void trace_##name##_rcuidle(proto)		\
	{								\
		if (static_key_false(&__tracepoint_##name.key))		\
			__DO_TRACE(&__tracepoint_##name,		\
				TP_PROTO(data_proto),			\
				TP_ARGS(data_args),			\
				TP_CONDITION(cond), 1);			\
	}
#else
#define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_args)
#endif

Not sure what the best solution would be in this case. Having the macro
define a dummy function for modules would fix the build error, however it
would be confusing that the event is traced when the driver is built-in,
but not when it is built as a module.

I imagine the goal behind making this driver a module is to have a single
kernel image for multiple SoC platforms, without too much platform
specific code in the kernel image itself.

I guess the question is whether there any options for keeping the driver
modular and having consistent tracing behavior, short of removing the
tracepoint.

On Thu, Mar 26, 2020 at 10:44:58PM +0000, John Stultz wrote:
> This patch allow the rpmh driver to be loaded as a permenent
> module. Meaning it can be loaded from a module, but then cannot
> be unloaded.
> 
> Ideally, it would include a remove hook and related logic, but
> the rpmh driver is fairly core to the system, so once its loaded
> with almost anythign else to get the system to go, the dependencies
> are not likely to ever also be removed.
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
> ---
>  drivers/soc/qcom/Kconfig    | 2 +-
>  drivers/soc/qcom/rpmh-rsc.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index af774555b9d2..ac91eaf810f7 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -104,7 +104,7 @@ config QCOM_RMTFS_MEM
>  	  Say y here if you intend to boot the modem remoteproc.
>  
>  config QCOM_RPMH
> -	bool "Qualcomm RPM-Hardened (RPMH) Communication"
> +	tristate "Qualcomm RPM-Hardened (RPMH) Communication"
>  	depends on ARCH_QCOM && ARM64 || COMPILE_TEST
>  	help
>  	  Support for communication with the hardened-RPM blocks in
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index e278fc11fe5c..30585d98fdf1 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -11,6 +11,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> @@ -679,6 +680,8 @@ static const struct of_device_id rpmh_drv_match[] = {
>  	{ .compatible = "qcom,rpmh-rsc", },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, rpmh_drv_match);
> +
>  
>  static struct platform_driver rpmh_driver = {
>  	.probe = rpmh_rsc_probe,
> @@ -693,3 +696,6 @@ static int __init rpmh_driver_init(void)
>  	return platform_driver_register(&rpmh_driver);
>  }
>  arch_initcall(rpmh_driver_init);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPMh Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 
