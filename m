Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448B8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 02:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078722082D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 02:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwGyNDkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgDKC0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 22:26:19 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34545 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDKC0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 22:26:19 -0400
Received: by mail-pj1-f65.google.com with SMTP id q16so2065723pje.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 19:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9QWTHRRLu2SNoXMVr8er30dtVtDUkqmUu8dqdXp0zBo=;
        b=gwGyNDkE+v0753EJpooO71QpVYwsLyrGTVnJYTW7Yzj6M0xU/QZj76chLAuTLZWSAG
         9lHH/MJUJLj4kFuBpNvzcZQPf1j9fZu7O9hvQENB7QVNK+S/54ggxGTxL1m6I0ymfRWV
         rkO3WVrqJECAUj5XBVaZWIG3U2bVUfy0yY0NskrWVbSysKwt+Dp3bPHtrllJ3u2ZurMS
         D4XSSm4pjVrZ8kVJNSQeFuijeEjqdnYSePe1hz44i2MzsEbSyi1fTzVdIgOkKodgYmFB
         5Q6p6aABytM5dpS+g2IPPItTlH0qU5SRAFRvv5uh5UNah6tRqWX/igx5ZsvwukX5xUX/
         IvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9QWTHRRLu2SNoXMVr8er30dtVtDUkqmUu8dqdXp0zBo=;
        b=CoOms2wNr3Pap//o+rtllzUj5xxN8iWNNNom72AMgH/Sl+AocZ6EtymV241ldQkX47
         Y19rbq4FjhvnW6GUpenBKm3gmoCxvAKftCMB7LjGHbrdBpf1HNTY1MXpaNlho6gNy8Ds
         1TeKhh1pEupyzSeE0tCPLKwhqbYSgyzyes9PFV7njQgmMkhZbFcjjjpvc1mGKHq9x1mu
         eUkEKfNnYAXk/rF4RLZEAjkdT7LF1FufVHiLoUHfnzhTUIL/iZuaQzmxqYXhgsznyfK4
         rAHcylrT2QB1STt1C80qgD9FUAqrRpDcRSTI1e9mjUDS5m8pOryQumjOO6DTsHBRZHrB
         iZAw==
X-Gm-Message-State: AGi0PuaCLFp+2uv/aTteBzCZ7PWFLvn4Y8Nz3zgG7dvcrqHvcTP5CFzU
        Ju+25goPBhlefDKrzt4lmKJ/Jg==
X-Google-Smtp-Source: APiQypIAUsk9JXZ4eZ7z5c+24lbiiLbP6zb1dK3BsKgHpLxi25S9VapHngUiDqP0Qg9FgGN/gX1gkg==
X-Received: by 2002:a17:90a:de0e:: with SMTP id m14mr8702041pjv.54.1586571977804;
        Fri, 10 Apr 2020 19:26:17 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g14sm2895868pjd.15.2020.04.10.19.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 19:26:17 -0700 (PDT)
Date:   Fri, 10 Apr 2020 19:26:27 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: Re: [PATCH v2 2/2] remoteproc: core: Prevent sleep when rproc crashes
Message-ID: <20200411022627.GA826227@builder.lan>
References: <1586384305-7825-1-git-send-email-sidgup@codeaurora.org>
 <1586384305-7825-3-git-send-email-sidgup@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586384305-7825-3-git-send-email-sidgup@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08 Apr 15:18 PDT 2020, Siddharth Gupta wrote:

> Remoteproc recovery should be fast and any delay will have an impact on the
> user-experience. Add a wakeup source to remoteproc which ensures that the
> system does not go into idle state while a remoteproc is recovering, thus
> prevent any delays that might occur during system resume.
> 

This is better, but I think it can be reworded further to show that it's
not a matter of making it "fast", it's a matter of preventing suspend
from interrupting the recovery of a remoteproc.

> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c   | 1 +
>  drivers/remoteproc/remoteproc_core.c | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 7a63efb..6bb2c7d 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -401,6 +401,7 @@ static int adsp_probe(struct platform_device *pdev)
>  
>  	adsp = (struct qcom_adsp *)rproc->priv;
>  	adsp->dev = &pdev->dev;
> +	device_wakeup_enable(adsp->dev);

Move this 5 lines down and give it an empty line before and after.

>  	adsp->rproc = rproc;
>  	adsp->pas_id = desc->pas_id;
>  	adsp->has_aggre2_clk = desc->has_aggre2_clk;
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 9f99fe2..19a360d 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1729,6 +1729,8 @@ static void rproc_crash_handler_work(struct work_struct *work)
>  
>  	if (!rproc->recovery_disabled)
>  		rproc_trigger_recovery(rproc);
> +
> +	pm_relax(rproc->dev.parent);
>  }
>  
>  /**
> @@ -2273,6 +2275,8 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
>  		return;
>  	}
>  

	/* Prevent suspend while the remoteproc is being recovered */


PS. This patch is unrelated to patch 1/2, so please resubmit it
separately.

Regards,
Bjorn

> +	pm_stay_awake(rproc->dev.parent);
> +
>  	dev_err(&rproc->dev, "crash detected in %s: type %s\n",
>  		rproc->name, rproc_crash_to_string(type));
>  
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
