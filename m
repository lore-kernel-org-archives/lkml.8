Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAE4C55185
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A52206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LoafRACq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDUWSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgDUWSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:18:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E571C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:18:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h69so50376pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OYoaW0F2MgVZYtoV+xSYkk8kCiRu4rOdk3RKyhr0ibY=;
        b=LoafRACqFidTUKhOp4vdGpTBN1kdLiKz4tmU/+jFulOGAAmJpA5bYp7sOAHeALpEWi
         3o5cHN72hTPL2feOL0+pfTuaueJr05khD4Np47C/yIr6SRBg983W0vgPcH2LeeVAwYZe
         OMHTMFIvev2ITCzU7FQxDnJPey6e9jyEE0m2aeHCowEhdBvTOyU9Bl7kBNHJwK5L0hmq
         pCx61AAkq1QgLi9W9fX/hX/T9C52eOoK+bRzk0vx5M3REsj8zY7CHFAuZMYe7/UEv+WH
         Ruvfeb/m0A1PCrI35ija5CFaF6Jr+gD9+vg7w3Ux8SSyNXOvHIyz7sVKPQstlhR+fKJQ
         p+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OYoaW0F2MgVZYtoV+xSYkk8kCiRu4rOdk3RKyhr0ibY=;
        b=taPj55D2uJ35aMnXbq+QJHSXwER5cj9O/M0RthRyYqWXDxZBVLWqiJhNH3rAhwJtdF
         2mu89G5Nz3VYASlzWHEtFKme6kykri1NPeY8B11RbXu5tCMuhTgcnYmQits+bV2iEi8q
         W9L3kJErE9d/Ko+1LEaWJQahiuaKIlEQDjENwxO/CfkIH+K6zBH3MmaV41S0S8Wr2zeo
         065VrYRvh6IjGSI/0BZHXtvLS9jXV+tKWiu6v+sLuT3RVhcXVWf/IWloi24djypAaWNN
         1uxOSingMM35Uql3eyNTRNjDJz9JWmaCKZWNx47gQCbtaFNPJ8DafsLEcuWEuFdbTKzj
         3ppg==
X-Gm-Message-State: AGi0Puab9TTFsakEN0T2rCXS6xB43sFcwHoVcjQY8ZcKpfyqSYGKbH5v
        7YRNmS0bfRY6SczNeGKz84U/Tw==
X-Google-Smtp-Source: APiQypK9aebk+hZ8mFUbDPt1J6YRIpgCXz4RHbURMpC7KWmFyuD10c89qsNVVsv5/18vJjzaVRGuyw==
X-Received: by 2002:a62:874e:: with SMTP id i75mr15722402pfe.248.1587507524449;
        Tue, 21 Apr 2020 15:18:44 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f3sm3349295pjo.24.2020.04.21.15.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 15:18:43 -0700 (PDT)
Date:   Tue, 21 Apr 2020 16:18:41 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [RFC 03/18] remoteproc: Move rvdev management in rproc_virtio
Message-ID: <20200421221841.GB17676@xps15>
References: <20200416161331.7606-1-arnaud.pouliquen@st.com>
 <20200416161331.7606-4-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416161331.7606-4-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 06:13:16PM +0200, Arnaud Pouliquen wrote:
