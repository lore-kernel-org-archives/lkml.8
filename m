Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1467FC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 00:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68A420716
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 00:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4bSynyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgIDAE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 20:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgIDAE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 20:04:58 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225CBC061245
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 17:04:58 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id i4so4399131ota.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 17:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VSHHoRCPCCBCRo757gSOtAD/R8UuY2/X2C5k4cFW6xQ=;
        b=C4bSynyFciaY6I7tRwoCutZmg7kRL2P8HhCRG9MJT0iA5tcng6AZegRFvFsCVTyRyl
         IL7lbOa/hZBoVhC9wNGXLljZUZku0H0Qa90lmsfDN5keYetDvRRf1QGMjhiVXcxCJQOG
         jNhZGv9ERf0FaZb2xfiBeL7Yvptj2TNUhZNxzCSpAU5XbHhJD7Z7IlTVH39MlhEKF/OL
         tJM95UeqecPMSmbYBNkdxLwB0NM62ov6D4gW2h8c2yM1Xm6vcQqjWTZkNfWmoriSGQZe
         5nUrZdR5adMqiUA6VxG+olA74hTNHSncFxlk67MqA0NEXawx0KkdGAebH4A2qUiRbxNs
         IWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VSHHoRCPCCBCRo757gSOtAD/R8UuY2/X2C5k4cFW6xQ=;
        b=geLgMnXi+6vxN2Eay6tmgMRsIVK9fklygyakC6zXgTLHO4qXyKsLfFdfzJR5/hEYB5
         Vjz/FeIDji8GteGMX2/yAyAr6BFKSIbpMJmi9440T++CIGqjSbKV/UB6Y0Ty0ySC9oH5
         GOPlV6pAAUab5YQ1SW/VxsMFxcKCJ4d2/qwv9KmM/WpjT8+aXqxo8xhcJe4DEirqVBEz
         hxVW7j3OfqdePDeP+GUofTJ2jqoXeD0ekvwwjY1XkUVVyTrT4hlXcpsZv7ajSaiQw3AN
         BWkJxtulMG7SgtNre+zZCzJMAXoHXcE5Tux4gXxY44x3z/0o3XpeX5bdJ6xxVbrz42tx
         Msig==
X-Gm-Message-State: AOAM531sgeya/Gdo8CmOm6sf7saVJs/eG+OP1bTDGGcAcyB/984B2zTE
        XgYvNT8YLBJshvSSndt8RAY82w==
X-Google-Smtp-Source: ABdhPJxql8PSc86/6gHX0IL3TgXN6ryQG/9ZfnyydT7/gccfYkRb/wfacfkdyjQxVOEM0DMi+ihQEw==
X-Received: by 2002:a9d:4d0:: with SMTP id 74mr3688274otm.119.1599177897280;
        Thu, 03 Sep 2020 17:04:57 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id t4sm864852otc.24.2020.09.03.17.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 17:04:56 -0700 (PDT)
Date:   Thu, 3 Sep 2020 19:04:54 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v3 1/3] remoteproc: Expose remoteproc configuration
 through sysfs
Message-ID: <20200904000454.GD3715@yoga>
References: <1599174226-2307-1-git-send-email-rishabhb@codeaurora.org>
 <1599174226-2307-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599174226-2307-2-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Sep 18:03 CDT 2020, Rishabh Bhatnagar wrote:

> Add a feature flag to expose some of the remoteproc configuration
> through sysfs. This feature is helpful in systems where debugfs is
> not available/mounted. Currently the recovery and coredump
> configuration is exposed through sysfs rather than debugfs when
> this feature is selected.
> 

This commit message gives me the feeling that it's about making a
selection between debugfs vs sysfs. But the patches moves the code from
debugfs to sysfs and then hide it behind this config option.

That said, I just commented on v2 questioning that this should be a
compile time option at all - might be useful for some drivers to
dynamically "hide" these sysfs attributes though.

Regards,
Bjorn

> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index c6659dfe..98d52cbe 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -275,6 +275,17 @@ config TI_K3_DSP_REMOTEPROC
>  	  It's safe to say N here if you're not interested in utilizing
>  	  the DSP slave processors.
>  
> +config RPROC_SYSFS_CONFIGURATION_SUPPORT
> +	bool "Expose remoteproc configuration sysfs entries"
> +	default y
> +	help
> +	  Say y here to expose recovery and coredump configuration sysfs
> +	  entries. This is helpful in operating systems where debugfs is
> +	  not available/mounted.
> +
> +	  It's safe to say N here if you are not interested in accessing
> +	  recovery and coredump configuration through sysfs.
> +
>  endif # REMOTEPROC
>  
>  endmenu
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
