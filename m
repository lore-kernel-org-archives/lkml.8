Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B191AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D2520758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589914037;
	bh=5PKF2D1pxH50bb5xYBcG0QBG9s1cz+Mvg5Y2K5jAnNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X2Pc0yUAFPMdU9S9tUn5fryy+vCNKec3Pawc5jGumVNg/+QN1ZSDpiM4Y/0I6Jgrc
	 7ZPr81s40rro8LcdP2bDFFOyDQ4xHEcOpMJyeT6yPm1u4TdSYvvVsgb+VEnnHeOCrR
	 yCPNs4Pf7XA/f6qXSQ+GfbJTGObZt5FnD9anwdXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgESSrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:47:17 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:44095 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgESSrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:47:16 -0400
Received: by mail-il1-f196.google.com with SMTP id j3so411548ilk.11;
        Tue, 19 May 2020 11:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V0YVAkM2HLojpq1b1+p0fXyP5bQOH8dXeAGrEDtHiho=;
        b=YZWfvy/onpHjqBhhm5ZAhfsYYzcgR4zy0EBqemiREnyhdg+lVB9v1zhvapyaN+8SHQ
         oLUlKQwkakZduEP7+QeW8sVv2ebv6Iqk7VjTrgJU6/Q6X1zLj2wDbkIjRcnJ2UQpOLgf
         5m4eELYInqIPsaawAwC1xSSJhDh45t/sLaSNrBOSPRwlkw+XGnXSWpXUE3UxBSKXh5eF
         fKRosazM0e4LltoIghFFh3nA4RaRfCan9biS/1U6Zh2TkWU3cfdBmfm+J7pUPivTj8kk
         HIHjJwVIjLmzR50QyjUu/SiPeG4StC9675morZVG2W3t25hZyBttrRcuAT9L1htNuOn7
         rO6w==
X-Gm-Message-State: AOAM530SMALqbnCpReRsGmK8FJWLuLq5R+aZijERR5d19p8zbjw/g8Vy
        BAjBjUSvnrpb8GLqIQFbBA==
X-Google-Smtp-Source: ABdhPJyzd1P9DWDtFNJWkIwwMCBUct5L83pHOE4PIc8p5UKRsYNsbjmDE3c6SZ6DlG9Xm7yO1lWSrA==
X-Received: by 2002:a92:1949:: with SMTP id e9mr452979ilm.106.1589914035610;
        Tue, 19 May 2020 11:47:15 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w26sm131757ill.19.2020.05.19.11.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:47:14 -0700 (PDT)
Received: (nullmailer pid 457373 invoked by uid 1000);
        Tue, 19 May 2020 18:47:13 -0000
Date:   Tue, 19 May 2020 12:47:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     john.garry@huawei.com, will@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 RESEND 2/3] bindings/perf/imx-ddr: update compatible
 string
Message-ID: <20200519184713.GA453195@bogus>
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
 <20200512073115.14177-3-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512073115.14177-3-qiangqing.zhang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 03:31:14PM +0800, Joakim Zhang wrote:
> Update compatible string according to driver change.`

Why?

You are breaking compatibility.

> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> index 7822a806ea0a..b27a1d4fec78 100644
> --- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> +++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> @@ -4,7 +4,9 @@ Required properties:
>  
>  - compatible: should be one of:
>  	"fsl,imx8-ddr-pmu"
> -	"fsl,imx8m-ddr-pmu"
> +	"fsl,imx8mq-ddr-pmu"
> +	"fsl,imx8mm-ddr-pmu"
> +	"fsl,imx8mn-ddr-pmu"
>  	"fsl,imx8mp-ddr-pmu"
>  
>  - reg: physical address and size
> -- 
> 2.17.1
> 
