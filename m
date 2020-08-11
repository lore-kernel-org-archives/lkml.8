Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F25C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BE8206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6gVIwrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgHKWqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgHKWqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 18:46:05 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EDFC061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 15:46:05 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh1so203393plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 15:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AAlB7AADi1d+qrv8BbA2OuomHwJe1ObClWJvHdEt10k=;
        b=A6gVIwrdYXgM7QuIVj86358/aLJZuUzMqDOEA2hxs/8xvFM9OPYJk0obw3ZJnmD3xp
         D/DdcfbhvS/ihd/SPS7S19BbkHZstlgvWXsUWrfSeDFbhCS6t9B5cf/bAQ0zbHchu4h6
         FNtwY2nTNAydaTiJtNHn2uzgajQJ/ZPeFhU3IL0tJ26PosnU2VHhDGlCsHbFHuFEdk4r
         GsA6lk55x0ArSM9pvsKTlrD14YrJoChaExi1xNFDH+leFysVmIZ3WlQENBeVcki+T06u
         K/ghB6dSSDzPHv9H7MvfeG9eb6qs1DxW8kaXGyDiemGrSvkqWlGQTdBxuZu8jVP8av3Z
         9s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AAlB7AADi1d+qrv8BbA2OuomHwJe1ObClWJvHdEt10k=;
        b=JgTDP0iMaKbYOILGZ3tJTJ+ci/QRXXFi+BHqoRWMJMYcY/Z9gMopBZAASmno8SsppM
         yQ8nZ3WvYq1UHbFj+5qbJZt2WsVlEctkXCy7i+Ua58cwteh6G0ZcMffk7940sxnVu3A9
         gZiklwMuE5vuOLV+34jv/VsLvrRIXpuiwCSR+AzREIoC/9TgI/kaHp+u9DTIQNsILqGQ
         WKUAHmJ/vNeltLew6ijPkxnlzjNt2htyI5wIXiFqXLR5vA109ACgAHHkv1kd4hNARrNQ
         YsoUdCddVHL7fKmIRm5OfC/m8M97PvkNsG8gMfIHOsSZbznF3/CSS606C88EG214B61r
         cqyQ==
X-Gm-Message-State: AOAM531lIPZNxetHR1w4zLtRJ1tVgx27RGWDi4JBRcJR2tkNOlTeNkx1
        7AIw9C+EzMG5UEV0uKJHWdRCwcjjxGM=
X-Google-Smtp-Source: ABdhPJw139s9RYvi6HdwGiQP3oI8ROpCRG7hB09mor/U3JqJiqPAxtwLUcDJA7GP1pFhY8RzOlxcZg==
X-Received: by 2002:a17:90a:202c:: with SMTP id n41mr3429775pjc.126.1597185964913;
        Tue, 11 Aug 2020 15:46:04 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s18sm195630pgj.3.2020.08.11.15.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 15:46:04 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:46:02 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, o.rempel@pengutronix.de, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] remoteproc: imx_rproc: add elf memory hooks
Message-ID: <20200811224602.GF3370567@xps15>
References: <1595928673-26306-1-git-send-email-peng.fan@nxp.com>
 <1595928673-26306-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595928673-26306-2-git-send-email-peng.fan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 05:31:13PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Please not apply 2/2 for now, this 2/2 has not gone through
> test on all i.MX8 platforms.

Why sending patches to the mailing list if they are not ready to be applied?

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 8957ed271d20..8ad860c65256 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -6,6 +6,7 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> @@ -241,10 +242,22 @@ static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
>  	return va;
>  }
>  
> +static void *imx_rproc_memcpy(struct rproc *rproc, void *dest, const void *src, size_t count)
> +{
> +       memcpy_toio((void * __iomem)dest, src, count);
> +}
> +
> +static void *imx_rproc_memset(struct rproc *rproc, void *s, int c, size_t count)
> +{
> +	memset_io((void * __iomem)s, c, count);
> +}
> +
>  static const struct rproc_ops imx_rproc_ops = {
>  	.start		= imx_rproc_start,
>  	.stop		= imx_rproc_stop,
>  	.da_to_va       = imx_rproc_da_to_va,
> +	.memset		= imx_rproc_memset,
> +	.memcpy		= imx_rproc_memcpy,

That won't work - you are modifying how _all_ the platforms out there are
working.  As I indicated on the series on iMX8M, add a field to imx_rproc_dcfg
and apply the correct memory accessor based on that.  

It might also suggest that it is time to split the iMX platform drivers, i.e
older MCU and iMX8M.

>  };
>  
>  static int imx_rproc_addr_init(struct imx_rproc *priv,
> -- 
> 2.16.4
> 
