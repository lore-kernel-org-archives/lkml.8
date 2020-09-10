Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A35C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C04021D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GMLrSwZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIJTvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgIJTuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:50:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357FEC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:50:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fa1so548121pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xDChIkAtb5Vukpnd8bJJRVf7fU2a+5XPgWV5S0nOt9o=;
        b=GMLrSwZmHtAb7ckfKa7u7eqxr83FkDC1sG/gpb2HdAJ7QRD+yEt9AnrvUNRzaA9mSr
         rsYXudCO+sEnI8MY+QRb6e87ZPH+k/EEssmqkNN8/ygzCn3nP/vi9P1wq+GB8iTl1O2L
         xC/Nw1N4lLEdzCrTp+NZlBoguH2YonWZ+IwFSNlsXftiiq5/taPI3Yt9lfVYQywDGeFX
         mQ8O9oLnHNJYcZaBpkb8+vndfLA7l4vpU4JTwhRa4k416jxLFL/qLesQLk0yDrkGfoVj
         ctC/y+9Mo5VSiBvA9NDfWwnfAGhZmq+16PQG9a0IUTCptP+a+bWvtyH/iTJYlnJf4nX0
         qNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xDChIkAtb5Vukpnd8bJJRVf7fU2a+5XPgWV5S0nOt9o=;
        b=L6425zMmpOUhkM0TimoGShivA+6l++l1b7iYQtNFg0fIiIt6DsP/0KPk3AQvtly+Ph
         BZ7fGYTPlXhmtt++mAAlKaD1U4T2EN3G3/YQ75pYKAoNmMbc5nCt/PuyIO36K+JyVxBW
         FsQHulc8ndUDD+w5I31K3Zh/nY7O5uwu7M0qe+jbC8CDMJsombsp9s69sTLCZar9F3rN
         gQMpWOsyKMXIvsoT3n5IT7IfIq2NzSBwV5dI/55Ma6Ww5CoVoR/gNgDPNpn9gh2WKEMZ
         tZy/4rPOCugknyhtY9gfXJJJ0vvezqdxVLku1g8k4VSZycpagSQo+sQBo+6EOJzVaQNr
         ZLuA==
X-Gm-Message-State: AOAM532sdppgck8lIxLAirdSCtYw7Cg9VkekvXnlGDJ1AubAcq3vg9KC
        zCMZ4esT0uABfjjdUFkTQAQ/fQ==
X-Google-Smtp-Source: ABdhPJyZYiVntwdGvOTjgASZ9NTGbtmfntR5sx4R5k7O0XZpReyPmnbzTe4k88faDRcbkzb73sG2hg==
X-Received: by 2002:a17:90a:2ec8:: with SMTP id h8mr1482436pjs.173.1599767436537;
        Thu, 10 Sep 2020 12:50:36 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l1sm6732257pfc.164.2020.09.10.12.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:50:36 -0700 (PDT)
Date:   Thu, 10 Sep 2020 13:50:34 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] remoteproc: k3-dsp: Fix return value check in
 k3_dsp_rproc_of_get_memories()
Message-ID: <20200910195034.GA586100@xps15>
References: <20200902140614.28636-1-yuehaibing@huawei.com>
 <20200905122503.17352-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905122503.17352-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 08:25:03PM +0800, YueHaibing wrote:
> In case of error, the function devm_ioremap_wc() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.
> 
> Fixes: 6edbe024ba17 ("remoteproc: k3-dsp: Add a remoteproc driver of K3 C66x DSPs")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Acked-by: Suman Anna <s-anna@ti.com>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
> v2: return ENOMEM instead of EBUSY, use corret Fixes tag
> ---
>  drivers/remoteproc/ti_k3_dsp_remoteproc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> index 9011e477290c..f373df35d7d0 100644
> --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> @@ -445,10 +445,10 @@ static int k3_dsp_rproc_of_get_memories(struct platform_device *pdev,
>  
>  		kproc->mem[i].cpu_addr = devm_ioremap_wc(dev, res->start,
>  							 resource_size(res));
> -		if (IS_ERR(kproc->mem[i].cpu_addr)) {
> +		if (!kproc->mem[i].cpu_addr) {
>  			dev_err(dev, "failed to map %s memory\n",
>  				data->mems[i].name);
> -			return PTR_ERR(kproc->mem[i].cpu_addr);
> +			return -ENOMEM;
>  		}
>  		kproc->mem[i].bus_addr = res->start;
>  		kproc->mem[i].dev_addr = data->mems[i].dev_addr;
> -- 
> 2.17.1
> 
> 
