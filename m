Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FDAC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D2F620706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIVHxlWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHXWs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHXWs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:48:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BEBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 15:48:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m71so5772374pfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 15:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XhjRGPeMtbD1pCGLmSutEOnQyRpFwGSHyJqKRaZdagY=;
        b=VIVHxlWPfOp94errB0KwNhRdHWzpuuZQFfcLgzitWQq0Ptjrg2dB3TjAqJmkbT188K
         Z97QKQpJuQ12ly+VPhA/3w/o5dBm5EL5acyMae7p7fH6dhSAIQNGXsG7Vc3LFu72ngpP
         fyP1U8yhQduTtVMBY5SHRJDAVUesxfWB4YK53XCTzkh6Hh+3TMM4MzzMOKOvhzM8bsu+
         oeioyQ/25aDME4Uyr9w5A4QzHLAgRBlec8I8At36OQ1EWtZWFn/49bEpKrXzObM26pw4
         G9aq56O0n6Bzp4BIhcyX2/lpT8fVIcfC7r7waKMSTLO/LB3GzhCOOQWlyvMLQbe1hJHQ
         YTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XhjRGPeMtbD1pCGLmSutEOnQyRpFwGSHyJqKRaZdagY=;
        b=j5ik41yd5qI2fDHS7FvmK7BeOjmWqvNRfoX71LhjKzu8E26CXzDiKRFJH0sGBVkrq9
         VGGF2Td5KRvjGJZHNaEAo0eN/nEARaBd0XeeZBcU50sO0Z41YKnc4TMfcZkoeqhRWWYZ
         MClLMqRNbTQKimPM1G9mabzjx5nIwidUWR02GIT6YAmgK2PAxjvj859vu96Ow+QQ8CKZ
         I73sGmaVDQQ04tCFs8I99v2U9B2CrmpkYSJT/kwxRieRyCGe8mg08nG1ZMt0xz+bJ9hr
         c8Mv3TxR8QYW1JD17PlcZ8Z2+3VH/MaZnzKFAJJbf/fb0YMQlXbozoUV+ISW2YKutm0g
         IkzQ==
X-Gm-Message-State: AOAM533uL1CoY1SvXJKfqhk1sYF5uYhcs7CdlS/kwW2AhqtBsW1pcT3b
        wTn8PS2HeYplvdhRg349WkiV4UjpoCm94A==
X-Google-Smtp-Source: ABdhPJzDNkRlRt0j0ucKBpCeHF9eStZLAcljLdy2sHPoxRGfnNKbzU3ylICFRZ8PjJ98HledN0PFvA==
X-Received: by 2002:a63:5c08:: with SMTP id q8mr4923296pgb.222.1598309336216;
        Mon, 24 Aug 2020 15:48:56 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m190sm7945267pfm.184.2020.08.24.15.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 15:48:55 -0700 (PDT)
Date:   Mon, 24 Aug 2020 16:48:53 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 6/9] rpmsg: virtio: use rpmsg ns device for the ns
 announcement
Message-ID: <20200824224853.GE3938186@xps15>
References: <20200731114732.12815-1-arnaud.pouliquen@st.com>
 <20200731114732.12815-7-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731114732.12815-7-arnaud.pouliquen@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 01:47:29PM +0200, Arnaud Pouliquen wrote:
