Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDF2C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CC02080C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUiMvZ9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDTGt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 02:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTGt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 02:49:28 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BCCC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 23:49:28 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 145so2224597pfw.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 23:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WqzonlfyvwL3GiTnet9R+LA4ymwNNLykP6f8pKxh1d8=;
        b=WUiMvZ9dgOyXwv7yKqLM8tH4tCbXkdcAxhJZM+P6e0PfaLVANEhtMjo3834qVFIUwt
         yDu8fT49146q1shwriBVKXa34WYhkJhpCIrWZsWWNqd7VKBNWkR+Fp1ARLcxHnJ936wy
         z1pVtFhhe4N3N6t5I595kryBy1QgpwOhi073aZ0dd7S5vGZKrpFYJkp6RJogLVp1mvSB
         oz8pvwM6wdFkoqp5TqgBlOC4eOx5LRwZtJ3lPZcFkqnk8arjZXjdttQQucKwQOUzRgPh
         joqDlBuQX5FWZbBWvF++vuTngk8yw7ygzIvGgvfwZasBb2XxB2/8nEIDcQK4umw+4HcS
         SLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WqzonlfyvwL3GiTnet9R+LA4ymwNNLykP6f8pKxh1d8=;
        b=fodNvefLDkQAlwT9GpRlf9jXge0HsjSVek99PDtSn/EsW1xEVyCxacs3IO6SeUQ41s
         8S/v1FgDiVoDXnwAeUfOZW25eT3/vFiwtoiXLSTXrkgFIyq4N2WH2o0cbF7jSDfwzvUG
         shZWaTJgoUmes3Txt+g8ARkzaYJ8+YAnqHZVXalFjoLIMArZb5v3pnaHM1o67qPl4WYW
         LDZOq8KTdWyNIUPvHLTmVs8zq8bCvvlsVTGVzdcLOo1sxziwoCu22hG4Qm5Yk7z651w0
         1Fnn+im2zur0I+8qhamXLj+Dvf2MuhgBTaZQS+PvpU8Art8xGdsWrX8QkUlnevYZQ7BN
         y6KQ==
X-Gm-Message-State: AGi0PubNprBcm4PI+2nDLLDcB71JjOa5OfqqPbkgvvdy8yGOop1mA0O0
        f1EsuE3TEW4kaQ8ht8DhvmYZgA==
X-Google-Smtp-Source: APiQypLMoYJXtPNOLATIch8erHrs+HZv8MVXnC8Q1YwevfvLvkIMBOTdJw+OLb6sgFIBJeYUhRc/BQ==
X-Received: by 2002:a62:fc02:: with SMTP id e2mr15362600pfh.195.1587365367935;
        Sun, 19 Apr 2020 23:49:27 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x12sm110012pfq.209.2020.04.19.23.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 23:49:27 -0700 (PDT)
Date:   Sun, 19 Apr 2020 23:49:50 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/5] remoteproc: Add support for runtime PM
Message-ID: <20200420064950.GC1868936@builder.lan>
References: <20200417170040.174319-1-paul@crapouillou.net>
 <20200417170040.174319-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417170040.174319-3-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17 Apr 10:00 PDT 2020, Paul Cercueil wrote:

> Call pm_runtime_get_sync() before the firmware is loaded, and
> pm_runtime_put() after the remote processor has been stopped.
> 
> Even though the remoteproc device has no PM callbacks, this allows the
> parent device's PM callbacks to be properly called.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> Notes:
>     v2-v4: No change
>     v5: Move calls to prepare/unprepare to rproc_fw_boot/rproc_shutdown
>     v6: Instead of prepare/unprepare callbacks, use PM runtime callbacks
> 
>  drivers/remoteproc/remoteproc_core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index a7f96bc98406..d391b054efd8 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -29,6 +29,7 @@
>  #include <linux/devcoredump.h>
>  #include <linux/rculist.h>
>  #include <linux/remoteproc.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/iommu.h>
>  #include <linux/idr.h>
>  #include <linux/elf.h>
> @@ -1384,6 +1385,8 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  
>  	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
>  
> +	pm_runtime_get_sync(dev);

This can return an error, should we ignore this?

Apart from that this looks good.

Regards,
Bjorn

> +
>  	/*
>  	 * if enabling an IOMMU isn't relevant for this rproc, this is
>  	 * just a nop
> @@ -1391,7 +1394,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  	ret = rproc_enable_iommu(rproc);
>  	if (ret) {
>  		dev_err(dev, "can't enable iommu: %d\n", ret);
> -		return ret;
> +		goto put_pm_runtime;
>  	}
>  
>  	rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
> @@ -1435,6 +1438,8 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  	rproc->table_ptr = NULL;
>  disable_iommu:
>  	rproc_disable_iommu(rproc);
> +put_pm_runtime:
> +	pm_runtime_put(dev);
>  	return ret;
>  }
>  
> @@ -1840,6 +1845,8 @@ void rproc_shutdown(struct rproc *rproc)
>  
>  	rproc_disable_iommu(rproc);
>  
> +	pm_runtime_put(dev);
> +
>  	/* Free the copy of the resource table */
>  	kfree(rproc->cached_table);
>  	rproc->cached_table = NULL;
> @@ -2118,6 +2125,9 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  
>  	rproc->state = RPROC_OFFLINE;
>  
> +	pm_runtime_no_callbacks(&rproc->dev);
> +	pm_runtime_enable(&rproc->dev);
> +
>  	return rproc;
>  }
>  EXPORT_SYMBOL(rproc_alloc);
> @@ -2133,6 +2143,7 @@ EXPORT_SYMBOL(rproc_alloc);
>   */
>  void rproc_free(struct rproc *rproc)
>  {
> +	pm_runtime_disable(&rproc->dev);
>  	put_device(&rproc->dev);
>  }
>  EXPORT_SYMBOL(rproc_free);
> -- 
> 2.25.1
> 
