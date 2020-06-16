Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8D9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9137A2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gH1KvEav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgFPHJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFPHJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:09:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E17C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:09:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so19509836wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xjzZA1JVmcnbsQ75mNq0MIUXgWZ/kHv41u1CBA9GBrE=;
        b=gH1KvEav1y3QBhTi9p6cRJZfAI1yODXt/yZvnFdYmStPCMcgJCVYG/QpoOdSH0rppX
         tTLisBgXU0C8AKU5KTzUb3ufWgcbIWmQciXnvMejqamc4d3+nCdqSdUtpytIBPqlLhh8
         isTyMDxQ5jx7pFzzx1VuXKq3OdFCUaGL47qpme0veSNXQLY1/wP/qYDpxzfZ9eVcgtLP
         QEkakFcMamVQ32fGJyn/rHUzzDiNckLK2lNQDLenpQk//afhzyMfQwyrsziAJ/ntAza8
         fJAXj7zON0om7A0KoYjPLrJ+tiPKuhWt3rXdbpF+4S63YTk8zmCInVeXgxzKJ8+r3VrV
         ZQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xjzZA1JVmcnbsQ75mNq0MIUXgWZ/kHv41u1CBA9GBrE=;
        b=bGK+tstK48qa/kiql4JxfgE0NUS54Gk8IMzQUb0twRxB8W+igYLS7T4jRgW2wxR2VB
         eqSWNQw5jUFsnQqY+mb4ACHqTXk+x02tDdzR7BiSqH3AqDNci5o++Ix6muPHPgs/yPbp
         ZLS1DgV5hSokQr2XIivVuIjh4MyBezOpIWzFyTMc06tQ6eP+ZfoPdWiWMNGQ8BqsIMZN
         OaN1WTOxVe1Jv974ATQY/eih+xpN1UM2fpo2I6jWbfyb+0ephgZl3lPUAHauj1NllUsD
         mOizSKDNVzhJaWTlxOV2ccOMsmFZbHYLuTqV0TMT7/cAujP/oRQzGZUC28TcI4eUhpd/
         0Eeg==
X-Gm-Message-State: AOAM532dAnLCyQIVoSyLaltwmmGT8AT0SzuEbdhlFZTHWLiNRcdmBk+A
        gtK5+4UWWwIka0ggFpOQXKOL0g==
X-Google-Smtp-Source: ABdhPJyloO6MYeNZN1dv3p1GkbCH3pbQl61EBUHj8IXOQT91dm0nhSQ/4DbSP2GoKk+U9j0uU0I0NA==
X-Received: by 2002:a5d:6085:: with SMTP id w5mr1463840wrt.322.1592291363863;
        Tue, 16 Jun 2020 00:09:23 -0700 (PDT)
Received: from dell ([109.180.115.156])
        by smtp.gmail.com with ESMTPSA id p7sm28067577wro.26.2020.06.16.00.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:09:23 -0700 (PDT)
Date:   Tue, 16 Jun 2020 08:09:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Emmitsburg PCH PCI IDs
Message-ID: <20200616070921.GD2608702@dell>
References: <20200615161032.12906-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615161032.12906-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020, Andy Shevchenko wrote:

> Intel Emmitsburg PCH has the same LPSS than Intel Ice Lake.
> Add the new IDs to the list of supported devices.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
