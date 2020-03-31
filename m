Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2448C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4E0216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cLsERM1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgCaRgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:36:47 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52054 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCaRgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:36:47 -0400
Received: by mail-pj1-f65.google.com with SMTP id w9so1372192pjh.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 10:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=itnJI6TbXHN042Oa+aTTOeRNLontCXYyyXyRfk33Mmc=;
        b=cLsERM1XNUA8PFQaWGoAh/DqbQJ7NCrZjyEmqn9SOkOaGVCy64bv8UanQGECXkNtnt
         jwGbVsJz3cxnWTuybMxY68Sf7BFOHkXBjTgf9IgKG5Fp0keI2F1ZIo7IC2QPBPZXXp4R
         Pm8zX9Wt9jX3A37lcq0axmzKzV2qIkp9TIMcJqYjEdzoPlG8Kvk317eKWpFj7qMuWh36
         IvX0ZH8GEgA7nXw+h/9tKIpnzzeqWnFYdNce2Qft80ImIPeX4ArneoUkzgF96jRgmfO8
         7UHBafxADfewOCV2GZesnuIEEluB7c3wEcnrryihq/Z8N3huWaWi1RRIp/Rp7VdVRbJg
         nPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=itnJI6TbXHN042Oa+aTTOeRNLontCXYyyXyRfk33Mmc=;
        b=nIoVjkM7ocd5jrBoa6ehzYKpqlwwvHd81jCa/8GyWK3SBqduS6Ay3ZW/ycQ5H1T4lS
         8ahEfRDuwBpJj1L1jsvV8QbhGwU77g3UvSWjRieWFGzuArYLBEpsa2UkhtF/kTTTJ8jn
         jE1otqW34LgvM5drPbUJw34xDkP6pomdhLRsWgcAA92YfgxsNkMPJx1VILhWzQmAob8n
         iICeLy57vEDrneg6p4WS8p5HaPnvtmEoSHwjb3ZCpaamNZuADG8YFXIRbxl7T9U4mdTB
         uFN/zeoWhx5Qs+R8fjwhwiIzDYYrrPzmphaMeJfJoKoNluQAUXvMif9dMhFAL9qZXgQH
         YouA==
X-Gm-Message-State: ANhLgQ1XWFTKw3HcMcayVzIJ+krdGDiBaHOA4A2xWlUYB8XF6NfNDdaZ
        WcEpuQiPis9abMdmUoT1P6HLLg==
X-Google-Smtp-Source: ADFU+vuHAMUlcbxqb/N3HSGF+xsV+3DP9UUsTb+iyyE/sj6a8xzWdNLikk0xou/WLtqbZoILztVuiw==
X-Received: by 2002:a17:902:b497:: with SMTP id y23mr18708380plr.81.1585676203788;
        Tue, 31 Mar 2020 10:36:43 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w2sm6713384pff.195.2020.03.31.10.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:36:43 -0700 (PDT)
Date:   Tue, 31 Mar 2020 11:36:41 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        xiang xiao <xiaoxiang781216@gmail.com>
Subject: Re: [PATCH v7 1/2] rpmsg: core: add API to get MTU
Message-ID: <20200331173641.GA23918@xps15>
References: <20200324170407.16470-1-arnaud.pouliquen@st.com>
 <20200324170407.16470-2-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324170407.16470-2-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 06:04:06PM +0100, Arnaud Pouliquen wrote:
> Return the rpmsg buffer MTU for sending message, so rpmsg users
> can split a long message in several sub rpmsg buffers.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Acked-by: Suman Anna <s-anna@ti.com>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  drivers/rpmsg/rpmsg_core.c       | 21 +++++++++++++++++++++
>  drivers/rpmsg/rpmsg_internal.h   |  2 ++
>  drivers/rpmsg/virtio_rpmsg_bus.c | 10 ++++++++++
>  include/linux/rpmsg.h            | 10 ++++++++++
>  4 files changed, 43 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index e330ec4dfc33..a6ef54c4779a 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -283,6 +283,27 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>  }
>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>  
> +/**
> + * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
> + * @ept: the rpmsg endpoint
> + *
> + * This function returns maximum buffer size available for a single message.
> + *
> + * Return: the maximum transmission size on success and an appropriate error
> + * value on failure.
> + */
> +
> +ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
> +{
> +	if (WARN_ON(!ept))
> +		return -EINVAL;
> +	if (!ept->ops->get_mtu)
> +		return -ENOTSUPP;
> +
> +	return ept->ops->get_mtu(ept);
> +}
> +EXPORT_SYMBOL(rpmsg_get_mtu);
> +
>  /*
>   * match an rpmsg channel with a channel info struct.
>   * this is used to make sure we're not creating rpmsg devices for channels
> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> index 3fc83cd50e98..e6f88ee90ff6 100644
> --- a/drivers/rpmsg/rpmsg_internal.h
> +++ b/drivers/rpmsg/rpmsg_internal.h
> @@ -47,6 +47,7 @@ struct rpmsg_device_ops {
>   * @trysendto:		see @rpmsg_trysendto(), optional
>   * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
>   * @poll:		see @rpmsg_poll(), optional
> + * @get_mtu:		see @rpmsg_get_mtu(), optional
>   *
>   * Indirection table for the operations that a rpmsg backend should implement.
>   * In addition to @destroy_ept, the backend must at least implement @send and
> @@ -66,6 +67,7 @@ struct rpmsg_endpoint_ops {
>  			     void *data, int len);
>  	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
>  			     poll_table *wait);
> +	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
>  };
>  
>  int rpmsg_register_device(struct rpmsg_device *rpdev);
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 376ebbf880d6..6e48fdf24555 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -175,6 +175,7 @@ static int virtio_rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data,
>  				  int len, u32 dst);
>  static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
>  					   u32 dst, void *data, int len);
> +static ssize_t virtio_rpmsg_get_mtu(struct rpmsg_endpoint *ept);
>  
>  static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
>  	.destroy_ept = virtio_rpmsg_destroy_ept,
> @@ -184,6 +185,7 @@ static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
>  	.trysend = virtio_rpmsg_trysend,
>  	.trysendto = virtio_rpmsg_trysendto,
>  	.trysend_offchannel = virtio_rpmsg_trysend_offchannel,
> +	.get_mtu = virtio_rpmsg_get_mtu,
>  };
>  
>  /**
> @@ -699,6 +701,14 @@ static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
>  	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
>  }
>  
> +static ssize_t virtio_rpmsg_get_mtu(struct rpmsg_endpoint *ept)
> +{
> +	struct rpmsg_device *rpdev = ept->rpdev;
> +	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
> +
> +	return vch->vrp->buf_size - sizeof(struct rpmsg_hdr);
> +}
> +
>  static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
>  			     struct rpmsg_hdr *msg, unsigned int len)
>  {
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index 9fe156d1c018..88d7892ca93d 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -135,6 +135,8 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>  __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>  			poll_table *wait);
>  
> +ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
> +
>  #else
>  
>  static inline int register_rpmsg_device(struct rpmsg_device *dev)
> @@ -242,6 +244,14 @@ static inline __poll_t rpmsg_poll(struct rpmsg_endpoint *ept,
>  	return 0;
>  }
>  
> +static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
> +{
> +	/* This shouldn't be possible */
> +	WARN_ON(1);
> +
> +	return -ENXIO;
> +}
> +
>  #endif /* IS_ENABLED(CONFIG_RPMSG) */
>  
>  /* use a macro to avoid include chaining to get THIS_MODULE */
> -- 
> 2.17.1
> 
