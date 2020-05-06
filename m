Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A38C47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B2D20721
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GaKi7CgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgEFAlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 20:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgEFAlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 20:41:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77A5C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 17:41:33 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q24so25862pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 17:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zr3qvb+Ut2s97bD0EkxwEuSZBJMTkTrRquNnixCkEaI=;
        b=GaKi7CgHgoyjZ7fujORQxjoWl3jgqo9cpnUwLQAxjfDT0SX++WDGWsFct3J7jMvvQx
         d7tsy9KhLzk29z+v66OkFS1G0QFtxNFybaS0jMlp4HRhuQUolpOqD0xhCU4D4E6AtNBT
         siwQK4Qm6NEv4ald6KKkW91VBmJ4Zl0Md/PIYgPpQS/9LHt1kWaYcARDSDrYTlmqB9Yl
         ySYxUpolW2qJI6eHohCsu7aZ8YMzenTkFBI3xaZDAT9PtOpOFm5FCFEApN7/GIqNHlm1
         af0yPf+ZvhRyiDpusXnnuQG+b+gtTvvbz2TMFCmQ6YocTnQEKvR459w0uRIoy8+1B4MG
         WdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zr3qvb+Ut2s97bD0EkxwEuSZBJMTkTrRquNnixCkEaI=;
        b=gsTMVu+iaaDY50ctRvVlfajUSi/EbJJCNo2iiRrGdpiaEK4t3rSM/7+nMU03ouQiTG
         XXFTPi/Ge64BM+qQnsXaLMaxv/GWZze9bUGeqdezmaKIR/Fq2i4th26AEP0shEXuEn5P
         IqggV7QACQuRJ5RHn566hC9mEvv4jBUbcLq+W47muDLomyIcIHqc8+HRkyfQkwG2/GvQ
         Kj4wsC0AWeLRjV9ppwbf0GtW9pi0q2OLvCNemmGJbL3IFOCDlGIcdrHjcmlwcV9q5YH3
         5onA6Fv/3P6DlN6Cn4bBy9mD7t2qHfeDEOXUM2+v5KzoIt5FVqyLkNX5wr4tlpHXtBjZ
         kX1w==
X-Gm-Message-State: AGi0PuaCD0ysQaNdqQsFZNfEZ+R7p5NvQuenIwMyHVp+eC14bXc/ub0l
        GCmoEhd8HlYfwSSssb02lbnmjg==
X-Google-Smtp-Source: APiQypISKDRS5zXBzR37EauPrXdEUNdAGAofCQuw8lDj0uZ0w+CpaKoTE7KeUuYR9oKABNrBga2aeg==
X-Received: by 2002:a17:90a:cc6:: with SMTP id 6mr2752915pjt.17.1588725693003;
        Tue, 05 May 2020 17:41:33 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k4sm247972pgg.88.2020.05.05.17.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:41:32 -0700 (PDT)
Date:   Tue, 5 May 2020 17:42:17 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, loic.pallardy@st.com, arnaud.pouliquen@st.com,
        s-anna@ti.com, linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/14] remoteproc: Introducting new start and stop
 functions
Message-ID: <20200506004217.GE2329931@builder.lan>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-8-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424200135.28825-8-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24 Apr 13:01 PDT 2020, Mathieu Poirier wrote:

> Add new functions to replace direct calling of rproc->ops->start() and
> rproc->ops->stop().  That way different behaviour can be played out
> when booting a remote processor or synchronising with it.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

PS. But I do wonder if we should just inline the struct rproc_ops in
struct rproc, rather than allocate a separate object for it. But after
adding all your accessors changing this would be quite succinct.

Regards,
Bjorn

> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c     |  6 +++---
>  drivers/remoteproc/remoteproc_internal.h | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 9de0e2b7ca2b..ef88d3e84bfb 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1339,7 +1339,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  	}
>  
>  	/* power up the remote processor */
> -	ret = rproc->ops->start(rproc);
> +	ret = rproc_start_device(rproc);
>  	if (ret) {
>  		dev_err(dev, "can't start rproc %s: %d\n", rproc->name, ret);
>  		goto unprepare_subdevices;
> @@ -1360,7 +1360,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  	return 0;
>  
>  stop_rproc:
> -	rproc->ops->stop(rproc);
> +	rproc_stop_device(rproc);
>  unprepare_subdevices:
>  	rproc_unprepare_subdevices(rproc);
>  reset_table_ptr:
> @@ -1493,7 +1493,7 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
>  	rproc->table_ptr = rproc->cached_table;
>  
>  	/* power off the remote processor */
> -	ret = rproc->ops->stop(rproc);
> +	ret = rproc_stop_device(rproc);
>  	if (ret) {
>  		dev_err(dev, "can't stop rproc: %d\n", ret);
>  		return ret;
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 47b500e40dd9..dda7044c4b3e 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -125,6 +125,22 @@ struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
>  	return NULL;
>  }
>  
> +static inline int rproc_start_device(struct rproc *rproc)
> +{
> +	if (rproc->ops && rproc->ops->start)
> +		return rproc->ops->start(rproc);
> +
> +	return 0;
> +}
> +
> +static inline int rproc_stop_device(struct rproc *rproc)
> +{
> +	if (rproc->ops && rproc->ops->stop)
> +		return rproc->ops->stop(rproc);
> +
> +	return 0;
> +}
> +
>  static inline
>  bool rproc_u64_fit_in_size_t(u64 val)
>  {
> -- 
> 2.20.1
> 
