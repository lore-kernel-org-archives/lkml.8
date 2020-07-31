Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86345C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F23C208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596224095;
	bh=m+JnSD6UxYGIM1KtfQPLz7NxtA1CV0Xi4yzn8SY89n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fqJD99F/EmzJM6e32aHEl0+t7dH1nPlKMXUs5nfSMSJkv+f0+lVbJqOtafYpILXFx
	 Xe3yYGTAhV2bsTS2Oh4R/2KDmYozvrc4OwC1ur4D92nNi7SX2gRmC4IrGo+iHcWZTk
	 wx+0YVtVpH3GRCJBfdvIhf0Rs7kHZP1zfM2tyZKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgGaTey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:34:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38011 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGaTex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 15:34:53 -0400
Received: by mail-io1-f68.google.com with SMTP id l1so32739308ioh.5;
        Fri, 31 Jul 2020 12:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pVSgcL7GtE1GSUUFa5tR37IcCV79BC/hP7BlkQgtdcw=;
        b=cwPucYUy7M83Dt+qQsEtKw5euzd/5G3r7QxLY5AGdZikj3/Q0caytm03aw08Fw/U8d
         UFEuQq7TycPrRbK9YNVMbuOkQjy0w4iAJIil8cHz8BbGI4l/HbkqRhbHRnBLYJECHNOy
         H0GcCkgzNmzZqvIXhj3yhz1dLF0pi9Qj7b3c1u1qakjsgrH/ycyPTHGHVaai9C1QruH2
         vGB/632Iesyf2GsY2Y650obKvIcsYGv+eMYg1TAaSJRpFKwSglo2U+5MmOEFM7pe8yr0
         bE2ViKXXHRjGe64zx9CTizWmc7yl3P5iNn/CEQFYxDIquR0aXpUgHsrGE6D+t0otdaZ4
         mZiw==
X-Gm-Message-State: AOAM532uzdfHYi6Px6ZaAiv+iR4kXtNHykdDMWMQtr+jgQ9bwjgG00gi
        uOfNghXIuNVxgA/QvpE7Aw==
X-Google-Smtp-Source: ABdhPJzTwWzSWdu5Ht4AzCpdTYI+subwwHxjfOOZ5tXzv7Rcj1YJ3aVynSdu5Wr6nxEEdbMr4g7nbQ==
X-Received: by 2002:a05:6602:2fcf:: with SMTP id v15mr5083954iow.78.1596224092882;
        Fri, 31 Jul 2020 12:34:52 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f20sm5172514ilj.62.2020.07.31.12.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 12:34:51 -0700 (PDT)
Received: (nullmailer pid 641081 invoked by uid 1000);
        Fri, 31 Jul 2020 19:34:48 -0000
Date:   Fri, 31 Jul 2020 13:34:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        NXP Linux Team <linux-imx@nxp.com>, agx@sigxcpu.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, lukas@mntmn.com,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v9 5/5] dt-bindings: display: imx: add bindings for DCSS
Message-ID: <20200731193448.GA640642@bogus>
References: <20200731081836.3048-1-laurentiu.palcu@oss.nxp.com>
 <20200731081836.3048-6-laurentiu.palcu@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731081836.3048-6-laurentiu.palcu@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 11:18:33 +0300, Laurentiu Palcu wrote:
> From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> 
> Add bindings for iMX8MQ Display Controller Subsystem.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> ---
> Changes in v9:
>  * Include imx8mq-clock.h in the example so we can use clock names
>    instead of their values;
> 
>  .../bindings/display/imx/nxp,imx8mq-dcss.yaml | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
