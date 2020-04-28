Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEEAC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F942137B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sT8+oE5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgD1T67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728559AbgD1T66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:58:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F48C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:58:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t9so43659pjw.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fEZQSwqgdVgK8Dc4Lm4abA9DcTezznGRFVnE2xG2IhU=;
        b=sT8+oE5b8EB90ljmegCi/3tIIqW0jgecb5RExDQPsz102kqx09Bs6j+ye6jzW66MGf
         ZrPnKe/P0Gnk3bK1WDlTx+WMEjbuRQiZt2IYr7zexD74xlMRzqiZKq7RsC0v7C4meSE8
         zX2eyGoWuSijH0XPRkT77jr3jXzE5LUi1SzaoeSkDgbwS3rHYjvUlhhP4HfFlKHJea3l
         F7stqe/gmTTYfZAoZ8gLWVy/bhNZM5/D6I8f7L7RQC5dwr3wBIiq4fCP3UtU5xcVVp1X
         SziCu1BuDc0YGieJcgzyzSlobUfVpyNB6e5hDh9tTnyMsHai3RSRFcU0Ns1FLMtqs+d/
         oeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fEZQSwqgdVgK8Dc4Lm4abA9DcTezznGRFVnE2xG2IhU=;
        b=tC4YdQCzsowWdom8wM3y+FP/wiNMiPSunwJUQIvyRTGDjlcxMmTOuMZ1yo81dcpdvX
         qvGa2wMZlY8gvVo9BhPXJfN/tQNmBxM7JXLz2NxAWv7FNCP1Dtbs5Sp1ugQ8YnkU5G6R
         7VRFva8QPdiq9eVbe0ZjbvckmKZDNQDZDInwBjyYIFs6pXx5PUv3m9XZBF3BpIhpuvV5
         S3Ff4wscM9AVEgM1AEz7PmFUsGwvNOx4BCZ3ehTxuOe7Dizv7Df2adj553l1YCHe9MBd
         gJHdP5v0DCUCEvQFkJYeum7H5nKflQ7JNjh6CWZmvyQ+T4yxLDHfXkWq8fRIrWoD4Pv+
         0e3A==
X-Gm-Message-State: AGi0PuawfjX67aDwh47Cgk+TssF75E6SlxpMcjR4OWiANIjAzNYz00bA
        GP77dBq+Xpttw+PmJ7M3MwzIug==
X-Google-Smtp-Source: APiQypIK57JLnFpeho7mksYIVHhBF3Gc0olKcF4/PHj0nDqZdhZ94PjsIr3TYZMoZ/Z4b3mdOz7plw==
X-Received: by 2002:a17:902:8ec1:: with SMTP id x1mr30230396plo.180.1588103937943;
        Tue, 28 Apr 2020 12:58:57 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t23sm2924285pji.32.2020.04.28.12.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 12:58:57 -0700 (PDT)
Date:   Tue, 28 Apr 2020 13:58:55 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] remoteproc/k3-dsp: Add support for L2RAM loading on
 C66x DSPs
Message-ID: <20200428195855.GC10552@xps15>
References: <20200325201839.15896-1-s-anna@ti.com>
 <20200325201839.15896-4-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325201839.15896-4-s-anna@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 03:18:39PM -0500, Suman Anna wrote:
