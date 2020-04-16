Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2131CC38A29
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 19:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F201B21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 19:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCizqDZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgDPTls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 15:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725894AbgDPTlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 15:41:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84484C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 12:41:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i3so2141622pgk.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4+5yvpF/CzkFV4Q2jkIdrwA/yhScLV1YzzJf+T0+lT0=;
        b=vCizqDZqzySQAlaQKNZSPfzWTNKVRci9vMWz/TPic+3XrkQ03Ffgkm9kWe0f4jZjUf
         8G/6u6CSBI/Ollj0zVbg8YRdI9x7IulHItSD/ttIFKdkO77DNk9A2QM5GoXfHCf58OOY
         ENtU9vEBypBTtQvaaLBL8IVFxOKZCqadrz/x6ScCnlG0oxmakq9nru4cWYT20gdDgyY4
         UI+drYXOPUwSRIZRBwmi9GvTGrryUnz5pMW4HOHttXbnoQotENvKHXfDGo8RgUaV0vxP
         3QlZeNHsCFrYH93qGFHQbLR2Z2zNWAVNhknBrBzhUwknHU7g1S3YMLN4mvZEVckyopmG
         kNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4+5yvpF/CzkFV4Q2jkIdrwA/yhScLV1YzzJf+T0+lT0=;
        b=adanUkApuHxlTcVOAbU8J6ykiFm3HxSsnBOVAhFrIwWiJSRbUWAiBvMpEFyXs/Orjb
         SV+IvO2j/ANYi+dZzP4K8L4XWH2zuSn62VcnrXPTiNkC56UVdRLY1NzXwRcvmZbBNq+E
         +1BLsfFDCH1UFFiCFpHk7Gx24joWBhovp9vZgTfdKX7zLy0Y9D8A9gHxCtwKZTa2B5d6
         eO7ruGjNBH0jNbZ6od9Hf7RkRVYW40LZzW0Y/+ndzt/pAyQrVyUzd/amtUPKtr2clOeD
         yM9DBDtxzql26xtbmomuPAv3Kdit3ZeOdP11/9PJJAc9t64r/OSN4UWF5bWSsnaXgn06
         AqIg==
X-Gm-Message-State: AGi0Puah416dZev8rLf9PVTOP7i99cho1NeQjOcLkKj8UQmKrAtD3qmV
        ir1E8f9C7OEcG26NJ2Q72j7NSzEFxIY=
X-Google-Smtp-Source: APiQypL9j8meLyGkikWSZboSQOmU2u65qLLK1r6+xhTUyBIVdpn5qScfiojY7EddmHUFHZFnYDfj6w==
X-Received: by 2002:a05:6a00:c8:: with SMTP id e8mr32914135pfj.131.1587066106898;
        Thu, 16 Apr 2020 12:41:46 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y123sm17140605pfb.13.2020.04.16.12.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 12:41:46 -0700 (PDT)
Date:   Thu, 16 Apr 2020 13:41:44 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: Re: [PATCH v2 2/2] remoteproc: core: Prevent sleep when rproc crashes
Message-ID: <20200416194144.GA30314@xps15>
References: <1586384305-7825-1-git-send-email-sidgup@codeaurora.org>
 <1586384305-7825-3-git-send-email-sidgup@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586384305-7825-3-git-send-email-sidgup@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 03:18:25PM -0700, Siddharth Gupta wrote:
> Remoteproc recovery should be fast and any delay will have an impact on the
> user-experience. Add a wakeup source to remoteproc which ensures that the
> system does not go into idle state while a remoteproc is recovering, thus
> prevent any delays that might occur during system resume.
> 
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
> +	pm_stay_awake(rproc->dev.parent);
> +

Much better:

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	dev_err(&rproc->dev, "crash detected in %s: type %s\n",
>  		rproc->name, rproc_crash_to_string(type));
>  
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