> Migrate the management of the rvdev device and subdev from core
> to virtio, to prepare the rpmsg virtio platform device creation.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c     | 118 +-------------------
>  drivers/remoteproc/remoteproc_internal.h |   5 +-
>  drivers/remoteproc/remoteproc_virtio.c   | 136 +++++++++++++++++++++--
>  3 files changed, 131 insertions(+), 128 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 5c90d569c0f7..4fcd685cbfd8 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -371,8 +371,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
>  	return 0;
>  }
>  
> -static int
> -rproc_parse_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc, int i)
> +int rproc_parse_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc, int i)
>  {
>  	struct rproc *rproc = rvdev->rproc;
>  	struct device *dev = &rproc->dev;
> @@ -410,117 +409,6 @@ void rproc_free_vring(struct rproc_vring *rvring)
>  	rsc->vring[idx].notifyid = -1;
>  }
>  
> -static int rproc_vdev_do_start(struct rproc_subdev *subdev)
> -{
> -	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
> -
> -	return rproc_add_virtio_dev(rvdev, rvdev->id);
> -}
> -
> -static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
> -{
> -	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
> -	int ret;
> -
> -	ret = device_for_each_child(&rvdev->dev, NULL, rproc_remove_virtio_dev);
> -	if (ret)
> -		dev_warn(&rvdev->dev, "can't remove vdev child device: %d\n", ret);
> -}
> -
> -/**
> - * rproc_rvdev_release() - release the existence of a rvdev
> - *
> - * @dev: the subdevice's dev
> - */
> -static void rproc_rvdev_release(struct device *dev)
> -{
> -	struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev, dev);
> -
> -	of_reserved_mem_device_release(dev);
> -
> -	kfree(rvdev);
> -}
> -
> -static int rproc_rvdev_add_device(struct rproc_vdev *rvdev)
> -{
> -	struct rproc *rproc = rvdev->rproc;
> -	struct fw_rsc_vdev *rsc = rvdev->rsc;
> -	char name[16];
> -	int ret, i;
> -
> -	/* Initialise vdev subdevice */
> -	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
> -	rvdev->dev.parent = &rproc->dev;
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
> -		dev_warn(&rvdev->dev,
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
> -	/* allocate the vring resources */
> -	for (i = 0; i < rsc->num_of_vrings; i++) {
> -		ret = rproc_alloc_vring(rvdev, i);
> -		if (ret)
> -			goto free_vg;
> -	}
> -
> -	rvdev->subdev.start = rproc_vdev_do_start;
> -	rvdev->subdev.stop = rproc_vdev_do_stop;
> -
> -	rproc_add_subdev(rproc, &rvdev->subdev);
> -
> -	return 0;
> -
> -free_vg:
> -	for (i--; i >= 0; i--) {
> -		struct rproc_vring *rvring = &rvdev->vring[i];
> -
> -		rproc_free_vring(rvring);
> -	}
> -
> -free_rvdev:
> -	device_unregister(&rvdev->dev);
> -
> -	return ret;
> -}
> -
> -static void rproc_rvdev_remove_device(struct rproc_vdev *rvdev)
> -{
> -	struct rproc *rproc = rvdev->rproc;
> -	struct rproc_vring *rvring;
> -	int id;
> -
> -	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
> -		rvring = &rvdev->vring[id];
> -		rproc_free_vring(rvring);
> -	}
> -
> -	rproc_remove_subdev(rproc, &rvdev->subdev);
> -	device_unregister(&rvdev->dev);
> -}
> -
>  /**
>   * rproc_handle_vdev() - handle a vdev fw resource
>   * @rproc: the remote processor
> @@ -590,14 +478,14 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>  
>  	list_add_tail(&rvdev->node, &rproc->rvdevs);
>  
> -	return rproc_rvdev_add_device(rvdev);
> +	return rproc_virtio_device_add(rvdev);
>  }
>  
>  void rproc_vdev_release(struct kref *ref)
>  {
>  	struct rproc_vdev *rvdev = container_of(ref, struct rproc_vdev, refcount);
>  
> -	rproc_rvdev_remove_device(rvdev);
> +	rproc_virtio_device_remove(rvdev);
>  	list_del(&rvdev->node);
>  }
>  
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 493ef9262411..fad95f1a50c1 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -30,8 +30,8 @@ irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
>  void rproc_vdev_release(struct kref *ref);
>  
>  /* from remoteproc_virtio.c */
> -int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id);
> -int rproc_remove_virtio_dev(struct device *dev, void *data);
> +int rproc_virtio_device_add(struct rproc_vdev *rvdev);
> +void rproc_virtio_device_remove(struct rproc_vdev *rvdev);
>  
>  /* from remoteproc_debugfs.c */
>  void rproc_remove_trace_file(struct dentry *tfile);
> @@ -47,6 +47,7 @@ extern struct class rproc_class;
>  int rproc_init_sysfs(void);
>  void rproc_exit_sysfs(void);
>  
> +int rproc_parse_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc, int i);
>  void rproc_free_vring(struct rproc_vring *rvring);
>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
>  
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 8c07cb2ca8ba..0f7efac7d4f3 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -296,6 +296,20 @@ static const struct virtio_config_ops rproc_virtio_config_ops = {
>  	.set		= rproc_virtio_set,
>  };
>  
> +/**
> + * rproc_rvdev_release() - release the existence of a rvdev
> + *
> + * @dev: the subdevice's dev
> + */
> +static void rproc_virtio_rvdev_release(struct device *dev)
> +{
> +	struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev, dev);
> +
> +	of_reserved_mem_device_release(dev);
> +
> +	kfree(rvdev);
> +}
> +
>  /*
>   * This function is called whenever vdev is released, and is responsible
>   * to decrement the remote processor's refcount which was taken when vdev was
> @@ -318,16 +332,18 @@ static void rproc_virtio_dev_release(struct device *dev)
>  }
>  
>  /**
> - * rproc_add_virtio_dev() - register an rproc-induced virtio device
> - * @rvdev: the remote vdev
> + * rproc_vdev_start() - register an rproc-induced virtio device

s/rproc_vdev_start/rproc_virtio_start

> + * @subdev: the rproc virtio subdevice
>   *
>   * This function registers a virtio device. This vdev's partent is
>   * the rproc device.
>   *
>   * Returns 0 on success or an appropriate error value otherwise.
>   */
> -int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
> +static int rproc_vitio_start(struct rproc_subdev *subdev)

