Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11815C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6DF206B9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/Ywt9ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgDQJ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbgDQJ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:26:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3066DC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:26:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so2206091wrg.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XlGUZqw+jrAS6ieTYoAuxs9RQKcypT6nzhcddAJ3oBs=;
        b=y/Ywt9ad2jWK04NVwdvXe99a6lul3V9rTx0HxhP56trpnnzty2YutCuV7V3HEQD78A
         epYHZqmNexqv6IkOEFvC4Yzu5A2dQUABHZ+6jme5CCysIZqmR0U+fqeyEixt6xF7nfXw
         Wr8IhEpagZWXPVPqysZwaQliHsHyMVn/Y4C+I2UC6UAn545+hDWFoQ4HKYOs0KpkpFB7
         orR7GBGjPbo3fD9WoH8bjPYrS6AZg+K1+Xk5wSNrbmeZXMX6jVJ0s93VLpuBb6IWBswH
         MTVaQSa5C/puzLPZWlG4ey1jcwPLo5A/pi6kQz+UG4za8+huqWy9Qs91XdIKunephl9s
         HQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XlGUZqw+jrAS6ieTYoAuxs9RQKcypT6nzhcddAJ3oBs=;
        b=dddIhZHJVeTAU1p51mlP5KmFUYe+qEjJmF/orBOKYOVij+kP7q4Mr42ZkSqd2aft5m
         3zQipHMf72YffKincJgksPmx5KgaqEgke/5M+POcojUnjHFwY6hnnlGq0j45A7yGBuhm
         13zhh+QsSRGkQhQ6+ftluu2M+aiOqpC2zYWMhJmJmbtl3Nc8z3dY7LKyRh9jl2RP/nmT
         rn4dGzJjfgA38CT079Ir/iKhEo84JadstPjaF9H210JvJMjvKSWDl8gTX9LkBqMhkb9Q
         dlWPF8o+XOV36RePzfSZxvvwBygZpNXpEA6lUnh5B3S+bZqrgxDhTcZ9/x+0SRc9GJrx
         xpKQ==
X-Gm-Message-State: AGi0PubtmC7jjISTULv4bAcuMdnNjzjTiRdQqrvJquACaN7RWN+ymYm9
        +aKYK5wDO7em4p3fA7wu+gLewlv7C6g=
X-Google-Smtp-Source: APiQypJEHKfVv7MN9RgD2/Dtw/QNQXo8fZLMPbHsDPSCSeVOHIEodPloz1SEk8G7V4umefGvssCHfw==
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr2846343wrw.307.1587115566938;
        Fri, 17 Apr 2020 02:26:06 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id h5sm12635867wrp.97.2020.04.17.02.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 02:26:06 -0700 (PDT)
Date:   Fri, 17 Apr 2020 10:27:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd:asic3:Delete redundant variable definition
Message-ID: <20200417092705.GG2167633@dell>
References: <20200403042020.17452-1-tangbin@cmss.chinamobile.com>
 <20200416070802.GQ2167633@dell>
 <211e7521-639d-804c-f332-bfed0cf315df@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211e7521-639d-804c-f332-bfed0cf315df@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020, Tang Bin wrote:

> Hi, Lee:
> 
> On 2020/4/16 15:08, Lee Jones wrote:
> > On Fri, 03 Apr 2020, Tang Bin wrote:
> > 
> > > In this function, 'ret' is always assigned, even if 'pdata->leds'
> > > don't carry out,it has already been assigned a value in the above
> > > code, including '0',so it's redundant.
> > Which line initialises/assigns 'ret' before this one?
> 
>     I think it maybe my fault before, because I treat get resource and irq
> succeed. But now I have two questions  to ask you:
> 
>     Q1: About asic3_mfd_probe()?
> 
>           In the function asic3_mfd_probe(), if get resource or irq failed,
> the value returned just detected and dev_dbg() error message, but there were
> no error return. What I think the modify should be as follows:
> 
>     mem_sdio = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>     if (!mem_sdio) {
>         dev_dbg(asic->dev, "no SDIO MEM resource\n");
>         ret = -EINVAL;
>         goto out;
>     }
> 
>     irq = platform_get_irq(pdev, 1);
>     if (irq < 0) {
>         dev_dbg(asic->dev, "no SDIO IRQ resource\n");
>         ret = irq;
>         goto out;
>     }
> 
>     If the function do like this, the 'ret = 0' in line 993 maybe redundant.
> 
> 
>    Q2: About asic3_probe()?
> 
>           In the line 995, if the function asic3_irq_probe() failed, it will
> print error message by the internally called function platform_get_irq(), so
> the dev_err() in the line 997 is redundant, should be delete.
> 
> 
>     I'll wait actively, and submit the corresponding patch according to your
> reply.

Just submit the patch and we can discuss it there.

These kind of messages always require a lot of extra faff to process.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
