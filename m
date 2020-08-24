Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B094C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B7320656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8qrRiGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgHXWov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHXWou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:44:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B1CC061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 15:44:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n3so320584pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 15:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lvqRTw0O3/yHbkOlErkH4DxLVlE/caoRK9250pDnuAc=;
        b=c8qrRiGCb73Dq+2Ss/c+oYm87rB3yS5b69CdPfgdJvR9OkGboB8mQDsBffKqrmPV2Z
         7SP58uLu7Lq+cK09GbokMmYO0eyKBYizG1AIGGzXf04vQDwoutHJJ1HXHZWsJ4buBoP0
         okNbb5Fpk7pIHc7D1NOIZqHCo8v5CYKdgSFbptNMDwwMVfhYplZ8ejyXpJPchXscoxHo
         fYT3hC/28GRCdl2Icy8sMsKJ1zmV0EThW8EXjLTjgzTcI7vNntWlrsv2uk7iKvNVKUCa
         /jYaKVeGMK3eypuuDuPr8+YmzRtExnXVaZsGq6FI2sdF4cDeI93utfdqtXmWkuuNIcTl
         guiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lvqRTw0O3/yHbkOlErkH4DxLVlE/caoRK9250pDnuAc=;
        b=OMtaY9Pdf6CQIO5bEFy6ZSM8gtenrX5hoyTUUayPWLirzT+npDcm6Cnl2pKkt/vkVK
         Ly+mbfrKO3FXbkJNBlIECZbjHLyqQn1HbLO1ioEPcH/iie7vBqTewS1E2UzRM5h8SJmS
         geICsVXW3AqeUrz0lnDEsRs7hKANMH8wNeJuAoJAxXIugYpTRvUof8pPS3xnSn1VshDK
         IGKgPE8/bMqQPjo/ynAiYsVCAkgAgdaWD5XNfQBgji5I18Wy1PPBXRbDzX+cCfsd0TIK
         r91jNAiEsKvhK4UYywL8/6pwhBWntET7azsPA6QOeVmf0S5nkOy4Z9nwxVlUIKZx46Cj
         1LQg==
X-Gm-Message-State: AOAM531CBoMcOsZJXJ85sefQwHffPI+ZMLDTgXCTVe4vjFOnhtO/5VQN
        PdVcf6s8dVPMgHQeIf6kcWnEFQ==
X-Google-Smtp-Source: ABdhPJziXw/OMxO7aabSOn/p/vOo1+0RBR9sraOf+s0c/lIGdujYnIuv4mKjS3v5VqZkJ6K6Gni+WA==
X-Received: by 2002:a17:90a:d24c:: with SMTP id o12mr1200035pjw.60.1598309089056;
        Mon, 24 Aug 2020 15:44:49 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 144sm12465625pfu.114.2020.08.24.15.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 15:44:48 -0700 (PDT)
Date:   Mon, 24 Aug 2020 16:44:46 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/9] rpmsg: core: add channel creation internal API
Message-ID: <20200824224446.GC3938186@xps15>
References: <20200731114732.12815-1-arnaud.pouliquen@st.com>
 <20200731114732.12815-3-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731114732.12815-3-arnaud.pouliquen@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

On Fri, Jul 31, 2020 at 01:47:25PM +0200, Arnaud Pouliquen wrote:
> Add the channel creation API as a first step to be able to define the
> name service announcement as a rpmsg driver independent from the RPMsg
> virtio bus.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  drivers/rpmsg/rpmsg_core.c     | 37 ++++++++++++++++++++++++++++++++++
>  drivers/rpmsg/rpmsg_internal.h | 12 +++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index a6361cad608b..ae7da4a2e528 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -20,6 +20,43 @@
>  
>  #include "rpmsg_internal.h"
>  
> +/**
> + * rpmsg_create_channel() - create a new rpmsg channel
> + * using its name and address info.
> + * @rpdev: rpmsg driver
> + * @chinfo: channel_info to bind
> + *
> + * Returns a pointer to the new rpmsg device on success, or NULL on error.
> + */
> +struct rpmsg_device *
> +	rpmsg_create_channel(struct rpmsg_device *rpdev,
> +			     struct rpmsg_channel_info *chinfo)
> +{
> +	if (WARN_ON(!rpdev) || !rpdev->ops->create_channel)
> +		return NULL;

Ok for the WARN_ON().  In another if(), I would check for ops and
ops->create_channel().  Same for the release() operation.

> +
> +	return rpdev->ops->create_channel(rpdev, chinfo);
> +}
> +EXPORT_SYMBOL(rpmsg_create_channel);
> +
> +/**
> + * rpmsg_release_channel() - release a rpmsg channel
> + * using its name and address info.
> + * @rpdev: rpmsg driver
> + * @chinfo: channel_info to bind
> + *
> + * Returns a pointer to the new rpmsg device on success, or NULL on error.
> + */
> +int rpmsg_release_channel(struct rpmsg_device *rpdev,
> +			  struct rpmsg_channel_info *chinfo)
> +{
> +	if (WARN_ON(!rpdev) || !rpdev->ops->release_channel)
> +		return 0;
> +
> +	return rpdev->ops->release_channel(rpdev, chinfo);
> +}
> +EXPORT_SYMBOL(rpmsg_release_channel);
> +
>  /**
>   * rpmsg_create_ept() - create a new rpmsg_endpoint
>   * @rpdev: rpmsg channel device
> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> index 3fc83cd50e98..d5ab286d0e5e 100644
> --- a/drivers/rpmsg/rpmsg_internal.h
> +++ b/drivers/rpmsg/rpmsg_internal.h
> @@ -20,6 +20,8 @@
>  
>  /**
>   * struct rpmsg_device_ops - indirection table for the rpmsg_device operations
> + * @create_channel:	create backend-specific channel, optional
> + * @release_channel:	release backend-specific channel, optional
>   * @create_ept:		create backend-specific endpoint, required
>   * @announce_create:	announce presence of new channel, optional
>   * @announce_destroy:	announce destruction of channel, optional
> @@ -29,6 +31,11 @@
>   * advertise new channels implicitly by creating the endpoints.
>   */
>  struct rpmsg_device_ops {
> +	struct rpmsg_device *(*create_channel)(struct rpmsg_device *rpdev,
> +					     struct rpmsg_channel_info *chinfo);
> +	int (*release_channel)(struct rpmsg_device *rpdev,
> +			       struct rpmsg_channel_info *chinfo);
> +
>  	struct rpmsg_endpoint *(*create_ept)(struct rpmsg_device *rpdev,
>  					    rpmsg_rx_cb_t cb, void *priv,
>  					    struct rpmsg_channel_info chinfo);
> @@ -75,6 +82,11 @@ int rpmsg_unregister_device(struct device *parent,
>  struct device *rpmsg_find_device(struct device *parent,
>  				 struct rpmsg_channel_info *chinfo);
>  
> +struct rpmsg_device *
> +	rpmsg_create_channel(struct rpmsg_device *rpdev,
> +			     struct rpmsg_channel_info *chinfo);
> +int rpmsg_release_channel(struct rpmsg_device *rpdev,
> +			  struct rpmsg_channel_info *chinfo);
>  /**
>   * rpmsg_chrdev_register_device() - register chrdev device based on rpdev
>   * @rpdev:	prepared rpdev to be used for creating endpoints
> -- 
> 2.17.1
> 
