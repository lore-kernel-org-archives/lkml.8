Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D32C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9FAA2051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7ZUsQXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441496AbgDPKOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441467AbgDPKNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:13:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D3C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:13:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d77so3961493wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wf1Npf9XSC73Ejyy+DvRIDVeqsXEFPd8u8XiRzEMgUA=;
        b=V7ZUsQXrHaQgXeN9L6GIsDZcF5AXmwDSfb8Fu+bYTmu7cNylxhcGZmQO8ex3UvnUKl
         vnTPCRJxEgE979dRUeC+LRYyVqm7tlsyBIsZXlPH89z5nI1vlM2mtJzKJSkBiKxZvhoV
         E7B4hxkHnxkj+W7iRO4nzrzI5ZcbaehqM5QvpP4V53KA2a8e9S0WZDK2eCHDLDzcRsd7
         eq07Moye1J6gN+zHqKk/QS4TkK03UXSt/jDvKG3Z80N202RxmyxtXh/I0T1weeGvipUl
         PTBF1P6H91Jk7afn4eg9ncOVvJgvoXwVyMMcKtcCN6yh8Jhm+kM2aD8e7Og15Kb6Y6SH
         HEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wf1Npf9XSC73Ejyy+DvRIDVeqsXEFPd8u8XiRzEMgUA=;
        b=ZUzAL1ijhB2VsuteUxiYSrXvlSz11o9Xv14jW0l9wCmfJ4RKSl/EKts0hwS10JffSE
         SC9r64pX/DvH/Utn+nv0xadloBmLfxvhPHOE4PwU8/VGFFff1r6aclF6sQhEPpaHHS/0
         kZfHVIt0hqCilKHahF0q4u8qjSmEG1roLhH+jEnXGhcYdv2286gk7pCCzwNKf3+aIINx
         STgGDDcCVRKFPSIGIsl//noaL07Ogl0dE8rGFQ6Y6kbolnBLsFnMhYRowvaCCiN9piJa
         z95+O57kZIBX6e0s0EXiR5mQhVA/xBghXTfJLbFjD/7TUhqRMZdxj2u9DA0BhQMHtlwx
         OpGA==
X-Gm-Message-State: AGi0PuY3bSHlGK3N/s5kb5bAFkNrj/SekBKFPXGQJaqlrOsr/a5kLiXY
        dilHxo1Rg+o7mtyWcDjQYN295w==
X-Google-Smtp-Source: APiQypJXPwtuhD8dFO+JsNn5QLOU6Dyekq3TSruLoNK9phQLHnzSPcNF8U1T4kQiCuJrZMDNKiED+Q==
X-Received: by 2002:a1c:384:: with SMTP id 126mr4165777wmd.58.1587032020316;
        Thu, 16 Apr 2020 03:13:40 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id y10sm3039407wma.5.2020.04.16.03.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 03:13:39 -0700 (PDT)
Date:   Thu, 16 Apr 2020 11:14:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     andrew@lunn.ch, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: tqmx86: Fix a typo in MODULE_DESCRIPTION
Message-ID: <20200416101439.GD2167633@dell>
References: <20200412213047.4827-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200412213047.4827-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Apr 2020, Christophe JAILLET wrote:

> Based on the file name and code of the driver, it is likely that this
> module is related to TQMx86 and not TQx86.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/mfd/tqmx86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