s/rproc_vitio_start/rproc_virtio_start

>  {
> +	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev,
> +						subdev);
>  	struct rproc *rproc = rvdev->rproc;
>  	struct device *dev = &rvdev->dev;
>  	struct virtio_device *vdev;
> @@ -376,7 +392,7 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> -	vdev->id.device	= id,
> +	vdev->id.device	= rvdev->id,
>  	vdev->config = &rproc_virtio_config_ops,
>  	vdev->dev.parent = dev;
>  	vdev->dev.release = rproc_virtio_dev_release;
> @@ -401,23 +417,121 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>  		goto out;
>  	}
>  
> -	dev_info(dev, "registered %s (type %d)\n", dev_name(&vdev->dev), id);
> +	dev_info(dev, "registered %s (type %d)\n", dev_name(&vdev->dev),
> +		 rvdev->id);
>  
>  out:
>  	return ret;
>  }
>  
> +static int rproc_remove_virtio_dev(struct device *dev, void *data)
> +{
> +	struct virtio_device *vdev = dev_to_virtio(dev);
> +	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
> +	struct rproc_vring *rvring;
> +	int id;
> +
> +	unregister_virtio_device(vdev);
> +
> +	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
> +		rvring = &rvdev->vring[id];
> +		rproc_free_vring(rvring);
> +	}

Why freeing the rings here and not in rproc_virtio_device_remove() as it was
done in rproc_rvdev_remove_device()?  Renaming function and splitting them in
the same patch is extremely difficult to follow.

> +
> +	return 0;
> +}
>  /**
>   * rproc_remove_virtio_dev() - remove an rproc-induced virtio device
> - * @dev: the virtio device
> - * @data: must be null
> + * @subdev: the rproc virtio subdevice
> + * @crashed: indicate if the stop is the result of a crash
>   *
> - * This function unregisters an existing virtio device.
> + * This function unregisters existing virtio devices.
>   */
> -int rproc_remove_virtio_dev(struct device *dev, void *data)
> +static void rproc_vitio_stop(struct rproc_subdev *subdev, bool crashed)

Same as above

>  {
> -	struct virtio_device *vdev = dev_to_virtio(dev);
> +	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev,
> +						subdev);
> +	int ret;
> +
> +	ret = device_for_each_child(&rvdev->dev, NULL, rproc_remove_virtio_dev);
> +	if (ret)
> +		dev_warn(&rvdev->dev, "can't remove vdev child device: %d\n",
> +			 ret);
> +}
> +
> +static const struct rproc_subdev rproc_virtio_subdev = {
> +	.start		= rproc_vitio_start,
> +	.stop		= rproc_vitio_stop
> +};
> +
> +int rproc_virtio_device_add(struct rproc_vdev *rvdev)
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
> +	rvdev->dev.release = rproc_virtio_rvdev_release;
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
> +	rvdev->subdev = rproc_virtio_subdev;
> +
> +	rproc_add_subdev(rproc, &rvdev->subdev);
>  
> -	unregister_virtio_device(vdev);
>  	return 0;
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
> +void rproc_virtio_device_remove(struct rproc_vdev *rvdev)
> +{
> +	struct rproc *rproc = rvdev->rproc;
> +
> +	rproc_remove_subdev(rproc, &rvdev->subdev);
> +	device_unregister(&rvdev->dev);
>  }
> -- 
> 2.17.1
> 
