Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26778C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F305122527
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIan6DgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgATTgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 14:36:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42703 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgATTgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:36:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id s64so157184pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 11:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kV18ZB3OdaVHnupftfiGPuw+5EOO07kYgb5mXEqEo+k=;
        b=EIan6DgANAg+4ke6Cn/EoZM5Bkx1BLqgja/FLOcAN7QnF6He78WJH/Fc98ZouFNhuX
         p7wS/vsDuAYEk5X+RK0kYx58xYRN+yB2zW9H/RrC99OIgCATBEvlqvXPGcoC6xAj2fnC
         9j9uH9RJXpgSXzXV0r/ShpvW+w5/8EBI6tHmW+w0sV+E0gkSBBnhFHzPbzHznAi2imvB
         DK5O5VMWQm3LUF8rt8+s1KZxBrATrMfa4EdW0b3Ah6MOIdFFXKoZw6IZWaqIgwNCBp0k
         jAc6hmZakXqfgKPEssaLtGBwZKHrzHvxp6hHnKE3DO6Q54tioEtNGpp5Rqx/N+cp0p3s
         Eb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kV18ZB3OdaVHnupftfiGPuw+5EOO07kYgb5mXEqEo+k=;
        b=TtpXOTn0VrdrHPPmeamwqakG5fm2XngXCsLA2LtnhiJV6dCndM8HdFGjIuX9JgTgji
         1U7Xf2vs7IUwRumewnizNAHlPP9z3tg5S/rY3izYUHdvr0l6igKYvW5bqYp6yXGCscfZ
         yHE0CRNVhszrNy5W3+1Tpm4IZX8cCEWl0voOVS6kh5RpY2MG/V7XUnssu5vGUeUSgEDb
         z6uvOUazvWxemvRlX8GLaT4EtHR8jYme2AKijNfTIsOYTbGsGg9OrXdcouWO60z0RjtG
         pMcFVFUFGKseJTdFgjCF5J+H0Gi6bt5sjW0LZzfdsWUS++sPexDrZeWGlyLkaW9rm5Wm
         Eyow==
X-Gm-Message-State: APjAAAXyMQ8mKY8M+iv4IxPLkYv0U4bibbnpwvUF94IAUADHfXijWq81
        Wvf1i9QGdBsRVO8bLiWabjVJrA==
X-Google-Smtp-Source: APXvYqzZSgL5iovEwaLITIBxMYmbfTg8/ef5G7Tf37jgVvwlVQ2dIYbc+ZkQ88Yeufnv8XVA4/Oi3w==
X-Received: by 2002:a63:1b54:: with SMTP id b20mr1303204pgm.312.1579549001420;
        Mon, 20 Jan 2020 11:36:41 -0800 (PST)
Received: from yoga (wsip-184-181-24-67.sd.sd.cox.net. [184.181.24.67])
        by smtp.gmail.com with ESMTPSA id k190sm39447610pga.73.2020.01.20.11.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 11:36:40 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:36:38 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     evgreen@chromium.org, p.zabel@pengutronix.de, ohad@wizery.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org
Subject: Re: [PATCH 4/4] remoteproc: qcom: q6v5-mss: Improve readability of
 reset_assert
Message-ID: <20200120193638.GK1511@yoga>
References: <20200117135130.3605-1-sibis@codeaurora.org>
 <20200117135130.3605-5-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117135130.3605-5-sibis@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17 Jan 05:51 PST 2020, Sibi Sankar wrote:

> Define CONN_BOX_SPARE_0_EN and fixup comments to improve readability of
> Q6 modem reset_assert sequence on SC7180 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 6a98e9029c70b..8c9cfc213d5ff 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -71,6 +71,7 @@
>  #define NAV_AXI_HALTREQ_BIT		BIT(0)
>  #define NAV_AXI_HALTACK_BIT		BIT(1)
>  #define NAV_AXI_IDLE_BIT		BIT(2)
> +#define CONN_BOX_SPARE_0_EN		BIT(0)
>  
>  #define HALT_ACK_TIMEOUT_MS		100
>  #define NAV_HALT_ACK_TIMEOUT_US		200
> @@ -415,16 +416,26 @@ static int q6v5_reset_assert(struct q6v5 *qproc)
>  		ret = reset_control_reset(qproc->mss_restart);
>  		reset_control_deassert(qproc->pdc_reset);
>  	} else if (qproc->has_halt_nav) {
> -		/* SWAR using CONN_BOX_SPARE_0 for pipeline glitch issue */
> +		/*
> +		 * SWWA for the pipeline glitch issue seen while

Is SWWA an abbreviation for SoftWare WorkAround?

> +		 * putting the Q6 modem on SC7180 into reset:
> +		 * 1 - Assert PDC reset
> +		 * 2 - Set CONN_BOX_SPARE_0_EN
> +		 * 3 - Withdraw the halt requests
> +		 * 4 - Assert MSS reset
> +		 * 5 - Deassert PDC reset
> +		 * 6 - Clear CONN_BOX_SPARE_0_EN
> +		 * 7 - Deassert MSS reset

This pretty much outlines what's written below. How about making this
something like:

/* 
 * Work around a pipeline glitch seen when putting the Q6 modem in
 * SC7180 into reset by also toggling CONN_BOX_SPARE_0_EN, while holding
 * the PDC reset.
 */


Although, it would be even better if it indicated what you mean with
"pipeline glitch"...

Regards,
Bjorn

> +		 */
>  		reset_control_assert(qproc->pdc_reset);
>  		regmap_update_bits(qproc->conn_map, qproc->conn_box,
> -				   BIT(0), BIT(0));
> +				   CONN_BOX_SPARE_0_EN, 1);
>  		regmap_update_bits(qproc->halt_nav_map, qproc->halt_nav,
>  				   NAV_AXI_HALTREQ_BIT, 0);
>  		reset_control_assert(qproc->mss_restart);
>  		reset_control_deassert(qproc->pdc_reset);
>  		regmap_update_bits(qproc->conn_map, qproc->conn_box,
> -				   BIT(0), 0);
> +				   CONN_BOX_SPARE_0_EN, 0);
>  		ret = reset_control_deassert(qproc->mss_restart);
>  	} else {
>  		ret = reset_control_assert(qproc->mss_restart);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
