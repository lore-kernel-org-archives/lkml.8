Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB493C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC1B207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kM4ssiCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgH1LBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgH1K5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:57:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE7BC061232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:56:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so890971wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6dAy6oQX3mxrE+oxJsDs9WAbPrSNKxjGvuLNGWIC4oM=;
        b=kM4ssiCWMiZAAZ2OWMpy/DriODdVtl3gCmEfDR/c50iR/N3ODFW0YACnDWzoTSYz+a
         qFaIZe8BCjsreh8eip7ZRi6Eu39LwT/WEGLyVO+MrgO8GEbDddMQ9mfr5WAD6AxfH98v
         weZqD9j6lXoxksJvmm3YdHu8BsZ3tsu8oxCEvMbV1AHWadxh97loR8QbvMdZDJyfqpmv
         uLJY42pCGRq9Ra5MTPtqpA1SXRCysf9Yo778mEl+vohDD5yX3qMYPp5mvFflXvEux12n
         743jcdL6DcisuXKqTQ5RrGeZSGCd9Efphkt2/DkqoFt16DhKFRU/kwVo57qbUywTcuup
         1/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6dAy6oQX3mxrE+oxJsDs9WAbPrSNKxjGvuLNGWIC4oM=;
        b=lJC1wyyMSX7N19QBd8wjZxFg543V1jiqqtCpUJcSM7s2lusn6jlflugpZnwcHCFDDk
         Ki/TW8b4/WofL/IvFnezx/smFdwsERu9zYgF8lWA0fS+norgkMPR4z64Rj0IbqoZF2tP
         PVUZP6gaYOop67pUtjHVcNrpns0uGMoBxlOxfPlGlQpcAuKMq04S/u/NpbvTMbUWOwY5
         vvw7t8AsFAzMXGArFcVqzuY0zozlO7HaomK1xnSPhc9z7XIqSvY+Fi4IY2ZzO8Xl2zFO
         GccdBgmi1EdR0lmLEqJ8BY2mw30SD151pbsGy65UsMeDQlo3Hjug4fBpIGuU2xft0U0/
         aMbQ==
X-Gm-Message-State: AOAM533l8wwNMJobEKou1HkCTN4XciZPmrYcCrl4urtcIbtL2ibVbFVw
        b2lAP1QdYYT/ZJgS65NhF361ew==
X-Google-Smtp-Source: ABdhPJw/pGifNiKSDL+fZAMKRrWedIGRP9Xar1f6rZ+tD/5UoRm11w6CkIx3lDRpcW4omPV/wyXKng==
X-Received: by 2002:adf:f808:: with SMTP id s8mr995576wrp.218.1598612217550;
        Fri, 28 Aug 2020 03:56:57 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id q11sm1313636wrw.61.2020.08.28.03.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 03:56:56 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:56:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH V5 0/3] Intel Platform Monitoring Technology
Message-ID: <20200828105655.GU1826686@dell>
References: <20200819180255.11770-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200819180255.11770-1-david.e.box@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020, David E. Box wrote:

[...]

> David E. Box (3):
>   PCI: Add defines for Designated Vendor-Specific Extended Capability
>   mfd: Intel Platform Monitoring Technology support
>   platform/x86: Intel PMT Telemetry capability driver
> 
>  .../ABI/testing/sysfs-class-pmt_telemetry     |  46 ++
>  MAINTAINERS                                   |   6 +
>  drivers/mfd/Kconfig                           |  10 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/intel_pmt.c                       | 220 +++++++++
>  drivers/platform/x86/Kconfig                  |  10 +
>  drivers/platform/x86/Makefile                 |   1 +
>  drivers/platform/x86/intel_pmt_telemetry.c    | 448 ++++++++++++++++++
>  include/uapi/linux/pci_regs.h                 |   5 +
>  9 files changed, 747 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-pmt_telemetry
>  create mode 100644 drivers/mfd/intel_pmt.c
>  create mode 100644 drivers/platform/x86/intel_pmt_telemetry.c

What's the plan for this set?

I'm happy to pick it up and take it through MFD if required.

If that's the route of choice, I'll pick it up in just over a week.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