> The resets for the DSP processors on K3 SoCs are managed through the
> Power and Sleep Controller (PSC) module. Each DSP typically has two
> resets - a global module reset for powering on the device, and a local
> reset that affects only the CPU while allowing access to the other
> sub-modules within the DSP processor sub-systems.
> 
> The C66x DSPs have two levels of internal RAMs that can be used to
> boot from, and the firmware loading into these RAMs require the
> local reset to be asserted with the device powered on/enabled using
> the module reset. Enhance the K3 DSP remoteproc driver to add support
> for loading into the internal RAMs. The local reset is deasserted on
> SoC power-on-reset, so logic has to be added in probe in remoteproc
> mode to balance the remoteproc state-machine.
> 
> Note that the local resets are a no-op on C71x cores, and the hardware
> does not supporting loading into its internal RAMs.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/remoteproc/ti_k3_dsp_remoteproc.c | 82 +++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> index fd0d84f46f90..7b712ef74611 100644
> --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> @@ -175,6 +175,9 @@ static int k3_dsp_rproc_reset(struct k3_dsp_rproc *kproc)
>  		return ret;
>  	}
>  
> +	if (kproc->data->uses_lreset)
> +		return ret;
> +
>  	ret = kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
>  						    kproc->ti_sci_id);
>  	if (ret) {
> @@ -192,6 +195,9 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
>  	struct device *dev = kproc->dev;
>  	int ret;
>  
> +	if (kproc->data->uses_lreset)
> +		goto lreset;
> +
>  	ret = kproc->ti_sci->ops.dev_ops.get_device(kproc->ti_sci,
>  						   kproc->ti_sci_id);
>  	if (ret) {
> @@ -199,6 +205,7 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
>  		return ret;
>  	}
>  
> +lreset:
>  	ret = reset_control_deassert(kproc->reset);
>  	if (ret) {
>  		dev_err(dev, "local-reset deassert failed, ret = %d\n", ret);
> @@ -210,6 +217,63 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
>  	return ret;
>  }
>  
> +/*
> + * The C66x DSP cores have a local reset that affects only the CPU, and a
> + * generic module reset that powers on the device and allows the DSP internal
> + * memories to be accessed while the local reset is asserted. This function is
> + * used to release the global reset on C66x DSPs to allow loading into the DSP
> + * internal RAMs. The .prepare() ops is invoked by remoteproc core before any
> + * firmware loading, and is followed by the .start() ops after loading to
> + * actually let the C66x DSP cores run. The local reset on C71x cores is a
> + * no-op and the global reset cannot be released on C71x cores until after
> + * the firmware images are loaded, so this function does nothing for C71x cores.
> + */
> +static int k3_dsp_rproc_prepare(struct rproc *rproc)
> +{
> +	struct k3_dsp_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +	int ret;
> +
> +	/* local reset is no-op on C71x processors */
> +	if (!kproc->data->uses_lreset)
> +		return 0;

In k3_dsp_rproc_release() the condition is "if (kproc->data->uses_lreset)" and
here it is the opposite, which did a good job at getting me confused.

Taking a step back, I assume c71 DSPs will have their own k3_dsp_dev_data where
the users_lreset flag will be false.  In that case I think it would make the
code easier to understand if the k3_dsp_rproc_ops was declared without the
.prepare and .unprepare.  In probe(), if data->uses_lreset is true then
k3_dsp_rproc_prepare() and k3_dsp_rproc_unprepare() are set.

I am done reviewing this set.

Thanks,
Mathieu

> +
> +	ret = kproc->ti_sci->ops.dev_ops.get_device(kproc->ti_sci,
> +						    kproc->ti_sci_id);
> +	if (ret)
> +		dev_err(dev, "module-reset deassert failed, cannot enable internal RAM loading, ret = %d\n",
> +			ret);
> +
> +	return ret;
> +}
> +
> +/*
> + * This function implements the .unprepare() ops and performs the complimentary
> + * operations to that of the .prepare() ops. The function is used to assert the
> + * global reset on applicable C66x cores. This completes the second portion of
> + * powering down the C66x DSP cores. The cores themselves are only halted in the
> + * .stop() callback through the local reset, and the .unprepare() ops is invoked
> + * by the remoteproc core after the remoteproc is stopped to balance the global
> + * reset.
> + */
> +static int k3_dsp_rproc_unprepare(struct rproc *rproc)
> +{
> +	struct k3_dsp_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +	int ret;
> +
> +	/* local reset is no-op on C71x processors */
> +	if (!kproc->data->uses_lreset)
> +		return 0;
> +
> +	ret = kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
> +						    kproc->ti_sci_id);
> +	if (ret)
> +		dev_err(dev, "module-reset assert failed, ret = %d\n", ret);
> +
> +	return ret;
> +}
> +
>  /*
>   * Power up the DSP remote processor.
>   *
> @@ -353,6 +417,8 @@ static void *k3_dsp_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
>  }
>  
>  static const struct rproc_ops k3_dsp_rproc_ops = {
> +	.prepare	= k3_dsp_rproc_prepare,
> +	.unprepare	= k3_dsp_rproc_unprepare,
>  	.start		= k3_dsp_rproc_start,
>  	.stop		= k3_dsp_rproc_stop,
>  	.kick		= k3_dsp_rproc_kick,
> @@ -644,6 +710,22 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
>  		goto disable_clk;
>  	}
>  
> +	/*
> +	 * ensure the DSP local reset is asserted to ensure the DSP doesn't
> +	 * execute bogus code in .prepare() when the module reset is released.
> +	 */
> +	if (data->uses_lreset) {
> +		ret = reset_control_status(kproc->reset);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to get reset status, status = %d\n",
> +				ret);
> +			goto release_mem;
> +		} else if (ret == 0) {
> +			dev_warn(dev, "local reset is deasserted for device\n");
> +			k3_dsp_rproc_reset(kproc);
> +		}
> +	}
> +
>  	ret = rproc_add(rproc);
>  	if (ret) {
>  		dev_err(dev, "failed to add register device with remoteproc core, status = %d\n",
> -- 
> 2.23.0
> 
