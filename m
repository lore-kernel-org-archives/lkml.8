Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47358C38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2554221D91
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="utdWXHRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgDQKNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728915AbgDQKNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:13:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A98C061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:13:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x18so2435487wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Si8xNa2PRt0kIhccFd8IRCrcCliJZGdfrQl0M6nEdTs=;
        b=utdWXHRDGLukUPDocwW6Cm48BY6bvFz80fFjJC3jpN5iRv2FnVhpn5i7lNKcBhS8sJ
         xHiQQO2Jbegs0tzYojnLQ5M1vDah1L2xgfi1BzmqHjJKC0wTjgKJPL4ZiXUtHDEeWApp
         G5pEAeVkba955wVhuY3VoZCj8teWpA60tuCqiu7FfOrsGWO49JAro14aLJNAoX+NQSD1
         ncHthxk6aHwtjwlI2DB0JBVkqCBjdu3aXRQMKmFTfMcYQNw3MmhfDE8LHt2N8SOyCPsw
         CAPXYAV9p4XxXipAbMvRb+N7NHpA6NGbsoM95P6IjYP1DspabfxVh/PdyVMd4UDDKbs7
         uOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Si8xNa2PRt0kIhccFd8IRCrcCliJZGdfrQl0M6nEdTs=;
        b=SAQ9qGabuJl3ZPQl4rODj0+y1V9C6HkHJC7IExhJhIRWmMWBoOrYQV1tiUY0ut37BR
         PnWqNakWJXFhI7BdXf8uUBKrmpoFNVJMXAcp6LCVRFVzP49FnTPdM8k26rpnKKRjYsFD
         tYLgGdOMjKYVW8zCqLVLLOG1Y4EJhpPYtRxBRszrTrKxF6OElAy0AF2i2Dmp380BTKRY
         OWTewkmUDtfkFoLxagLxguV4VRr1+XZdTvxLiBbZ82+kT2hl7oAFWrsUGIVsiPA10Iue
         UwLykF+PCfLjRiKdBpMFJIX7LS+Z7L35tqGYLPH+ZFe4bYY3Yvlo/6nid1yJVUU1NLw9
         xqww==
X-Gm-Message-State: AGi0PuZalLlSkRKVwDiPMLRMnS8E6n2KGx4fRqAbNyT68ln2SrbXSyij
        dKq78kUdzxDn+gdjJb4OPqE7pQ==
X-Google-Smtp-Source: APiQypJJoXQEbutIxLdmsu/x/STiUGWe4/3crlmEFrGGKFCFPbSIFAprP4Y9woxirt4trOT8/ToViw==
X-Received: by 2002:a05:6000:8f:: with SMTP id m15mr3108271wrx.19.1587118424935;
        Fri, 17 Apr 2020 03:13:44 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id o18sm4886743wrp.23.2020.04.17.03.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 03:13:44 -0700 (PDT)
Date:   Fri, 17 Apr 2020 11:14:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] video: backlight: tosa_lcd: convert to use
 i2c_new_client_device()
Message-ID: <20200417101446.GB3737@dell>
References: <20200326210959.13111-1-wsa+renesas@sang-engineering.com>
 <20200326210959.13111-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200326210959.13111-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020, Wolfram Sang wrote:

> Move away from the deprecated API and return the shiny new ERRPTR where
> useful.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/video/backlight/tosa_lcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
