Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32756C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB002098B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojF+jQJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgH1Km6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgH1Kmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:42:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA15C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:42:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a5so845790wrm.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DRZf113ZOPSokfkPQfpN6cX86yO1qy7+w+jLp2LHhj4=;
        b=ojF+jQJ50xVA734g2UIGnE9GD+/gqRjFexRajwJ42MU7N6d6lsppEKCS64yelJkraQ
         QE9pm9RnsFcA9723W+FnYkiYnF8QxqM9ZUTfHutvz/b/jGmSjBRqAPZVXFmp+YfrNcCf
         yt2tWuF5THVnmAR21yzyKnUx1bhJJkLHdUCKG2XjrFjVckx8ZmVBwk688J2//l2u0tT9
         3ChZElmNyGnUu1I6WThyv3T7eBAmIEX2NN+xF3tMjGxZV2O8v1+4So0G6hbxyBYR25ye
         +iWMY2x4INzQ8TAcNTwzQ/u6byTYSVYFiSYD/fcKFk6DiARZu1YjaEKqpgjbuiR85w3o
         pVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DRZf113ZOPSokfkPQfpN6cX86yO1qy7+w+jLp2LHhj4=;
        b=RUpqBpwReaOYT9FgdBZopubi4bRGLACkRWFAnFdO32V2+rMWkeKhKyZek4kQs3+Ol3
         pvdwE3hFjQvQT2kyTlpJ1Xsb1McsaVHtAqJ1woJxA+5CXoV7LZiuPSmzPWl0DEGL245X
         alaoT/rBPKbmv8EP8/uavyb7VTylEaNFn1PoxWCEE/7M0KgfCfWctTaY9vDTWdFioxsZ
         vouNmblLsAJdu6UT3+zYwA0wq7JdOoRosoRxA+BmmZDn47qqW7ZYq3KwYxROsBF3TYVC
         e0QLglWmqTg/1IiFN635tCO4U5z5hW1d+mScVwexuoyaz5HjwA2TMBrvcfstUq4cPFDt
         57lQ==
X-Gm-Message-State: AOAM530zIR3JLIzwgDyjYzaj1gsF5ur+8VGarCUmuL+6Nbr4u+SjHQYJ
        BAp0MPniPdcucNK3sxzETMa0ZYFc246s3g==
X-Google-Smtp-Source: ABdhPJwXKM7gAVNPjFu41r6eWDa2BfHJT+MKVDUtz1ZI/3piRfiQgGO7rLs73zcjbSReityE775HWA==
X-Received: by 2002:adf:f7cd:: with SMTP id a13mr999283wrq.296.1598611364472;
        Fri, 28 Aug 2020 03:42:44 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id f2sm1373291wrj.54.2020.08.28.03.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 03:42:43 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:42:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2] mfd: dm355evm_msp: Convert LEDs to GPIO descriptor
 table
Message-ID: <20200828104242.GN1826686@dell>
References: <20200826202149.174815-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200826202149.174815-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020, Linus Walleij wrote:

> This converts the DaVinci DM355EVM LEDs to use GPIO
> descriptor look-ups.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Moved out all the tables and device definition to the top
>   of the file to not have static locals inside the function.
> ---
>  drivers/mfd/dm355evm_msp.c | 76 +++++++++++++++++++++++++-------------
>  1 file changed, 50 insertions(+), 26 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