> As generic NS driver is available, rely on it for NS management instead of
> managing it in RPMsg virtio bus.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  drivers/rpmsg/Kconfig            |  1 +
>  drivers/rpmsg/virtio_rpmsg_bus.c | 86 ++++++++------------------------
>  2 files changed, 21 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
> index 140faa975ea1..0143c9864c45 100644
> --- a/drivers/rpmsg/Kconfig
> +++ b/drivers/rpmsg/Kconfig
> @@ -71,5 +71,6 @@ config RPMSG_VIRTIO
>  	depends on HAS_DMA
>  	select RPMSG
>  	select VIRTIO
> +	select RPMSG_NS
>  
>  endmenu
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index b2927661868c..f771fdae150e 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -48,7 +48,6 @@
>   * @endpoints_lock: lock of the endpoints set
>   * @sendq:	wait queue of sending contexts waiting for a tx buffers
>   * @sleepers:	number of senders that are waiting for a tx buffer
> - * @ns_ept:	the bus's name service endpoint
>   *
>   * This structure stores the rpmsg state of a given virtio remote processor
>   * device (there might be several virtio proc devices for each physical
> @@ -67,7 +66,6 @@ struct virtproc_info {
>  	struct mutex endpoints_lock;
>  	wait_queue_head_t sendq;
>  	atomic_t sleepers;
> -	struct rpmsg_endpoint *ns_ept;
>  };
>  
>  /* The feature bitmap for virtio rpmsg */
> @@ -841,68 +839,14 @@ static void rpmsg_xmit_done(struct virtqueue *svq)
>  	wake_up_interruptible(&vrp->sendq);
>  }
>  
> -/* invoked when a name service announcement arrives */
> -static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
> -		       void *priv, u32 src)
> -{
> -	struct rpmsg_ns_msg *msg = data;
> -	struct rpmsg_device *newch;
> -	struct rpmsg_channel_info chinfo;
> -	struct virtproc_info *vrp = priv;
> -	struct device *dev = &vrp->vdev->dev;
> -	int ret;
> -
> -#if defined(CONFIG_DYNAMIC_DEBUG)
> -	dynamic_hex_dump("NS announcement: ", DUMP_PREFIX_NONE, 16, 1,
> -			 data, len, true);
> -#endif
> -
> -	if (len != sizeof(*msg)) {
> -		dev_err(dev, "malformed ns msg (%d)\n", len);
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * the name service ept does _not_ belong to a real rpmsg channel,
> -	 * and is handled by the rpmsg bus itself.
> -	 * for sanity reasons, make sure a valid rpdev has _not_ sneaked
> -	 * in somehow.
> -	 */
> -	if (rpdev) {
> -		dev_err(dev, "anomaly: ns ept has an rpdev handle\n");
> -		return -EINVAL;
> -	}
> -
> -	/* don't trust the remote processor for null terminating the name */
> -	msg->name[RPMSG_NAME_SIZE - 1] = '\0';
> -
> -	strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
> -	chinfo.src = RPMSG_ADDR_ANY;
> -	chinfo.dst = virtio32_to_cpu(vrp->vdev, msg->addr);
> -
> -	dev_info(dev, "%sing channel %s addr 0x%x\n",
> -		 virtio32_to_cpu(vrp->vdev, msg->flags) & RPMSG_NS_DESTROY ?
> -		 "destroy" : "creat", msg->name, chinfo.dst);
> -
> -	if (virtio32_to_cpu(vrp->vdev, msg->flags) & RPMSG_NS_DESTROY) {
> -		ret = rpmsg_unregister_device(&vrp->vdev->dev, &chinfo);
> -		if (ret)
> -			dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
> -	} else {
> -		newch = __rpmsg_create_channel(vrp, &chinfo);
> -		if (!newch)
> -			dev_err(dev, "rpmsg_create_channel failed\n");
> -	}
> -
> -	return 0;
> -}
> -
>  static int rpmsg_probe(struct virtio_device *vdev)
>  {
>  	vq_callback_t *vq_cbs[] = { rpmsg_recv_done, rpmsg_xmit_done };
>  	static const char * const names[] = { "input", "output" };
>  	struct virtqueue *vqs[2];
>  	struct virtproc_info *vrp;
> +	struct virtio_rpmsg_channel *vch;
> +	struct rpmsg_device *rpdev_ns;
>  	void *bufs_va;
>  	int err = 0, i;
>  	size_t total_buf_space;
> @@ -978,14 +922,27 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  
>  	/* if supported by the remote processor, enable the name service */
>  	if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_NS)) {
> -		/* a dedicated endpoint handles the name service msgs */
> -		vrp->ns_ept = __rpmsg_create_ept(vrp, NULL, rpmsg_ns_cb,
> -						vrp, RPMSG_NS_ADDR);
> -		if (!vrp->ns_ept) {
> -			dev_err(&vdev->dev, "failed to create the ns ept\n");
> +		vch = kzalloc(sizeof(*vch), GFP_KERNEL);
> +		if (!vch) {
>  			err = -ENOMEM;
>  			goto free_coherent;
>  		}
> +
> +		/* Link the channel to our vrp */
> +		vch->vrp = vrp;
> +
> +		/* Assign public information to the rpmsg_device */
> +		rpdev_ns = &vch->rpdev;
> +		rpdev_ns->ops = &virtio_rpmsg_ops;
> +
> +		rpdev_ns->dev.parent = &vrp->vdev->dev;
> +		rpdev_ns->dev.release = virtio_rpmsg_release_device;
> +
> +		err = rpmsg_ns_register_device(rpdev_ns);
> +		if (err) {
> +			kfree(vch);
> +			goto free_coherent;
> +		}

This patch doesn't apply to Bjorn's rproc-next anymore - would you mind
rebasing?

>  	}
>  
>  	/*
> @@ -1038,9 +995,6 @@ static void rpmsg_remove(struct virtio_device *vdev)
>  	if (ret)
>  		dev_warn(&vdev->dev, "can't remove rpmsg device: %d\n", ret);
>  
> -	if (vrp->ns_ept)
> -		__rpmsg_destroy_ept(vrp, vrp->ns_ept);
> -
>  	idr_destroy(&vrp->endpoints);
>  
>  	vdev->config->del_vqs(vrp->vdev);
> -- 
> 2.17.1
> 
