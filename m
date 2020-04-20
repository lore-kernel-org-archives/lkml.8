Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE07C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F94120679
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/HqtMo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDTFAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 01:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgDTFA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 01:00:29 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35954C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 22:00:29 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b12so1399823pff.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 22:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mpVmBINyItbN9tJRKVmVpOS+woKoJyrV26f3Xb0hHNE=;
        b=Q/HqtMo5vgugwYLK5vfGCzNzBpiu8J4Z1fxAN6yp15Ll8JotAF3X576PMh9RlvqITs
         OPgsqPX1s1WWPw+LkSAZkBBVzM/q3uexPnYWjCD6EM2U/UUJHknKJkMJ0nCQ/WB96HSz
         XuwPkdK7W4A2UXjWuOwgwW/ucKlWxU/inxmxWm5vDo3kdZ2yWgC8vOhfDHoAfIad+yS/
         lrZAmHtQKkqVLDgq/bnDeOqkaxOvrIaR+aLIluuYt7diBi+GHU5sx29dcf7xBZ4RHGSP
         xo/0W34i0C4hy5vcf9rMgaHvTSFzCfCbM6bs0rxBGGWNjrJme2NUzFT+wVNYVe7ZS8Ai
         P/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mpVmBINyItbN9tJRKVmVpOS+woKoJyrV26f3Xb0hHNE=;
        b=Ftk5vZXS9xB1QISEP+j+Rtw2c1obMJE0fhBXWMcihfAL0sK1gxRAT89A8uxQ0Nt+gN
         vXrAMFzIHfyKmBQ5g7v6p+dr6kUXiekUY59YqHpa57hJdhCEr0NUFbvIqroJ7Q1jR+JZ
         ISB+JCP8teELf4STOTFADSLu3gpgTkM7I9AkTfYd1dpcSQ0JQGeHdCmgrdvGul8S1Dot
         p5PaI34qrMv0bKyVazkGCob3iMNCtyiroBNg23a3lhQ4QJmwj3iF3Jg+08cfeMTL9CTw
         F3ohuHJKnpdw9l5j6SKc8MTZlg28IhKV5rG0UwzXHVS+pDWjqfcqtuacCwvdrnUaGHfI
         7LWQ==
X-Gm-Message-State: AGi0PuaIOFtiK0PJaQi3PYY6TmDLToyPLj9IO+NMWCPMrItq/dvpV4CP
        kyRe05cvYh+qYM7bkKW3XIBY5g==
X-Google-Smtp-Source: APiQypJxnzX7F+q4d+VoMv2cdy9NkKlZeFbo+lrQvAe+aYism0c9YRhFVztGdMBLIshqu+vARP19sw==
X-Received: by 2002:a63:2057:: with SMTP id r23mr15012894pgm.232.1587358828683;
        Sun, 19 Apr 2020 22:00:28 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v9sm3698518pju.3.2020.04.19.22.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 22:00:27 -0700 (PDT)
Date:   Sun, 19 Apr 2020 22:00:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, s-anna@ti.com, elder@linaro.org,
        Markus.Elfring@web.de, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] remoteproc: Fix IDR initialisation in
 rproc_alloc()
Message-ID: <20200420050051.GB1516868@builder.lan>
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
 <20200415204858.2448-2-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415204858.2448-2-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15 Apr 13:48 PDT 2020, Mathieu Poirier wrote:

> From: Alex Elder <elder@linaro.org>
> 
> If ida_simple_get() returns an error when called in rproc_alloc(),
> put_device() is called to clean things up.  By this time the rproc
> device type has been assigned, with rproc_type_release() as the
> release function.
> 
> The first thing rproc_type_release() does is call:
>     idr_destroy(&rproc->notifyids);
> 
> But at the time the ida_simple_get() call is made, the notifyids
> field in the remoteproc structure has not been initialized.
> 
> I'm not actually sure this case causes an observable problem, but
> it's incorrect.  Fix this by initializing the notifyids field before
> calling ida_simple_get() in rproc_alloc().
> 
> Fixes: b5ab5e24e960 ("remoteproc: maintain a generic child device for each rproc")
> Signed-off-by: Alex Elder <elder@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/remoteproc/remoteproc_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index e12a54e67588..80056513ae71 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2053,6 +2053,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	rproc->dev.type = &rproc_type;
>  	rproc->dev.class = &rproc_class;
>  	rproc->dev.driver_data = rproc;
> +	idr_init(&rproc->notifyids);
>  
>  	/* Assign a unique device index and name */
>  	rproc->index = ida_simple_get(&rproc_dev_index, 0, 0, GFP_KERNEL);
> @@ -2078,8 +2079,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  
>  	mutex_init(&rproc->lock);
>  
> -	idr_init(&rproc->notifyids);
> -
>  	INIT_LIST_HEAD(&rproc->carveouts);
>  	INIT_LIST_HEAD(&rproc->mappings);
>  	INIT_LIST_HEAD(&rproc->traces);
> -- 
> 2.20.1
> 
