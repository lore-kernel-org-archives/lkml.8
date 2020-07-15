Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FB4C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E822065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mV2pcg1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgGOPh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgGOPh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:37:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB0CC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:37:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g10so3722862wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2Je4T8z/w322fxOUCkiwVBCB1R8T4g7KUgJ9ivXdC54=;
        b=mV2pcg1F1aIcUk+DLzQEo+MAWNQ+9PrKfD0mHv/xMs+Zo3xFO7vnIzCL2hx3luthr9
         E19+CaAT6rzLFbghnD1ivXmqYl00TBVPWlUCNVzNzqyEJ0OhdLAz57AHmXwmAYgYQulz
         yKH++yAHrFj2LNcT+D/wGA9BbLXjODS3ipwCSqZxfoNy95RGooNgSkRMmHk4zCZXj2MH
         MI7pA8lUosPGjIw6voiU/tjOj1LqD8tULchQBDWmI8x1kiz/FIHp0ZGR9eCWUd5bp9ow
         LJSV6ApJuAXQRzIZHkxfmL5WAh21DPvwdKG3pDxSntkZ7drWyoWmRteWcQ4Sk9oDO/Lp
         CKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2Je4T8z/w322fxOUCkiwVBCB1R8T4g7KUgJ9ivXdC54=;
        b=dGg5IbcKhliN7xKZhpTInB1IMW+cW+8b6uf4tXHstqcCWO9fztgsAipEZ/C++JT5pC
         tH08L7LI/uazMDxGbsjKimlkfBNZNkZVf8UkP9X+ZY7PkRPUsFFdH16YCEt5DbKzMRkj
         USKkAZ+5Mj6x1VFbPdUcEIM2K3j2U1sHo+gRdM5Qsk2brZsM6HF4cuPvHEFuasqwnyDk
         OFdB0mV5z3wwo0oMvRA6jQMPuDVG9NEEptqpavvcrAaUOOU1ZcPPDFe1WEumG9KPdap4
         sdV06EZ6joeOxQtbOh4vo05AtGn1yoRm151KMwRtIrtuOKsZG/ZIWX2Et/0u643LfwMJ
         fNlQ==
X-Gm-Message-State: AOAM532WI/5FTqEbYyOHb/X4dJt2a6LQxciEpfkkxGKye8hoAhiYIIMJ
        9k1xfmx2zXWAlsOXgZbnwzgSRg==
X-Google-Smtp-Source: ABdhPJwFsRC9h0/qpemmdCtzkg1WNsyzY0pDmoXoAcVsFn3mA3VMdNn/N97b8wMFmFHTu+Eh1VAQsg==
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr95213wma.66.1594827447500;
        Wed, 15 Jul 2020 08:37:27 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id r1sm4073872wrt.73.2020.07.15.08.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:37:26 -0700 (PDT)
Date:   Wed, 15 Jul 2020 16:37:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 00/17] Rid W=1 warnings in DMA
Message-ID: <20200715153725.GJ3165313@dell>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
 <20200715152923.GB52592@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715152923.GB52592@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020, Vinod Koul wrote:

> Hi Lee,
> 
> On 14-07-20, 12:15, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > After these patches are applied, the build system no longer
> > complains about any W=0 nor W=1 level warnings in drivers/dma.
> > 
> > Hurrah!
> 
> Yes indeed, thanks for fixing these up. I have changed the subsystem
> name to dmaengine: and applied all

Much obliged.  Thank you Vinod.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
