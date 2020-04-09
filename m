Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BBCC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFB6206F7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OgYeFYtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgDIVgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:36:38 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39362 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgDIVgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:36:38 -0400
Received: by mail-pj1-f66.google.com with SMTP id z3so17630pjr.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CKSH66DRpSKDttW0HoIJ+Q7V/JrDgmsRLWNjAkPoZvs=;
        b=OgYeFYtz9TG5T5+OQ5HdreAp7UJvnomOdemJ2ZanB1NbWyQdpKatCBGGj9201dn3RE
         FF8XRBH/yJeSte8EZ+hYYArAFlXsD0Vq29xTsILMMytu0Gp4Ml+mWC/4UZXcHFl4NRu0
         tpr4AwAAIMIewL1kAwI+GwStxQj+LcbqXPGzZonSVmkcwuVC+NBCleuUUTU92XmljVXT
         BSjZrcLCoPZVBlWSXCYnFKBRPtYcDmaVtRVR8SvI6IrxIDUqKrY8QJflivLUUhl1Wsyi
         c0sQfB/wEZpmvdX6haHiJtufdMgKcjD5hQQsWVyY0dvsdYPPoy1KKkpS+wL3pCXy1uzJ
         X95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CKSH66DRpSKDttW0HoIJ+Q7V/JrDgmsRLWNjAkPoZvs=;
        b=sbD6YoiLsQXBsxkDj5JKTr7lF/MHW1SkVFsBVJIe7+uwYm3RBx9TArx1J5QvKwGDGh
         BHFWWk/IpzIi8ZfcFF6ImqjVPs6sPABuJPyhSNXZEFyeUz2qOLL5veU6nk/pGLV91Nd9
         evffw95JhKYUcxfcvJTZleJUUEhm10TJn8cK2TMwhu8RbDMAm+WlaaYy3Im+FYxAggOP
         XcxaoSmEdj78ROIw2npZvwIl/vcb26VGvW8MTA55RRfQ/Z5o1qxMs9/R/VvvYzOa26We
         XeJYJ3HmIAfmayZpCW5w2RZukvVcLIvXdBCrqLPIKrhpCALfr9E+ssF+0jpHutgEgDyk
         jchw==
X-Gm-Message-State: AGi0PuaUa0h+YEaBW7x56LeLM1iM9vC9PU5J5zl2sIIUMH1lVyBqvhVx
        zBKvyD8v5iWaWMimmJdx2aVKqQ==
X-Google-Smtp-Source: APiQypLaCPRkZGps/eMNdIh0y5VzobKlrdqJ7muVqbtpELbjLw8rCU9TWBniqmpH8PoKINDrrdRABQ==
X-Received: by 2002:a17:902:7c8f:: with SMTP id y15mr1555480pll.202.1586468195817;
        Thu, 09 Apr 2020 14:36:35 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f8sm58901pgc.75.2020.04.09.14.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 14:36:35 -0700 (PDT)
Date:   Thu, 9 Apr 2020 15:36:33 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] remoteproc/k3-r5: Initialize TCM memories for ECC
Message-ID: <20200409213633.GB32029@xps15>
References: <20200324201819.23095-1-s-anna@ti.com>
 <20200324201819.23095-7-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324201819.23095-7-s-anna@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:18:18PM -0500, Suman Anna wrote:
> The R5F processors on K3 SoCs all have two TCMs (ATCM and BTCM) that
> support 32-bit ECC. The TCMs are typically loaded with some boot-up
> code to initialize the R5 MPUs to further execute code out of DDR.
> The ECC for the TCMs is enabled by default on K3 SoCs due to internal
> default tie-off values, but the TCM memories are not initialized on
> device power up. Any read access without the corresponding TCM memory
> location initialized will generate an ECC error, and any such access
> from a A72 or A53 core will trigger a SError.
> 
> So, zero initialize both the TCM memories before loading any firmware
> onto a R5F in remoteproc mode. Any R5F booted from U-Boot/SPL would
> require a similar initialization in the bootloader. Note that both
> the TCMs are initialized unconditionally as the TCM enable config bits
> only manage the access and visibility from R5. The Core1 TCMs are not
> used and accessible in LockStep mode, so they are only initialized
> in Split-mode.

Everything was going well with this changelog until the last sentence.
Intuitively one is looking for the code that avoids the initialisation for
"Core1" in the patch but it is not there, and rightly so.  In locksetup mode the
second core is not registered with the remoteproc core and as such the
associated TCMs won't be initialised.

Simply put, I would just remove the last sentence as all it does (at least for
me) is add confusion.

With that:

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 655f8f14c37d..8c9b7ae5d8b7 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -366,6 +366,17 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
>  		dev_err(dev, "unable to enable cores for TCM loading, ret = %d\n",
>  			ret);
>  
> +	/*
> +	 * Zero out both TCMs unconditionally (access from v8 Arm core is not
> +	 * affected by ATCM & BTCM enable configuration values) so that ECC
> +	 * can be effective on all TCM addresses.
> +	 */
> +	dev_dbg(dev, "zeroing out ATCM memory\n");
> +	memset(core->mem[0].cpu_addr, 0x00, core->mem[0].size);
> +
> +	dev_dbg(dev, "zeroing out BTCM memory\n");
> +	memset(core->mem[1].cpu_addr, 0x00, core->mem[1].size);
> +
>  	return ret;
>  }
>  
> -- 
> 2.23.0
> 
