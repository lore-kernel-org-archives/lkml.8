Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D21C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61FD22314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJXgIfvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgATTYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 14:24:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46788 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgATTYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:24:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id n9so179451pff.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 11:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4BImEj4H53pDmcZg2F5mDuPA97CrTOZdicbRO7KXC2w=;
        b=SJXgIfvyWUbFDJRJHMl3vakHhpmRchRQnb/4moM5JQQNLQ8WkBRrzsNXOXT3g1+9f3
         Dil/2snqAtHl+dbIl3dIxmRxJlCT/J3ncCcVoBxSHMv+sGcHeJdWM27DorO68WKGUw3q
         3IvLHQvLgfHLXf+ZqDOdQ0rDSUMPN1cGv3c0lpq64Bme3saRnIJwJyqVsKxeUKQrVtey
         8GRoPXQC8glf9a3CT9Loj91qVEq9F3l62U93f6STPGDmhGPEimnpRhFCh/iTtwclzeqr
         pL9Ww0Bwu3FOv1vKFLRYJVrZS/eu+XLR7jkBoTKFR5eua4hHnWQtEUWSsTusCmfthx79
         gCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4BImEj4H53pDmcZg2F5mDuPA97CrTOZdicbRO7KXC2w=;
        b=o/5PV5QbJlGD1FYPx8sYLDlW7Fk0pps7PTsdGmjHeK6PVyeOtxkgnDVMpzeZAnUd80
         TN9Xu5sIzJ2L15OKoVc/llhMv1F8u+uERQu0yM6drM+jnxeIj9IWVsA6g74zHjI0/SIj
         KLlkJSq/a2DpduDKxjiC1VSt/PVcJWz7wrwlAylwDqTDMjhT8SkucfGVc4wrsTBikgE+
         r2YyIg9HmSaonXj/I7iDcqqFThepLeEdR4vKQYOY23g8Rf9nOh8/zU8oBgpM0qRrp6/X
         nUWq6FCxU8ESBzuL/tVDhatRaW/p35mgTLGYXoWEoNx6DQ8uhW/ULWLbjVUD4AruOF0o
         R7Tg==
X-Gm-Message-State: APjAAAWFilrN2sRAkQN8gxMKHoXozB5zeB4mRhAbJ6F5s6ioDk8s1yOe
        HFEL/FFEZSB82HbMD/eytruQ4Q==
X-Google-Smtp-Source: APXvYqwTpbmTC0/4YIYnBfzFSfiJW1OAQ4LFl8vJvbkCRR0WIbfjOsKAg8PEOBfPpe2u1BHUXs04OQ==
X-Received: by 2002:a63:1346:: with SMTP id 6mr1251849pgt.111.1579548275691;
        Mon, 20 Jan 2020 11:24:35 -0800 (PST)
Received: from yoga (wsip-184-181-24-67.sd.sd.cox.net. [184.181.24.67])
        by smtp.gmail.com with ESMTPSA id u127sm41991223pfc.95.2020.01.20.11.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 11:24:35 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:24:32 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     evgreen@chromium.org, p.zabel@pengutronix.de, ohad@wizery.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org
Subject: Re: [PATCH 1/4] remoteproc: qcom: q6v5-mss: Use
 regmap_read_poll_timeout
Message-ID: <20200120192432.GJ1511@yoga>
References: <20200117135130.3605-1-sibis@codeaurora.org>
 <20200117135130.3605-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117135130.3605-2-sibis@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17 Jan 05:51 PST 2020, Sibi Sankar wrote:

> Replace the loop for HALT_ACK detection with regmap_read_poll_timeout.
> 

Nice, but we should be able to do the same in q6v5proc_halt_axi_port()?

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 51f451311f5fc..f20b39c6ff0ed 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -73,6 +73,7 @@
>  #define NAV_AXI_IDLE_BIT		BIT(2)
>  
>  #define HALT_ACK_TIMEOUT_MS		100
> +#define NAV_HALT_ACK_TIMEOUT_US		200
>  
>  /* QDSP6SS_RESET */
>  #define Q6SS_STOP_CORE			BIT(0)
> @@ -746,7 +747,6 @@ static void q6v5proc_halt_nav_axi_port(struct q6v5 *qproc,
>  				       struct regmap *halt_map,
>  				       u32 offset)
>  {
> -	unsigned long timeout;
>  	unsigned int val;
>  	int ret;
>  
> @@ -760,15 +760,11 @@ static void q6v5proc_halt_nav_axi_port(struct q6v5 *qproc,
>  			   NAV_AXI_HALTREQ_BIT);
>  
>  	/* Wait for halt ack*/
> -	timeout = jiffies + msecs_to_jiffies(HALT_ACK_TIMEOUT_MS);
> -	for (;;) {
> -		ret = regmap_read(halt_map, offset, &val);
> -		if (ret || (val & NAV_AXI_HALTACK_BIT) ||
> -		    time_after(jiffies, timeout))
> -			break;
> -
> -		udelay(5);
> -	}
> +	ret = regmap_read_poll_timeout(halt_map, offset, val,
> +				       (val & NAV_AXI_HALTACK_BIT),
> +				       5, NAV_HALT_ACK_TIMEOUT_US);
> +	if (ret)
> +		dev_err(qproc->dev, "nav halt ack timeout\n");

Is there a case where this new print adds value beyond the printout we
already have for the case of IDLE_BIT not going high? Can we simply
ignore the return value and skip the print?

Regards,
Bjorn

>  
>  	ret = regmap_read(halt_map, offset, &val);
>  	if (ret || !(val & NAV_AXI_IDLE_BIT))
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
