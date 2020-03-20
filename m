Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D91AC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFD720739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YprCCeD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgCTUeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:34:14 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50825 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCTUeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:34:14 -0400
Received: by mail-pj1-f68.google.com with SMTP id v13so3013152pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 13:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x8zGXsapHuWnqMC8cZSaagYiLOs94TGgifWsiIRGTSM=;
        b=YprCCeD9Wl+McB6ZRErSXSnfWwEZBH5YThXbWzDhm9ZWAPbyBLeTaZxu4kts8/HVC+
         7zB1EcA5VN5akzU7Mp+X2R2flpKXTzM62cvzUUWSu8v9W0SkHw3vTIupRKLok16UN10k
         eAKKs52fMZzRnNJwBb2X+mfGkFNg1bGMItzSxbwHcsoF4ymsUPOqrAzE0c1G4H0qft4E
         +phE/Ml3hNTb+rO/d1d3qvhJTelnmlyTaa5VczkZDFQjnnQQ1RXPnVruhAtBDbr0JRxk
         xWzLW2z2FGckcMgPmizse39QL4IeQSnV94UuzyNPINKDxKU+SKeDsK5sP+kG0CHYZHn9
         8Lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x8zGXsapHuWnqMC8cZSaagYiLOs94TGgifWsiIRGTSM=;
        b=tVrD8VNciIHUTMvAVkW2vlmqZyAnnSOV8ahSWsTsemPKQq4nx/Kzh1+7JrO9bTRMFO
         VEOVQml+xTK23efhxmNOsfxwIzK+I3qx9yiLd5/bITmbE1JbhjGSn/HpZc9mY+luhP/o
         RbfavrIAu50u/CtyaJkOhFSzaxtb9qTGiipK1oFnTRUr7kBMjS0thVRBGW+BlBJUU7Kx
         5T4k9bdParnEXLqYH8Elv9QYppiMG+AoPq7udD/51mDCW2NOGdFI+i2Epr1Kjn5GoBPw
         oFvB8c01Qn5VXXqleihc9ZQKCbYrkHxkz2PE/EO2l5aIcSeScMSFY4PYUhP5uiuAZJYg
         9QcA==
X-Gm-Message-State: ANhLgQ1lA8iXOQDsrFzg5dlT/Ky+M4ADKgylV2o/7bNcRKAL3uS6V08E
        HR24UyE0CVx3C04Z9U2dDsM8Aw==
X-Google-Smtp-Source: ADFU+vtZlnHDo2zCjA+NB50NqFM3kOSwr9ntQAIkhkaWBh3ON1lfL7OI5PQTvzgPqzaiaFCejv3GZQ==
X-Received: by 2002:a17:90a:e013:: with SMTP id u19mr11095637pjy.65.1584736452872;
        Fri, 20 Mar 2020 13:34:12 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d206sm6174522pfd.160.2020.03.20.13.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:34:12 -0700 (PDT)
Date:   Fri, 20 Mar 2020 14:34:09 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Andrew F. Davis" <afd@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv8 RESEND 03/15] remoteproc/omap: Add a sanity check for
 DSP boot address alignment
Message-ID: <20200320203409.GC16145@xps15>
References: <20200313081718.30612-4-t-kristo@ti.com>
 <20200314004334.26509-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314004334.26509-1-s-anna@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 07:43:34PM -0500, Suman Anna wrote:
> The DSP remote processors on OMAP SoCs require a boot register to
> be programmed with a boot address, and this boot address needs to
> be on a 1KB boundary. The current code is simply masking the boot
> address appropriately without performing any sanity checks before
> releasing the resets. An unaligned boot address results in an
> undefined execution behavior and can result in various bus errors
> like MMU Faults or L3 NoC errors. Such errors are hard to debug and
> can be easily avoided by adding a sanity check for the alignment
> before booting a DSP remote processor.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Andrew F. Davis <afd@ti.com>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
> v8-Resend: Updated to fix compilation issues against rproc-next
> 
>  drivers/remoteproc/omap_remoteproc.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> index d47d5ded651a..fe11cb709770 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -121,14 +121,23 @@ static void omap_rproc_kick(struct rproc *rproc, int vqid)
>   * @rproc: handle of a remote processor
>   *
>   * Set boot address for a supported DSP remote processor.
> + *
> + * Return: 0 on success, or -EINVAL if boot address is not aligned properly
>   */
> -static void omap_rproc_write_dsp_boot_addr(struct rproc *rproc)
> +static int omap_rproc_write_dsp_boot_addr(struct rproc *rproc)
>  {
> +	struct device *dev = rproc->dev.parent;
>  	struct omap_rproc *oproc = rproc->priv;
>  	struct omap_rproc_boot_data *bdata = oproc->boot_data;
>  	u32 offset = bdata->boot_reg;
>  
> -	regmap_write(bdata->syscon, offset, rproc->bootaddr);
> +	if (rproc->bootaddr & (SZ_1K - 1)) {
> +		dev_err(dev, "invalid boot address 0x%llx, must be aligned on a 1KB boundary\n",
> +			rproc->bootaddr);

Yes it does fix the compilation problem but after that patch 7 doesn't apply
anymore.

> +		return -EINVAL;
> +	}
> +
> +	return regmap_write(bdata->syscon, offset, rproc->bootaddr);
>  }
>  
>  /*
> @@ -145,8 +154,11 @@ static int omap_rproc_start(struct rproc *rproc)
>  	int ret;
>  	struct mbox_client *client = &oproc->client;
>  
> -	if (oproc->boot_data)
> -		omap_rproc_write_dsp_boot_addr(rproc);
> +	if (oproc->boot_data) {
> +		ret = omap_rproc_write_dsp_boot_addr(rproc);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	client->dev = dev;
>  	client->tx_done = NULL;
> -- 
> 2.23.0
> 
