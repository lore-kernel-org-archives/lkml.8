Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54581C54FCB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C68E20782
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ho+pWboh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgDUCwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726325AbgDUCwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:52:32 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8809C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:52:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so740906pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eX6YUoAUyU+ald9w0j9y7218CuMrF9AfTefdb4alt7k=;
        b=Ho+pWbohjKTbqwiK7ylfi0+5ra50+e7O/4vhoi7sO6wSGyeQVWHW9pMw3K1ByITxeq
         z0VvDWGxnjNrIHd5LsVqLBwa+BcbghBVjOwGn+dONaY1qVIeFuWkO9US9xfPmPFawzgQ
         5heqivxlNf5V7lEkyxccC4wEAfuJ4O3QWWAnX3wN7o27anigl1fSE85ambi3Z1CAm4G4
         pBZvpf8kjuSRWxzoXqrLT/G6DxdUFxnztpSVJTkos2ocV7t2YT71m5OneanzpNN2r+Bo
         cFzpE+4/KfDlKV/cuYb/1FIKHJrqQebnIHs9DuaGlRiuDp8KeU3aJGSnpTtiSaiUYmy4
         wDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eX6YUoAUyU+ald9w0j9y7218CuMrF9AfTefdb4alt7k=;
        b=DUv4UOzNpMshrePGGCxPdHkfNpI+bT7k2qUKsWS1/X36JAX2EyCSsbiJ4fIwXYqvfO
         0HivO7mzWsT+L7BuqUk44CSXj/3bWi6s6cr7pflkqBbqgW66F4RVRmM5oaurFfru9aIS
         kegs3viScedpz4Y8I1nFM+fIWI+QTUpGlToK+/WiHkT8cbHxoCzviz8dhANmwMlVcgJk
         s8YmiOPQS4gCVrVFENh5MUXTrUDa0XyiMjruPitkIZEMs2JO4/eHwVKIC1sqgmh3JFCn
         RTcVfgETmffsxx67g/7ODW22iLQU9UYVdVDp1dGn4YLmYBW7LvDHtfMyhb8X2qzLaQ7Z
         4zcg==
X-Gm-Message-State: AGi0PubGPF84gq9bswGWwn4jXco4/sQRMAZM6s6i/Scta4NDR8g7OgHW
        HfSkNvBE2Tgi4HInsQtG1UIriw==
X-Google-Smtp-Source: APiQypL/E8X9y33COIhDNLXm7A3iI42f49fWAH3eN4CyoMfQlo9TcCfOvUS3Lv9YjydPpYGbOaTW3g==
X-Received: by 2002:a17:90a:8c93:: with SMTP id b19mr2947130pjo.141.1587437551079;
        Mon, 20 Apr 2020 19:52:31 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c201sm910602pfc.73.2020.04.20.19.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 19:52:30 -0700 (PDT)
Date:   Mon, 20 Apr 2020 19:52:54 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Loic Pallardy <loic.pallardy@st.com>
Subject: Re: [PATCH 1/2] remoteproc: Add prepare and unprepare ops
Message-ID: <20200421025254.GK1868936@builder.lan>
References: <20200417002036.24359-1-s-anna@ti.com>
 <20200417002036.24359-2-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417002036.24359-2-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Apr 17:20 PDT 2020, Suman Anna wrote:

> From: Loic Pallardy <loic.pallardy@st.com>
> 
> On some SoC architecture, it is needed to enable HW like
> clock, bus, regulator, memory region... before loading
> co-processor firmware.
> 
> This patch introduces prepare and unprepare ops to execute
> platform specific function before firmware loading and after
> stop execution.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Do we have an inbound user of these new oops?

Regards,
Bjorn

> ---
> v1:
>  - Make the direct ops into inline helper functions in line
>    with the comments on the MCU sync series (v1 comments).
>    No change in functionality.
>  - Picked up the Reviewed-by tags
> v0: https://patchwork.kernel.org/patch/11456383/
> 
>  drivers/remoteproc/remoteproc_core.c     | 15 ++++++++++++++-
>  drivers/remoteproc/remoteproc_internal.h | 16 ++++++++++++++++
>  include/linux/remoteproc.h               |  4 ++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index d681eeb962b6..e38f627059ac 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1394,12 +1394,19 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  		return ret;
>  	}
>  
> +	/* Prepare rproc for firmware loading if needed */
> +	ret = rproc_prepare_device(rproc);
> +	if (ret) {
> +		dev_err(dev, "can't prepare rproc %s: %d\n", rproc->name, ret);
> +		goto disable_iommu;
> +	}
> +
>  	rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
>  
>  	/* Load resource table, core dump segment list etc from the firmware */
>  	ret = rproc_parse_fw(rproc, fw);
>  	if (ret)
> -		goto disable_iommu;
> +		goto unprepare_rproc;
>  
>  	/* reset max_notifyid */
>  	rproc->max_notifyid = -1;
> @@ -1433,6 +1440,9 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  	kfree(rproc->cached_table);
>  	rproc->cached_table = NULL;
>  	rproc->table_ptr = NULL;
> +unprepare_rproc:
> +	/* release HW resources if needed */
> +	rproc_unprepare_device(rproc);
>  disable_iommu:
>  	rproc_disable_iommu(rproc);
>  	return ret;
> @@ -1838,6 +1848,9 @@ void rproc_shutdown(struct rproc *rproc)
>  	/* clean up all acquired resources */
>  	rproc_resource_cleanup(rproc);
>  
> +	/* release HW resources if needed */
> +	rproc_unprepare_device(rproc);
> +
>  	rproc_disable_iommu(rproc);
>  
>  	/* Free the copy of the resource table */
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index b389dc79da81..101e6be8d240 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -64,6 +64,22 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
>  struct rproc_mem_entry *
>  rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
>  
> +static inline int rproc_prepare_device(struct rproc *rproc)
> +{
> +	if (rproc->ops->prepare)
> +		return rproc->ops->prepare(rproc);
> +
> +	return 0;
> +}
> +
> +static inline int rproc_unprepare_device(struct rproc *rproc)
> +{
> +	if (rproc->ops->unprepare)
> +		return rproc->ops->unprepare(rproc);
> +
> +	return 0;
> +}
> +
>  static inline
>  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
>  {
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 38607107b7cb..b8481ac969f1 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -355,6 +355,8 @@ enum rsc_handling_status {
>  
>  /**
>   * struct rproc_ops - platform-specific device handlers
> + * @prepare:	prepare device for code loading
> + * @unprepare:	unprepare device after stop
>   * @start:	power on the device and boot it
>   * @stop:	power off the device
>   * @kick:	kick a virtqueue (virtqueue id given as a parameter)
> @@ -373,6 +375,8 @@ enum rsc_handling_status {
>   *		panic at least the returned number of milliseconds
>   */
>  struct rproc_ops {
> +	int (*prepare)(struct rproc *rproc);
> +	int (*unprepare)(struct rproc *rproc);
>  	int (*start)(struct rproc *rproc);
>  	int (*stop)(struct rproc *rproc);
>  	void (*kick)(struct rproc *rproc, int vqid);
> -- 
> 2.26.0
> 
