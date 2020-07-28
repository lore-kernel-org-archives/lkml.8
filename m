Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E355C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B898207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUg3NliK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgG1GMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgG1GMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:12:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC4C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:12:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id lw1so2256052pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FTEn6vC4TzDFRYgBbBTvo3anpjXgbfxoEfVzcA7SkSk=;
        b=MUg3NliKoM4l5YHCqj5bM6/ricxHDSN+fUGuIqDe/VZsMi11o6T2ZWNrRmiGKK5bXn
         dLZvVFi/IzR3WXetg3BP7uU3fBwXJssdNdgivnfmBA7cBYg+K5O4ADsLf8uOtjMgwCmW
         BHVtqNd36wdDmGMHvhmLxiLOiWxKlF+4EXujG3fIufA2TNNIHe5Nz+L91MFOKPFXIVKl
         SQJdZRQBhdKoCi1prMQzl3mdc4RBqCnSLm8j77reyUikupG/akrM9Siwn4HHjKS03a5W
         7YnQPphP5IXd+BRNyHBQC9v7DGBNN9AcgsvqcnvlqDDqrmOCT3LpU7oErJhyYlMdKGUO
         gTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FTEn6vC4TzDFRYgBbBTvo3anpjXgbfxoEfVzcA7SkSk=;
        b=JB19ACFx6HF+b6O8EB1gF+SLIhTmxDyI2YyOP6w1ZQkF7lNk4E8zPGFQIsQdF6jJdM
         FtcYdU/EUpc5OcgUs6KyfxTRcNz5sOizoIK0fjtlsvmzUtRmkyfsrlPrwUEx5P7m5nmK
         UObL3+z1maSastsi7Z9j3oXrVu6Xbix2TcY/90CPExHxYXfz9Ujmr/8Z7sbo45fkLcT9
         1raX6sVYwscTySOmZk/9Gnpt4oFaMBZB3wQYNvBDLDKY8RaTeIVMsY53MJ7/3ilrVcvS
         12Ru4EqTgOuv8GUxRaK16Dyexc+oue+K6NugXbOMTbB8Dqvr7wwnP7Rh7m39+SKosqVe
         3zRA==
X-Gm-Message-State: AOAM532xTlTpFSVi8b7DeGoThooJl/4sLBnBpdwjaPjsyaBababLatej
        I180Xj/CsFdZqeBz5sQcxC6THA==
X-Google-Smtp-Source: ABdhPJy3fY7LAadwN1KhzxnyyGUckPuRZaBmAV2u3CSU6/2WJqNnkEDPuCSPRvntmZyPct9tGqDxrQ==
X-Received: by 2002:a17:902:7484:: with SMTP id h4mr7663521pll.139.1595916750072;
        Mon, 27 Jul 2020 23:12:30 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b22sm1545548pju.26.2020.07.27.23.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 23:12:29 -0700 (PDT)
Date:   Mon, 27 Jul 2020 23:08:57 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     rishabhb@codeaurora.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, sidgup@codeaurora.org, stable@vger.kernel.org
Subject: Re: [RESEND v1] soc: qcom: pdr: Reorder the PD state indication ack
Message-ID: <20200728060857.GB202429@builder.lan>
References: <20200701195954.9007-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701195954.9007-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01 Jul 12:59 PDT 2020, Sibi Sankar wrote:

> The Protection Domains (PD) have a mechanism to keep its resources
> enabled until the PD down indication is acked. Reorder the PD state
> indication ack so that clients get to release the relevant resources
> before the PD goes down.
> 
> Fixes: fbe639b44a82 ("soc: qcom: Introduce Protection Domain Restart helpers")
> Reported-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> 
> I couldn't find the previous patch on patchworks. Resending the patch
> since it would need to land on stable trees as well
> 
>  drivers/soc/qcom/pdr_interface.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
> index a90d707da6894..088dc99f77f3f 100644
> --- a/drivers/soc/qcom/pdr_interface.c
> +++ b/drivers/soc/qcom/pdr_interface.c
> @@ -279,13 +279,15 @@ static void pdr_indack_work(struct work_struct *work)
>  
>  	list_for_each_entry_safe(ind, tmp, &pdr->indack_list, node) {
>  		pds = ind->pds;
> -		pdr_send_indack_msg(pdr, pds, ind->transaction_id);
>  
>  		mutex_lock(&pdr->status_lock);
>  		pds->state = ind->curr_state;
>  		pdr->status(pds->state, pds->service_path, pdr->priv);
>  		mutex_unlock(&pdr->status_lock);
>  
> +		/* Ack the indication after clients release the PD resources */
> +		pdr_send_indack_msg(pdr, pds, ind->transaction_id);
> +
>  		mutex_lock(&pdr->list_lock);
>  		list_del(&ind->node);
>  		mutex_unlock(&pdr->list_lock);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
