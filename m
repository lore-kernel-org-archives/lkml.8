Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617C4C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B101206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkKpc2Jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGQFDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 01:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgGQFDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 01:03:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BD1C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:03:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gc9so5962271pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ShbI1+9lFcZEZwxlQ7fpYW/wdg7t2yDwfyw40puWmmo=;
        b=IkKpc2JphzW2wnaE6/O9HYFekvdZrA0iZ9P0PDYTDnemYU6LlCFXReSqTEsKIpx7zt
         jb2CEoCodqma8C5PC4okq1X3sstRApRCgtOXjcNmsb+H7cjgpJWnKtZJpYyJ90gS2Mqf
         iBUFT3uzqOynWhiEQkQzdLfIyRmEb47JnsAeucVtxjBnkvzgaYrxjR0iu8vzzey9ZOt6
         1Z+k3I+dktefrmg7ZozPhAz2DIiDaovAguOHJz4ON82Wh5deJsugqqcvtZi/N71MuJpk
         rAz+Ror+W40jmw1HS0G7jTA8euBkiPtrmt358mXxS8+yxKxVqgjwcmuNjjU2Sllbij6D
         1wxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ShbI1+9lFcZEZwxlQ7fpYW/wdg7t2yDwfyw40puWmmo=;
        b=O5p388FyRh5VptDKV3TLIG9rkB/R4/65sPYgiWloAqgIFi9jgD9Sx3ZEUbjHI9ngjQ
         6PGTVJl8qM2iMvWikipxOU+aBiu/7KDcT8MMpr/KbvMUlDvjVHq5ZXvl/D1Nf11DDvYP
         dOQwty/PiNQYblqJMKsAPX4tr2mUg16gz41cfGPa0ItKYh4A/PzlpTYBFo6oKtTuEinR
         yPHSEIn7Npl6umc5UUFbHMWMDmL3+V3cmuveorVxiE49DZlq4rivWD08g0aMoaN34hKG
         5Sxz9dmlnYrD/59sKIFt1GwpG3A1zeT7la7iKtEwDqOfuyKEZSgpAfRTJInhbLW0O4D3
         z+Fw==
X-Gm-Message-State: AOAM531uWTbGVOAusiVnGqyU4m5isMPCT+ZULxYYVNWk1wEKSXXbv6Pz
        PqgUXkk208NBEHEuf/0O3gG6Lg==
X-Google-Smtp-Source: ABdhPJztzCYHCYkLAFAxl3K4Tg9WLZ0pv0E/O9FIcB+RSoCIOMMF8eLTByvpqmi8C6ODLJefbXrXBA==
X-Received: by 2002:a17:90a:3a81:: with SMTP id b1mr8405719pjc.217.1594962186100;
        Thu, 16 Jul 2020 22:03:06 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e18sm6243326pff.37.2020.07.16.22.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 22:03:05 -0700 (PDT)
Date:   Thu, 16 Jul 2020 22:01:03 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, sibis@codearora.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v8 2/5] remoteproc: qcom_q6v5_mss: Replace mask based
 tracking with size
Message-ID: <20200717050103.GE2922385@builder.lan>
References: <1594938035-7327-1-git-send-email-rishabhb@codeaurora.org>
 <1594938035-7327-3-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594938035-7327-3-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Jul 15:20 PDT 2020, Rishabh Bhatnagar wrote:

> From: Sibi Sankar <sibis@codeaurora.org>
> 
> In order to land inline coredump support for mss, the dump_segment
> function would need to support granularities less than the segment
> size. This is achieved by replacing mask based tracking with size.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index feb70283b..037cd45 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -181,8 +181,8 @@ struct q6v5 {
>  	bool running;
>  
>  	bool dump_mba_loaded;
> -	unsigned long dump_segment_mask;
> -	unsigned long dump_complete_mask;
> +	size_t current_dump_size;
> +	size_t total_dump_size;
>  
>  	phys_addr_t mba_phys;
>  	void *mba_region;
> @@ -1203,7 +1203,6 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
>  {
>  	int ret = 0;
>  	struct q6v5 *qproc = rproc->priv;
> -	unsigned long mask = BIT((unsigned long)segment->priv);
>  	int offset = segment->da - qproc->mpss_reloc;
>  	void *ptr = NULL;
>  
> @@ -1229,10 +1228,10 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
>  		memset(dest, 0xff, segment->size);
>  	}
>  
> -	qproc->dump_segment_mask |= mask;
> +	qproc->current_dump_size += segment->size;
>  
>  	/* Reclaim mba after copying segments */
> -	if (qproc->dump_segment_mask == qproc->dump_complete_mask) {
> +	if (qproc->current_dump_size == qproc->total_dump_size) {
>  		if (qproc->dump_mba_loaded) {
>  			/* Try to reset ownership back to Q6 */
>  			q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm,
> @@ -1274,7 +1273,7 @@ static int q6v5_start(struct rproc *rproc)
>  			"Failed to reclaim mba buffer system may become unstable\n");
>  
>  	/* Reset Dump Segment Mask */
> -	qproc->dump_segment_mask = 0;
> +	qproc->current_dump_size = 0;
>  	qproc->running = true;
>  
>  	return 0;
> @@ -1323,7 +1322,7 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
>  
>  	ehdr = (struct elf32_hdr *)fw->data;
>  	phdrs = (struct elf32_phdr *)(ehdr + 1);
> -	qproc->dump_complete_mask = 0;
> +	qproc->total_dump_size = 0;
>  
>  	for (i = 0; i < ehdr->e_phnum; i++) {
>  		phdr = &phdrs[i];
> @@ -1334,11 +1333,11 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
>  		ret = rproc_coredump_add_custom_segment(rproc, phdr->p_paddr,
>  							phdr->p_memsz,
>  							qcom_q6v5_dump_segment,
> -							(void *)i);
> +							NULL);
>  		if (ret)
>  			break;
>  
> -		qproc->dump_complete_mask |= BIT(i);
> +		qproc->total_dump_size += phdr->p_memsz;
>  	}
>  
>  	release_firmware(fw);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
