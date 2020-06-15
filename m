Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07291C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7286206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lc/0UVSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgFOJ0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgFOJ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:26:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973E4C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:26:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so13864933wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Rzxkol7w2QC50xcBFexG/soZ0rzW0UYaIlHrmwy/Vl4=;
        b=lc/0UVSxPinnkjDB/lFuqYGDeDU3GTO/xQpG14bzThYrcAzSIf4rcgTtABwesYQmpk
         ZeZ393630Ant4rb6ydPcR037Ny5WHbHzrVRrSUjC8OiOndguT3fbjALpGxY3uIqF4+xy
         G1ROVao91s3C13/YISlmmLI8VYZXLxC0P3FVJrVvPi1id7KFd427AluMHr3mqBvePJIN
         rfDMCdtRR2HgrtpQf9WGtvgaJlsedSjanZYR5rOamASSWWy2HcJX7fjYPARmrc4cCR3h
         sEOAwa/hDp/2yGmDo3eYiDgB4+0KR5/c7ELTwXQoUcAOApfqXqz7IZP19e5bpylQpseK
         rSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Rzxkol7w2QC50xcBFexG/soZ0rzW0UYaIlHrmwy/Vl4=;
        b=CJAIyCMrtO2Axw35/DAIFj1uyPkk5g7u/9v9e+QdwP6LGadhG6q2AT/LQNS6PdCp9E
         DI6e1030VpA80RbW1GIyTl0lyk1vjZdnHKfDLfuMMfVTBtZHjkmZPJ7+fv0R+3x69FCe
         MEHWWfRfRJUI/YlXZslCgoeqk2j7eJjDq3CDWSELdjY9bOWGEChK9KHJZSGpoVuTtzkR
         /Ceda0M452qKtvMD2/8UyMXGjKUIVIEipR3Ljl37hSkeoYNb415BgOOcnFBkq68pxK+P
         QZfwnVh0FKZoEthw3cEgmbyc9zse2A+a5PCq7Vv/khD/lEMDuBsLrWGYS6h8hnh2osSH
         3J2A==
X-Gm-Message-State: AOAM5332zvO6CRifxXRIrKC+kYKvgNgm/TclArymTZe4RQZVaBPIKwZY
        oeBFpq9P9PZgpqP+DqYZqc0i9Q==
X-Google-Smtp-Source: ABdhPJwCaq+quncmRhoHqb9o1t8O7Lp9QJlLwsERoVR/Cy+mzVIJu9PSqQTp80ULC4g08tqY/VX/vA==
X-Received: by 2002:a1c:790a:: with SMTP id l10mr11470065wme.80.1592213207106;
        Mon, 15 Jun 2020 02:26:47 -0700 (PDT)
Received: from dell ([2.27.167.101])
        by smtp.gmail.com with ESMTPSA id k21sm24685707wrd.24.2020.06.15.02.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:26:46 -0700 (PDT)
Date:   Mon, 15 Jun 2020 10:26:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
Message-ID: <20200615092644.GA2608702@dell>
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <4b188fb5-6667-720d-46e1-6f103efe8966@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b188fb5-6667-720d-46e1-6f103efe8966@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jun 2020, Frank Rowand wrote:

> Hi Lee,
> 
> I'm looking at 5.8-rc1.
> 
> The only use of OF_MFD_CELL() where the same compatible is specified
> for multiple elements of a struct mfd_cell array is for compatible
> "stericsson,ab8500-pwm" in drivers/mfd/ab8500-core.c:
> 
>         OF_MFD_CELL("ab8500-pwm",
>                     NULL, NULL, 0, 1, "stericsson,ab8500-pwm"),
>         OF_MFD_CELL("ab8500-pwm",
>                     NULL, NULL, 0, 2, "stericsson,ab8500-pwm"),
>         OF_MFD_CELL("ab8500-pwm",
>                     NULL, NULL, 0, 3, "stericsson,ab8500-pwm"),
> 
> The only .dts or .dtsi files where I see compatible "stericsson,ab8500-pwm"
> are:
> 
>    arch/arm/boot/dts/ste-ab8500.dtsi
>    arch/arm/boot/dts/ste-ab8505.dtsi
> 
> These two .dtsi files only have a single node with this compatible.
> Chasing back to .dts and .dtsi files that include these two .dtsi
> files, I see no case where there are multiple nodes with this
> compatible.
> 
> So it looks to me like there is no .dts in mainline that is providing
> the three "stericsson,ab8500-pwm" nodes that drivers/mfd/ab8500-core.c
> is expecting.  No case that there are multiple mfd child nodes where
> mfd_add_device() would assign the first of n child nodes with the
> same compatible to multiple devices.
> 
> So it appears to me that drivers/mfd/ab8500-core.c is currently broken.
> Am I missing something here?
> 
> If I am correct, then either drivers/mfd/ab8500-core.c or
> ste-ab8500.dtsi and ste-ab8505.dtsi need to be fixed.

Your analysis is correct.

Although it's not "broken", it just works when it really shouldn't.

I will be fixing the 'ab8500-pwm' case in due course.

> Moving forward, your proposed OF_MFD_CELL_REG() method seems a good
> approach (I have not completely read the actual code in the patch yet
> though).

Thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
