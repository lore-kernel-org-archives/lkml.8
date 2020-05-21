Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B61C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66D62088E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Va/yGpiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgEUStY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbgEUStX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:49:23 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E301C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:49:23 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n15so3791129pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vKhdX7VroNvNGwmyw4pwCoJqbqonHHryY8fJ3jkzGJM=;
        b=Va/yGpiJd9MABqJyRSMy0YLsOCgMWuHuIvx4zDntC9TJCYU1Ub/nc73NUxB7u1g4iq
         Zzpfff+WCiGb2Ed4q6N8CqB+RlNx6RJ/Il/kT5V80XRXFfMNUUnElFXAzfW1IvU4pjcc
         8zYRc2WQPd1uVttH3TbA+O+x2z40w3xhGJOo9roFQ6cOCeRsXy7Z+jtqkZsESa9hs8LL
         fCxbZPduDWFDMdeG7mdgPItbe4I6XnLNLoWis6Dvvqp21EUstWw+3EKHI9OY6WUF37Mv
         zgTOSNRe/YjUzncPdVEG4z0Oxq55C2AYd2JGo6bC7x8AcOT1eDHkGpkV3mCxs8ly2K2A
         G8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vKhdX7VroNvNGwmyw4pwCoJqbqonHHryY8fJ3jkzGJM=;
        b=pmqkJhhvk2fRiIghfoe0ocFIcXoe1oMQUWcQieFgpT0VTANm2QWm0Z+REX6NvpFjK2
         UMpI4l8FKuyo4ni80enZxa96Gm1OV0I4AUwG0iuGGzPu2yFgqNdOFAYNQ2qGD8ctGSbg
         9R9XrTj0uIz4xZwOJ7n+1vbO0tQB8gV4qfF32aEyln5Amz8U4SfgRDAdKpRBgtpw6rKf
         362Hr6jwp2NO9idnMveD9zA/sn+10SwxvqOaA3c6E3qGXv8jmzvuzivgaNv6lhWnpW3U
         Jyli/peLHAyrSLAheEFCG+dm0wf4T4nBYbBFv5Msy/MidSYDN4IbQdFqZpS4DUC9bjsr
         AkAA==
X-Gm-Message-State: AOAM533RiSwAREa87k/mryraIoYPSa7t5WrB4hmpIvN/ZoR7y+E8MxdX
        1wzLsMPox+X6hc09eP0Vnyk1tw==
X-Google-Smtp-Source: ABdhPJyRa2D5PE+qUrTiBzlqBLvPjQtuo0C6gW/bqiU5zxyYikIfUjmXJIX2cRiI06/5aZQyPAa8qQ==
X-Received: by 2002:a65:4903:: with SMTP id p3mr9929512pgs.318.1590086962644;
        Thu, 21 May 2020 11:49:22 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id ep10sm3324168pjb.25.2020.05.21.11.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:49:22 -0700 (PDT)
Date:   Thu, 21 May 2020 11:48:04 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] remoteproc/k3-dsp: Add support for L2RAM loading
 on C66x DSPs
Message-ID: <20200521184804.GM408178@builder.lan>
References: <20200521001006.2725-1-s-anna@ti.com>
 <20200521001006.2725-5-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521001006.2725-5-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 May 17:10 PDT 2020, Suman Anna wrote:

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

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> v2:
>  - Dropped the local-reset no-op checks from k3_dsp_rproc_prepare/unprepare()
>    callbacks. The logic will be adjusted back in the C71 patch series.
>  - The C71 local reset references are also removed from the comments for the
>    k3_dsp_rproc_prepare() function.
> v1: https://patchwork.kernel.org/patch/11458579/
> 
>  drivers/remoteproc/ti_k3_dsp_remoteproc.c | 72 +++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> index e4036f5992fe..610fbbf85ee6 100644
> --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> @@ -174,6 +174,9 @@ static int k3_dsp_rproc_reset(struct k3_dsp_rproc *kproc)
>  		return ret;
>  	}
>  
> +	if (kproc->data->uses_lreset)
> +		return ret;
> +
>  	ret = kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
>  						    kproc->ti_sci_id);
>  	if (ret) {
> @@ -191,6 +194,9 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
>  	struct device *dev = kproc->dev;
>  	int ret;
>  
> +	if (kproc->data->uses_lreset)
> +		goto lreset;
> +
>  	ret = kproc->ti_sci->ops.dev_ops.get_device(kproc->ti_sci,
>  						    kproc->ti_sci_id);
>  	if (ret) {
> @@ -198,6 +204,7 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
>  		return ret;
>  	}
>  
> +lreset:
>  	ret = reset_control_deassert(kproc->reset);
>  	if (ret) {
>  		dev_err(dev, "local-reset deassert failed, ret = %d\n", ret);
> @@ -209,6 +216,53 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
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
> + * actually let the C66x DSP cores run.
> + */
> +static int k3_dsp_rproc_prepare(struct rproc *rproc)
> +{
> +	struct k3_dsp_rproc *kproc = rproc->priv;
> +	struct device *dev = kproc->dev;
> +	int ret;
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
> @@ -352,6 +406,8 @@ static void *k3_dsp_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
>  }
>  
>  static const struct rproc_ops k3_dsp_rproc_ops = {
> +	.prepare	= k3_dsp_rproc_prepare,
> +	.unprepare	= k3_dsp_rproc_unprepare,
>  	.start		= k3_dsp_rproc_start,
>  	.stop		= k3_dsp_rproc_stop,
>  	.kick		= k3_dsp_rproc_kick,
> @@ -614,6 +670,22 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
>  		goto release_tsp;
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
> 2.26.0
> 
