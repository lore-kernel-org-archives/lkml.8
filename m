Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA99C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F4A206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkuhUNV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgENFRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgENFR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:17:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AD6C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 22:17:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id z15so2583261pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 22:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GjJPgwHAWLCdp+4b5y9We0V/4Ec6i8aFUo1gPxwMZ7w=;
        b=MkuhUNV21I7fxjv4MrVDEcmFSHwUJ9lvNGa8cXCPIn1dx62l2uSsNsmmCeUQUAS43c
         nSBL/PzySbiBqaxWXoaUqcFN4ADbjC3t4Xb9Lvu49f4EjFmeUeGrJ3izVna5vv3tvv3q
         CulRTby5nRpPCy1ASOPVRug05M2Ky27e6fZQ+faMWY3rzOeXkdzbjf/QghV0sgzv9sfU
         7TRQ58vGck02M+Wrm/1GoCQ0sdlvDSoFrEOmQo+bQB6vZ1gPEqYB4BwIA7+BHFNlhp/p
         d6BqcGuXO/C2zmjGPLXrbWachYsg3NZ1dIU9EauzT7U0aS9REMPNzBRSGJZ10hk/BUJG
         lOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GjJPgwHAWLCdp+4b5y9We0V/4Ec6i8aFUo1gPxwMZ7w=;
        b=mrRchoOPfWagr2gRRsNB4dk4HngnRuUtekWatsvTUKsApPXpMnjV7oRfR90EjyWEof
         /uhNSw6iErR0v8MxiaxpPb9AxalPqaAJxD+nSahKAYTjMSw7I5F3ISRkEZgTVFsf5YjT
         53h6J+eVAPgY8bW3p1nz0/Lmo7dKXjvYQZEtLnl489BFYTp3OsRuD2iPPjBkGs6FAp1p
         aq7kA57AAncWf9Cy5/DM1ySjlmETYKP0nA1+yN+74c1kTXYzrgmXhr+FgyOFP/rfeHJC
         6i84rNnIZi8rvOc5stdwaiyfcrM/YfDwH/L1rkgK0dWddyM35cYmq8585ag52NytCgPO
         av8A==
X-Gm-Message-State: AOAM530midzuH3fhlY5Aje0SCK5Uq93fwPyLk8/+gxiLmPNueRNQrIE9
        n3aqs8KJroHvvuXP8KDpv+7aCA==
X-Google-Smtp-Source: ABdhPJwPKu284FGW2y3JeQslHbE7FXQ0tLPsAtF5Z1Sd1/eTKJSL1+BfVYzPKbw4EN2fAafX5g9fYw==
X-Received: by 2002:a17:902:c406:: with SMTP id k6mr2369370plk.203.1589433447383;
        Wed, 13 May 2020 22:17:27 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a7sm1126526pfg.157.2020.05.13.22.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 22:17:26 -0700 (PDT)
Date:   Wed, 13 May 2020 22:15:56 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/12] remoteproc: stm32: Introduce new loaded rsc ops
 for synchronisation
Message-ID: <20200514051556.GB396285@builder.lan>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
 <20200424202505.29562-12-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424202505.29562-12-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24 Apr 13:25 PDT 2020, Mathieu Poirier wrote:

> Introduce new elf find loaded resource table rproc_ops functions to be
> used when synchonising with an MCU.
> 
> Mainly based on the work published by Arnaud Pouliquen [1].
> 
> [1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Loic Pallardy <loic.pallardy@st.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>


But I would have preferred if we during probe (when we discover rsc_va)
could just set it on the rproc.

Regards,
Bjorn

> ---
>  drivers/remoteproc/stm32_rproc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index b8ae8aed5585..dcae6103e3df 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -319,6 +319,15 @@ static int stm32_rproc_sync_parse_fw(struct rproc *rproc,
>  	return stm32_rproc_sync_elf_load_rsc_table(rproc, fw);
>  }
>  
> +static struct resource_table *
> +stm32_rproc_sync_elf_find_loaded_rsc_table(struct rproc *rproc,
> +					   const struct firmware *fw)
> +{
> +	struct stm32_rproc *ddata = rproc->priv;
> +
> +	return (struct resource_table *)ddata->rsc_va;
> +}
> +
>  static irqreturn_t stm32_rproc_wdg(int irq, void *data)
>  {
>  	struct platform_device *pdev = data;
> @@ -593,6 +602,7 @@ static __maybe_unused struct rproc_ops st_rproc_sync_ops = {
>  	.start		= stm32_rproc_sync_start,
>  	.stop		= stm32_rproc_stop,
>  	.parse_fw       = stm32_rproc_sync_parse_fw,
> +	.find_loaded_rsc_table = stm32_rproc_sync_elf_find_loaded_rsc_table,
>  };
>  
>  static const struct of_device_id stm32_rproc_match[] = {
> -- 
> 2.20.1
> 
