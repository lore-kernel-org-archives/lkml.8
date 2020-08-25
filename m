Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F29AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EBAE20715
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/zMCQMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgHYTVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHYTVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:21:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022CBC061574;
        Tue, 25 Aug 2020 12:21:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id j13so29592pjd.4;
        Tue, 25 Aug 2020 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ASNxTNL+cbL7rWIBkXZ7JVzxoeGtx7WsWu0Q+KFRvcU=;
        b=G/zMCQMxaxHI/7O7FP7sKWHJLvWg+eOyt9bw2CpuzROQaJpSAB5R5Z9XIqTzW3Tcfa
         +8TiGWrQDSCF/H0R7+N1HCCS6F9eSfVe9nrUV3DbyrHY5de4haHjn3YBqxvGa/oXOVV7
         UFhlKx8tDQS9dRVUb9js2P6hSlEIbcrzgwoWrk0b6C1yU/5VrXGO9RR04zz5Fm+73nJf
         O+BopQEwuLGIB3Zr/2ZJiILRjtU5AZl9EO2A+jZQ8D/m/u5ZQRYv0y3qO3lYJM3jUJX0
         WHq0XakRRdE7EyQtD/Uzko/dZJ6UIqWFoNnjPEBAJ+vl6/fqW5Z3jM4YUlwAfRVMvAaQ
         5Zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ASNxTNL+cbL7rWIBkXZ7JVzxoeGtx7WsWu0Q+KFRvcU=;
        b=Ayg9ARXtnwal+iMXYR1R6WgpT2tO2DzNTE6bPsz7y0uANp5IPNnKb2hka1qT3CZmHb
         gqBQiVvtQw+ULL5xVlulUl7kFJTQ2d6BySvgI/7pICEDqa4lMwnYXBe+fsXxTYdmFI3J
         6gxdcgnfH3UkFiAIiv7aqH1NZ1QcIrhrF3PhAayCJHX0ngnqMxNwFr+V3TCQp8l+tZpi
         aMm9Jusq1xhJVHulSXnp2UyQnkQKfDY3lNlk8z0BpTdJ64MYf3oABEhVdwPr7Qto5lqJ
         bkYBn8/0wajHwkCDZ4TCiCu34/j6iY44qGXVvfvbCLgmcGm853KhOPCRJDE+UcExCtQf
         kA7g==
X-Gm-Message-State: AOAM530h/c742ybNAsjSQ3eLehnZ4ZA2RdyEF40Hoq3nFw5/R8DE3/T9
        btkX5jN45rg2dwLQM2QX4ug=
X-Google-Smtp-Source: ABdhPJxIgFX7ASnjyZBpmzoeLnEF37BSnHGnhQIt2drUAPgBxzXqww495nVcv5oUWLuDMfSAv9Rerg==
X-Received: by 2002:a17:90b:4397:: with SMTP id in23mr2776765pjb.102.1598383294621;
        Tue, 25 Aug 2020 12:21:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 5sm10942pfw.25.2020.08.25.12.21.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 12:21:34 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:21:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.7 000/127] 5.7.18-rc2 review
Message-ID: <20200825192132.GF36661@roeck-us.net>
References: <20200824164741.748994020@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824164741.748994020@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 06:48:33PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.7.18 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Aug 2020 16:47:07 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 431 pass: 431 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
