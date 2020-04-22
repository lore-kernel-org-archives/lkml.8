Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1CCC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0429420774
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="StViLItM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgDVQ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDVQ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:57:26 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A7CC03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:57:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h11so1160535plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LA63jnfhhhDCyX7Fu0cdpcXti3GWsmdF3pn/l4YJ88c=;
        b=StViLItM3IVtkPnVbWVLQjAKCHxIZQegI1rtlUPycFWJL89AP8nxjL6hirDcS+pXRz
         rW0LQla7jZvBhEaQEouwe6lHacxYUA4kkYLrUWEYKm7lPruPLWIEP2DEbzCA6h+XS39Q
         47VfIhdoYLPL/RXx7PbBoWqx48FGT0SudNTcIjAiplCTTINuJFXAFbg+cC2l3VSK15Dq
         vv4250KTXIwHKtVEO0uqE3LNXkhfW7lcjPs4kwfxBAox9WzlZTT3Y80hnmuZ9GNPPJAe
         1D/wtSmiKwZahqacvNfmYRSvWS7diZm+4NGGX1bgP/CYP93G+VG7rl4B5PuYhRN5IFp3
         ZqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LA63jnfhhhDCyX7Fu0cdpcXti3GWsmdF3pn/l4YJ88c=;
        b=BGPlu62vxXz6RPY1LJtGF6fFSBEtEHyyd71mIh3FdkbIZPjFCnnpntQREhyDtbADjr
         iQmjzCFZqYEEVXclnrzi1WYTnpOdsd95LsVaxkGgsskW322Ed8H4fgvH8gv6poW1BGZv
         S5L6R6lbINFu2Qv+KrSVNOaSXzaC6R1ZvbGvn4KzR1IjnAUfBxcqulSrQEBtR+ydu/vB
         UmhrF25S3mxBAEfhmRcC0epFoCKGsXmEIOseSrXbI06QXCEKXaBI4a1Gt6zT8Po22cZ7
         9yq0AIqDEuzt6G1o8AHihWQZ+Tpb0rCA8Xzphwgmc4478ZTGQkVtWumXBrB7Gt4IjsNF
         Q5qw==
X-Gm-Message-State: AGi0PuYPf/AS9hPjAGsv680NSRMdolfFfXt9dsZW4+pyEdQEvthbmO2B
        G+asgfuQbrcHQPZA0rs7Wx8ZRQ==
X-Google-Smtp-Source: APiQypJrAPHYm3pFKDOryB0qSlR2qS4ej4IFKk7cli/N7z1Gq6cJ+cvck8r8p0iidKtU2dULeEJx/A==
X-Received: by 2002:a17:902:76c1:: with SMTP id j1mr4790699plt.79.1587574645684;
        Wed, 22 Apr 2020 09:57:25 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s22sm3938pfd.51.2020.04.22.09.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 09:57:25 -0700 (PDT)
Date:   Wed, 22 Apr 2020 10:57:23 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [RFC 02/18] remoteproc: Introduce virtio device add/remove
 functions in core.
Message-ID: <20200422165723.GA9283@xps15>
References: <20200416161331.7606-1-arnaud.pouliquen@st.com>
 <20200416161331.7606-3-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416161331.7606-3-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This morning I'm attempting to take a fresh look at this set...

