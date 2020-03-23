Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD92C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CCA20714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjNaZRyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgCWWpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 18:45:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44010 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCWWpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 18:45:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id f206so8255283pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 15:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TtecznepabbAupu5OhOJc88aU0NaofKjnQBnVaXn4N0=;
        b=IjNaZRyRYGMcE0x6dwwZkBtuw57R2TXwcrpUx9acHodEYtVrFi2TRISrhMH1zS6FXa
         lhc2ZjvhReJVfj99jl6Ouimr/xKCRphxnaXm7MlXv16EnADSwT2syqhfllDVSRIzDYW8
         KfspzlCde6336YXWInAYnEJWipEoiKWX3XL/xv6CT5huoO7/Rmm+wDlewDFSVaW734N8
         afFeZ8eeVydh7pkemF5N7VASjgAubIYC5atJ/5AQXESzuXFciWhNMKAxNA0RYf1GVYUy
         BkpGAYI2SqpAnbDSsKbR8biPgWYasibtetHE2JbS3XvfJz7/l5kirAu81G/8goa+5/mG
         wIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TtecznepabbAupu5OhOJc88aU0NaofKjnQBnVaXn4N0=;
        b=Ih68tY1roopke9RzNMKELqzi6PBpK/2/P/utm3YdN7z+dz72eaA+unP5++tyneDjU+
         rkTSX1vGkwPhS+B1OoGF2hHiLFoFx3Bl5ocF30hx3j/+7zbXqgWxESYYCSThs93tGwek
         9D3Q0RCAwOxXFzRnN0lL6FT4kTSBygK1AihpyWoRAPoe4Owy3cJGygRFeUuD7p6uQQQB
         gOsaHnlu4C/n59MSfhQd0rKX6tdPT4nv7sYFeOuBH4QnuwUrl93NJRS3JFDb3IZTBDe1
         O9MPJDffWhdxA0VEMfM6q01A7wzT2KReAm4ssxc0AKFtKJBPB515ibrH/vMoA1qpAvw6
         2RRQ==
X-Gm-Message-State: ANhLgQ1JxPCjMdztZAjBxznxJx7LwU/HOb3wwleSTLyUj54COD+6YTJw
        Xh8zOxKNfCTf7VVNfpGESeRrfQ==
X-Google-Smtp-Source: ADFU+vvYPq6IkWolXCJyUIaTFdVYJTxdfEQvTVJCVUvN27Ti6d8m7eoCGv8VwrrCCv/bFy/UakGVPA==
X-Received: by 2002:a63:fe58:: with SMTP id x24mr23348015pgj.170.1585003539852;
        Mon, 23 Mar 2020 15:45:39 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y9sm10286254pfo.135.2020.03.23.15.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 15:45:39 -0700 (PDT)
Date:   Mon, 23 Mar 2020 16:45:36 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] remoteproc: qcom: Introduce panic handler for PAS
 and ADSP
Message-ID: <20200323224536.GE30464@xps15>
References: <20200310063817.3344712-1-bjorn.andersson@linaro.org>
 <20200310063817.3344712-5-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310063817.3344712-5-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 11:38:17PM -0700, Bjorn Andersson wrote:
> Make the PAS and ADSP/CDSP remoteproc drivers implement the panic
> handler that will invoke a stop to prepare the remoteprocs for post
> mortem debugging.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Change since v3:
>  - Change return type to unsigned long
> 
>  drivers/remoteproc/qcom_q6v5_adsp.c | 8 ++++++++
>  drivers/remoteproc/qcom_q6v5_pas.c  | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index d5cdff942535..8f1044e8ea3b 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -292,12 +292,20 @@ static void *adsp_da_to_va(struct rproc *rproc, u64 da, int len)
>  	return adsp->mem_region + offset;
>  }
>  
> +static unsigned long adsp_panic(struct rproc *rproc)
> +{
> +	struct qcom_adsp *adsp = rproc->priv;
> +
> +	return qcom_q6v5_panic(&adsp->q6v5);
> +}
> +
>  static const struct rproc_ops adsp_ops = {
>  	.start = adsp_start,
>  	.stop = adsp_stop,
>  	.da_to_va = adsp_da_to_va,
>  	.parse_fw = qcom_register_dump_segments,
>  	.load = adsp_load,
> +	.panic = adsp_panic,
>  };
>  
>  static int adsp_init_clock(struct qcom_adsp *adsp, const char **clk_ids)
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index e64c268e6113..678c0ddfce96 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -243,12 +243,20 @@ static void *adsp_da_to_va(struct rproc *rproc, u64 da, int len)
>  	return adsp->mem_region + offset;
>  }
>  
> +static unsigned long adsp_panic(struct rproc *rproc)
> +{
> +	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;

Above rproc->priv is not casted but it is here... Not a problem, just
consistency.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> +
> +	return qcom_q6v5_panic(&adsp->q6v5);
> +}
> +
>  static const struct rproc_ops adsp_ops = {
>  	.start = adsp_start,
>  	.stop = adsp_stop,
>  	.da_to_va = adsp_da_to_va,
>  	.parse_fw = qcom_register_dump_segments,
>  	.load = adsp_load,
> +	.panic = adsp_panic,
>  };
>  
>  static int adsp_init_clock(struct qcom_adsp *adsp)
> -- 
> 2.24.0
> 
