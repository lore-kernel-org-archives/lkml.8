Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C83BC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D59572070A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phPo4Gy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgGQFFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 01:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgGQFFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 01:05:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06598C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:05:42 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u5so4824650pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VTEZVIOiCGS/T8c+vGYTrPkNGXRl/4INiU1G5wt4TkQ=;
        b=phPo4Gy6/kkpPzzHO5YdflGM7eTIiRauOl0//z8atxzbsehYOrSnMEtayeq1pdHi/M
         L30hZIKBPj6WPV/9UZgBTty1Hl50i0M0VbZYWN/czrOa8mbNYSK9IfOhwtwRHBDkiAku
         3nAxFxKKMi2jtKFh9bXYIMKPH0FFefQDSs934vJ0UWM2HKVp/x4sd451jLwgIB5sANa7
         V0FNj/GXN+NWcrcHzC6KpjZ8Rv0b8kukPn6yLXpQAEU3mabtjzHFXmcihAQYmZx1wE/Z
         4jn3pcszagZ0x5d8/wVYo33roJesAHho4jepx2tFQoaJj8DgFbUpJKWiEm/ITC3O2hkM
         A5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VTEZVIOiCGS/T8c+vGYTrPkNGXRl/4INiU1G5wt4TkQ=;
        b=hvPBlSMBh/oEBVwSjarm+OzEnk4wC91xrrM/98l5oTaTmRkQvCq503/nOY2nc82a/v
         Ac7w8zl2lTAMt6wxzAXNTGxGO2H5vN2g4pX5DmhBM5cx6R9BFdfSyDmUEzq//6/0OxYO
         LYdmZR5M0OvuBACKCfF/yTzoSNkdMwhZS9bhHNZeQuh4ZaVJJ3RLa7CAoKdAMQkZDid4
         yWDTTMkbFtAIyVEB6ZD66eoEvPEtNc1NbIm8Cmg7LX2lPv8oV6N05MxdTz5YWbpgAwvo
         PsP/MQUzucURKFG6nwM11BVDI0mqFL1SNYyrwySeOcbDC/7EZE51kSgOgHLNPMwfwK8s
         SaYQ==
X-Gm-Message-State: AOAM531+w3fqr7JRqZSXBhTjKGSnwQYEq+X7PqbayLpbjVTP20J9eFmy
        jeBTIJbGWZbPsVyr2N9VHoLK9Q==
X-Google-Smtp-Source: ABdhPJzYZmEIGH7HWnECYCKaTykwlCz1C/BZZYw1p2QHUF0G4Yxjt+Ifp1OCWG8GS9BHhC9dU0t4bA==
X-Received: by 2002:a63:ab4f:: with SMTP id k15mr7342527pgp.247.1594962342362;
        Thu, 16 Jul 2020 22:05:42 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a30sm6379979pfr.87.2020.07.16.22.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 22:05:41 -0700 (PDT)
Date:   Thu, 16 Jul 2020 22:03:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, sibis@codearora.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v8 3/5] remoteproc: Pass size and offset as arguments to
 segment dump function
Message-ID: <20200717050339.GF2922385@builder.lan>
References: <1594938035-7327-1-git-send-email-rishabhb@codeaurora.org>
 <1594938035-7327-4-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594938035-7327-4-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Jul 15:20 PDT 2020, Rishabh Bhatnagar wrote:

> Change the segment dump API signature to include size and offset
> arguments. Refactor the qcom_q6v5_mss driver to use these
> arguments while copying the segment. Doing this lays the ground
> work for "inline" coredump functionality being added in the next
> patch.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c       | 10 +++++-----
>  drivers/remoteproc/remoteproc_coredump.c |  5 +++--
>  include/linux/remoteproc.h               |  5 +++--
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 037cd45..6baa3ae 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -1199,7 +1199,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  
>  static void qcom_q6v5_dump_segment(struct rproc *rproc,
>  				   struct rproc_dump_segment *segment,
> -				   void *dest)
> +				   void *dest, size_t cp_offset, size_t size)
>  {
>  	int ret = 0;
>  	struct q6v5 *qproc = rproc->priv;
> @@ -1219,16 +1219,16 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
>  	}
>  
>  	if (!ret)
> -		ptr = ioremap_wc(qproc->mpss_phys + offset, segment->size);
> +		ptr = ioremap_wc(qproc->mpss_phys + offset + cp_offset, size);
>  
>  	if (ptr) {
> -		memcpy(dest, ptr, segment->size);
> +		memcpy(dest, ptr, size);
>  		iounmap(ptr);
>  	} else {
> -		memset(dest, 0xff, segment->size);
> +		memset(dest, 0xff, size);
>  	}
>  
> -	qproc->current_dump_size += segment->size;
> +	qproc->current_dump_size += size;
>  
>  	/* Reclaim mba after copying segments */
>  	if (qproc->current_dump_size == qproc->total_dump_size) {
> diff --git a/drivers/remoteproc/remoteproc_coredump.c b/drivers/remoteproc/remoteproc_coredump.c
> index ded0244..390f563 100644
> --- a/drivers/remoteproc/remoteproc_coredump.c
> +++ b/drivers/remoteproc/remoteproc_coredump.c
> @@ -72,7 +72,8 @@ int rproc_coredump_add_custom_segment(struct rproc *rproc,
>  				      dma_addr_t da, size_t size,
>  				      void (*dumpfn)(struct rproc *rproc,
>  						     struct rproc_dump_segment *segment,
> -						     void *dest),
> +						     void *dest, size_t offset,
> +						     size_t size),
>  				      void *priv)
>  {
>  	struct rproc_dump_segment *segment;
> @@ -183,7 +184,7 @@ void rproc_coredump(struct rproc *rproc)
>  		elf_phdr_set_p_align(class, phdr, 0);
>  
>  		if (segment->dump) {
> -			segment->dump(rproc, segment, data + offset);
> +			segment->dump(rproc, segment, data + offset, 0, segment->size);
>  		} else {
>  			ptr = rproc_da_to_va(rproc, segment->da, segment->size);
>  			if (!ptr) {
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index e7b7bab..eb08139 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -451,7 +451,7 @@ struct rproc_dump_segment {
>  
>  	void *priv;
>  	void (*dump)(struct rproc *rproc, struct rproc_dump_segment *segment,
> -		     void *dest);
> +		     void *dest, size_t offset, size_t size);
>  	loff_t offset;
>  };
>  
> @@ -630,7 +630,8 @@ int rproc_coredump_add_custom_segment(struct rproc *rproc,
>  				      dma_addr_t da, size_t size,
>  				      void (*dumpfn)(struct rproc *rproc,
>  						     struct rproc_dump_segment *segment,
> -						     void *dest),
> +						     void *dest, size_t offset,
> +						     size_t size),
>  				      void *priv);
>  int rproc_coredump_set_elf_info(struct rproc *rproc, u8 class, u16 machine);
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