On Thu, Apr 16, 2020 at 06:13:15PM +0200, Arnaud Pouliquen wrote:
> In preparation of the migration of the management of rvdev in
> rproc_virtio, this patch spins off new functions to manage the
> virtio device.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 149 +++++++++++++++------------
>  1 file changed, 83 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 2a0425ab82a7..5c90d569c0f7 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -441,6 +441,86 @@ static void rproc_rvdev_release(struct device *dev)
>  	kfree(rvdev);
>  }
>  
> +static int rproc_rvdev_add_device(struct rproc_vdev *rvdev)
> +{
> +	struct rproc *rproc = rvdev->rproc;
> +	struct fw_rsc_vdev *rsc = rvdev->rsc;
> +	char name[16];
> +	int ret, i;
> +
> +	/* Initialise vdev subdevice */
> +	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> +	rvdev->dev.parent = &rproc->dev;
> +	rvdev->dev.dma_pfn_offset = rproc->dev.parent->dma_pfn_offset;
> +	rvdev->dev.release = rproc_rvdev_release;
> +	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
> +	dev_set_drvdata(&rvdev->dev, rvdev);
> +
> +	ret = device_register(&rvdev->dev);
> +	if (ret) {
> +		put_device(&rvdev->dev);
> +		return ret;
> +	}
> +	/* Make device dma capable by inheriting from parent's capabilities */
> +	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
> +
> +	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
> +					   dma_get_mask(rproc->dev.parent));
> +	if (ret) {
> +		dev_warn(&rvdev->dev,
> +			 "Failed to set DMA mask %llx. Trying to continue... %x\n",
> +			 dma_get_mask(rproc->dev.parent), ret);
> +	}
> +
> +	/* parse the vrings */
> +	for (i = 0; i < rsc->num_of_vrings; i++) {
> +		ret = rproc_parse_vring(rvdev, rsc, i);
> +		if (ret)
> +			goto free_rvdev;
> +	}
> +
> +	/* allocate the vring resources */
> +	for (i = 0; i < rsc->num_of_vrings; i++) {
> +		ret = rproc_alloc_vring(rvdev, i);
> +		if (ret)
> +			goto free_vg;
> +	}
> +
> +	rvdev->subdev.start = rproc_vdev_do_start;
> +	rvdev->subdev.stop = rproc_vdev_do_stop;
> +
> +	rproc_add_subdev(rproc, &rvdev->subdev);
> +
> +	return 0;
> +
> +free_vg:
> +	for (i--; i >= 0; i--) {
> +		struct rproc_vring *rvring = &rvdev->vring[i];
> +
> +		rproc_free_vring(rvring);
> +	}
> +
> +free_rvdev:
> +	device_unregister(&rvdev->dev);
> +
> +	return ret;
> +}
> +
> +static void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
> +{
> +	struct rproc *rproc = rvdev->rproc;
> +	struct rproc_vring *rvring;
> +	int id;
> +
> +	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
> +		rvring = &rvdev->vring[id];
> +		rproc_free_vring(rvring);
> +	}
> +
> +	rproc_remove_subdev(rproc, &rvdev->subdev);
> +	device_unregister(&rvdev->dev);
> +}
> +
>  /**
>   * rproc_handle_vdev() - handle a vdev fw resource
>   * @rproc: the remote processor
> @@ -473,8 +553,6 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>  {
>  	struct device *dev = &rproc->dev;
>  	struct rproc_vdev *rvdev;
> -	int i, ret;
> -	char name[16];
>  
>  	/* make sure resource isn't truncated */
>  	if (struct_size(rsc, vring, rsc->num_of_vrings) + rsc->config_len >
> @@ -505,83 +583,22 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>  	kref_init(&rvdev->refcount);
>  
>  	rvdev->rsc = rsc;
> +	rvdev->rsc_offset = offset;
>  	rvdev->id = rsc->id;
>  	rvdev->rproc = rproc;
>  	rvdev->index = rproc->nb_vdev++;
>  
> -	/* Initialise vdev subdevice */
> -	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> -	rvdev->dev.parent = rproc->dev.parent;
> -	rvdev->dev.dma_pfn_offset = rproc->dev.parent->dma_pfn_offset;
> -	rvdev->dev.release = rproc_rvdev_release;
> -	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
> -	dev_set_drvdata(&rvdev->dev, rvdev);
> -
> -	ret = device_register(&rvdev->dev);
> -	if (ret) {
> -		put_device(&rvdev->dev);
> -		return ret;
> -	}
> -	/* Make device dma capable by inheriting from parent's capabilities */
> -	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
> -
> -	ret = dma_coerce_mask_and_coherent(&rvdev->dev,
> -					   dma_get_mask(rproc->dev.parent));
> -	if (ret) {
> -		dev_warn(dev,
> -			 "Failed to set DMA mask %llx. Trying to continue... %x\n",
> -			 dma_get_mask(rproc->dev.parent), ret);
> -	}
> -
> -	/* parse the vrings */
> -	for (i = 0; i < rsc->num_of_vrings; i++) {
> -		ret = rproc_parse_vring(rvdev, rsc, i);
> -		if (ret)
> -			goto free_rvdev;
> -	}
> -
> -	/* remember the resource offset*/
> -	rvdev->rsc_offset = offset;
> -
> -	/* allocate the vring resources */
> -	for (i = 0; i < rsc->num_of_vrings; i++) {
> -		ret = rproc_alloc_vring(rvdev, i);
> -		if (ret)
> -			goto unwind_vring_allocations;
> -	}
> -
>  	list_add_tail(&rvdev->node, &rproc->rvdevs);

This should go in rproc_rvdev_add_device()

>  
> -	rvdev->subdev.start = rproc_vdev_do_start;
> -	rvdev->subdev.stop = rproc_vdev_do_stop;
> -
> -	rproc_add_subdev(rproc, &rvdev->subdev);
> -
> -	return 0;
> -
> -unwind_vring_allocations:
> -	for (i--; i >= 0; i--)
> -		rproc_free_vring(&rvdev->vring[i]);
> -free_rvdev:
> -	device_unregister(&rvdev->dev);
> -	return ret;
> +	return rproc_rvdev_add_device(rvdev);
>  }
>  
>  void rproc_vdev_release(struct kref *ref)
>  {
>  	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
> -	struct rproc_vring *rvring;
> -	struct rproc *rproc = rvdev->rproc;
> -	int id;
> -
> -	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
> -		rvring = &rvdev->vring[id];
> -		rproc_free_vring(rvring);
> -	}
>  
> -	rproc_remove_subdev(rproc, &rvdev->subdev);
> +	rproc_rvdev_remove_device(rvdev);
>  	list_del(&rvdev->node);
> -	device_unregister(&rvdev->dev);

Keep this function intact, rename it rproc_rvdev_remove_device() to balance out
rproc_rvdev_add_device() and modify rproc_resource_cleanup() to reflect the
change.  I suppose we have nothing to loose since rproc_handle_vdev() and
rproc_vdev_release(), from a syntactic point of view, didn't balance each other
out.

>  }
>  
>  /**
> -- 
> 2.17.1
> 
