Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1E7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7592071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fg7emq7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbgFVHaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731344AbgFVHaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:30:18 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E47C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:30:18 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t25so14758971oij.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ygaQRZsiHWxwQyMfFbHB0BV1hg9adFSrkxnAXBNM/Xo=;
        b=Fg7emq7u6AxvbahIlxX2OEGFyhdrP70UBnBknmSN2foEef4qnd2y/lgST91lNQWiGF
         XsgUC8J+w0VYhGHm4oZdzLaaB6GDupvwYBbeWJTB3ISR2N9mnx+FKi5NIerlVFaDJof6
         fFXMzbIcbcTph+esVMxxu/6flV+irY9rU5+hyJ0uWLzAaceHSnJ2J9ygJnhXqXLB5jyd
         bTFYNGUvWJa8q5fOUnvUGTyT19qv/wFGTGBDOJjs6WvdUIQE91PsObySKFR3yxlr5H5/
         +lUBozy9lwLLrSxjAqJ6SehdmX+9wXbQxRP17LZ/9TlUNtx/tH2Ik/zOGbJ6UaedmMYX
         WATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ygaQRZsiHWxwQyMfFbHB0BV1hg9adFSrkxnAXBNM/Xo=;
        b=FhCJ94XK07lEGrNnM/g+5+LPhZ558ECaSOGQEfUDCbwkov3TJDdSSFIL/VJOQ+CLaL
         vLRMoHTgpMrEaEeC9U+u/ESsAnq6iAIxBw6Fhk5e7zqkEdNGGHeNrKBM0gUja3M+NWFE
         Gq7vgr2MoFZ3Zzd+YRJ/zii0OxG84BSdpmFAhccHaAwhNUAuqJZ756Dym4RIyy4AOjzG
         Gx4IQiqkTHNmGQNuai1r09VZggv2oNTa2rbFaQKZT493S8LBrMderBwCx1E7yZj+kHKZ
         wtuTxAN8YfTNyo0ihUFG7gpawuRK3Itzh8dEv39143Tqo6SV3rainrLMwUxX0HlOwu1O
         zXYQ==
X-Gm-Message-State: AOAM530XneYAh7/B6le5SQIP9nwYcxstkhP2z4WBFRFpRfofLVVBAQcD
        7oms3Lj9cXarHMAXIc3c4B/hGQ==
X-Google-Smtp-Source: ABdhPJziLw4HeHf3U5p5Ms7FJjg86kxkO3uXjiamKOQkajCldTvffCNwAyUn8IpkhaFEuWdbh4+4GQ==
X-Received: by 2002:aca:5049:: with SMTP id e70mr11817176oib.72.1592811017862;
        Mon, 22 Jun 2020 00:30:17 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 190sm3246689oon.2.2020.06.22.00.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 00:30:17 -0700 (PDT)
Date:   Mon, 22 Jun 2020 00:27:32 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, s-anna@ti.com
Subject: Re: [PATCH v4 8/9] remoteproc: Refactor function rproc_free_vring()
Message-ID: <20200622072732.GJ149351@builder.lan>
References: <20200601175139.22097-1-mathieu.poirier@linaro.org>
 <20200601175139.22097-9-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601175139.22097-9-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Jun 10:51 PDT 2020, Mathieu Poirier wrote:

> When function rproc_free_vring() clears the virtio device section
> it does so on the cached resource table rather than the one
> installed in the remote processor memory.  When a remote processor
> has been booted by another entity there is no need to use a cached
> table and as such, no need to clear the virtio device section in
> it.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_core.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index d32ac8f0c872..0e23284fbd25 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -411,10 +411,22 @@ void rproc_free_vring(struct rproc_vring *rvring)
>  
>  	idr_remove(&rproc->notifyids, rvring->notifyid);
>  
> -	/* reset resource entry info */
> -	rsc = (void *)rproc->table_ptr + rvring->rvdev->rsc_offset;
> -	rsc->vring[idx].da = 0;
> -	rsc->vring[idx].notifyid = -1;
> +	/*
> +	 * At this point rproc_stop() has been called and the installed resource
> +	 * table in the remote processor memory may no longer be accessible. As
> +	 * such and as per rproc_stop(), rproc->table_ptr points to the cached
> +	 * resource table (rproc->cached_table).  The cached resource table is
> +	 * only available when a remote processor has been booted by the
> +	 * remoteproc core, otherwise it is NULL.
> +	 *
> +	 * Based on the above, reset the virtio device section in the cached
> +	 * resource table only if there is one to work with.
> +	 */
> +	if (rproc->table_ptr) {
> +		rsc = (void *)rproc->table_ptr + rvring->rvdev->rsc_offset;
> +		rsc->vring[idx].da = 0;
> +		rsc->vring[idx].notifyid = -1;
> +	}
>  }
>  
>  static int rproc_vdev_do_start(struct rproc_subdev *subdev)
> -- 
> 2.20.1
> 
