Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1229C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D57A20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLHgDfMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgFVRfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbgFVRfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:35:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450E0C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:35:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d8so7844050plo.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L1g5xES3CpMTfmaxXXd6gYSv9IzAcINcj2uv/tgbG9Y=;
        b=ZLHgDfMAYWXXWSfPXppNDYDfwV+JeYKEEMTRJtc0XT9yPcQHGZZ4zXHxbUW0x3qXFO
         aW2DKF+9eKkb0m7Ky0j3c0XN4XCKs5xLhFxhTy6/FiXeoRyZsf6SXmnCFHxlByNj6XGl
         3GVnnqf7wls7RVlESYlk040A83i1QGTUGHHF+2HK5/8ePZUR1SEv+lXB7xYd/rAUm2R9
         2DbjgGumYL4PhI9p0FbsLXtcSyu7eB4k4/9MGdM2p/ZPs2jAQUhq4xMz+L8E8PDD8IJ8
         5nu5vIhY4MwkyV/Myew4bZnsIPLRNj9Q10o4jycLaJY5awm1zUKy0xOlPTnQy8cVLDRy
         CMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L1g5xES3CpMTfmaxXXd6gYSv9IzAcINcj2uv/tgbG9Y=;
        b=UQXOV2PR6ep3rRRvtMI7Ql/BI3LlMmhXfuc8ZmWFuKvShaczauqob4RnigiRb58knm
         cdvM+0VxPg/X6TKa8tSyjEQIgpkKRKNh/G6imR3jmtU1g0DVsgOkC5hN/87CNak+D5yl
         xxJPaxsa2ojqRL80mKMUKiLzTygsumftQgtt5qeyMciR+wzNlImhY3pVfr56O8gSowq9
         Vz0Ih4V2gTHZN4Qbdv/O+qKPwARG9M71dbxW8CDI17CyxnsyjvuN/NpD4zb2+IcqYabG
         iLLKkxp7+na4VwkENHIw9SXhNQgxmAu/nKhutJQAD7/D7oUgti2T+CMt0vebRNBdYBQs
         aM1Q==
X-Gm-Message-State: AOAM532Wpn6umgfF1nZPRybmVRzsHVc8Ovnk5oP7+Rkl4cK9SebNWS5l
        D2i/w2uotUi+D4QgkPpy9VxrMA==
X-Google-Smtp-Source: ABdhPJwMVQv0naG5OOxhiKhTYMgSY9S0QaQjF3tJwVYat59w4ioGMRX8xTLHUto82LpsEk5KMDfYxQ==
X-Received: by 2002:a17:90a:c250:: with SMTP id d16mr19234190pjx.60.1592847342715;
        Mon, 22 Jun 2020 10:35:42 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n19sm10925109pgb.0.2020.06.22.10.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 10:35:42 -0700 (PDT)
Date:   Mon, 22 Jun 2020 11:35:40 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] remoteproc: k3: Add TI-SCI processor control
 helper functions
Message-ID: <20200622173540.GA1820962@xps15>
References: <20200612224914.7634-1-s-anna@ti.com>
 <20200612224914.7634-3-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612224914.7634-3-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

Apologies for the late reply, this one slipped through the cracks...


