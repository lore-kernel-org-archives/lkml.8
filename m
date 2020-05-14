Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60527C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADD3206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WaEy+o54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgENFPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725876AbgENFPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:15:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5000C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 22:15:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s69so3765642pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 22:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2yXsWHQlHZFO6uOvXrEaZ/pS+PzZxIKV+dtwFcRxe6w=;
        b=WaEy+o54dBSzmlKivA2IuiMCd2bVGyN/8T4tkjvVvubQFLn97LTv0O/ySe1z/fH/u3
         MdiddCBwUdTikQYAt7mfPDkzu9K9YRsM1a26eZ7vgwdrfxQv9Ly8One/CWbQuwXe2QWZ
         d0wpkTf3Mt09I3QJARIvSlOGK8APyyQJweufAlgEfoyZZIzX+H4XMEuIHKwZR17+8Z8/
         bi2lE6JgFaPYNKf+KBzn/yQpi6Zom8tNmikCY+c6swEltzuP43VRUoGOCOcl8nf6vKEK
         6DJYLSPYRQRB76ESJr8A6lis27zwZihNf3FK1kdonfvLWja9w4FSmZlr+nveVp58bUwL
         7EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2yXsWHQlHZFO6uOvXrEaZ/pS+PzZxIKV+dtwFcRxe6w=;
        b=SFTtSsol7mRr5oAIdviwXLJXhbh5+xAGlzNEGJaf6ZYdxS4uTIw1NEV51RqBwgbX+D
         4UNzGiPcdLRPWQKH09J2x/RR0iO5B09N1J788mN9u5AtND35qBc0h6BglLsiCPxC10cE
         NxA1WcjReJU/Rik/N9cCFoISfpTK/FBa1K7UKz/Wkvar18f0XtAp0WRxOjPjRxUf8+Wl
         aZdE9ZNPHMBygTtN0g0ASmJyT4GRuZ3tf5JZI2234CqTMBYt5u9c4ezap2qrmi3dWNVB
         MgHXxfF7lvwl/9R5loYh1jfFyCGfgZS8bGfmyN+QS5haPrP5V2RvCBrXM8qiQ7Qil8Zr
         IK6g==
X-Gm-Message-State: AOAM5322NoCQ4RCRlGbV6wK9AMk1DUXD73uIrYTm2eiml8Kr5ktVWnc8
        jM0EpvLe6KSbvRFy42E3Y8tClQ==
X-Google-Smtp-Source: ABdhPJxxhy9EY2uDVHzZ5e3gf3ckUoHFy83l2BU7ClFXDzIPQkfzRRzKac281D9+vAEJfZiCrzq7bQ==
X-Received: by 2002:a17:90b:f86:: with SMTP id ft6mr7177214pjb.49.1589433307144;
        Wed, 13 May 2020 22:15:07 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w14sm1084582pgo.75.2020.05.13.22.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 22:15:06 -0700 (PDT)
Date:   Wed, 13 May 2020 22:13:36 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/12] remoteproc: stm32: Introduce new parse fw ops
 for synchronisation
Message-ID: <20200514051336.GA396285@builder.lan>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
 <20200424202505.29562-11-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424202505.29562-11-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24 Apr 13:25 PDT 2020, Mathieu Poirier wrote:

> Introduce new parse firmware rproc_ops functions to be used when
> synchonising with an MCU.
> 
> Mainly based on the work published by Arnaud Pouliquen [1].
> 
> [1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/stm32_rproc.c | 51 +++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 86d23c35d805..b8ae8aed5585 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -215,7 +215,34 @@ static int stm32_rproc_elf_load_rsc_table(struct rproc *rproc,
>  	return 0;
>  }
>  
> -static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
> +static int stm32_rproc_sync_elf_load_rsc_table(struct rproc *rproc,
> +					       const struct firmware *fw)
> +{
> +	struct resource_table *table = NULL;
> +	struct stm32_rproc *ddata = rproc->priv;
> +
> +	if (ddata->rsc_va) {

Does it really make sense to try to sync with a remote that doesn't have
a resource table?

> +		table = (struct resource_table *)ddata->rsc_va;
> +		/* Assuming that the resource table fits in 1kB is fair */
> +		rproc->cached_table = kmemdup(table, RSC_TBL_SIZE, GFP_KERNEL);

It's unfortunate that we need to create a clone of the resource table
that we found in ram, and then return the original memory when the core
ask for the loaded table...

I wonder if we somehow can avoid this in the core (i.e. skip overwriting
table_ptr with the cached_table during stop)

> +		if (!rproc->cached_table)
> +			return -ENOMEM;
> +
> +		rproc->table_ptr = rproc->cached_table;
> +		rproc->table_sz = RSC_TBL_SIZE;
> +		return 0;
> +	}
> +
> +	rproc->cached_table = NULL;
> +	rproc->table_ptr = NULL;
> +	rproc->table_sz = 0;
> +
> +	dev_warn(&rproc->dev, "no resource table found for this firmware\n");
> +	return 0;
> +}
> +
> +static int stm32_rproc_parse_memory_regions(struct rproc *rproc,
> +					    const struct firmware *fw)
>  {
>  	struct device *dev = rproc->dev.parent;
>  	struct device_node *np = dev->of_node;
> @@ -268,9 +295,30 @@ static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>  		index++;
>  	}
>  
> +	return 0;
> +}
> +
> +static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
> +{
> +	int ret = stm32_rproc_parse_memory_regions(rproc, fw);
> +
> +	if (ret)
> +		return ret;
> +
>  	return stm32_rproc_elf_load_rsc_table(rproc, fw);
>  }
>  
> +static int stm32_rproc_sync_parse_fw(struct rproc *rproc,
> +				     const struct firmware *fw)

Rather than having a function parse_fw that is passed no fw and return
some state that was setup in probe, how about just do this during probe?

Regards,
Bjorn

> +{
> +	int ret = stm32_rproc_parse_memory_regions(rproc, fw);
> +
> +	if (ret)
> +		return ret;
> +
> +	return stm32_rproc_sync_elf_load_rsc_table(rproc, fw);
> +}
> +
>  static irqreturn_t stm32_rproc_wdg(int irq, void *data)
>  {
>  	struct platform_device *pdev = data;
> @@ -544,6 +592,7 @@ static struct rproc_ops st_rproc_ops = {
>  static __maybe_unused struct rproc_ops st_rproc_sync_ops = {
>  	.start		= stm32_rproc_sync_start,
>  	.stop		= stm32_rproc_stop,
> +	.parse_fw       = stm32_rproc_sync_parse_fw,
>  };
>  
>  static const struct of_device_id stm32_rproc_match[] = {
> -- 
> 2.20.1
> 
