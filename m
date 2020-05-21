Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE332C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92BCB20738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+AZJRu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgEUSpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgEUSpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:45:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B451C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:45:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so3610203pgn.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gU8sgFKhNViTucmSrL8PoKpJXA/y6HhdPP2rA9oeoRs=;
        b=r+AZJRu3w6JTsxL9KO6nU41GHlIcNCImEJya4BVj3jLk1yS6icM9SUIyDHKfgcai5Y
         /m2RAVPAZY6ES+8b+7Txyszh0a5kRmAFSFdKGdxndopgAYEcD4oRHsiSi+Y4A/pEiNmP
         2IQ37IjlC+vsSb21XAzgX+yhOfGJAdqIr8N8TYrTDNbat7nE02ikplbIYQnu/UcpsmxJ
         BGaIaXtYi3NU26GiUvFrTkHyUB9FArAxhYFKITKQjLeO9UheJwGcxnjK1i+oUNPDj2Ve
         1vg9w3AIfdncH6IlikagLtM+LH3gOHN5QPcjXemjceYNp6LK3TsREjcexk7UagXHd5oN
         ceCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gU8sgFKhNViTucmSrL8PoKpJXA/y6HhdPP2rA9oeoRs=;
        b=O8fU2rfRPfChhpwZ3yfiJozzoAbMS7renyu00IHDNKKJMKSJAyQg3hJOFge6881RoN
         EGQcr9AZAjngFgMYUVkVoAIAm+BmLTIz/U+kgKRHVbo64D73bXj7jI1MfFoCZxhKzzbM
         m5v02bkgf50DFaZ9EvOVmz7B1YokWALCroyK0kbQOm1Id7TLF3pZbGssVXuXMh5LRICo
         hwMEhbDW2PxrhmMCL4oX4mpKx7736rVd2Cr6SZQch4wfXLceclmTXrAl5RJAyIhKcgq0
         lBb9mfR1p0+Ur10ngXaJLnMqRrxnIMxZQBnYBgJkD5djnCxVxZxiWbQvKSzqE9JHU0t+
         Qdkw==
X-Gm-Message-State: AOAM532+BiCQyWz8QATdE453jqEdP1BhFP/2gWiq564IWBGBRbRb6PvW
        pkzfTrivayO34bEC4DGaqNtUjQ==
X-Google-Smtp-Source: ABdhPJzvAmH8U4KBIxMOLHqgBdJx23hqsA0xjqegq5rGHfJS7mrUJhHAnx3Fwau8/vsc2QlNDUyUqA==
X-Received: by 2002:a62:e707:: with SMTP id s7mr111797pfh.208.1590086745675;
        Thu, 21 May 2020 11:45:45 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m43sm5106636pje.16.2020.05.21.11.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:45:45 -0700 (PDT)
Date:   Thu, 21 May 2020 11:44:27 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] remoteproc: Introduce rproc_of_parse_firmware()
 helper
Message-ID: <20200521184427.GL408178@builder.lan>
References: <20200521001006.2725-1-s-anna@ti.com>
 <20200521001006.2725-2-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521001006.2725-2-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 May 17:10 PDT 2020, Suman Anna wrote:

> Add a new helper function rproc_of_parse_firmware() to the remoteproc
> core that can be used by various remoteproc drivers to look up the
> the "firmware-name" property from a rproc device node. This property
> is already being used by multiple drivers, so this helper can avoid
> repeating equivalent code in remoteproc drivers.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> v2: New patch
> 
>  drivers/remoteproc/remoteproc_core.c     | 23 +++++++++++++++++++++++
>  drivers/remoteproc/remoteproc_internal.h |  2 ++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 9f04c30c4aaf..c458b218d524 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1034,6 +1034,29 @@ rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, size_t len,
>  }
>  EXPORT_SYMBOL(rproc_of_resm_mem_entry_init);
>  
> +/**
> + * rproc_of_parse_firmware() - parse and return the firmware-name
> + * @dev: pointer on device struct representing a rproc
> + * @index: index to use for the firmware-name retrieval
> + * @fw_name: pointer to a character string, in which the firmware
> + *           name is returned on success and unmodified otherwise.
> + *
> + * This is an OF helper function that parses a device's DT node for
> + * the "firmware-name" property and returns the firmware name pointer
> + * in @fw_name on success.
> + *
> + * Return: 0 on success, or an appropriate failure.
> + */
> +int rproc_of_parse_firmware(struct device *dev, int index, const char **fw_name)
> +{
> +	int ret;
> +
> +	ret = of_property_read_string_index(dev->of_node, "firmware-name",
> +					    index, fw_name);
> +	return ret ? ret : 0;
> +}
> +EXPORT_SYMBOL(rproc_of_parse_firmware);
> +
>  /*
>   * A lookup table for resource handlers. The indices are defined in
>   * enum fw_resource_type.
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 4ba7cb59d3e8..e5341e91d2fc 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -28,6 +28,8 @@ struct rproc_debug_trace {
>  void rproc_release(struct kref *kref);
>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
>  void rproc_vdev_release(struct kref *ref);
> +int rproc_of_parse_firmware(struct device *dev, int index,
> +			    const char **fw_name);
>  
>  /* from remoteproc_virtio.c */
>  int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id);
> -- 
> 2.26.0
> 
