Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1F8C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 19:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F882065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 19:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594841380;
	bh=R7q+QrjteQ4SIK04XXZ+1xGD6XAv+4HFsuzeTFoQ00c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L7NVhdtneALpyB3Rxm/0Ix5rRxfUKJmJkOUoM5rscbBHZiBMfYkX6SXJlgDIuib11
	 1ayRRBRPFrBKh4RQdQrGAIdNojaBOAIl86U3AACdhm250fPZugl9crR90f/aWWeMLf
	 v8Zb2HMfY6jNUpM/bP7YLVmuZv53nQwD6ExQxbOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgGOT3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:29:39 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42238 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgGOT3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 15:29:38 -0400
Received: by mail-io1-f66.google.com with SMTP id c16so3465185ioi.9;
        Wed, 15 Jul 2020 12:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D93LZtUoWQhV2+rIxfU+EXRRqA3Mro73jmOIm4SVUSI=;
        b=pcszeq7ox6V6qOFBHI6Wp3AwdIevHLGDfKXhil2+IVGlO71DcU36dhYQbHZJbkQaXM
         D/PEH/lc2x2sRXn8hQNmmPprqdWLV6PKCyell3b1Yvt0CeEe6AhSfpftXVt5mZW41K5y
         4GVAAABc1pOWdFWoGK5eVCChQd5mvAQrZb4nwg+4h1JTjWYJMDb35POgvm8xGWSMhAPa
         MlM6rC0xUCdhthnKHclpvjG8QC5j+J8yzfgLrTMDxHnh+hJRPcTooPealf7iZgeHI/4L
         mYihwb031b7NSTsaA8KmPSTObIXDEYrTUnGwyOlWBW8M0uIsbisAxmutZyqnlgN70VDd
         sJiA==
X-Gm-Message-State: AOAM533LdKvWAPj+dXFGSB0ymMF1MqxNupS1cr7BV8OEi6EuHdedtSDH
        HwdLVJ/Q9r2xNW4WIXSZZA==
X-Google-Smtp-Source: ABdhPJz5CUXWiXyWIo2GOUgX7pfaopKLNbdwnQHpV8DX2NGyQLQJHDI2yPF3P1/t/oFO9FJXZ4UerQ==
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr873118ioc.8.1594841377213;
        Wed, 15 Jul 2020 12:29:37 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q2sm1515657ilp.82.2020.07.15.12.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 12:29:36 -0700 (PDT)
Received: (nullmailer pid 685623 invoked by uid 1000);
        Wed, 15 Jul 2020 19:29:35 -0000
Date:   Wed, 15 Jul 2020 13:29:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/2] dt-bindings: arm: rockchip: add A95X Z2
 description
Message-ID: <20200715192935.GA684031@bogus>
References: <20200620134659.4592-1-jbx6244@gmail.com>
 <20200620134659.4592-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620134659.4592-2-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 03:46:58PM +0200, Johan Jonker wrote:
> Add A95X Z2 description for a board with rk3318 processor.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index d4a404509..3d44b3cf0 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -25,6 +25,11 @@ properties:
>            - const: vamrs,rock960
>            - const: rockchip,rk3399
>  
> +      - description: A95X Z2
> +        items:
> +          - const: a95x,z2

Need to document vendor prefix.

> +          - const: rockchip,rk3318
> +
>        - description: Amarula Vyasa RK3288
>          items:
>            - const: amarula,vyasa-rk3288
> -- 
> 2.11.0
> 
