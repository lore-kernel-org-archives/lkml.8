Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0059C38A30
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 01:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A0EE2078C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 01:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RW1INQul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDUB5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 21:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725958AbgDUB5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 21:57:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C728C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 18:57:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ms17so701145pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 18:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jQ/Ly+wqz2XWXnpqb77hjmYSKdF9aJw60leWg2kb02E=;
        b=RW1INQulNwi0YSFUYKiIRsCpeHgYvd/bWAmviPE6juIvoqZkMuNL6/VnQOeszW1oM7
         nYNkZUUqVqP7/XIlB37k45PouF7Z2m7xBO1LyFFdNDkXZTif9AmfQO0wzdP8IXPfuIgr
         OO0GML6C/hnfSWfXAj53JxzQkftu+S5lYBp9OjKdTNomFJc4FHqXm6Oec5FwRNpN6XqU
         EdIXLtyOMLQYCt+9+erTZmFdHB0PKH5KNQ1UkduFSZ4GQrvYv7/trbG6U6ztDDpv5gRm
         icvqr/W8YOVDATqAlElSDdDAhOcmnb7N12fWFO0Rpb1jsh1rlqBWZqPIFIiUMd/xA/HP
         bW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jQ/Ly+wqz2XWXnpqb77hjmYSKdF9aJw60leWg2kb02E=;
        b=eENSQiF6kfNU9LiTGizE1jkWDTekrWYwsU33IJWjP57X1bB46ThYqMLR4QFn36MOZn
         xnwe+2TxuelaTROOfGiJAkKpYhHhWOkFDcVfbGE5Pv6mQlxxtTW7esHroDvCYsc7mRXL
         im7aKSEBYUfa2LrI4HyeU9h+h7ySrJKVms8Ad44/TdDGqTtSvW9D2tZeweveSOvMyupp
         bQxEfw2zU235L/Rbs0XxhI3ryPeeN0uZ0p8BnQ7Z/yMUBbWjdKkC31N8szvK54Hax5lB
         Ci96oQUp1XNwxBTxuCt6E+FjM/AsN3HKa7WU7WVA4Egqccu2iWc40OixLlZOE1GcGa38
         m34Q==
X-Gm-Message-State: AGi0PuZfpfrL4+SsBFhGBEPQ9PQ4ZsHXhHIDBP/kUDP2oCRT0AUV6EsG
        fpdj3CGbRnwVLCyKgch/rYSHng==
X-Google-Smtp-Source: APiQypL9IdMP4zHbcMG9i0xOHUfQ9w377ci8e7OqKpnXsxzlSwtWxNyaES4bUVwkzG35Xl9vXjeYoA==
X-Received: by 2002:a17:90a:2bc9:: with SMTP id n9mr2738894pje.131.1587434239831;
        Mon, 20 Apr 2020 18:57:19 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d8sm811533pfd.159.2020.04.20.18.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 18:57:19 -0700 (PDT)
Date:   Mon, 20 Apr 2020 18:57:43 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, elder@linaro.org, s-anna@ti.com,
        Markus.Elfring@web.de, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] remoteproc: Split rproc_ops allocation from
 rproc_alloc()
Message-ID: <20200421015743.GI1868936@builder.lan>
References: <20200420231601.16781-1-mathieu.poirier@linaro.org>
 <20200420231601.16781-4-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420231601.16781-4-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20 Apr 16:16 PDT 2020, Mathieu Poirier wrote:

> Make the rproc_ops allocation a function on its own in an effort
> to clean up function rproc_alloc().
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Alex Elder <elder@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/remoteproc/remoteproc_core.c | 33 ++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 45529d40342f..15318507aedb 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2028,6 +2028,26 @@ static int rproc_alloc_firmware(struct rproc *rproc,
>  	return 0;
>  }
>  
> +static int rproc_alloc_ops(struct rproc *rproc, const struct rproc_ops *ops)
> +{
> +	rproc->ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
> +	if (!rproc->ops)
> +		return -ENOMEM;
> +
> +	if (rproc->ops->load)
> +		return 0;
> +
> +	/* Default to ELF loader if no load function is specified */
> +	rproc->ops->load = rproc_elf_load_segments;
> +	rproc->ops->parse_fw = rproc_elf_load_rsc_table;
> +	rproc->ops->find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table;
> +	if (!rproc->ops->sanity_check)
> +		rproc->ops->sanity_check = rproc_elf32_sanity_check;
> +	rproc->ops->get_boot_addr = rproc_elf_get_boot_addr;
> +
> +	return 0;
> +}
> +
>  /**
>   * rproc_alloc() - allocate a remote processor handle
>   * @dev: the underlying device
> @@ -2067,8 +2087,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	if (rproc_alloc_firmware(rproc, name, firmware))
>  		goto free_rproc;
>  
> -	rproc->ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
> -	if (!rproc->ops)
> +	if (rproc_alloc_ops(rproc, ops))
>  		goto free_firmware;
>  
>  	rproc->name = name;
> @@ -2096,16 +2115,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  
>  	atomic_set(&rproc->power, 0);
>  
> -	/* Default to ELF loader if no load function is specified */
> -	if (!rproc->ops->load) {
> -		rproc->ops->load = rproc_elf_load_segments;
> -		rproc->ops->parse_fw = rproc_elf_load_rsc_table;
> -		rproc->ops->find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table;
> -		if (!rproc->ops->sanity_check)
> -			rproc->ops->sanity_check = rproc_elf32_sanity_check;
> -		rproc->ops->get_boot_addr = rproc_elf_get_boot_addr;
> -	}
> -
>  	mutex_init(&rproc->lock);
>  
>  	INIT_LIST_HEAD(&rproc->carveouts);
> -- 
> 2.20.1
> 