On Fri, Jun 12, 2020 at 05:49:10PM -0500, Suman Anna wrote:
> Texas Instruments' K3 generation SoCs have specific modules/register
> spaces used for configuring the various aspects of a remote processor.
> These include power, reset, boot vector and other configuration features
> specific to each compute processor present on the SoC. These registers
> are managed by the System Controller such as DMSC on K3 AM65x SoCs.
> 
> The Texas Instrument's System Control Interface (TI-SCI) Message Protocol
> is used to communicate to the System Controller from various compute
> processors to invoke specific services provided by the firmware running
> on the System Controller.
> 
> Add a common processor control interface header file that can be used by
> multiple remoteproc drivers. The helper functions within this header file
> abstract the various TI SCI protocol ops for the remoteproc drivers, and
> allow them to request the System Controller to be able to program and
> manage various remote processors on the SoC. The remoteproc drivers are
> expected to manage the life-cycle of their ti_sci_proc_dev local
> structures.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v3: New to this series, but the patch is identical to the one from the
>     K3 R5F series posted previously, with patch title adjusted
>     https://patchwork.kernel.org/patch/11456379/
> 
>  drivers/remoteproc/ti_sci_proc.h | 102 +++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 drivers/remoteproc/ti_sci_proc.h
> 
> diff --git a/drivers/remoteproc/ti_sci_proc.h b/drivers/remoteproc/ti_sci_proc.h
> new file mode 100644
> index 000000000000..e42d8015b8e7
> --- /dev/null
> +++ b/drivers/remoteproc/ti_sci_proc.h
> @@ -0,0 +1,102 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Texas Instruments TI-SCI Processor Controller Helper Functions
> + *
> + * Copyright (C) 2018-2020 Texas Instruments Incorporated - http://www.ti.com/
> + *	Suman Anna
> + */
> +
> +#ifndef REMOTEPROC_TI_SCI_PROC_H
> +#define REMOTEPROC_TI_SCI_PROC_H
> +
> +/**
> + * struct ti_sci_proc - structure representing a processor control client
> + * @sci: cached TI-SCI protocol handle
> + * @ops: cached TI-SCI proc ops
> + * @dev: cached client device pointer
> + * @proc_id: processor id for the consumer remoteproc device
> + * @host_id: host id to pass the control over for this consumer remoteproc
> + *	     device
> + */
> +struct ti_sci_proc {
> +	const struct ti_sci_handle *sci;
> +	const struct ti_sci_proc_ops *ops;
> +	struct device *dev;

Please include the proper header files for the above structures.  I would also
have expected the name of the structure to be ti_sci_rproc but that choice is
entirely your.

With the proper header files included:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> +	u8 proc_id;
> +	u8 host_id;
> +};
> +
> +static inline int ti_sci_proc_request(struct ti_sci_proc *tsp)
> +{
> +	int ret;
> +
> +	ret = tsp->ops->request(tsp->sci, tsp->proc_id);
> +	if (ret)
> +		dev_err(tsp->dev, "ti-sci processor request failed: %d\n",
> +			ret);
> +	return ret;
> +}
> +
> +static inline int ti_sci_proc_release(struct ti_sci_proc *tsp)
> +{
> +	int ret;
> +
> +	ret = tsp->ops->release(tsp->sci, tsp->proc_id);
> +	if (ret)
> +		dev_err(tsp->dev, "ti-sci processor release failed: %d\n",
> +			ret);
> +	return ret;
> +}
> +
> +static inline int ti_sci_proc_handover(struct ti_sci_proc *tsp)
> +{
> +	int ret;
> +
> +	ret = tsp->ops->handover(tsp->sci, tsp->proc_id, tsp->host_id);
> +	if (ret)
> +		dev_err(tsp->dev, "ti-sci processor handover of %d to %d failed: %d\n",
> +			tsp->proc_id, tsp->host_id, ret);
> +	return ret;
> +}
> +
> +static inline int ti_sci_proc_set_config(struct ti_sci_proc *tsp,
> +					 u64 boot_vector,
> +					 u32 cfg_set, u32 cfg_clr)
> +{
> +	int ret;
> +
> +	ret = tsp->ops->set_config(tsp->sci, tsp->proc_id, boot_vector,
> +				   cfg_set, cfg_clr);
> +	if (ret)
> +		dev_err(tsp->dev, "ti-sci processor set_config failed: %d\n",
> +			ret);
> +	return ret;
> +}
> +
> +static inline int ti_sci_proc_set_control(struct ti_sci_proc *tsp,
> +					  u32 ctrl_set, u32 ctrl_clr)
> +{
> +	int ret;
> +
> +	ret = tsp->ops->set_control(tsp->sci, tsp->proc_id, ctrl_set, ctrl_clr);
> +	if (ret)
> +		dev_err(tsp->dev, "ti-sci processor set_control failed: %d\n",
> +			ret);
> +	return ret;
> +}
> +
> +static inline int ti_sci_proc_get_status(struct ti_sci_proc *tsp,
> +					 u64 *boot_vector, u32 *cfg_flags,
> +					 u32 *ctrl_flags, u32 *status_flags)
> +{
> +	int ret;
> +
> +	ret = tsp->ops->get_status(tsp->sci, tsp->proc_id, boot_vector,
> +				   cfg_flags, ctrl_flags, status_flags);
> +	if (ret)
> +		dev_err(tsp->dev, "ti-sci processor get_status failed: %d\n",
> +			ret);
> +	return ret;
> +}
> +
> +#endif /* REMOTEPROC_TI_SCI_PROC_H */
> -- 
> 2.26.0
> 
